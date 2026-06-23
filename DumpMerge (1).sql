-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: merge_duas_teste
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `app_log`
--

DROP TABLE IF EXISTS `app_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `log_type` varchar(255) NOT NULL,
  `log_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `log_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_user` (`user_id`),
  CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `sec_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_variaveis`
--

DROP TABLE IF EXISTS `app_variaveis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_variaveis` (
  `variavel` varchar(100) DEFAULT NULL,
  `valor` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attachments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bind_type` varchar(64) NOT NULL DEFAULT '',
  `bind_id` int DEFAULT '0',
  `file` varchar(255) DEFAULT NULL,
  `info` varchar(255) DEFAULT NULL,
  `users_id` int DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `fk_users_id` (`users_id`),
  KEY `idx_bind_type` (`bind_type`),
  KEY `idx_bind_id` (`bind_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9672 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bug_comments`
--

DROP TABLE IF EXISTS `bug_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bug_comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bug_id` int NOT NULL,
  `commented_by` int NOT NULL,
  `comment_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `comment_text` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bug_id` (`bug_id`),
  KEY `commented_by` (`commented_by`),
  CONSTRAINT `bug_comments_ibfk_1` FOREIGN KEY (`bug_id`) REFERENCES `bug_reports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bug_comments_ibfk_2` FOREIGN KEY (`commented_by`) REFERENCES `sec_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bug_programs`
--

DROP TABLE IF EXISTS `bug_programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bug_programs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `responsible` int NOT NULL,
  `tipoactivo` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `responsible` (`responsible`),
  CONSTRAINT `bug_programs_ibfk_1` FOREIGN KEY (`responsible`) REFERENCES `sec_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bug_reports`
--

DROP TABLE IF EXISTS `bug_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bug_reports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipoactivo_id` int NOT NULL,
  `program_id` int NOT NULL,
  `report_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `reported_by` int NOT NULL,
  `bug_type` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `image` longblob,
  `accepted` tinyint(1) DEFAULT '0',
  `response` text,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `program_id` (`program_id`),
  KEY `reported_by` (`reported_by`),
  CONSTRAINT `bug_reports_ibfk_1` FOREIGN KEY (`program_id`) REFERENCES `bug_programs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bug_reports_ibfk_2` FOREIGN KEY (`reported_by`) REFERENCES `sec_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bug_tipoactivo`
--

DROP TABLE IF EXISTS `bug_tipoactivo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bug_tipoactivo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `responsavel_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`),
  KEY `responsavel_id` (`responsavel_id`),
  CONSTRAINT `bug_tipoactivo_ibfk_1` FOREIGN KEY (`responsavel_id`) REFERENCES `sec_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendar`
--

DROP TABLE IF EXISTS `calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calendar` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(300) NOT NULL,
  `description` text,
  `start_date` date NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `recurrence` varchar(1) DEFAULT NULL,
  `period` varchar(1) DEFAULT NULL,
  `category` int DEFAULT NULL,
  `id_api` varchar(255) DEFAULT NULL,
  `id_event_google` varchar(255) DEFAULT NULL,
  `recur_info` varchar(255) DEFAULT NULL,
  `event_color` varchar(255) DEFAULT NULL,
  `creator` varchar(255) DEFAULT NULL,
  `reminder` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cq_campos_dinamicos`
--

DROP TABLE IF EXISTS `cq_campos_dinamicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cq_campos_dinamicos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `no_id` int NOT NULL,
  `nome_campo` varchar(100) NOT NULL,
  `tipo_campo` varchar(20) NOT NULL,
  `opcoes` text,
  `obrigatorio` int DEFAULT '0',
  `ordem` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `no_id` (`no_id`),
  CONSTRAINT `cq_campos_dinamicos_ibfk_1` FOREIGN KEY (`no_id`) REFERENCES `cq_nos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cq_nos`
--

DROP TABLE IF EXISTS `cq_nos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cq_nos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `projeto_id` int NOT NULL,
  `pai_id` int DEFAULT NULL,
  `nome` varchar(100) NOT NULL,
  `criado_em` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `projeto_id` (`projeto_id`),
  KEY `pai_id` (`pai_id`),
  CONSTRAINT `cq_nos_ibfk_1` FOREIGN KEY (`projeto_id`) REFERENCES `cq_projetos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cq_nos_ibfk_2` FOREIGN KEY (`pai_id`) REFERENCES `cq_nos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cq_projetos`
--

DROP TABLE IF EXISTS `cq_projetos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cq_projetos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` text,
  `criado_por` int DEFAULT NULL,
  `criado_em` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `criado_por` (`criado_por`),
  CONSTRAINT `fk_projetos_sec_users` FOREIGN KEY (`criado_por`) REFERENCES `sec_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cq_registos`
--

DROP TABLE IF EXISTS `cq_registos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cq_registos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `no_id` int NOT NULL,
  `utilizador_id` int NOT NULL,
  `dados` text NOT NULL,
  `criado_em` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `no_id` (`no_id`),
  KEY `utilizador_id` (`utilizador_id`),
  CONSTRAINT `cq_registos_ibfk_2` FOREIGN KEY (`utilizador_id`) REFERENCES `utilizadores` (`id`),
  CONSTRAINT `fk_registos_sec_users` FOREIGN KEY (`utilizador_id`) REFERENCES `sec_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cq_utilizador_no`
--

DROP TABLE IF EXISTS `cq_utilizador_no`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cq_utilizador_no` (
  `id` int NOT NULL AUTO_INCREMENT,
  `no_id` int DEFAULT NULL,
  `utilizador_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `no_id` (`no_id`),
  KEY `utilizador_id` (`utilizador_id`),
  CONSTRAINT `cq_utilizador_no_ibfk_2` FOREIGN KEY (`utilizador_id`) REFERENCES `utilizadores` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_utilizador_no_sec_users` FOREIGN KEY (`utilizador_id`) REFERENCES `sec_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cq_utilizador_projeto`
--

DROP TABLE IF EXISTS `cq_utilizador_projeto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cq_utilizador_projeto` (
  `projeto_id` int NOT NULL,
  `utilizador_id` int NOT NULL,
  PRIMARY KEY (`projeto_id`,`utilizador_id`),
  KEY `utilizador_id` (`utilizador_id`),
  CONSTRAINT `cq_utilizador_projeto_ibfk_2` FOREIGN KEY (`utilizador_id`) REFERENCES `utilizadores` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_utilizador_projeto_sec_users` FOREIGN KEY (`utilizador_id`) REFERENCES `sec_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dash_digest_log`
--

