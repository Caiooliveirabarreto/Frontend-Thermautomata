-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 04/08/2026 às 01:09
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `thermabd`
--
CREATE DATABASE IF NOT EXISTS `thermabd` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `thermabd`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `artigos`
--

CREATE TABLE `artigos` (
  `idart` int(11) NOT NULL,
  `artigo` text NOT NULL,
  `iduser` int(11) NOT NULL,
  `visibilidade` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `artigos`
--

INSERT INTO `artigos` (`idart`, `artigo`, `iduser`, `visibilidade`) VALUES
(1, 'A importância da saúde mental na adolescência.', 1, 1),
(2, 'Como a tecnologia influencia a educação.', 2, 1),
(3, 'Sustentabilidade nas cidades inteligentes.', 1, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `artigos_fontes`
--

CREATE TABLE `artigos_fontes` (
  `idart` int(11) NOT NULL,
  `idfont` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `artigos_fontes`
--

INSERT INTO `artigos_fontes` (`idart`, `idfont`) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `artigos_tags`
--

CREATE TABLE `artigos_tags` (
  `idart` int(11) NOT NULL,
  `idtag` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `artigos_tags`
--

INSERT INTO `artigos_tags` (`idart`, `idtag`) VALUES
(1, 1),
(1, 5),
(2, 2),
(2, 3),
(3, 2),
(3, 4);

-- --------------------------------------------------------

--
-- Estrutura para tabela `fontes`
--

CREATE TABLE `fontes` (
  `idfont` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `fontes`
--

INSERT INTO `fontes` (`idfont`, `nome`, `link`) VALUES
(1, 'Organização Mundial da Saúde', 'https://www.who.int'),
(2, 'Ministério da Saúde', 'https://www.gov.br/saude'),
(3, 'UNESCO', 'https://www.unesco.org');

-- --------------------------------------------------------

--
-- Estrutura para tabela `salvos`
--

CREATE TABLE `salvos` (
  `iduser` int(11) NOT NULL,
  `idart` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `salvos`
--

INSERT INTO `salvos` (`iduser`, `idart`) VALUES
(1, 2),
(2, 1),
(2, 3),
(3, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tags`
--

CREATE TABLE `tags` (
  `idtag` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tags`
--

INSERT INTO `tags` (`idtag`, `nome`) VALUES
(3, 'Educação'),
(1, 'Poluição'),
(5, 'Psicologia'),
(4, 'Sustentabilidade'),
(2, 'Tecnologia');

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario`
--

CREATE TABLE `usuario` (
  `iduser` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `tipo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuario`
--

INSERT INTO `usuario` (`iduser`, `nome`, `email`, `senha`, `tipo`) VALUES
(1, 'João Silva', 'joao@email.com', '123456', 0),
(2, 'Maria Souza', 'maria@email.com', 'abcdef', 0),
(3, 'Administrador', 'admin@email.com', 'admin123', 1);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `artigos`
--
ALTER TABLE `artigos`
  ADD PRIMARY KEY (`idart`),
  ADD KEY `iduser` (`iduser`);

--
-- Índices de tabela `artigos_fontes`
--
ALTER TABLE `artigos_fontes`
  ADD PRIMARY KEY (`idart`,`idfont`),
  ADD KEY `idfont` (`idfont`);

--
-- Índices de tabela `artigos_tags`
--
ALTER TABLE `artigos_tags`
  ADD PRIMARY KEY (`idart`,`idtag`),
  ADD KEY `idtag` (`idtag`);

--
-- Índices de tabela `fontes`
--
ALTER TABLE `fontes`
  ADD PRIMARY KEY (`idfont`);

--
-- Índices de tabela `salvos`
--
ALTER TABLE `salvos`
  ADD PRIMARY KEY (`iduser`,`idart`),
  ADD KEY `idart` (`idart`);

--
-- Índices de tabela `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`idtag`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Índices de tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`iduser`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `artigos`
--
ALTER TABLE `artigos`
  MODIFY `idart` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `fontes`
--
ALTER TABLE `fontes`
  MODIFY `idfont` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `tags`
--
ALTER TABLE `tags`
  MODIFY `idtag` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `iduser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `artigos`
--
ALTER TABLE `artigos`
  ADD CONSTRAINT `artigos_ibfk_1` FOREIGN KEY (`iduser`) REFERENCES `usuario` (`iduser`);

--
-- Restrições para tabelas `artigos_fontes`
--
ALTER TABLE `artigos_fontes`
  ADD CONSTRAINT `artigos_fontes_ibfk_1` FOREIGN KEY (`idart`) REFERENCES `artigos` (`idart`),
  ADD CONSTRAINT `artigos_fontes_ibfk_2` FOREIGN KEY (`idfont`) REFERENCES `fontes` (`idfont`);

--
-- Restrições para tabelas `artigos_tags`
--
ALTER TABLE `artigos_tags`
  ADD CONSTRAINT `artigos_tags_ibfk_1` FOREIGN KEY (`idart`) REFERENCES `artigos` (`idart`),
  ADD CONSTRAINT `artigos_tags_ibfk_2` FOREIGN KEY (`idtag`) REFERENCES `tags` (`idtag`);

--
-- Restrições para tabelas `salvos`
--
ALTER TABLE `salvos`
  ADD CONSTRAINT `salvos_ibfk_1` FOREIGN KEY (`iduser`) REFERENCES `usuario` (`iduser`),
  ADD CONSTRAINT `salvos_ibfk_2` FOREIGN KEY (`idart`) REFERENCES `artigos` (`idart`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
