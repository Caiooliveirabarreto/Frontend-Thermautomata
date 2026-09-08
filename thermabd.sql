-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 08/09/2026 às 05:23
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
  `titulo` varchar(255) NOT NULL,
  `artigo` text NOT NULL,
  `iduser` int(11) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pendente',
  `data_criacao` datetime NOT NULL DEFAULT current_timestamp(),
  `data_atualizacao` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `artigos`
--

INSERT INTO `artigos` (`idart`, `titulo`, `artigo`, `iduser`, `status`, `data_criacao`, `data_atualizacao`) VALUES
(4, 'Um artigo de Teste', 'esse é um artigo muito legal de teste', 2, 'aprovado', '2026-09-07 07:13:25', '2026-09-07 18:42:21'),
(9, 'Artigo testando tags 2', 'Esse artigo é para testar as tags e ver se está funcionando', 2, 'rejeitado', '2026-09-07 08:11:44', '2026-09-07 18:45:56'),
(10, 'Testando para saber se funciona as tags', 'tem que testar né ne né Estevão buxaa', 2, 'pendente', '2026-09-07 08:26:03', '2026-09-07 08:26:03'),
(12, 'Verificar se adiciona as tags no artigos_tags', 'Se funcionar, eu mereço uma coxinha', 2, 'aprovado', '2026-09-07 08:37:20', '2026-09-07 20:54:33'),
(13, 'Artigo gamer', 'Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem ', 3, 'pendente', '2026-09-07 20:00:24', '2026-09-07 20:00:24'),
(16, 'Artigo gamerrrr', 'Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem eita eita eita', 3, 'aprovado', '2026-09-07 20:06:22', '2026-09-07 20:07:05'),
(17, 'Muitas letras', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb', 3, 'aprovado', '2026-09-07 20:08:43', '2026-09-07 20:08:52');

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
(10, 9),
(12, 11),
(13, 12),
(16, 15),
(17, 16);

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
(12, 6),
(12, 9),
(12, 13),
(13, 7),
(16, 7),
(16, 13),
(17, 7),
(17, 13);

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
(7, 'Figma', 'figma.com'),
(9, 'Lol', '67.com'),
(10, 'Roblox', 'roblox.com'),
(11, 'Localhost', 'localhost.com'),
(12, 'Tiktok', 'tiktok.com'),
(15, 'Google', 'https://www.google.com/'),
(16, 'Figma', 'https://www.figma.com/');

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
(2, 4),
(2, 12),
(3, 4),
(3, 16),
(3, 17);

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
(7, 'Economia'),
(10, 'Educação'),
(15, 'Infraestrutura'),
(8, 'Meio Ambiente'),
(6, 'Política'),
(11, 'Saúde'),
(14, 'Sociedade'),
(13, 'Sustentabilidade'),
(9, 'Tecnologia'),
(12, 'Urbanismo');

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario`
--

CREATE TABLE `usuario` (
  `iduser` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `tipo` tinyint(4) NOT NULL DEFAULT 0,
  `foto_perfil` varchar(255) NOT NULL DEFAULT 'template-perfil.jpg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuario`
--

INSERT INTO `usuario` (`iduser`, `nome`, `email`, `senha`, `tipo`, `foto_perfil`) VALUES
(2, 'Suzuki', 'suzuki@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$7Nwo7lC/yuwUUz0NK5h99w$OJgqJlbETXdWfft5c5U0eNYpC+j45acwdlJVr2LvzAM', 0, 'template-perfil.jpg'),
(3, 'Cometi', 'cometi@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$DB9rCgW7E8KFL/RoKNy8zQ$PX1yrim+AV4a+oE6DA5CzWsGsNMfl4uwO5GAw9qvXtU', 1, 'template-perfil.jpg'),
(5, 'Tsu', 'tsuki@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$FaryylZDsg4H7xDJeG6kpg$oScY4mV7m6L0dTlnrCDMaGtHewdd8mwKxidJqQCU0H8', 0, 'template-perfil.jpg'),
(6, 'Tsuki', 'tsukii@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$uKRGWY1N5EUhMvHoC12d9w$wpkssGG99lv2GOha+pNjhWTNvxVKmjDEz5wV3OgzQ/c', 0, 'template-perfil.jpg'),
(8, 'Suzukax', 'suzukax@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$zqmduqoE4qheVTLyX9R4Bw$/XeeUCSlW5pZzmND4WF0oV5zBiHI8nL6f/i3DgBT78s', 0, 'template-perfil.jpg'),
(9, 'Arthur', 'arthur@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$LjhcBQqnW8rQNFcG5vOLTQ$wO6GJ2IaFC406SA9VVDSYSDhm+03y0WKmrgOrkgVcPE', 0, '05d20b0e-2a2a-4459-9fa0-8598f831a142.jpg'),
(10, 'Yukimiya', 'yukimiya@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$VFnnShYHQUZ5p5GK3eOCDQ$CVESIBI3SJ8xZZeNFFLMnA0BeBJnwQe6mwZYTh77Bj4', 0, '51232554-7bac-4bc3-9743-d3e3bfc1346f.jpg');

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
  ADD KEY `artigos_fontes_ibfk_2` (`idfont`);

--
-- Índices de tabela `artigos_tags`
--
ALTER TABLE `artigos_tags`
  ADD PRIMARY KEY (`idart`,`idtag`),
  ADD KEY `artigos_tags_ibfk_2` (`idtag`);

--
-- Índices de tabela `fontes`
--
ALTER TABLE `fontes`
  ADD PRIMARY KEY (`idfont`),
  ADD UNIQUE KEY `unique_link` (`link`);

--
-- Índices de tabela `salvos`
--
ALTER TABLE `salvos`
  ADD PRIMARY KEY (`iduser`,`idart`),
  ADD KEY `salvos_ibfk_2` (`idart`);

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
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `uq_usuario_nome` (`nome`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `artigos`
--
ALTER TABLE `artigos`
  MODIFY `idart` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de tabela `fontes`
--
ALTER TABLE `fontes`
  MODIFY `idfont` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de tabela `tags`
--
ALTER TABLE `tags`
  MODIFY `idtag` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `iduser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
  ADD CONSTRAINT `artigos_fontes_ibfk_1` FOREIGN KEY (`idart`) REFERENCES `artigos` (`idart`) ON DELETE CASCADE,
  ADD CONSTRAINT `artigos_fontes_ibfk_2` FOREIGN KEY (`idfont`) REFERENCES `fontes` (`idfont`) ON DELETE CASCADE;

--
-- Restrições para tabelas `artigos_tags`
--
ALTER TABLE `artigos_tags`
  ADD CONSTRAINT `artigos_tags_ibfk_1` FOREIGN KEY (`idart`) REFERENCES `artigos` (`idart`) ON DELETE CASCADE,
  ADD CONSTRAINT `artigos_tags_ibfk_2` FOREIGN KEY (`idtag`) REFERENCES `tags` (`idtag`) ON DELETE CASCADE;

--
-- Restrições para tabelas `salvos`
--
ALTER TABLE `salvos`
  ADD CONSTRAINT `salvos_ibfk_1` FOREIGN KEY (`iduser`) REFERENCES `usuario` (`iduser`) ON DELETE CASCADE,
  ADD CONSTRAINT `salvos_ibfk_2` FOREIGN KEY (`idart`) REFERENCES `artigos` (`idart`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