DROP TABLE IF EXISTS `dash_digest_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dash_digest_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `login` varchar(128) NOT NULL,
  `sent_date` date NOT NULL,
  `email_to` varchar(255) NOT NULL,
  `ok` tinyint(1) NOT NULL DEFAULT '0',
  `error_msg` varchar(500) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_dash_digest_login_date` (`login`,`sent_date`),
  KEY `idx_dash_digest_sent_date` (`sent_date`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dash_digest_prefs`
--

DROP TABLE IF EXISTS `dash_digest_prefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dash_digest_prefs` (
  `login` varchar(128) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `only_if_pending` tinyint(1) NOT NULL DEFAULT '1',
  `last_sent_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `device_tokens`
--

DROP TABLE IF EXISTS `device_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `fcm_token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_token` (`fcm_token`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `device_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sec_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dia_maquinas`
--

DROP TABLE IF EXISTS `dia_maquinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dia_maquinas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dia_id` int NOT NULL,
  `maquina_id` int NOT NULL,
  `horas_total` decimal(6,2) DEFAULT NULL,
  `custo_total` decimal(10,2) NOT NULL DEFAULT '0.00',
  `combustivel_total` decimal(10,2) DEFAULT NULL,
  `nota` varchar(1000) DEFAULT NULL,
  `custo_hora_snapshot` decimal(10,2) DEFAULT NULL,
  `combustivel_hora_snapshot` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dia_id` (`dia_id`),
  KEY `maquina_id` (`maquina_id`),
  CONSTRAINT `dia_maquinas_ibfk_1` FOREIGN KEY (`dia_id`) REFERENCES `dias` (`id`) ON DELETE CASCADE,
  CONSTRAINT `dia_maquinas_ibfk_2` FOREIGN KEY (`maquina_id`) REFERENCES `maquinas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=738 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dia_pessoas`
--

DROP TABLE IF EXISTS `dia_pessoas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dia_pessoas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dia_id` int NOT NULL,
  `pessoa_id` int NOT NULL,
  `horas_total` decimal(6,2) DEFAULT NULL,
  `custo_total` decimal(10,2) DEFAULT NULL,
  `custo_extra` decimal(10,2) DEFAULT '0.00',
  `nota` varchar(1000) DEFAULT NULL,
  `custo_hora_override` decimal(8,2) DEFAULT NULL,
  `custo_hora_snapshot` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dia_id` (`dia_id`),
  KEY `pessoa_id` (`pessoa_id`),
  CONSTRAINT `dia_pessoas_ibfk_1` FOREIGN KEY (`dia_id`) REFERENCES `dias` (`id`) ON DELETE CASCADE,
  CONSTRAINT `dia_pessoas_ibfk_2` FOREIGN KEY (`pessoa_id`) REFERENCES `operadores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2189 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dia_viaturas`
--

DROP TABLE IF EXISTS `dia_viaturas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dia_viaturas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dia_id` int NOT NULL,
  `viatura_id` int NOT NULL,
  `km_total` decimal(8,2) DEFAULT NULL,
  `custo_total` decimal(10,2) DEFAULT NULL,
  `custo_km_snapshot` decimal(10,2) DEFAULT NULL,
  `custo_km_override` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dia_id` (`dia_id`),
  KEY `viatura_id` (`viatura_id`),
  CONSTRAINT `dia_viaturas_ibfk_1` FOREIGN KEY (`dia_id`) REFERENCES `dias` (`id`) ON DELETE CASCADE,
  CONSTRAINT `dia_viaturas_ibfk_2` FOREIGN KEY (`viatura_id`) REFERENCES `viaturas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=622 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dias`
--

DROP TABLE IF EXISTS `dias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `obra_id` int NOT NULL,
  `data` date NOT NULL,
  `estado` enum('aberta','fechada') DEFAULT 'aberta',
  `faturado` double DEFAULT NULL,
  `criado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `valor_to` decimal(10,2) DEFAULT '0.00',
  `nota_valor_to` varchar(1000) DEFAULT NULL,
  `valor_combustivel` decimal(10,2) DEFAULT '0.00',
  `nota_valor_combustivel` varchar(1000) DEFAULT NULL,
  `valor_estadias` decimal(10,2) DEFAULT '0.00',
  `nota_valor_estadias` varchar(1000) DEFAULT NULL,
  `valor_materiais` decimal(10,2) DEFAULT '0.00',
  `nota_valor_materiais` varchar(1000) DEFAULT NULL,
  `valor_refeicoes` decimal(10,2) NOT NULL DEFAULT '0.00',
  `nota_valor_refeicoes` varchar(1000) DEFAULT NULL,
  `qtd_almocos` int NOT NULL DEFAULT '0',
  `qtd_jantares` int NOT NULL DEFAULT '0',
  `custo_almoco_snapshot` decimal(10,2) DEFAULT NULL,
  `custo_jantar_snapshot` decimal(10,2) DEFAULT NULL,
  `custo_almoco_override` decimal(10,2) DEFAULT NULL,
  `custo_jantar_override` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_dia` (`obra_id`,`data`),
  CONSTRAINT `fk_dias_projects` FOREIGN KEY (`obra_id`) REFERENCES `projects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=304 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empresas`
--

DROP TABLE IF EXISTS `empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome_empresa` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `alvara` text,
  `alvara_file` text,
  `nipc_file` text,
  `certidao_permanente` text,
  `declaracao_ss_ndivida_file` text,
  `declaracao_ss_ndivida_validade` date DEFAULT NULL,
  `declaracao_at_ndivida_file` text,
  `declaracao_at_ndivida_validade` date DEFAULT NULL,
  `seguro_acidente_trabalho_apolice` text,
  `seguro_acidente_trabalho_file` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `seguro_acidente_trabalho_validade` date DEFAULT NULL,
  `seguro_rcivil_apolice` text,
  `seguro_rcivil_file` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `seguro_rcivil_validade` date DEFAULT NULL,
  `mapa_seguradora_file` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ferias_lista`
--

DROP TABLE IF EXISTS `ferias_lista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ferias_lista` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `dia_ferias` date DEFAULT NULL,
  `aprovacao` text,
  `nota` varchar(100) DEFAULT NULL,
  `created_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hr_groups`
--

DROP TABLE IF EXISTS `hr_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `manager_user_id` int DEFAULT NULL,
  `hr_approval_required` tinyint(1) DEFAULT '1',
  `active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hr_holidays`
--

DROP TABLE IF EXISTS `hr_holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_holidays` (
  `id` int NOT NULL AUTO_INCREMENT,
  `holiday_date` date NOT NULL,
  `name` varchar(150) NOT NULL,
  `type` varchar(50) DEFAULT 'national',
  `year` int NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hr_timebank_logs`
--

DROP TABLE IF EXISTS `hr_timebank_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_timebank_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action` varchar(50) NOT NULL,
  `details` text,
  `executed_by` varchar(100) DEFAULT NULL,
  `executed_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hr_timebank_movements`
--

DROP TABLE IF EXISTS `hr_timebank_movements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_timebank_movements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `movement_date` date NOT NULL,
  `source_date` date DEFAULT NULL,
  `year_ref` int NOT NULL,
  `week_ref` int DEFAULT NULL,
  `movement_type` varchar(30) NOT NULL,
  `origin` varchar(50) DEFAULT 'auto',
  `hours` decimal(8,2) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `source_table` varchar(100) DEFAULT NULL,
  `source_id` int DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `payroll_processed` tinyint(1) DEFAULT '0',
  `payroll_date` date DEFAULT NULL,
  `payroll_processed_by` varchar(100) DEFAULT NULL,
  `payroll_processed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_date` (`user_id`,`movement_date`),
  KEY `idx_user_year` (`user_id`,`year_ref`),
  KEY `idx_source` (`source_table`,`source_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21465 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hr_timebank_rules`
--

DROP TABLE IF EXISTS `hr_timebank_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_timebank_rules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `year_ref` int NOT NULL,
  `start_date` date DEFAULT NULL,
  `daily_bank_limit` decimal(5,2) DEFAULT '2.00',
  `weekly_normal_hours` decimal(5,2) DEFAULT '40.00',
  `annual_limit` decimal(6,2) DEFAULT '200.00',
  `expiry_month` int DEFAULT '3',
  `expiry_day` int DEFAULT '31',
  `weekend_to_bank` tinyint(1) DEFAULT '0',
  `holiday_to_bank` tinyint(1) DEFAULT '0',
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hr_timebank_users`
--

DROP TABLE IF EXISTS `hr_timebank_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_timebank_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_timebank_user` (`user_id`),
  KEY `idx_user_active` (`user_id`,`active`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hr_user_groups`
--

DROP TABLE IF EXISTS `hr_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_user_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  `is_primary` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hr_vacation_adjustments`
--

DROP TABLE IF EXISTS `hr_vacation_adjustments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_vacation_adjustments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `year` int NOT NULL,
  `days` decimal(5,2) NOT NULL,
  `adjustment_type` varchar(50) NOT NULL,
  `reason` text,
  `created_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hr_vacation_balances`
--

DROP TABLE IF EXISTS `hr_vacation_balances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_vacation_balances` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `year` int NOT NULL,
  `initial_days` decimal(5,2) DEFAULT '0.00',
  `credited_days` decimal(5,2) DEFAULT '0.00',
  `used_days` decimal(5,2) DEFAULT '0.00',
  `pending_days` decimal(5,2) DEFAULT '0.00',
  `available_days` decimal(5,2) DEFAULT '0.00',
  `notes` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_year` (`user_id`,`year`)
) ENGINE=InnoDB AUTO_INCREMENT=1029 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hr_vacation_days`
--

DROP TABLE IF EXISTS `hr_vacation_days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_vacation_days` (
  `id` int NOT NULL AUTO_INCREMENT,
  `request_id` int NOT NULL,
  `user_id` int NOT NULL,
  `vacation_date` date NOT NULL,
  `day_value` decimal(3,2) DEFAULT '1.00',
  `is_weekend` tinyint(1) DEFAULT '0',
  `is_holiday` tinyint(1) DEFAULT '0',
  `status` varchar(30) DEFAULT 'pending',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=976 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hr_vacation_requests`
--

DROP TABLE IF EXISTS `hr_vacation_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_vacation_requests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `total_days` decimal(5,2) DEFAULT '0.00',
  `request_type` varchar(50) DEFAULT 'vacation',
  `status` varchar(30) DEFAULT 'pending_manager',
  `manager_user_id` int DEFAULT NULL,
  `manager_status` varchar(30) DEFAULT 'pending',
  `manager_approval_date` datetime DEFAULT NULL,
  `manager_notes` text,
  `hr_user_id` int DEFAULT NULL,
  `hr_status` varchar(30) DEFAULT 'pending',
  `hr_approval_date` datetime DEFAULT NULL,
  `hr_notes` text,
  `reason` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `leave_type` enum('vacation','timebank') DEFAULT 'vacation',
  `hours_requested` decimal(8,2) DEFAULT NULL,
  `timebank_movement_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=318 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_categorias`
--

DROP TABLE IF EXISTS `inv_categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_categorias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `data_cadastro` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=13210 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_documentos_equipamento`
--

DROP TABLE IF EXISTS `inv_documentos_equipamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_documentos_equipamento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `equipment_id` int NOT NULL,
  `tipo_documento` varchar(100) NOT NULL,
  `nome_arquivo` varchar(255) NOT NULL,
  `conteudo` longblob NOT NULL,
  `data_upload` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `equipment_id` (`equipment_id`),
  CONSTRAINT `inv_documentos_equipamento_ibfk_1` FOREIGN KEY (`equipment_id`) REFERENCES `inv_equipamentos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_email_destinatarios`
--

DROP TABLE IF EXISTS `inv_email_destinatarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_email_destinatarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `data_cadastro` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_email_log`
--

DROP TABLE IF EXISTS `inv_email_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_email_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `equipment_id` int DEFAULT NULL,
  `destinatario` varchar(255) NOT NULL,
  `assunto` varchar(255) NOT NULL,
  `enviado_por` varchar(100) DEFAULT NULL,
  `num_anexos` int DEFAULT '0',
  `data_envio` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `equipment_id` (`equipment_id`),
  CONSTRAINT `inv_email_log_ibfk_1` FOREIGN KEY (`equipment_id`) REFERENCES `inv_equipamentos` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_equipamento_subcategorias`
--

