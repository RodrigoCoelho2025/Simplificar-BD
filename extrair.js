const fs = require('fs');
const readline = require('readline');

// Caminhos dos ficheiros
const ficheiroEntrada = process.argv[2] || './DumpMerge (1).sql';
const ficheiroSaida = process.argv[3] || './estrutura_simplificada.txt';

if (!fs.existsSync(ficheiroEntrada)) {
    console.error(`\x1b[31mErro: O ficheiro "${ficheiroEntrada}" não foi encontrado na pasta.\x1b[0m`);
    process.exit(1);
}

// Detetar codificação (UTF-8 ou UTF-16 LE do PowerShell)
let encoding = 'utf8';
try {
    const buffer = Buffer.alloc(2);
    const fd = fs.openSync(ficheiroEntrada, 'r');
    fs.readSync(fd, buffer, 0, 2, 0);
    fs.closeSync(fd);
    if (buffer[0] === 0xFF && buffer[1] === 0xFE) encoding = 'utf16le';
} catch (e) { encoding = 'utf8'; }

// Tradutor de tipos técnicos para linguagem humana
function obterTipoAmigavel(linha) {
    const l = linha.toLowerCase();
    if (l.includes('tinyint(1)') || l.includes('boolean') || l.includes('bit(')) return 'Sim/Não (Booleano)';
    if (l.includes('int')) return 'Número Inteiro';
    if (l.includes('decimal') || l.includes('float') || l.includes('double') || l.includes('numeric')) return 'Número Decimal / Valor';
    if (l.includes('varchar') || l.includes('text') || l.includes('char') || l.includes('json')) return 'Texto';
    if (l.includes('date') || l.includes('time') || l.includes('timestamp')) return 'Data / Hora';
    if (l.includes('blob') || l.includes('binary')) return 'Ficheiro / Dados Binários';
    return 'Outro Tipo';
}

async function processarSQL() {
    const lerStream = fs.createReadStream(ficheiroEntrada, { encoding: encoding });
    const escreverStream = fs.createWriteStream(ficheiroSaida, { encoding: 'utf8' });
    const rl = readline.createInterface({ input: lerStream, crlfDelay: Infinity });

    // Escreve o cabeçalho estilo documento
    escreverStream.write("=====================================================================\n");
    escreverStream.write("RESUMO SIMPLIFICADO DA ESTRUTURA DA BASE DE DADOS (ESTILO DOCUMENTO)\n");
    escreverStream.write("=====================================================================\n\n");

    let tabelaAtual = '';
    let totalTabelas = 0;

    // ESTA MENSAGEM GARANTE QUE ESTÁS A USAR O CÓDIGO CORRETO
    console.log(`\x1b[32m[SINAL VERDE: A EXECUTAR VERSÃO NOVA - FORMATO RESUMO]\x1b[0m`);
    console.log(`\x1b[36mA ler em modo [${encoding.toUpperCase()}]...\x1b[0m`);

    for await (const linha of rl) {
        let linhaLimpa = linha.trim();
        if (encoding === 'utf16le') {
            linhaLimpa = linhaLimpa.replace(/^\uFEFF/, '');
        }

        // 1. Detetar o início da tabela
        const matchCreate = linhaLimpa.match(/CREATE TABLE\s+`([^`]+)`/i);
        if (matchCreate) {
            tabelaAtual = matchCreate[1];
            escreverStream.write(`TABELA: ${tabelaAtual}\n`);
            escreverStream.write("-".repeat(tabelaAtual.length + 8) + "\n");
            escreverStream.write("Campos:\n");
            totalTabelas++;
            continue;
        }

        // 2. Extrair apenas o que interessa enquanto estiver dentro da tabela
        if (tabelaAtual) {
            
            // Se a linha fechar a tabela (ex: ) ENGINE=InnoDB... ), encerra o bloco
            if (linhaLimpa.startsWith(')') && linhaLimpa.includes(';')) {
                escreverStream.write("\n" + "==================================================\n\n");
                tabelaAtual = '';
                continue;
            }

            // Se for um campo/coluna válido (começa com `)
            if (linhaLimpa.startsWith('`')) {
                const matchCampo = linhaLimpa.match(/^`([^`]+)`\s+(.*)$/);
                if (matchCampo) {
                    const nomeCampo = matchCampo[1];
                    const restoLinha = matchCampo[2];
                    const tipoAmigavel = obterTipoAmigavel(restoLinha);
                    
                    let extras = [];
                    if (linhaLimpa.toUpperCase().includes('AUTO_INCREMENT')) extras.push('Automático');
                    const extraStr = extras.length ? ` (${extras.join(', ')})` : '';
                    
                    escreverStream.write(`  • ${nomeCampo}: ${tipoAmigavel}${extraStr}\n`);
                }
            }
            // Se for a Chave Primária
            else if (linhaLimpa.toUpperCase().startsWith('PRIMARY KEY')) {
                const matchPK = linhaLimpa.match(/PRIMARY KEY\s+\(([^)]+)\)/i);
                if (matchPK) {
                    const camposPK = matchPK[1].replace(/`/g, '').trim();
                    escreverStream.write(`  • [Chave Primária Principal]: ${camposPK}\n`);
                }
            }
            // Se for uma Chave Estrangeira (Relacionamentos)
            else if (linhaLimpa.toUpperCase().includes('FOREIGN KEY')) {
                const matchFK = inlineMatch = linhaLimpa.match(/FOREIGN KEY\s+\(`([^`]+)`\)\s+REFERENCES\s+`([^`]+)`\s+\(`([^`]+)`\)/i);
                if (matchFK) {
                    escreverStream.write(`  • [Ligação / Relacionamento]: O campo '${matchFK[1]}' liga à tabela '${matchFK[2]}' (campo '${matchFK[3]}')\n`);
                }
            }
        }
    }

    escreverStream.end();
    console.log(`\n\x1b[32m--- TERMINADO COM SUCESSO! ---\x1b[0m`);
    console.log(`- Mapeadas: ${totalTabelas} tabelas limpas.`);
    console.log(`- Abre o ficheiro: \x1b[33mestrutura_simplificada.txt\x1b[0m para ver o teu documento.\n`);
}

processarSQL().catch(console.error);