DROP TABLE IF EXISTS `inv_equipamento_subcategorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_equipamento_subcategorias` (
  `equipment_id` int NOT NULL,
  `subcategoria_id` int NOT NULL,
  PRIMARY KEY (`equipment_id`,`subcategoria_id`),
  KEY `idx_inv_equipamento_subcategorias_subcategoria` (`subcategoria_id`),
  CONSTRAINT `inv_equipamento_subcategorias_ibfk_1` FOREIGN KEY (`equipment_id`) REFERENCES `inv_equipamentos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `inv_equipamento_subcategorias_ibfk_2` FOREIGN KEY (`subcategoria_id`) REFERENCES `inv_subcategorias` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_equipamentos`
--

DROP TABLE IF EXISTS `inv_equipamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_equipamentos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` text,
  `marca` varchar(100) DEFAULT NULL,
  `categoria` varchar(100) DEFAULT NULL,
  `inventory_type` enum('individual','quantity') NOT NULL DEFAULT 'individual',
  `is_consumable` tinyint(1) NOT NULL DEFAULT '0',
  `initial_quantity` decimal(12,2) NOT NULL DEFAULT '0.00',
  `unidade` varchar(50) DEFAULT NULL,
  `localizacao` varchar(100) DEFAULT NULL,
  `localizacao_base` varchar(100) DEFAULT NULL,
  `numero_serie` varchar(255) DEFAULT NULL,
  `status` enum('Disponivel','Retirado') DEFAULT 'Disponivel',
  `data_cadastro` datetime DEFAULT CURRENT_TIMESTAMP,
  `observacoes` text,
  `criado_por` varchar(100) DEFAULT NULL,
  `stock_minimo` int NOT NULL DEFAULT '0',
  `ultima_alteracao_por` varchar(120) DEFAULT NULL,
  `ultima_alteracao_em` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_historico`
--

DROP TABLE IF EXISTS `inv_historico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_historico` (
  `id` int NOT NULL AUTO_INCREMENT,
  `equipment_id` int DEFAULT NULL,
  `responsavel` varchar(255) NOT NULL,
  `obra` varchar(255) NOT NULL,
  `tipo` enum('Retirada','Devolução') NOT NULL,
  `assinatura` longtext,
  `observacoes` text,
  `data_evento` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `equipment_id` (`equipment_id`),
  CONSTRAINT `inv_historico_ibfk_1` FOREIGN KEY (`equipment_id`) REFERENCES `inv_equipamentos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_item_logs`
--

DROP TABLE IF EXISTS `inv_item_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_item_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `item_nome` varchar(255) NOT NULL DEFAULT '',
  `acao` enum('edicao','eliminacao') NOT NULL DEFAULT 'edicao',
  `campo` varchar(100) NOT NULL DEFAULT '',
  `valor_anterior` text,
  `valor_novo` text,
  `utilizador_id` int NOT NULL,
  `utilizador_nome` varchar(120) NOT NULL DEFAULT '',
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_inv_item_logs_item` (`item_id`),
  KEY `idx_inv_item_logs_criado` (`criado_em`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_itens_log`
--

DROP TABLE IF EXISTS `inv_itens_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_itens_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `item_nome` varchar(255) NOT NULL DEFAULT '',
  `acao` enum('criacao','edicao','eliminacao') NOT NULL DEFAULT 'edicao',
  `campo` varchar(100) NOT NULL DEFAULT '',
  `valor_anterior` text,
  `valor_novo` text,
  `utilizador_id` int DEFAULT NULL,
  `utilizador_nome` varchar(255) NOT NULL DEFAULT '',
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_inv_itens_log_item` (`item_id`),
  KEY `idx_inv_itens_log_criado` (`criado_em`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_partial_return_tracking`
--

DROP TABLE IF EXISTS `inv_partial_return_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_partial_return_tracking` (
  `id` int NOT NULL AUTO_INCREMENT,
  `original_stock_movement_id` int NOT NULL COMMENT 'ID do stock movement original (saída)',
  `equipment_id` int NOT NULL COMMENT 'ID do equipamento',
  `quantity_withdrawn` decimal(12,2) NOT NULL COMMENT 'Quantidade original levantada',
  `quantity_used` decimal(12,2) DEFAULT NULL COMMENT 'Quantidade utilizada',
  `quantity_returned` decimal(12,2) DEFAULT NULL COMMENT 'Quantidade devolvida',
  `obra_destination` varchar(255) DEFAULT NULL COMMENT 'Para qual obra foi levantado',
  `return_destination` varchar(100) DEFAULT 'Stock Novo' COMMENT 'Para onde foi devolvido',
  `responsible_person` varchar(255) DEFAULT NULL COMMENT 'Pessoa responsável pelo levantamento',
  `observation` text COMMENT 'Observações sobre a devolução',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `completed_at` datetime DEFAULT NULL COMMENT 'Data em que a devolução foi completada',
  `status` enum('pendente','parcial','completo') DEFAULT 'pendente' COMMENT 'Status do rastreamento',
  `signature_base64` longtext,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_original_movement` (`original_stock_movement_id`),
  KEY `idx_equipment` (`equipment_id`),
  KEY `idx_created` (`created_at`),
  CONSTRAINT `inv_partial_return_tracking_ibfk_1` FOREIGN KEY (`original_stock_movement_id`) REFERENCES `inv_stock_movements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `inv_partial_return_tracking_ibfk_2` FOREIGN KEY (`equipment_id`) REFERENCES `inv_equipamentos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_stock_movements`
--

DROP TABLE IF EXISTS `inv_stock_movements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_stock_movements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `equipment_id` int NOT NULL,
  `movement_type` enum('entrada','saida') NOT NULL,
  `quantity` decimal(12,2) NOT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `responsavel` varchar(255) DEFAULT NULL,
  `notes` text,
  `assinatura` longtext COMMENT 'Assinatura digital do movimento',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) DEFAULT NULL,
  `obra` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_inv_stock_movements_equipment_date` (`equipment_id`,`created_at`),
  KEY `idx_inv_stock_movements_type` (`movement_type`),
  KEY `idx_inv_stock_movements_status` (`status`),
  CONSTRAINT `inv_stock_movements_ibfk_1` FOREIGN KEY (`equipment_id`) REFERENCES `inv_equipamentos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_subcategorias`
--

DROP TABLE IF EXISTS `inv_subcategorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_subcategorias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `data_cadastro` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inv_user_pins`
--

DROP TABLE IF EXISTS `inv_user_pins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inv_user_pins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `utilizador_id` int NOT NULL,
  `pin_hash` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `criado_em` datetime DEFAULT CURRENT_TIMESTAMP,
  `atualizado_em` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_inv_user_pins_sec_users` (`utilizador_id`),
  CONSTRAINT `fk_inv_user_pins_sec_users` FOREIGN KEY (`utilizador_id`) REFERENCES `sec_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice_mail_recipients`
--

DROP TABLE IF EXISTS `invoice_mail_recipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_mail_recipients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `login` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `recipient_kind` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'accounting_submit',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_invoice_mail_kind_login` (`recipient_kind`,`login`),
  KEY `idx_invoice_mail_kind_active` (`recipient_kind`,`active`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice_request_files`
--

DROP TABLE IF EXISTS `invoice_request_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_request_files` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invoice_request_id` int NOT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `file_name` varchar(255) NOT NULL,
  `original_file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `uploaded_by` varchar(100) DEFAULT NULL,
  `uploaded_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice_request_lines`
--

DROP TABLE IF EXISTS `invoice_request_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_request_lines` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invoice_request_id` int NOT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `designation` varchar(500) NOT NULL,
  `unit` varchar(30) NOT NULL DEFAULT 'un',
  `qty` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `unit_price` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `discount_percent` decimal(5,2) NOT NULL DEFAULT '0.00',
  `line_net` decimal(14,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `idx_invoice_request_lines_req` (`invoice_request_id`),
  CONSTRAINT `fk_invoice_request_lines_req` FOREIGN KEY (`invoice_request_id`) REFERENCES `invoice_requests` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice_request_status_events`
--

DROP TABLE IF EXISTS `invoice_request_status_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_request_status_events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invoice_request_id` int NOT NULL,
  `old_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `changed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `changed_by_login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `changed_by_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `idx_irse_request` (`invoice_request_id`),
  KEY `idx_irse_changed_at` (`changed_at`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `invoice_requests`
--

DROP TABLE IF EXISTS `invoice_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_requests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `request_code` varchar(40) DEFAULT NULL,
  `client_name` varchar(255) NOT NULL,
  `client_vat` varchar(50) DEFAULT NULL,
  `invoice_sent_by` varchar(32) NOT NULL DEFAULT 'accounting' COMMENT 'requester=quem fez o pedido; accounting=contabilidade',
  `client_address` varchar(500) DEFAULT NULL,
  `client_email` varchar(255) DEFAULT NULL,
  `client_contact_name` varchar(255) DEFAULT NULL,
  `client_phone` varchar(80) DEFAULT NULL,
  `phc_client_clstamp` varchar(64) DEFAULT NULL COMMENT 'clstamp em phc_clientes',
  `phc_client_no` varchar(64) DEFAULT NULL COMMENT 'N.º cliente PHC (cl.no)',
  `client_from_phc` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=seleccionado da base PHC',
  `issuing_company_id` int DEFAULT NULL,
  `issuing_company` varchar(100) DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  `project_name` varchar(255) DEFAULT NULL,
  `cost_center` varchar(100) DEFAULT NULL,
  `purchase_order` varchar(100) DEFAULT NULL,
  `payment_days` int DEFAULT NULL,
  `payment_terms` varchar(100) DEFAULT NULL,
  `description` text NOT NULL,
  `notes` text,
  `amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `vat_rate` decimal(5,2) NOT NULL DEFAULT '23.00',
  `total_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `status` varchar(50) NOT NULL DEFAULT 'draft',
  `created_by` varchar(100) DEFAULT NULL,
  `created_by_name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `submitted_at` datetime DEFAULT NULL,
  `submitted_by` varchar(100) DEFAULT NULL,
  `accounting_status_note` text,
  `final_invoice_number` varchar(100) DEFAULT NULL,
  `final_invoice_sharepoint_url` varchar(1000) DEFAULT NULL,
  `final_invoice_date` date DEFAULT NULL,
  `final_amount` decimal(12,2) DEFAULT NULL,
  `final_total` decimal(12,2) DEFAULT NULL,
  `sent_to_client` tinyint(1) NOT NULL DEFAULT '0',
  `final_invoice_sent_to_client_at` datetime DEFAULT NULL,
  `completed_by` varchar(100) DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `payment_received` tinyint(1) DEFAULT '0',
  `payment_received_date` date DEFAULT NULL,
  `payment_received_amount` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `action` varchar(50) NOT NULL,
  `entity` varchar(50) NOT NULL,
  `entity_id` int DEFAULT NULL,
  `details` text,
  `ip` varchar(45) DEFAULT NULL,
  `method` varchar(10) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_logs_user_id` (`user_id`),
  KEY `idx_logs_action` (`action`),
  KEY `idx_logs_entity` (`entity`),
  KEY `idx_logs_entity_id` (`entity_id`),
  KEY `idx_logs_created` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=524 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `maquinas`
--

DROP TABLE IF EXISTS `maquinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maquinas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `matricula` varchar(20) DEFAULT NULL,
  `custo_hora` decimal(8,2) DEFAULT NULL,
  `combustivel_hora` decimal(8,2) DEFAULT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notif_inbox`
--

DROP TABLE IF EXISTS `notif_inbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notif_inbox` (
  `inbox_id` int NOT NULL AUTO_INCREMENT,
  `notif_id` int NOT NULL,
  `login` varchar(255) NOT NULL,
  `notif_dtsent` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `notif_ontop` int NOT NULL DEFAULT '0',
  `notif_isread` int NOT NULL DEFAULT '0',
  `notif_dtread` datetime DEFAULT NULL,
  `notif_tags` varchar(255) DEFAULT NULL,
  `notif_important` int DEFAULT NULL,
  PRIMARY KEY (`inbox_id`)
) ENGINE=InnoDB AUTO_INCREMENT=918 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notif_notifications`
--

DROP TABLE IF EXISTS `notif_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notif_notifications` (
  `notif_id` int NOT NULL AUTO_INCREMENT,
  `notif_title` varchar(255) NOT NULL,
  `notif_message` text NOT NULL,
  `notif_dtcreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `notif_ontop` int NOT NULL DEFAULT '0',
  `notif_dtexpire` datetime DEFAULT NULL,
  `notif_categ` varchar(60) DEFAULT NULL,
  `notif_login_sender` varchar(255) NOT NULL,
  `notif_type` varchar(60) DEFAULT NULL,
  `notif_link` varchar(255) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`notif_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notif_pref`
--

DROP TABLE IF EXISTS `notif_pref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notif_pref` (
  `login` varchar(255) NOT NULL,
  `receive_email` int NOT NULL DEFAULT '0',
  `receive_sms` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notif_profiles`
--

DROP TABLE IF EXISTS `notif_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notif_profiles` (
  `profile_id` int NOT NULL AUTO_INCREMENT,
  `profile_name` varchar(255) DEFAULT NULL,
  `profile_users` text,
  `profile_groups` text,
  `profile_public` int NOT NULL DEFAULT '0',
  `profile_owner` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notif_tags`
--

DROP TABLE IF EXISTS `notif_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notif_tags` (
  `tag_id` int NOT NULL AUTO_INCREMENT,
  `tag_title` varchar(50) NOT NULL,
  `login` varchar(255) NOT NULL,
  `tag_color` varchar(100) DEFAULT NULL,
  `tag_active` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notif_user_tags`
--

DROP TABLE IF EXISTS `notif_user_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notif_user_tags` (
  `user_tags_id` int NOT NULL AUTO_INCREMENT,
  `login` varchar(255) NOT NULL,
  `login_sender` varchar(255) NOT NULL,
  `tags` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_tags_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `operadores`
--

DROP TABLE IF EXISTS `operadores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operadores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `tipo_vinculo` enum('interno','externo') NOT NULL DEFAULT 'interno',
  `cargo` varchar(100) DEFAULT NULL,
  `categoria_sindical` varchar(100) DEFAULT NULL,
  `custo_hora` decimal(8,2) DEFAULT NULL,
  `pais` varchar(80) DEFAULT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `parametros_custos`
--

DROP TABLE IF EXISTS `parametros_custos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parametros_custos` (
  `chave` varchar(80) NOT NULL,
  `valor` decimal(10,2) NOT NULL DEFAULT '0.00',
  `descricao` varchar(200) DEFAULT NULL,
  `atualizado_em` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`chave`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phc_analitica`
--

DROP TABLE IF EXISTS `phc_analitica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phc_analitica` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `empresa_id` int DEFAULT NULL,
  `cct` varchar(50) NOT NULL COMMENT 'Centro de custo PHC',
  `data` date DEFAULT NULL,
  `conta` varchar(32) DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `descritivo` varchar(255) DEFAULT NULL,
  `docnome` varchar(120) DEFAULT NULL,
  `dinome` varchar(120) DEFAULT NULL,
  `origem` varchar(60) DEFAULT NULL,
  `edeb` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `ecre` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `source_stamp` varchar(80) DEFAULT NULL,
  `synced_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_phc_analitica_cct` (`cct`),
  KEY `idx_phc_analitica_cct_data` (`cct`,`data`),
  KEY `idx_phc_analitica_conta` (`conta`),
  KEY `idx_phc_analitica_empresa` (`empresa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=107158 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phc_clientes`
--

DROP TABLE IF EXISTS `phc_clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phc_clientes` (
  `clstamp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `nome` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ncont` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `morada` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `local` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `empresa_id` int DEFAULT NULL,
  `source_db` varchar(150) DEFAULT NULL,
  `synced_at` datetime DEFAULT NULL,
  KEY `idx_clstamp` (`clstamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phc_compras`
--

DROP TABLE IF EXISTS `phc_compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phc_compras` (
  `id` int NOT NULL AUTO_INCREMENT,
  `empresa_id` int NOT NULL,
  `fostamp` varchar(25) NOT NULL,
  `docnome` varchar(50) DEFAULT NULL,
  `adoc` varchar(100) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `data` datetime DEFAULT NULL,
  `fref` varchar(100) DEFAULT NULL,
  `ccusto` varchar(100) DEFAULT NULL,
  `ettiliq` decimal(18,6) DEFAULT NULL,
  `total` decimal(18,6) DEFAULT NULL,
  `aprovado` tinyint(1) DEFAULT NULL,
  `source_db` varchar(150) DEFAULT NULL,
  `synced_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_fostamp_empresa` (`empresa_id`,`fostamp`),
  KEY `idx_ccusto` (`ccusto`),
  KEY `idx_data` (`data`)
) ENGINE=InnoDB AUTO_INCREMENT=24778 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phc_compras_linhas`
--

DROP TABLE IF EXISTS `phc_compras_linhas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phc_compras_linhas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `empresa_id` int NOT NULL,
  `fnstamp` varchar(25) NOT NULL,
  `fostamp` varchar(25) NOT NULL,
  `docnome` varchar(50) DEFAULT NULL,
  `adoc` varchar(100) DEFAULT NULL,
  `ref` varchar(100) DEFAULT NULL,
  `design` varchar(255) DEFAULT NULL,
  `unidade` varchar(20) DEFAULT NULL,
  `qtt` decimal(18,6) DEFAULT NULL,
  `pv` decimal(18,6) DEFAULT NULL,
  `tiliquido` decimal(18,6) DEFAULT NULL,
  `taxaiva` decimal(8,2) DEFAULT NULL,
  `fnccusto` varchar(100) DEFAULT NULL,
  `fnfref` varchar(100) DEFAULT NULL,
  `source_db` varchar(150) DEFAULT NULL,
  `synced_at` datetime DEFAULT NULL,
  `etiliquido` decimal(18,6) DEFAULT NULL,
  `iva` decimal(18,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_compra_linha` (`empresa_id`,`fnstamp`),
  KEY `idx_fostamp` (`fostamp`),
  KEY `idx_fnccusto` (`fnccusto`)
) ENGINE=InnoDB AUTO_INCREMENT=40525 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phc_empresas`
--

DROP TABLE IF EXISTS `phc_empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phc_empresas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome_empresa` varchar(150) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `sqlserver_host` varchar(150) NOT NULL,
  `sqlserver_port` int DEFAULT '1433',
  `sqlserver_database` varchar(150) NOT NULL,
  `sqlserver_username` varchar(100) NOT NULL,
  `sqlserver_password` text NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `last_sync_at` datetime DEFAULT NULL,
  `last_sync_status` varchar(30) DEFAULT NULL,
  `last_sync_message` text,
  `empresa_grupo_id` int DEFAULT NULL COMMENT 'empresas.id',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_empresa_grupo` (`empresa_grupo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phc_fornecedores`
--

DROP TABLE IF EXISTS `phc_fornecedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phc_fornecedores` (
  `flstamp` varchar(255) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `morada` varchar(255) DEFAULT NULL,
  `local` varchar(255) DEFAULT NULL,
  `codpost` varchar(255) DEFAULT NULL,
  `ncont` varchar(255) DEFAULT NULL,
  `empresa_id` int DEFAULT NULL,
  `source_db` varchar(150) DEFAULT NULL,
  `synced_at` datetime DEFAULT NULL,
  KEY `idx_flstamp` (`flstamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phc_rh_costs`
--

DROP TABLE IF EXISTS `phc_rh_costs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phc_rh_costs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `empresa_id` int NOT NULL,
  `source_db` varchar(255) DEFAULT NULL,
  `prstamp` varchar(64) NOT NULL,
  `prccstamp` varchar(80) NOT NULL,
  `funcionario_no` varchar(64) DEFAULT NULL,
  `funcionario_nome` varchar(255) DEFAULT NULL,
  `recibo` varchar(64) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `ano` int DEFAULT NULL,
  `mes` int DEFAULT NULL,
  `mesref` varchar(32) DEFAULT NULL,
  `seccao` varchar(128) DEFAULT NULL,
  `ccategoria` varchar(128) DEFAULT NULL,
  `ccprofiss` varchar(128) DEFAULT NULL,
  `ccusto_original` varchar(64) DEFAULT NULL,
  `ccusto_imputado` varchar(64) DEFAULT NULL,
  `pct_imputacao` decimal(8,3) DEFAULT NULL,
  `horasmes` decimal(18,6) DEFAULT NULL,
  `horasextra` decimal(18,6) DEFAULT NULL,
  `horasfalta` decimal(18,6) DEFAULT NULL,
  `liquido` decimal(18,6) DEFAULT NULL,
  `eliquido` decimal(18,6) DEFAULT NULL,
  `basemes` decimal(18,6) DEFAULT NULL,
  `ebasemes` decimal(18,6) DEFAULT NULL,
  `subsidio` decimal(18,6) DEFAULT NULL,
  `esubsidio` decimal(18,6) DEFAULT NULL,
  `bonus` decimal(18,6) DEFAULT NULL,
  `ebonus` decimal(18,6) DEFAULT NULL,
  `acidente` decimal(18,6) DEFAULT NULL,
  `eacidente` decimal(18,6) DEFAULT NULL,
  `ssevalor` decimal(18,6) DEFAULT NULL,
  `essevalor` decimal(18,6) DEFAULT NULL,
  `sshextra` decimal(18,6) DEFAULT NULL,
  `esshextra` decimal(18,6) DEFAULT NULL,
  `fctvalor` decimal(18,6) DEFAULT NULL,
  `efctvalor` decimal(18,6) DEFAULT NULL,
  `fgctvalor` decimal(18,6) DEFAULT NULL,
  `efgctvalor` decimal(18,6) DEFAULT NULL,
  `adseevalor` decimal(18,6) DEFAULT NULL,
  `eadseevalor` decimal(18,6) DEFAULT NULL,
  `ttsuj` decimal(18,6) DEFAULT NULL,
  `ettsuj` decimal(18,6) DEFAULT NULL,
  `ttnsuj` decimal(18,6) DEFAULT NULL,
  `ettnsuj` decimal(18,6) DEFAULT NULL,
  `ttdesc` decimal(18,6) DEFAULT NULL,
  `ettdesc` decimal(18,6) DEFAULT NULL,
  `custo_total_empresa` decimal(18,6) DEFAULT NULL,
  `custo_imputado` decimal(18,6) DEFAULT NULL,
  `pago` int DEFAULT NULL,
  `dpago` date DEFAULT NULL,
  `phc_usrdata` datetime DEFAULT NULL,
  `phc_ousrdata` datetime DEFAULT NULL,
  `synced_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_empresa_prcc` (`empresa_id`,`prccstamp`),
  KEY `idx_empresa_data` (`empresa_id`,`data`),
  KEY `idx_empresa_ano_mes` (`empresa_id`,`ano`,`mes`),
  KEY `idx_ccusto_imputado` (`empresa_id`,`ccusto_imputado`),
  KEY `idx_prstamp` (`empresa_id`,`prstamp`)
) ENGINE=InnoDB AUTO_INCREMENT=6461 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phc_sync_jobs`
--

DROP TABLE IF EXISTS `phc_sync_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phc_sync_jobs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `empresa_id` int NOT NULL,
  `job_type` varchar(50) NOT NULL,
  `status` varchar(30) DEFAULT 'pending',
  `started_at` datetime DEFAULT NULL,
  `finished_at` datetime DEFAULT NULL,
  `records_found` int DEFAULT '0',
  `records_inserted` int DEFAULT '0',
  `records_updated` int DEFAULT '0',
  `error_message` text,
  `triggered_by` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_empresa` (`empresa_id`),
  KEY `idx_status` (`status`),
  KEY `idx_job_type` (`job_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phc_sync_log`
--

DROP TABLE IF EXISTS `phc_sync_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phc_sync_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `empresa_id` int DEFAULT NULL,
  `sync_type` varchar(50) NOT NULL,
  `level` varchar(20) NOT NULL DEFAULT 'info',
  `message` text,
  `found` int DEFAULT '0',
  `inserted` int DEFAULT '0',
  `updated` int DEFAULT '0',
  `error` text,
  `started_at` datetime NOT NULL,
  `finished_at` datetime DEFAULT NULL,
  `duration_seconds` decimal(12,3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_empresa_started` (`empresa_id`,`started_at`),
  KEY `idx_sync_type` (`sync_type`),
  KEY `idx_started` (`started_at`)
) ENGINE=InnoDB AUTO_INCREMENT=568 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phc_sync_scripts`
--

DROP TABLE IF EXISTS `phc_sync_scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phc_sync_scripts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `script_key` varchar(100) NOT NULL,
  `nome` varchar(150) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `codigo` longtext,
  `active` tinyint(1) DEFAULT '1',
  `last_saved_by` varchar(100) DEFAULT NULL,
  `last_saved_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `script_key` (`script_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phc_sync_state`
--

DROP TABLE IF EXISTS `phc_sync_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phc_sync_state` (
  `id` int NOT NULL AUTO_INCREMENT,
  `empresa_id` int NOT NULL,
  `sync_type` varchar(50) NOT NULL,
  `last_success_at` datetime DEFAULT NULL,
  `last_run_at` datetime DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `message` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_empresa_sync` (`empresa_id`,`sync_type`),
  KEY `idx_empresa` (`empresa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=236 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phc_vendas`
--

DROP TABLE IF EXISTS `phc_vendas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phc_vendas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `empresa_id` int NOT NULL,
  `ftstamp` varchar(25) NOT NULL,
  `nmdoc` varchar(50) DEFAULT NULL,
  `fno` varchar(50) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `fdata` datetime DEFAULT NULL,
  `fref` varchar(100) DEFAULT NULL,
  `ccusto` varchar(100) DEFAULT NULL,
  `ettiliq` decimal(18,6) DEFAULT NULL,
  `onoff` varchar(1) DEFAULT NULL,
  `source_db` varchar(150) DEFAULT NULL,
  `synced_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_ftstamp_empresa` (`empresa_id`,`ftstamp`),
  KEY `idx_ccusto` (`ccusto`),
  KEY `idx_fdata` (`fdata`)
) ENGINE=InnoDB AUTO_INCREMENT=1797 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `phc_vendas_linhas`
--

DROP TABLE IF EXISTS `phc_vendas_linhas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `phc_vendas_linhas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `empresa_id` int NOT NULL,
  `fistamp` varchar(25) NOT NULL,
  `ftstamp` varchar(25) NOT NULL,
  `nmdoc` varchar(50) DEFAULT NULL,
  `fno` varchar(50) DEFAULT NULL,
  `ref` varchar(100) DEFAULT NULL,
  `design` varchar(255) DEFAULT NULL,
  `unidade` varchar(20) DEFAULT NULL,
  `qtt` decimal(18,6) DEFAULT NULL,
  `pv` decimal(18,6) DEFAULT NULL,
  `tiliquido` decimal(18,6) DEFAULT NULL,
  `iva` decimal(8,2) DEFAULT NULL,
  `ficcusto` varchar(100) DEFAULT NULL,
  `fifref` varchar(100) DEFAULT NULL,
  `source_db` varchar(150) DEFAULT NULL,
  `synced_at` datetime DEFAULT NULL,
  `etiliquido` decimal(18,6) DEFAULT NULL,
  `taxaiva` decimal(18,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_venda_linha` (`empresa_id`,`fistamp`),
  KEY `idx_ftstamp` (`ftstamp`),
  KEY `idx_ficcusto` (`ficcusto`)
) ENGINE=InnoDB AUTO_INCREMENT=9958 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_budget`
--

DROP TABLE IF EXISTS `project_budget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_budget` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `version` int NOT NULL DEFAULT '1',
  `source` enum('manual','excel_import','estimated_only') NOT NULL DEFAULT 'manual',
  `status` enum('draft','active','closed') NOT NULL DEFAULT 'draft',
  `total_sale` decimal(18,2) NOT NULL DEFAULT '0.00',
  `total_dry` decimal(18,2) NOT NULL DEFAULT '0.00',
  `margin_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `amount_m` decimal(18,2) NOT NULL DEFAULT '0.00',
  `amount_h` decimal(18,2) NOT NULL DEFAULT '0.00',
  `amount_e` decimal(18,2) NOT NULL DEFAULT '0.00',
  `amount_s` decimal(18,2) NOT NULL DEFAULT '0.00',
  `amount_t` decimal(18,2) NOT NULL DEFAULT '0.00',
  `amount_n` decimal(18,2) NOT NULL DEFAULT '0.00',
  `budget_h_hours` decimal(18,2) DEFAULT NULL COMMENT 'Horas MO previstas (explícitas ou derivadas)',
  `budget_h_rate` decimal(18,4) DEFAULT NULL COMMENT 'Taxa €/h referência orçamento',
  `billing_mode` enum('measurement','global','milestones') NOT NULL DEFAULT 'measurement',
  `ref_orc_snapshot` varchar(120) DEFAULT NULL,
  `notes` text,
  `created_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_project_budget_project` (`project_id`),
  KEY `idx_project_budget_status` (`project_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_budget_lines`
--

DROP TABLE IF EXISTS `project_budget_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_budget_lines` (
  `id` int NOT NULL AUTO_INCREMENT,
  `budget_id` int NOT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `line_no` varchar(32) DEFAULT NULL,
  `chapter` varchar(32) DEFAULT NULL,
  `description` varchar(500) NOT NULL DEFAULT '',
  `qty` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `unit` varchar(16) DEFAULT NULL,
  `unit_price_sale` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `amount_sale` decimal(18,2) NOT NULL DEFAULT '0.00',
  `unit_cost_dry` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `amount_dry` decimal(18,2) NOT NULL DEFAULT '0.00',
  `margin_factor` decimal(10,4) DEFAULT NULL,
  `cost_type` char(1) DEFAULT NULL COMMENT 'M H E S T N',
  `client_visible` tinyint(1) NOT NULL DEFAULT '1',
  `client_show_unit_price` tinyint(1) NOT NULL DEFAULT '1',
  `client_show_amount` tinyint(1) NOT NULL DEFAULT '1',
  `parent_line_id` int DEFAULT NULL,
  `notes` varchar(500) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_budget_lines_budget` (`budget_id`),
  KEY `idx_budget_lines_sort` (`budget_id`,`sort_order`),
  CONSTRAINT `fk_budget_lines_budget` FOREIGN KEY (`budget_id`) REFERENCES `project_budget` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2735 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_budget_measurement_lines`
--

DROP TABLE IF EXISTS `project_budget_measurement_lines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_budget_measurement_lines` (
  `id` int NOT NULL AUTO_INCREMENT,
  `measurement_id` int NOT NULL,
  `budget_line_id` int NOT NULL,
  `qty_contract` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `qty_prev_cumulative` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `qty_this_period` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `qty_cumulative` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `unit_price_sale` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `amount_this_period` decimal(18,2) NOT NULL DEFAULT '0.00',
  `notes` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_pbml_measurement` (`measurement_id`),
  KEY `idx_pbml_budget_line` (`budget_line_id`),
  CONSTRAINT `fk_pbml_budget_line` FOREIGN KEY (`budget_line_id`) REFERENCES `project_budget_lines` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_pbml_measurement` FOREIGN KEY (`measurement_id`) REFERENCES `project_budget_measurements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_budget_measurements`
--

DROP TABLE IF EXISTS `project_budget_measurements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_budget_measurements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `budget_id` int NOT NULL,
  `project_id` int NOT NULL,
  `measurement_no` varchar(32) NOT NULL DEFAULT '',
  `period_year` smallint DEFAULT NULL,
  `period_month` tinyint DEFAULT NULL,
  `measurement_date` date DEFAULT NULL,
  `status` enum('draft','approved','invoiced','cancelled') NOT NULL DEFAULT 'draft',
  `total_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `notes` text,
  `created_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_pbm_project` (`project_id`),
  KEY `idx_pbm_budget` (`budget_id`),
  KEY `idx_pbm_status` (`project_id`,`status`),
  CONSTRAINT `fk_pbm_budget` FOREIGN KEY (`budget_id`) REFERENCES `project_budget` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `projects_status_id` int DEFAULT NULL,
  `projects_priority_id` int DEFAULT NULL,
  `projects_types_id` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `ccusto` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `ref_orc` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `cliente` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `dono_obra` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `gest_proj` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `team` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `valor_estimado` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `data_inicio` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `is_public` tinyint DEFAULT NULL,
  `in_trash` tinyint(1) DEFAULT NULL,
  `in_trash_date` int DEFAULT NULL,
  `departments` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `empresa_id` int DEFAULT NULL,
  `analitica_compras` decimal(10,0) DEFAULT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  `orcamento` decimal(10,2) DEFAULT NULL,
  `fo_panel_id` int DEFAULT NULL,
  `fo_panel_cliente` text,
  `fo_panel_synced_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `projects_projects_status_FK` (`projects_status_id`),
  KEY `projects_projects_priority_FK` (`projects_priority_id`),
  KEY `projects_projects_types_FK` (`projects_types_id`),
  CONSTRAINT `projects_projects_priority_FK` FOREIGN KEY (`projects_priority_id`) REFERENCES `projects_priority` (`id`),
  CONSTRAINT `projects_projects_status_FK` FOREIGN KEY (`projects_status_id`) REFERENCES `projects_status` (`id`),
  CONSTRAINT `projects_projects_types_FK` FOREIGN KEY (`projects_types_id`) REFERENCES `projects_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1528 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects_comments`
--

DROP TABLE IF EXISTS `projects_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects_comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `projects_id` int NOT NULL DEFAULT '0',
  `created_by` int DEFAULT NULL,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `created_at` datetime DEFAULT NULL,
  `projects_status_id` int DEFAULT NULL,
  `in_trash` tinyint(1) DEFAULT NULL,
  `in_trash_date` int DEFAULT NULL,
  `projects_priority_id` int DEFAULT NULL,
  `projects_types_id` int DEFAULT NULL,
  `projects_groups_id` int DEFAULT NULL,
  `comment_file` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1580 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects_phases`
--

DROP TABLE IF EXISTS `projects_phases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects_phases` (
  `id` int NOT NULL AUTO_INCREMENT,
  `projects_id` int NOT NULL DEFAULT '0',
  `phases_status_id` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `due_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects_priority`
--

DROP TABLE IF EXISTS `projects_priority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects_priority` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `icon` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `sort_order` int DEFAULT NULL,
  `default_value` tinyint(1) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects_status`
--

DROP TABLE IF EXISTS `projects_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `status_group` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `sort_order` int DEFAULT '0',
  `default_value` tinyint(1) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `background_color` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects_types`
--

DROP TABLE IF EXISTS `projects_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `sort_order` int DEFAULT '0',
  `active` tinyint(1) DEFAULT NULL,
  `extra_fields` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `tasks_columns_list` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `background_color` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `default_value` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchase_approval_rules`
--

DROP TABLE IF EXISTS `purchase_approval_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_approval_rules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `min_value` decimal(14,2) DEFAULT '0.00',
  `max_value` decimal(14,2) DEFAULT NULL,
  `approval_level` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchase_approvals`
--

DROP TABLE IF EXISTS `purchase_approvals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_approvals` (
  `id` int NOT NULL AUTO_INCREMENT,
  `purchase_request_id` int NOT NULL,
  `approval_step` varchar(50) NOT NULL,
  `approver_user_id` int DEFAULT NULL,
  `status` varchar(30) DEFAULT 'pending',
  `approved_at` datetime DEFAULT NULL,
  `rejected_at` datetime DEFAULT NULL,
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_pa_approver` (`approver_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchase_files`
--

DROP TABLE IF EXISTS `purchase_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_files` (
  `id` int NOT NULL AUTO_INCREMENT,
  `entity_type` varchar(20) NOT NULL,
  `entity_id` int NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_type` varchar(100) DEFAULT NULL,
  `uploaded_by_id` int DEFAULT NULL,
  `uploaded_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_pf_entity` (`entity_type`,`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchase_order_items`
--

DROP TABLE IF EXISTS `purchase_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `purchase_order_id` int NOT NULL,
  `description` varchar(500) NOT NULL,
  `quantity` decimal(14,3) DEFAULT '1.000',
  `received_quantity` decimal(14,3) DEFAULT '0.000',
  `unit` varchar(50) DEFAULT 'un',
  `unit_price` decimal(14,2) DEFAULT '0.00',
  `vat_rate` decimal(5,2) DEFAULT '23.00',
  `total_without_vat` decimal(14,2) DEFAULT '0.00',
  `vat_value` decimal(14,2) DEFAULT '0.00',
  `total_with_vat` decimal(14,2) DEFAULT '0.00',
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `quantity_received` decimal(14,3) DEFAULT '0.000',
  `quantity_pending` decimal(14,3) DEFAULT '0.000',
  PRIMARY KEY (`id`),
  KEY `idx_poi_order` (`purchase_order_id`),
  CONSTRAINT `fk_poi_order` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchase_order_receipts`
--

DROP TABLE IF EXISTS `purchase_order_receipts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_order_receipts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `purchase_order_id` int NOT NULL,
  `purchase_order_item_id` int DEFAULT NULL,
  `quantity_received` decimal(14,3) DEFAULT '0.000',
  `received_date` date DEFAULT NULL,
  `received_by_id` int DEFAULT NULL,
  `received_by_name` varchar(255) DEFAULT NULL,
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_por_po` (`purchase_order_id`),
  KEY `idx_por_item` (`purchase_order_item_id`),
  KEY `idx_por_date` (`received_date`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchase_orders`
--

DROP TABLE IF EXISTS `purchase_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `purchase_request_id` int DEFAULT NULL,
  `project_id` int DEFAULT NULL,
  `empresa_id` int DEFAULT NULL,
  `ccusto` text,
  `analitica_compras` decimal(10,0) DEFAULT NULL,
  `po_number` varchar(50) NOT NULL,
  `po_year` int NOT NULL,
  `supplier_name` varchar(255) NOT NULL,
  `supplier_vat` varchar(50) DEFAULT NULL,
  `supplier_email` varchar(255) DEFAULT NULL,
  `supplier_phone` varchar(50) DEFAULT NULL,
  `supplier_address` text,
  `status` varchar(30) DEFAULT 'draft',
  `total_without_vat` decimal(14,2) DEFAULT '0.00',
  `vat_value` decimal(14,2) DEFAULT '0.00',
  `total_with_vat` decimal(14,2) DEFAULT '0.00',
  `issue_date` date DEFAULT NULL,
  `expected_delivery_date` date DEFAULT NULL,
  `payment_terms` varchar(255) DEFAULT NULL,
  `delivery_address` text,
  `notes` text,
  `created_by_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `delivery_contact_user_id` int DEFAULT NULL,
  `delivery_contact_name` varchar(255) DEFAULT NULL,
  `delivery_contact_phone` varchar(50) DEFAULT NULL,
  `delivery_contact_email` varchar(255) DEFAULT NULL,
  `sent_at` datetime DEFAULT NULL,
  `sent_by_id` int DEFAULT NULL,
  `received_at` datetime DEFAULT NULL,
  `invoiced_at` datetime DEFAULT NULL,
  `invoice_number` varchar(100) DEFAULT NULL,
  `invoice_date` date DEFAULT NULL,
  `invoice_total` decimal(14,2) DEFAULT NULL,
  `updated_by_id` int DEFAULT NULL,
  `invoiced_by_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_po_number` (`po_number`),
  KEY `idx_po_empresa` (`empresa_id`),
  KEY `idx_po_project` (`project_id`),
  KEY `idx_po_status` (`status`),
  KEY `idx_po_request` (`purchase_request_id`),
  CONSTRAINT `fk_po_request` FOREIGN KEY (`purchase_request_id`) REFERENCES `purchase_requests` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchase_request_items`
--

DROP TABLE IF EXISTS `purchase_request_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_request_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `purchase_request_id` int NOT NULL,
  `description` varchar(500) NOT NULL,
  `quantity` decimal(14,3) DEFAULT '1.000',
  `unit` varchar(50) DEFAULT 'un',
  `unit_price` decimal(14,2) DEFAULT '0.00',
  `vat_rate` decimal(5,2) DEFAULT '23.00',
  `total_without_vat` decimal(14,2) DEFAULT '0.00',
  `vat_value` decimal(14,2) DEFAULT '0.00',
  `total_with_vat` decimal(14,2) DEFAULT '0.00',
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_pri_request` (`purchase_request_id`),
  CONSTRAINT `fk_pri_request` FOREIGN KEY (`purchase_request_id`) REFERENCES `purchase_requests` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchase_request_logs`
--

DROP TABLE IF EXISTS `purchase_request_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_request_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `purchase_request_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `old_status` varchar(50) DEFAULT NULL,
  `new_status` varchar(50) DEFAULT NULL,
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_prl_request` (`purchase_request_id`),
  KEY `idx_prl_user` (`user_id`),
  KEY `idx_prl_action` (`action`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchase_requests`
--

DROP TABLE IF EXISTS `purchase_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_requests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_id` int DEFAULT NULL,
  `empresa_id` int DEFAULT NULL,
  `requested_by_id` int DEFAULT NULL,
  `request_code` varchar(50) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `ccusto` text,
  `analitica_compras` decimal(10,0) DEFAULT NULL,
  `supplier_id` int DEFAULT NULL,
  `supplier_name` varchar(255) DEFAULT NULL,
  `supplier_vat` varchar(50) DEFAULT NULL,
  `supplier_email` varchar(255) DEFAULT NULL,
  `supplier_phone` varchar(50) DEFAULT NULL,
  `payment_days` int DEFAULT NULL,
  `priority` varchar(20) DEFAULT 'normal',
  `status` varchar(30) DEFAULT 'draft',
  `estimated_total` decimal(14,2) DEFAULT '0.00',
  `estimated_vat` decimal(14,2) DEFAULT '0.00',
  `estimated_total_with_vat` decimal(14,2) DEFAULT '0.00',
  `needed_date` date DEFAULT NULL,
  `admin_notes` text,
  `rejection_reason` text,
  `submitted_at` datetime DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `rejected_at` datetime DEFAULT NULL,
  `approved_by_id` int DEFAULT NULL,
  `rejected_by_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `delivery_address` text,
  `delivery_contact_user_id` int DEFAULT NULL,
  `delivery_contact_name` varchar(255) DEFAULT NULL,
  `delivery_contact_phone` varchar(50) DEFAULT NULL,
  `delivery_contact_email` varchar(255) DEFAULT NULL,
  `delivery_notes` text,
  `responsible_user_id` int DEFAULT NULL,
  `responsible_name` varchar(255) DEFAULT NULL,
  `responsible_phone` varchar(50) DEFAULT NULL,
  `responsible_email` varchar(255) DEFAULT NULL,
  `approval_level_required` varchar(50) DEFAULT 'project_responsible',
  `approval_status` varchar(50) DEFAULT 'pending',
  `is_locked` tinyint(1) DEFAULT '0',
  `locked_at` datetime DEFAULT NULL,
  `locked_reason` varchar(255) DEFAULT NULL,
  `manager_approved_at` datetime DEFAULT NULL,
  `manager_approved_by` int DEFAULT NULL,
  `admin_approved_at` datetime DEFAULT NULL,
  `admin_approved_by` int DEFAULT NULL,
  `rejected_by` int DEFAULT NULL,
  `created_by_id` int DEFAULT NULL,
  `updated_by_id` int DEFAULT NULL,
  `submitted_by_id` int DEFAULT NULL,
  `po_created_by_id` int DEFAULT NULL,
  `po_created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_pr_project` (`project_id`),
  KEY `idx_pr_empresa` (`empresa_id`),
  KEY `idx_pr_status` (`status`),
  KEY `idx_pr_requested_by` (`requested_by_id`),
  KEY `idx_pr_supplier` (`supplier_id`),
  KEY `idx_purchase_requests_payment_days` (`payment_days`),
  CONSTRAINT `chk_purchase_requests_payment_days_non_negative` CHECK (((`payment_days` is null) or (`payment_days` >= 0)))
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchase_status_history`
--

DROP TABLE IF EXISTS `purchase_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_status_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `entity_type` varchar(20) NOT NULL,
  `entity_id` int NOT NULL,
  `old_status` varchar(50) DEFAULT NULL,
  `new_status` varchar(50) NOT NULL,
  `changed_by_id` int DEFAULT NULL,
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_psh_entity` (`entity_type`,`entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rf_formacao_pedido`
--

DROP TABLE IF EXISTS `rf_formacao_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rf_formacao_pedido` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `nome_formacao` text NOT NULL,
  `data_prevista` date DEFAULT NULL,
  `justificativo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `entidade_formadora` text NOT NULL,
  `local_formacao` text,
  `budget_formacao` double DEFAULT NULL,
  `horario_trabalho` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rh_categorias_profissionais`
--

DROP TABLE IF EXISTS `rh_categorias_profissionais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rh_categorias_profissionais` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categoria_profissional` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rh_ficha_funcionario`
--

DROP TABLE IF EXISTS `rh_ficha_funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rh_ficha_funcionario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `empresa_id` int DEFAULT NULL,
  `cat_profissional_id` int DEFAULT NULL,
  `gerenciamento_obra` text,
  `superior_hierarquico` int DEFAULT NULL,
  `aprovar_horas` text,
  `nif` text,
  `niss` text,
  `data_nascimento` date DEFAULT NULL,
  `cc` text,
  `cc_validade` date DEFAULT NULL,
  `passaport` text,
  `passaport_validade` date DEFAULT NULL,
  `titulo_residencia` text,
  `titulo_residencia_validade` date DEFAULT NULL,
  `titulo_residencia_ficheiro` text,
  `carta_conducao` text,
  `carta_conducao_validade` date DEFAULT NULL,
  `carta_conducao_ficheiro` text,
  `morada` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `telefone` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `email` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `calcado` text,
  `roupa` text,
  `pessoa_contacto` text,
  `pessoa_contacto_telefone` text,
  `pessoa_contacto_email` text,
  `fam_data` date DEFAULT NULL,
  `fam_validade` date DEFAULT NULL,
  `fam_file` text,
  `ficha_epi_data` date DEFAULT NULL,
  `ficha_epi_ficheiro` text,
  `admissao_ssocial_file` text,
  `dias_ferias_ano_autorizadas` int DEFAULT NULL,
  `dias_ferias_ano_gozadas` int DEFAULT NULL,
  `dias_ferias_saldo` int DEFAULT NULL,
  `active` varchar(1) DEFAULT NULL,
  `nomecompleto` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rh_ficha_funcionario_unique` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rh_formacoes`
--

DROP TABLE IF EXISTS `rh_formacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rh_formacoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` text NOT NULL,
  `formacao` longtext,
  `formacao_file` text,
  `formacao_data` date DEFAULT NULL,
  `formacao_validade` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rh_user_hourly_rates`
--

DROP TABLE IF EXISTS `rh_user_hourly_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rh_user_hourly_rates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT 'sec_users.id',
  `custo_hora` decimal(18,6) NOT NULL COMMENT 'Custo empresa €/h (s/ IVA)',
  `valid_from` date NOT NULL COMMENT 'Primeiro dia inclusive',
  `valid_to` date DEFAULT NULL COMMENT 'Último dia inclusive; NULL = vigente',
  `notes` varchar(500) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_rhur_user_from` (`user_id`,`valid_from`),
  KEY `idx_rhur_user_to` (`user_id`,`valid_to`),
  CONSTRAINT `fk_rhur_user` FOREIGN KEY (`user_id`) REFERENCES `sec_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sec_apps`
--

DROP TABLE IF EXISTS `sec_apps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sec_apps` (
  `app_name` varchar(128) NOT NULL,
  `app_type` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`app_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sec_groups`
--

DROP TABLE IF EXISTS `sec_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sec_groups` (
  `group_id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sec_groups_apps`
--

DROP TABLE IF EXISTS `sec_groups_apps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sec_groups_apps` (
  `group_id` int NOT NULL,
  `app_name` varchar(128) NOT NULL,
  `priv_access` varchar(1) DEFAULT NULL,
  `priv_insert` varchar(1) DEFAULT NULL,
  `priv_delete` varchar(1) DEFAULT NULL,
  `priv_update` varchar(1) DEFAULT NULL,
  `priv_export` varchar(1) DEFAULT NULL,
  `priv_print` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`group_id`,`app_name`),
  KEY `sec_groups_apps_ibfk_2` (`app_name`),
  CONSTRAINT `sec_groups_apps_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `sec_groups` (`group_id`) ON DELETE CASCADE,
  CONSTRAINT `sec_groups_apps_ibfk_2` FOREIGN KEY (`app_name`) REFERENCES `sec_apps` (`app_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sec_log`
--

DROP TABLE IF EXISTS `sec_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sec_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `inserted_date` datetime DEFAULT NULL,
  `username` varchar(90) NOT NULL,
  `application` varchar(255) NOT NULL,
  `creator` varchar(30) NOT NULL,
  `ip_user` varchar(255) NOT NULL,
  `action` varchar(30) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4148823 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sec_logged`
--

DROP TABLE IF EXISTS `sec_logged`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sec_logged` (
  `login` varchar(255) NOT NULL,
  `date_login` varchar(128) DEFAULT NULL,
  `sc_session` varchar(128) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sec_settings`
--

DROP TABLE IF EXISTS `sec_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sec_settings` (
  `set_name` varchar(255) NOT NULL,
  `set_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sec_users`
--

DROP TABLE IF EXISTS `sec_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sec_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `login` varchar(255) NOT NULL,
  `pswd` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `active` varchar(1) DEFAULT NULL,
  `activation_code` varchar(32) DEFAULT NULL,
  `priv_admin` varchar(1) DEFAULT NULL,
  `mfa` varchar(255) DEFAULT NULL,
  `picture` longblob,
  `role` varchar(128) DEFAULT NULL,
  `phone` varchar(64) DEFAULT NULL,
  `pswd_last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `mfa_last_updated` timestamp NULL DEFAULT NULL,
  `refresh_token` text,
  `tema_preferido` varchar(10) DEFAULT 'system',
  `perfil_inventario` enum('utilizador','gestor_armazem') NOT NULL DEFAULT 'utilizador' COMMENT 'Perfil exclusivo do inventário FOeng',
  `criado_em` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`login`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=505 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sec_users_groups`
--

DROP TABLE IF EXISTS `sec_users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sec_users_groups` (
  `login` varchar(255) NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`login`,`group_id`),
  KEY `sec_users_groups_ibfk_2` (`group_id`),
  CONSTRAINT `sec_users_groups_ibfk_1` FOREIGN KEY (`login`) REFERENCES `sec_users` (`login`) ON DELETE CASCADE,
  CONSTRAINT `sec_users_groups_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `sec_groups` (`group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `semana_maquinas`
--

DROP TABLE IF EXISTS `semana_maquinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semana_maquinas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `semana_id` int NOT NULL,
  `maquina_id` int NOT NULL,
  `horas_total` decimal(6,2) DEFAULT NULL,
  `combustivel_total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `semana_id` (`semana_id`),
  KEY `maquina_id` (`maquina_id`),
  CONSTRAINT `semana_maquinas_ibfk_1` FOREIGN KEY (`semana_id`) REFERENCES `semanas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `semana_maquinas_ibfk_2` FOREIGN KEY (`maquina_id`) REFERENCES `maquinas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `semana_pessoas`
--

DROP TABLE IF EXISTS `semana_pessoas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semana_pessoas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `semana_id` int NOT NULL,
  `pessoa_id` int NOT NULL,
  `horas_total` decimal(6,2) DEFAULT NULL,
  `custo_total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `semana_id` (`semana_id`),
  KEY `pessoa_id` (`pessoa_id`),
  CONSTRAINT `semana_pessoas_ibfk_1` FOREIGN KEY (`semana_id`) REFERENCES `semanas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `semana_pessoas_ibfk_2` FOREIGN KEY (`pessoa_id`) REFERENCES `operadores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `semana_viaturas`
--

DROP TABLE IF EXISTS `semana_viaturas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semana_viaturas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `semana_id` int NOT NULL,
  `viatura_id` int NOT NULL,
  `km_total` decimal(8,2) DEFAULT NULL,
  `custo_total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `semana_id` (`semana_id`),
  KEY `viatura_id` (`viatura_id`),
  CONSTRAINT `semana_viaturas_ibfk_1` FOREIGN KEY (`semana_id`) REFERENCES `semanas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `semana_viaturas_ibfk_2` FOREIGN KEY (`viatura_id`) REFERENCES `viaturas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `semanas`
--

DROP TABLE IF EXISTS `semanas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `semanas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `obra_id` int NOT NULL,
  `numero_semana` int NOT NULL,
  `data_inicio` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL,
  `estado` enum('aberta','fechada') DEFAULT 'aberta',
  `faturado` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `obra_id` (`obra_id`),
  CONSTRAINT `fk_semanas_projects` FOREIGN KEY (`obra_id`) REFERENCES `projects` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `vat` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `payment_days` int DEFAULT NULL,
  `address` text,
  `notes` text,
  `active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_suppliers_name` (`name`),
  KEY `idx_suppliers_vat` (`vat`),
  KEY `idx_suppliers_active` (`active`),
  KEY `idx_suppliers_payment_days` (`payment_days`),
  CONSTRAINT `chk_suppliers_payment_days_non_negative` CHECK (((`payment_days` is null) or (`payment_days` >= 0)))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parent_id` int DEFAULT NULL,
  `projects_id` int NOT NULL DEFAULT '0',
  `tasks_status_id` int DEFAULT NULL,
  `tasks_priority_id` int DEFAULT NULL,
  `tasks_label_id` int DEFAULT NULL,
  `tasks_type_id` int DEFAULT NULL,
  `tasks_groups_id` int DEFAULT NULL,
  `projects_phases_id` int DEFAULT NULL,
  `versions_id` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `assigned_to` varchar(255) DEFAULT NULL,
  `estimated_time` float DEFAULT NULL,
  `work_hours` float DEFAULT NULL,
  `togo_hours` float DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `tickets_id` int DEFAULT NULL,
  `closed_date` datetime DEFAULT NULL,
  `discussion_id` int DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `progress` int DEFAULT NULL,
  `sort_order` int DEFAULT NULL,
  `in_trash` tinyint(1) DEFAULT NULL,
  `in_trash_date` int DEFAULT NULL,
  `last_comment_date` int DEFAULT NULL,
  `custo_hora` decimal(18,6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tasks_projects` (`projects_id`),
  KEY `fk_tasks_task_status` (`tasks_status_id`),
  KEY `fk_tasks_projects_phases` (`projects_phases_id`),
  KEY `fk_tasks_pople` (`created_by`),
  KEY `fk_tasks_tasks_groups` (`tasks_groups_id`),
  KEY `fk_tasks_versions` (`versions_id`),
  KEY `fk_tasks_tasks_priority` (`tasks_priority_id`),
  KEY `fk_tasks_tickets` (`tickets_id`),
  KEY `fk_tasks_task_type` (`tasks_type_id`),
  KEY `fk_tasks_task_label` (`tasks_label_id`),
  CONSTRAINT `tasks_projects_FK` FOREIGN KEY (`projects_id`) REFERENCES `projects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5477 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tasks_comments`
--

DROP TABLE IF EXISTS `tasks_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_comments` (
  `id` int DEFAULT NULL,
  `tasks_id` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `tasks_status_id` int DEFAULT NULL,
  `tasks_priority_id` int DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `worked_hours` float DEFAULT NULL,
  `description` text,
  `created_at` datetime DEFAULT NULL,
  `progress` int DEFAULT NULL,
  `in_trash` tinyint(1) DEFAULT NULL,
  `in_trash_date` int DEFAULT NULL,
  `tasks_types_id` int DEFAULT NULL,
  `tasks_labels_id` int DEFAULT NULL,
  `togo_hours` float DEFAULT NULL,
  `comment_file` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tasks_groups`
--

DROP TABLE IF EXISTS `tasks_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_groups` (
  `id` int DEFAULT NULL,
  `projects_id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tasks_labels`
--

DROP TABLE IF EXISTS `tasks_labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_labels` (
  `id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sort_order` int DEFAULT NULL,
  `default_value` tinyint(1) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `background_color` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tasks_priority`
--

DROP TABLE IF EXISTS `tasks_priority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_priority` (
  `id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `icon` varchar(64) DEFAULT NULL,
  `sort_order` int DEFAULT NULL,
  `default_value` tinyint(1) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tasks_status`
--

DROP TABLE IF EXISTS `tasks_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_status` (
  `id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status_group` varchar(64) DEFAULT NULL,
  `sort_order` int DEFAULT NULL,
  `default_value` tinyint(1) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `background_color` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tasks_timer`
--

DROP TABLE IF EXISTS `tasks_timer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_timer` (
  `id` int DEFAULT NULL,
  `tasks_id` int DEFAULT NULL,
  `users_id` int DEFAULT NULL,
  `seconds` int DEFAULT NULL,
  `visible` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tasks_types`
--

DROP TABLE IF EXISTS `tasks_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks_types` (
  `id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `sort_order` int DEFAULT NULL,
  `default_value` tinyint(1) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `extra_fields` text,
  `background_color` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test_ai_app`
--

DROP TABLE IF EXISTS `test_ai_app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_ai_app` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_days`
--

DROP TABLE IF EXISTS `time_days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_days` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time_folhahoras_id` int NOT NULL,
  `usr_id` int NOT NULL,
  `ano` int DEFAULT NULL,
  `mes` int DEFAULT NULL,
  `dia` int NOT NULL,
  `centro_custo_id` int DEFAULT NULL,
  `task_id` int DEFAULT NULL,
  `entrada_1` time DEFAULT NULL,
  `saida_1` time DEFAULT NULL,
  `entrada_2` time DEFAULT NULL,
  `saida_2` time DEFAULT NULL,
  `horas` varchar(100) DEFAULT NULL,
  `tipo_id` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `nota_submit` longtext,
  `nota_approved` longtext,
  `entrada1_gps` varchar(100) DEFAULT NULL,
  `saida1_gps` varchar(100) DEFAULT NULL,
  `entrada2_gps` varchar(100) DEFAULT NULL,
  `saida2_gps` varchar(100) DEFAULT NULL,
  `resumo_dia` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36717 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_db_anos`
--

DROP TABLE IF EXISTS `time_db_anos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_db_anos` (
  `year` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_db_dias`
--

DROP TABLE IF EXISTS `time_db_dias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_db_dias` (
  `data` text,
  `ano` int DEFAULT NULL,
  `mes` int DEFAULT NULL,
  `dia` int DEFAULT NULL,
  `dia_sem` int DEFAULT NULL,
  `dia_sem_ext` text,
  `feriado` text,
  `fim_de_semana` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_db_meses`
--

DROP TABLE IF EXISTS `time_db_meses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_db_meses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `meses` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_db_tipo`
--

DROP TABLE IF EXISTS `time_db_tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_db_tipo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` text,
  `tipo` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_folhahoras`
--

DROP TABLE IF EXISTS `time_folhahoras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_folhahoras` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` int NOT NULL,
  `ano` int NOT NULL,
  `mes` int NOT NULL,
  `submited` text,
  `submited_by` text,
  `submited_at` datetime DEFAULT NULL,
  `submited_signature` longtext,
  `aproved` text,
  `aproved_by` text,
  `aproved_at` datetime DEFAULT NULL,
  `approved_signature` longtext,
  `valid_rh` varchar(10) DEFAULT NULL,
  `valid_cont` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1179 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_folhahoras_entradas`
--

DROP TABLE IF EXISTS `time_folhahoras_entradas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_folhahoras_entradas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `folha_id` int NOT NULL,
  `ano` int NOT NULL,
  `mes` int NOT NULL,
  `dia` int NOT NULL,
  `centro_custo_id` int DEFAULT NULL,
  `task_id` int DEFAULT NULL,
  `tipo_id` int DEFAULT NULL,
  `entrada_1` varchar(5) DEFAULT NULL,
  `saida_1` varchar(5) DEFAULT NULL,
  `entrada_2` varchar(5) DEFAULT NULL,
  `saida_2` varchar(5) DEFAULT NULL,
  `horas` decimal(5,2) DEFAULT '0.00',
  `resumo_dia` text,
  PRIMARY KEY (`id`),
  KEY `idx_folha_id` (`folha_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_usr_approve`
--

DROP TABLE IF EXISTS `time_usr_approve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_usr_approve` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usr_id_submit` text NOT NULL,
  `usr_id_approve` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_sessions`
--

DROP TABLE IF EXISTS `user_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_sessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `refresh_token` text,
  `device_info` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_used` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `ip_address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `viaturas`
--

DROP TABLE IF EXISTS `viaturas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `viaturas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `modelo` varchar(100) NOT NULL,
  `matricula` varchar(20) DEFAULT NULL,
  `custo_km` decimal(8,2) DEFAULT NULL,
  `consumo_l100km` decimal(5,2) DEFAULT NULL,
  `motorista_id` int DEFAULT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `motorista_id` (`motorista_id`),
  CONSTRAINT `viaturas_ibfk_1` FOREIGN KEY (`motorista_id`) REFERENCES `operadores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-22 16:40:10
