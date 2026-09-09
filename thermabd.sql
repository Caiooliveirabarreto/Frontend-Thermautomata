-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 09/09/2026 às 03:28
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
-- Banco de dados: `biblioteca`
--
CREATE DATABASE IF NOT EXISTS `biblioteca` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `biblioteca`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `livros`
--

CREATE TABLE `livros` (
  `id` int(11) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `genero` varchar(100) NOT NULL,
  `ano` int(11) NOT NULL,
  `autor` varchar(150) NOT NULL,
  `paginas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `livros`
--

INSERT INTO `livros` (`id`, `titulo`, `genero`, `ano`, `autor`, `paginas`) VALUES
(1, 'O Hobbit', 'Fantasia', 1937, 'J.R.R. Tolkien', 310),
(2, 'O Hobbit', 'Fantasia', 1937, 'John Ronald Reuel Tolkien', 310);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `livros`
--
ALTER TABLE `livros`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `livros`
--
ALTER TABLE `livros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Banco de dados: `cantina`
--
CREATE DATABASE IF NOT EXISTS `cantina` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `cantina`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `item`
--

CREATE TABLE `item` (
  `Cod_item` int(11) NOT NULL,
  `Nome` varchar(100) NOT NULL,
  `Descricao` text NOT NULL,
  `Preco` decimal(5,2) NOT NULL,
  `Tipo` varchar(50) NOT NULL,
  `Quantidade_Estoque` int(11) NOT NULL,
  `Imagem` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `item`
--

INSERT INTO `item` (`Cod_item`, `Nome`, `Descricao`, `Preco`, `Tipo`, `Quantidade_Estoque`, `Imagem`) VALUES
(1, 'Coxinha de Frango', 'Salgado com recheio de frango', 5.50, 'Salgado', 40, 'assets/img/menu/coxinha-frango.png'),
(2, 'Refrigerante Lata', 'Coca-Cola, Guaraná ou Fanta', 4.00, 'Bebida', 100, 'assets/img/menu/coca-latinha.png'),
(3, 'Brigadeiro', 'Doce de chocolate tradicional', 2.50, 'Doce', 30, 'assets/img/menu/brigadeiro.png'),
(4, 'Enroladinho de Salsicha', 'Uma salsicha muito gostosa', 10.00, 'Salgado', 10, 'assets/img/menu/enroladinho-salsicha.png');

-- --------------------------------------------------------

--
-- Estrutura para tabela `item_pedido`
--

CREATE TABLE `item_pedido` (
  `Quantidade` int(11) NOT NULL,
  `Pedido_Cod_pedido` int(11) DEFAULT NULL,
  `Item_Cod_item` int(11) DEFAULT NULL,
  `Valor_total` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `item_pedido`
--

INSERT INTO `item_pedido` (`Quantidade`, `Pedido_Cod_pedido`, `Item_Cod_item`, `Valor_total`) VALUES
(2, 1, 1, 20.49),
(1, 1, 2, 15.99),
(1, 3, 2, 4.00),
(1, 3, 1, 5.50),
(1, 4, 2, 4.00),
(4, 4, 1, 22.00),
(4, 5, 1, 22.00),
(1, 5, 2, 4.00),
(3, 6, 4, 30.00),
(1, 6, 1, 5.50),
(1, 7, 1, 5.50),
(1, 7, 2, 4.00),
(1, 8, 2, 4.00),
(1, 9, 2, 4.00),
(2, 10, 3, 5.00),
(1, 11, 1, 5.50);

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido`
--

CREATE TABLE `pedido` (
  `Cod_pedido` int(11) NOT NULL,
  `Data_Hora` datetime NOT NULL,
  `Usuario_CPF` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pedido`
--

INSERT INTO `pedido` (`Cod_pedido`, `Data_Hora`, `Usuario_CPF`) VALUES
(1, '0000-00-00 00:00:00', '11122233344'),
(2, '2025-11-23 23:01:12', NULL),
(3, '2025-11-23 23:05:52', NULL),
(4, '2025-11-23 23:14:57', NULL),
(5, '2025-11-23 23:17:39', NULL),
(6, '2025-11-23 23:20:24', NULL),
(7, '2025-11-23 23:41:20', NULL),
(8, '2025-11-24 00:03:21', NULL),
(9, '2025-11-24 00:08:54', NULL),
(10, '2025-11-24 00:09:48', NULL),
(11, '2025-11-24 00:25:42', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario`
--

CREATE TABLE `usuario` (
  `CPF` varchar(11) NOT NULL,
  `Nome` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Senha` varchar(255) NOT NULL,
  `Tipo_Usuario` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuario`
--

INSERT INTO `usuario` (`CPF`, `Nome`, `Email`, `Senha`, `Tipo_Usuario`) VALUES
('11122233344', 'João da Silva', 'joao.silva@aluno.com', 'senha_123', 'consumidor'),
('55566677788', 'Maria Oliveira', 'maria.adm@cantina.com', 'senha_456', 'administrador'),
('58826250847', 'Suzuki', 'arthurluz7288@gmail.com', '$2y$10$8M.Q6ZHUVGI/XWuixvNrleyQgl.iVIG6pbOkyPe3hHgd4r2IBvII2', 'administrador');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`Cod_item`);

--
-- Índices de tabela `item_pedido`
--
ALTER TABLE `item_pedido`
  ADD KEY `Pedido_Cod_pedido` (`Pedido_Cod_pedido`),
  ADD KEY `Item_Cod_item` (`Item_Cod_item`);

--
-- Índices de tabela `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`Cod_pedido`),
  ADD KEY `Usuario_CPF` (`Usuario_CPF`);

--
-- Índices de tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`CPF`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `item`
--
ALTER TABLE `item`
  MODIFY `Cod_item` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `pedido`
--
ALTER TABLE `pedido`
  MODIFY `Cod_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `item_pedido`
--
ALTER TABLE `item_pedido`
  ADD CONSTRAINT `item_pedido_ibfk_1` FOREIGN KEY (`Pedido_Cod_pedido`) REFERENCES `pedido` (`Cod_pedido`),
  ADD CONSTRAINT `item_pedido_ibfk_2` FOREIGN KEY (`Item_Cod_item`) REFERENCES `item` (`Cod_item`);

--
-- Restrições para tabelas `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`Usuario_CPF`) REFERENCES `usuario` (`CPF`);
--
-- Banco de dados: `estacionamento`
--
CREATE DATABASE IF NOT EXISTS `estacionamento` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `estacionamento`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `andar`
--

CREATE TABLE `andar` (
  `codlugar` int(11) NOT NULL,
  `capacidade` int(11) DEFAULT NULL,
  `andar` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `andar`
--

INSERT INTO `andar` (`codlugar`, `capacidade`, `andar`) VALUES
(1, 50, 'Subsolo 1'),
(2, 60, 'Subsolo 2'),
(3, 40, 'Térreo'),
(4, 35, '1º Andar'),
(5, 30, '2º Andar'),
(6, 45, '3º Andar'),
(7, 55, '4º Andar'),
(8, 50, '5º Andar'),
(9, 25, '6º Andar'),
(10, 20, 'Cobertura');

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

CREATE TABLE `cliente` (
  `cpf` varchar(20) NOT NULL,
  `dtnasc` datetime DEFAULT NULL,
  `nome` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `cliente`
--

INSERT INTO `cliente` (`cpf`, `dtnasc`, `nome`) VALUES
('10101010101', '1986-02-10 00:00:00', 'Mariana Duarte'),
('11111111111', '1985-04-12 00:00:00', 'Carlos Silva'),
('22222222222', '1990-07-23 00:00:00', 'Ana Pereira'),
('33333333333', '1978-11-02 00:00:00', 'Marcos Oliveira'),
('55555555555', '1988-09-15 00:00:00', 'Ricardo Santos'),
('66666666666', '2000-12-01 00:00:00', 'Fernanda Costa'),
('77777777777', '1993-03-09 00:00:00', 'Paulo Mendes'),
('88888888888', '1982-06-25 00:00:00', 'Camila Rocha'),
('99999999999', '1997-08-18 00:00:00', 'Gabriel Lima');

-- --------------------------------------------------------

--
-- Estrutura para tabela `estaciona`
--

CREATE TABLE `estaciona` (
  `codestaciona` int(11) NOT NULL,
  `horsaida` datetime DEFAULT NULL,
  `dtentrada` datetime DEFAULT NULL,
  `horentrada` datetime DEFAULT NULL,
  `dtsaida` datetime DEFAULT NULL,
  `placa` char(7) DEFAULT NULL,
  `codlugar` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `estaciona`
--

INSERT INTO `estaciona` (`codestaciona`, `horsaida`, `dtentrada`, `horentrada`, `dtsaida`, `placa`, `codlugar`) VALUES
(1, '2025-09-01 18:30:00', '2025-09-01 00:00:00', '2025-09-01 08:00:00', '2025-09-01 00:00:00', 'ABC1234', 1),
(2, '2025-09-01 19:00:00', '2025-09-01 00:00:00', '2025-09-01 09:15:00', '2025-09-01 00:00:00', 'DEF5678', 2),
(3, '2025-09-01 17:45:00', '2025-09-01 00:00:00', '2025-09-01 07:40:00', '2025-09-01 00:00:00', 'GHI9012', 3),
(5, '2025-09-01 16:50:00', '2025-08-19 00:00:00', '2025-09-01 06:55:00', '2025-09-01 00:00:00', 'MNO7890', 5),
(6, '2025-09-01 21:00:00', '2025-09-01 00:00:00', '2025-09-01 11:20:00', '2025-09-01 00:00:00', 'PQR1122', 6),
(7, '2025-09-01 18:10:00', '2025-09-01 00:00:00', '2025-09-01 08:45:00', '2025-09-01 00:00:00', 'STU3344', 7),
(8, '2025-09-01 19:30:00', '2025-09-01 00:00:00', '2025-09-01 09:30:00', '2025-09-01 00:00:00', 'VWX5566', 8),
(9, '2025-09-01 20:50:00', '2025-09-01 00:00:00', '2025-09-01 10:10:00', '2025-09-01 00:00:00', 'YZA7788', 9),
(10, '2025-09-01 17:00:00', '2025-09-01 00:00:00', '2025-09-01 07:20:00', '2025-09-01 00:00:00', 'BCD9900', 10);

-- --------------------------------------------------------

--
-- Estrutura para tabela `modelo`
--

CREATE TABLE `modelo` (
  `codmodelo` int(11) NOT NULL,
  `modelo` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `modelo`
--

INSERT INTO `modelo` (`codmodelo`, `modelo`) VALUES
(1, 'Fiat Uno'),
(2, 'Volkswagen Gol'),
(3, 'Chevrolet Onix'),
(4, 'Toyota Corolla'),
(5, 'Honda Civic'),
(6, 'Ford Ka'),
(7, 'Renault Sandero'),
(8, 'Jeep Compass'),
(9, 'Hyundai HB20'),
(10, 'Nissan Kicks');

-- --------------------------------------------------------

--
-- Estrutura para tabela `veiculo`
--

CREATE TABLE `veiculo` (
  `placa` char(7) NOT NULL,
  `cor` varchar(20) DEFAULT NULL,
  `cpf` varchar(20) DEFAULT NULL,
  `codmodelo` int(11) DEFAULT NULL,
  `ano` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `veiculo`
--

INSERT INTO `veiculo` (`placa`, `cor`, `cpf`, `codmodelo`, `ano`) VALUES
('ABC1234', 'Preto', '11111111111', 1, 2019),
('BCD9900', 'Prata', '10101010101', 7, 2005),
('DEF5678', 'Dourado', '22222222222', 2, 1996),
('GHI9012', 'Branco', '33333333333', 3, 2000),
('MNO7890', 'Azul', '55555555555', 5, 2001),
('PQR1122', 'Cinza', '66666666666', 6, 2015),
('STU3344', 'Verde', '77777777777', 7, 2009),
('VWX5566', 'Amarelo', '88888888888', 8, 2021),
('YZA7788', 'Preto', '99999999999', 9, 1999);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `andar`
--
ALTER TABLE `andar`
  ADD PRIMARY KEY (`codlugar`);

--
-- Índices de tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`cpf`);

--
-- Índices de tabela `estaciona`
--
ALTER TABLE `estaciona`
  ADD PRIMARY KEY (`codestaciona`),
  ADD KEY `placa` (`placa`),
  ADD KEY `codlugar` (`codlugar`);

--
-- Índices de tabela `modelo`
--
ALTER TABLE `modelo`
  ADD PRIMARY KEY (`codmodelo`);

--
-- Índices de tabela `veiculo`
--
ALTER TABLE `veiculo`
  ADD PRIMARY KEY (`placa`),
  ADD KEY `cpf` (`cpf`),
  ADD KEY `codmodelo` (`codmodelo`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `andar`
--
ALTER TABLE `andar`
  MODIFY `codlugar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `estaciona`
--
ALTER TABLE `estaciona`
  MODIFY `codestaciona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `modelo`
--
ALTER TABLE `modelo`
  MODIFY `codmodelo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `estaciona`
--
ALTER TABLE `estaciona`
  ADD CONSTRAINT `estaciona_ibfk_1` FOREIGN KEY (`placa`) REFERENCES `veiculo` (`placa`),
  ADD CONSTRAINT `estaciona_ibfk_2` FOREIGN KEY (`codlugar`) REFERENCES `andar` (`codlugar`);

--
-- Restrições para tabelas `veiculo`
--
ALTER TABLE `veiculo`
  ADD CONSTRAINT `veiculo_ibfk_1` FOREIGN KEY (`cpf`) REFERENCES `cliente` (`cpf`),
  ADD CONSTRAINT `veiculo_ibfk_2` FOREIGN KEY (`codmodelo`) REFERENCES `modelo` (`codmodelo`);
--
-- Banco de dados: `etecmcm2`
--
CREATE DATABASE IF NOT EXISTS `etecmcm2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `etecmcm2`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `categorias`
--

CREATE TABLE `categorias` (
  `id_categoria` int(11) NOT NULL,
  `nome_cat` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `categorias`
--

INSERT INTO `categorias` (`id_categoria`, `nome_cat`) VALUES
(1, 'Limpeza'),
(2, 'Frios'),
(3, 'Laticínios'),
(4, 'Enlatados'),
(5, 'Carnes'),
(6, 'Hortifruti'),
(7, 'Perfumaria'),
(8, 'Bebidas'),
(9, 'Eletroeletrônicos'),
(10, 'Congelados'),
(11, 'Embalagens');

-- --------------------------------------------------------

--
-- Estrutura para tabela `produto`
--

CREATE TABLE `produto` (
  `id_produto` int(11) NOT NULL,
  `nome_produto` varchar(255) DEFAULT NULL,
  `qtde_produto` int(11) DEFAULT NULL,
  `preco_produto` decimal(10,2) DEFAULT NULL,
  `marca_produto` varchar(255) DEFAULT NULL,
  `fk_categorias_id_categoria` int(11) DEFAULT NULL,
  `unidade_medida` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produto`
--

INSERT INTO `produto` (`id_produto`, `nome_produto`, `qtde_produto`, `preco_produto`, `marca_produto`, `fk_categorias_id_categoria`, `unidade_medida`) VALUES
(1, 'Sabão em pó', 4, 25.00, 'OMO', 1, 'Uni'),
(2, 'Detergente', 20, 3.25, 'Ypê', 1, 'Uni'),
(3, 'Mussarela', 100, 55.60, 'Presidente', 3, 'Kg'),
(4, 'Iogurte Natural', 100, 3.29, 'Nestle', 3, 'Uni'),
(5, 'Papel Alumínio', 50, 7.59, 'Wyda', 11, 'Uni'),
(6, 'Papel Toalha', 75, 4.24, 'Scala', 11, 'Uni'),
(7, 'Coxa de Frango', 100, 55.60, 'Sadia', 5, 'Kg'),
(8, 'Carne moída', 100, 65.99, 'Friboi', 5, 'Kg'),
(9, 'Maçã', 100, 5.99, 'Turma da Mônica', 6, 'Kg'),
(10, 'Mix de verduras', 100, 7.99, 'Swift', 6, 'Kg'),
(11, 'Perfume de Cereja', 100, 75.99, 'Oboticário', 7, 'Uni'),
(12, 'Carbon Fiber', 250, 99.99, 'Jequiti', 7, 'Uni'),
(13, 'Presunto Fatiado', 100, 6.80, 'Seara', 2, 'Kg'),
(14, 'Queijo prato', 80, 8.90, 'Aurora', 2, 'Kg'),
(15, 'Milho Verde', 78, 4.50, 'Quero', 4, 'Uni'),
(16, 'Ervilha', 150, 3.52, 'Quero', 4, 'Uni'),
(17, 'Refrigerante Cola 2L', 200, 7.50, 'Coca-Cola', 8, 'Uni'),
(18, 'Suco de Uva Integral', 90, 12.00, 'Aurora', 8, 'Uni'),
(19, 'Fone de Ouvido', 40, 49.90, 'Multilaser', 9, 'Uni'),
(20, 'Carregador USB', 55, 29.90, 'Samsung', 9, 'Uni'),
(21, 'Pizza Calabresa', 60, 18.90, 'Perdigão', 10, 'Kg'),
(22, 'Lasanha Bolonhesa', 50, 17.50, 'Sadia', 10, 'Kg');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Índices de tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`id_produto`),
  ADD KEY `FK_produto_2` (`fk_categorias_id_categoria`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `produto`
--
ALTER TABLE `produto`
  MODIFY `id_produto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `produto`
--
ALTER TABLE `produto`
  ADD CONSTRAINT `FK_produto_2` FOREIGN KEY (`fk_categorias_id_categoria`) REFERENCES `categorias` (`id_categoria`);
--
-- Banco de dados: `lavarapido`
--
CREATE DATABASE IF NOT EXISTS `lavarapido` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lavarapido`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `atendimento`
--

CREATE TABLE `atendimento` (
  `codatendimento` int(11) NOT NULL,
  `totalgeral` decimal(10,2) NOT NULL,
  `data` date NOT NULL,
  `codcarro` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `atendimento`
--

INSERT INTO `atendimento` (`codatendimento`, `totalgeral`, `data`, `codcarro`) VALUES
(1, 50.00, '2025-01-10', 1),
(2, 80.00, '2025-01-15', 2),
(3, 30.00, '2025-02-05', 3),
(4, 150.00, '2025-02-12', 4),
(5, 200.00, '2025-03-01', 5),
(6, 60.00, '2025-03-10', 6),
(7, 250.00, '2025-03-20', 7),
(8, 100.00, '2025-04-05', 8),
(9, 70.00, '2025-04-15', 9),
(10, 120.00, '2025-04-25', 10);

-- --------------------------------------------------------

--
-- Estrutura para tabela `atendimento_servico`
--

CREATE TABLE `atendimento_servico` (
  `codatend_servico` int(11) NOT NULL,
  `totalserv` decimal(10,2) NOT NULL,
  `qtde` int(11) NOT NULL,
  `codservico` int(11) DEFAULT NULL,
  `codatendimento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `atendimento_servico`
--

INSERT INTO `atendimento_servico` (`codatend_servico`, `totalserv`, `qtde`, `codservico`, `codatendimento`) VALUES
(1, 50.00, 1, 2, 1),
(2, 80.00, 1, 4, 2),
(3, 30.00, 1, 1, 3),
(4, 150.00, 1, 9, 4),
(5, 200.00, 1, 7, 5),
(6, 60.00, 1, 6, 6),
(7, 250.00, 1, 10, 7),
(8, 100.00, 1, 5, 8),
(9, 70.00, 1, 8, 9),
(10, 120.00, 1, 3, 10);

-- --------------------------------------------------------

--
-- Estrutura para tabela `carro`
--

CREATE TABLE `carro` (
  `codcarro` int(11) NOT NULL,
  `ano` int(11) NOT NULL,
  `codcliente` int(11) DEFAULT NULL,
  `codmodelo` int(11) DEFAULT NULL,
  `placa` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `carro`
--

INSERT INTO `carro` (`codcarro`, `ano`, `codcliente`, `codmodelo`, `placa`) VALUES
(1, 2020, 1, 1, 'ABC1A23'),
(2, 2019, 2, 2, 'DEF4B56'),
(3, 2021, 3, 3, 'GHI7C89'),
(4, 2018, 4, 4, 'JKL0D12'),
(5, 2022, 5, 5, 'MNO3E45'),
(6, 2020, 6, 6, 'PQR6F78'),
(7, 2017, 7, 7, 'STU9G01'),
(8, 2019, 8, 8, 'VWX2H34'),
(9, 2021, 9, 9, 'YZA5I67'),
(10, 2018, 10, 10, 'BCD8J90');

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

CREATE TABLE `cliente` (
  `codcliente` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `datanascimento` date NOT NULL,
  `telefone` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `codendereco` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `cliente`
--

INSERT INTO `cliente` (`codcliente`, `nome`, `datanascimento`, `telefone`, `email`, `codendereco`) VALUES
(1, 'João Silva', '1985-04-15', '1198765432', 'joao.silva@email.com', 1),
(2, 'Maria Oliveira', '1990-08-20', '2198765432', 'maria.oliveira@email.com', 2),
(3, 'Carlos Souza', '1978-11-05', '3198765432', 'carlos.souza@email.com', 3),
(4, 'Ana Santos', '1995-02-12', '4198765432', 'ana.santos@email.com', 4),
(5, 'Paulo Lima', '1982-06-25', '8198765432', 'paulo.lima@email.com', 5),
(6, 'Fernanda Costa', '1989-09-30', '2191234567', 'fernanda.costa@email.com', 6),
(7, 'Rafael Alves', '1993-01-18', '4191234567', 'rafael.alves@email.com', 7),
(8, 'Luciana Martins', '1980-12-01', '3191234567', 'luciana.martins@email.com', 8),
(9, 'Bruno Rocha', '1998-03-08', '8191234567', 'bruno.rocha@email.com', 9),
(10, 'Camila Ferreira', '1992-07-22', '1191234567', 'camila.ferreira@email.com', 10);

-- --------------------------------------------------------

--
-- Estrutura para tabela `endereco`
--

CREATE TABLE `endereco` (
  `codendereco` int(11) NOT NULL,
  `rua` varchar(100) NOT NULL,
  `num` varchar(10) NOT NULL,
  `bairro` varchar(50) NOT NULL,
  `cidade` varchar(50) NOT NULL,
  `estado` char(2) NOT NULL,
  `cep` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `endereco`
--

INSERT INTO `endereco` (`codendereco`, `rua`, `num`, `bairro`, `cidade`, `estado`, `cep`) VALUES
(1, 'Rua das Flores', '101', 'Centro', 'São Paulo', 'SP', '01001000'),
(2, 'Av. Paulista', '200', 'Bela Vista', 'São Paulo', 'SP', '01311000'),
(3, 'Rua Aroeiras', '345', 'Jardim', 'Campinas', 'SP', '13015000'),
(4, 'Rua Palmeiras', '50', 'Centro', 'Santos', 'SP', '11010000'),
(5, 'Rua das Acácias', '78', 'Boa Vista', 'Recife', 'PE', '50050000'),
(6, 'Av. Brasil', '1500', 'Copacabana', 'Rio de Janeiro', 'RJ', '22041001'),
(7, 'Rua Verde', '23', 'Centro', 'Curitiba', 'PR', '80010000'),
(8, 'Rua Azul', '67', 'Industrial', 'Betim', 'MG', '32600000'),
(9, 'Rua Amarela', '12', 'Centro', 'Fortaleza', 'CE', '60060000'),
(10, 'Av. Atlântica', '890', 'Meia Praia', 'Itapema', 'SC', '88220000');

-- --------------------------------------------------------

--
-- Estrutura para tabela `marca`
--

CREATE TABLE `marca` (
  `codmarca` int(11) NOT NULL,
  `marca` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `marca`
--

INSERT INTO `marca` (`codmarca`, `marca`) VALUES
(1, 'Chevrolet'),
(2, 'Volkswagen'),
(3, 'Fiat'),
(4, 'Ford'),
(5, 'Honda'),
(6, 'Toyota'),
(7, 'Hyundai'),
(8, 'Renault'),
(9, 'Nissan'),
(10, 'Peugeot');

-- --------------------------------------------------------

--
-- Estrutura para tabela `modelo`
--

CREATE TABLE `modelo` (
  `codmodelo` int(11) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `codmarca` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `modelo`
--

INSERT INTO `modelo` (`codmodelo`, `modelo`, `codmarca`) VALUES
(1, 'Onix', 1),
(2, 'Gol', 2),
(3, 'Argo', 3),
(4, 'Ka', 4),
(5, 'Civic', 5),
(6, 'Corolla', 6),
(7, 'HB20', 7),
(8, 'Sandero', 8),
(9, 'Versa', 9),
(10, '208', 10);

-- --------------------------------------------------------

--
-- Estrutura para tabela `servico`
--

CREATE TABLE `servico` (
  `codservico` int(11) NOT NULL,
  `servico` varchar(100) NOT NULL,
  `valor` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `servico`
--

INSERT INTO `servico` (`codservico`, `servico`, `valor`) VALUES
(1, 'Lavagem Simples', 30.00),
(2, 'Lavagem Completa', 50.00),
(3, 'Polimento', 120.00),
(4, 'Higienização Interna', 80.00),
(5, 'Enceramento', 100.00),
(6, 'Lavagem a Seco', 60.00),
(7, 'Cristalização de Pintura', 200.00),
(8, 'Limpeza de Motor', 70.00),
(9, 'Descontaminação de Pintura', 150.00),
(10, 'Vitrificação', 250.00);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `atendimento`
--
ALTER TABLE `atendimento`
  ADD PRIMARY KEY (`codatendimento`),
  ADD KEY `codcarro` (`codcarro`);

--
-- Índices de tabela `atendimento_servico`
--
ALTER TABLE `atendimento_servico`
  ADD PRIMARY KEY (`codatend_servico`),
  ADD KEY `codservico` (`codservico`),
  ADD KEY `codatendimento` (`codatendimento`);

--
-- Índices de tabela `carro`
--
ALTER TABLE `carro`
  ADD PRIMARY KEY (`codcarro`),
  ADD KEY `codcliente` (`codcliente`),
  ADD KEY `codmodelo` (`codmodelo`);

--
-- Índices de tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`codcliente`),
  ADD KEY `codendereco` (`codendereco`);

--
-- Índices de tabela `endereco`
--
ALTER TABLE `endereco`
  ADD PRIMARY KEY (`codendereco`);

--
-- Índices de tabela `marca`
--
ALTER TABLE `marca`
  ADD PRIMARY KEY (`codmarca`);

--
-- Índices de tabela `modelo`
--
ALTER TABLE `modelo`
  ADD PRIMARY KEY (`codmodelo`),
  ADD KEY `codmarca` (`codmarca`);

--
-- Índices de tabela `servico`
--
ALTER TABLE `servico`
  ADD PRIMARY KEY (`codservico`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `atendimento`
--
ALTER TABLE `atendimento`
  MODIFY `codatendimento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `atendimento_servico`
--
ALTER TABLE `atendimento_servico`
  MODIFY `codatend_servico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `carro`
--
ALTER TABLE `carro`
  MODIFY `codcarro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `cliente`
--
ALTER TABLE `cliente`
  MODIFY `codcliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `endereco`
--
ALTER TABLE `endereco`
  MODIFY `codendereco` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `marca`
--
ALTER TABLE `marca`
  MODIFY `codmarca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `modelo`
--
ALTER TABLE `modelo`
  MODIFY `codmodelo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `servico`
--
ALTER TABLE `servico`
  MODIFY `codservico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `atendimento`
--
ALTER TABLE `atendimento`
  ADD CONSTRAINT `atendimento_ibfk_1` FOREIGN KEY (`codcarro`) REFERENCES `carro` (`codcarro`);

--
-- Restrições para tabelas `atendimento_servico`
--
ALTER TABLE `atendimento_servico`
  ADD CONSTRAINT `atendimento_servico_ibfk_1` FOREIGN KEY (`codservico`) REFERENCES `servico` (`codservico`),
  ADD CONSTRAINT `atendimento_servico_ibfk_2` FOREIGN KEY (`codatendimento`) REFERENCES `atendimento` (`codatendimento`);

--
-- Restrições para tabelas `carro`
--
ALTER TABLE `carro`
  ADD CONSTRAINT `carro_ibfk_1` FOREIGN KEY (`codcliente`) REFERENCES `cliente` (`codcliente`),
  ADD CONSTRAINT `carro_ibfk_2` FOREIGN KEY (`codmodelo`) REFERENCES `modelo` (`codmodelo`);

--
-- Restrições para tabelas `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`codendereco`) REFERENCES `endereco` (`codendereco`);

--
-- Restrições para tabelas `modelo`
--
ALTER TABLE `modelo`
  ADD CONSTRAINT `modelo_ibfk_1` FOREIGN KEY (`codmarca`) REFERENCES `marca` (`codmarca`);
--
-- Banco de dados: `loja`
--
CREATE DATABASE IF NOT EXISTS `loja` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `loja`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `filmes`
--

CREATE TABLE `filmes` (
  `id` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `diretor` varchar(100) NOT NULL,
  `genero` varchar(100) NOT NULL,
  `duracao_minutos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `filmes`
--

INSERT INTO `filmes` (`id`, `titulo`, `diretor`, `genero`, `duracao_minutos`) VALUES
(1, 'Como Treinar o Seu Dragão: O Mundo Oculto', 'Dean DeBlois', 'Animação', 104),
(2, 'Star Wars: Episódio III – A Vingança dos Sith', 'George Lucas', 'Ficção Científica', 145);

-- --------------------------------------------------------

--
-- Estrutura para tabela `produtos`
--

CREATE TABLE `produtos` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `quantidade` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produtos`
--

INSERT INTO `produtos` (`id`, `nome`, `preco`, `quantidade`) VALUES
(7, 'Mouse', 29.00, 3),
(11, 'Teclado', 30.00, 6),
(15, 'Cadeira gamer', 79.00, 2),
(23, 'Batata Gamer', 35.00, 26);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `filmes`
--
ALTER TABLE `filmes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_filmes_id` (`id`);

--
-- Índices de tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `filmes`
--
ALTER TABLE `filmes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
--
-- Banco de dados: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

--
-- Despejando dados para a tabela `pma__designer_settings`
--

INSERT INTO `pma__designer_settings` (`username`, `settings_data`) VALUES
('root', '{\"snap_to_grid\":\"off\",\"relation_lines\":\"true\",\"angular_direct\":\"direct\"}');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

--
-- Despejando dados para a tabela `pma__export_templates`
--

INSERT INTO `pma__export_templates` (`id`, `username`, `export_type`, `template_name`, `template_data`) VALUES
(1, 'root', 'server', 'loja', '{\"quick_or_custom\":\"quick\",\"what\":\"sql\",\"db_select[]\":[\"etecmcm2\",\"lavarapido\",\"loja\",\"phpmyadmin\",\"restaurante\",\"test\"],\"aliases_new\":\"\",\"output_format\":\"sendit\",\"filename_template\":\"@SERVER@\",\"remember_template\":\"on\",\"charset\":\"utf-8\",\"compression\":\"none\",\"maxsize\":\"\",\"codegen_structure_or_data\":\"data\",\"codegen_format\":\"0\",\"csv_separator\":\",\",\"csv_enclosed\":\"\\\"\",\"csv_escaped\":\"\\\"\",\"csv_terminated\":\"AUTO\",\"csv_null\":\"NULL\",\"csv_columns\":\"something\",\"csv_structure_or_data\":\"data\",\"excel_null\":\"NULL\",\"excel_columns\":\"something\",\"excel_edition\":\"win\",\"excel_structure_or_data\":\"data\",\"json_structure_or_data\":\"data\",\"json_unicode\":\"something\",\"latex_caption\":\"something\",\"latex_structure_or_data\":\"structure_and_data\",\"latex_structure_caption\":\"Estrutura da tabela @TABLE@\",\"latex_structure_continued_caption\":\"Estrutura da tabela @TABLE@ (continuação)\",\"latex_structure_label\":\"tab:@TABLE@-structure\",\"latex_relation\":\"something\",\"latex_comments\":\"something\",\"latex_mime\":\"something\",\"latex_columns\":\"something\",\"latex_data_caption\":\"Conteúdo da tabela @TABLE@\",\"latex_data_continued_caption\":\"Conteúdo da tabela @TABLE@ (continuação)\",\"latex_data_label\":\"tab:@TABLE@-data\",\"latex_null\":\"\\\\textit{NULL}\",\"mediawiki_structure_or_data\":\"data\",\"mediawiki_caption\":\"something\",\"mediawiki_headers\":\"something\",\"htmlword_structure_or_data\":\"structure_and_data\",\"htmlword_null\":\"NULL\",\"ods_null\":\"NULL\",\"ods_structure_or_data\":\"data\",\"odt_structure_or_data\":\"structure_and_data\",\"odt_relation\":\"something\",\"odt_comments\":\"something\",\"odt_mime\":\"something\",\"odt_columns\":\"something\",\"odt_null\":\"NULL\",\"pdf_report_title\":\"\",\"pdf_structure_or_data\":\"data\",\"phparray_structure_or_data\":\"data\",\"sql_include_comments\":\"something\",\"sql_header_comment\":\"\",\"sql_use_transaction\":\"something\",\"sql_compatibility\":\"NONE\",\"sql_structure_or_data\":\"structure_and_data\",\"sql_create_table\":\"something\",\"sql_auto_increment\":\"something\",\"sql_create_view\":\"something\",\"sql_create_trigger\":\"something\",\"sql_backquotes\":\"something\",\"sql_type\":\"INSERT\",\"sql_insert_syntax\":\"both\",\"sql_max_query_size\":\"50000\",\"sql_hex_for_binary\":\"something\",\"sql_utc_time\":\"something\",\"texytext_structure_or_data\":\"structure_and_data\",\"texytext_null\":\"NULL\",\"yaml_structure_or_data\":\"data\",\"\":null,\"as_separate_files\":null,\"csv_removeCRLF\":null,\"excel_removeCRLF\":null,\"json_pretty_print\":null,\"htmlword_columns\":null,\"ods_columns\":null,\"sql_dates\":null,\"sql_relation\":null,\"sql_mime\":null,\"sql_disable_fk\":null,\"sql_views_as_tables\":null,\"sql_metadata\":null,\"sql_drop_database\":null,\"sql_drop_table\":null,\"sql_if_not_exists\":null,\"sql_simple_view_export\":null,\"sql_view_current_user\":null,\"sql_or_replace_view\":null,\"sql_procedure_function\":null,\"sql_truncate\":null,\"sql_delayed\":null,\"sql_ignore\":null,\"texytext_columns\":null}');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Despejando dados para a tabela `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"thermabd\",\"table\":\"artigos\"},{\"db\":\"thermabd\",\"table\":\"artigos_fontes\"},{\"db\":\"thermabd\",\"table\":\"artigos_tags\"},{\"db\":\"thermabd\",\"table\":\"fontes\"},{\"db\":\"thermabd\",\"table\":\"tags\"},{\"db\":\"thermabd\",\"table\":\"usuario\"},{\"db\":\"thermabd\",\"table\":\"salvos\"},{\"db\":\"loja\",\"table\":\"filmes\"},{\"db\":\"cantina\",\"table\":\"pedido\"},{\"db\":\"cantina\",\"table\":\"item\"}]');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

--
-- Despejando dados para a tabela `pma__table_uiprefs`
--

INSERT INTO `pma__table_uiprefs` (`username`, `db_name`, `table_name`, `prefs`, `last_update`) VALUES
('root', 'cantina', 'item', '[]', '2025-11-10 14:32:07');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Despejando dados para a tabela `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2026-09-09 01:09:34', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"pt_BR\"}');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Estrutura para tabela `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Índices de tabela `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Índices de tabela `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Índices de tabela `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Índices de tabela `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Índices de tabela `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Índices de tabela `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Índices de tabela `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Índices de tabela `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Índices de tabela `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Índices de tabela `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Índices de tabela `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Índices de tabela `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Índices de tabela `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Índices de tabela `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Índices de tabela `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Índices de tabela `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Índices de tabela `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Banco de dados: `restaurante`
--
CREATE DATABASE IF NOT EXISTS `restaurante` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `restaurante`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `areasrestaurante`
--

CREATE TABLE `areasrestaurante` (
  `codarea` int(11) NOT NULL,
  `descricao` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `atendimento`
--

CREATE TABLE `atendimento` (
  `codatendimento` int(11) NOT NULL,
  `codgarcom` int(11) DEFAULT NULL,
  `codmesa` int(11) DEFAULT NULL,
  `horarioentrada` datetime NOT NULL,
  `horariosaida` datetime NOT NULL,
  `qtdpessoas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `conta`
--

CREATE TABLE `conta` (
  `codconta` int(11) NOT NULL,
  `data` date NOT NULL,
  `valortotal` decimal(10,2) NOT NULL,
  `valorporpessoa` decimal(10,2) NOT NULL,
  `codmesa` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `garcom`
--

CREATE TABLE `garcom` (
  `codgarcom` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `item`
--

CREATE TABLE `item` (
  `coditem` int(11) NOT NULL,
  `preco` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `itensconta`
--

CREATE TABLE `itensconta` (
  `cod_itensconta` int(11) NOT NULL,
  `codconta` int(11) DEFAULT NULL,
  `coditem` int(11) DEFAULT NULL,
  `qtde` int(11) NOT NULL,
  `totalitem` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `mesa`
--

CREATE TABLE `mesa` (
  `codmesa` int(11) NOT NULL,
  `comporta` int(11) NOT NULL,
  `codarea` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `areasrestaurante`
--
ALTER TABLE `areasrestaurante`
  ADD PRIMARY KEY (`codarea`);

--
-- Índices de tabela `atendimento`
--
ALTER TABLE `atendimento`
  ADD PRIMARY KEY (`codatendimento`),
  ADD KEY `codgarcom` (`codgarcom`),
  ADD KEY `codmesa` (`codmesa`);

--
-- Índices de tabela `conta`
--
ALTER TABLE `conta`
  ADD PRIMARY KEY (`codconta`),
  ADD KEY `codmesa` (`codmesa`);

--
-- Índices de tabela `garcom`
--
ALTER TABLE `garcom`
  ADD PRIMARY KEY (`codgarcom`);

--
-- Índices de tabela `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`coditem`);

--
-- Índices de tabela `itensconta`
--
ALTER TABLE `itensconta`
  ADD PRIMARY KEY (`cod_itensconta`),
  ADD KEY `codconta` (`codconta`),
  ADD KEY `coditem` (`coditem`);

--
-- Índices de tabela `mesa`
--
ALTER TABLE `mesa`
  ADD PRIMARY KEY (`codmesa`),
  ADD KEY `codarea` (`codarea`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `areasrestaurante`
--
ALTER TABLE `areasrestaurante`
  MODIFY `codarea` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `atendimento`
--
ALTER TABLE `atendimento`
  MODIFY `codatendimento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `conta`
--
ALTER TABLE `conta`
  MODIFY `codconta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `garcom`
--
ALTER TABLE `garcom`
  MODIFY `codgarcom` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `item`
--
ALTER TABLE `item`
  MODIFY `coditem` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `itensconta`
--
ALTER TABLE `itensconta`
  MODIFY `cod_itensconta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `mesa`
--
ALTER TABLE `mesa`
  MODIFY `codmesa` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `atendimento`
--
ALTER TABLE `atendimento`
  ADD CONSTRAINT `atendimento_ibfk_1` FOREIGN KEY (`codgarcom`) REFERENCES `garcom` (`codgarcom`),
  ADD CONSTRAINT `atendimento_ibfk_2` FOREIGN KEY (`codmesa`) REFERENCES `mesa` (`codmesa`);

--
-- Restrições para tabelas `conta`
--
ALTER TABLE `conta`
  ADD CONSTRAINT `conta_ibfk_1` FOREIGN KEY (`codmesa`) REFERENCES `mesa` (`codmesa`);

--
-- Restrições para tabelas `itensconta`
--
ALTER TABLE `itensconta`
  ADD CONSTRAINT `itensconta_ibfk_1` FOREIGN KEY (`codconta`) REFERENCES `conta` (`codconta`),
  ADD CONSTRAINT `itensconta_ibfk_2` FOREIGN KEY (`coditem`) REFERENCES `item` (`coditem`);

--
-- Restrições para tabelas `mesa`
--
ALTER TABLE `mesa`
  ADD CONSTRAINT `mesa_ibfk_1` FOREIGN KEY (`codarea`) REFERENCES `areasrestaurante` (`codarea`);
--
-- Banco de dados: `sistema`
--
CREATE DATABASE IF NOT EXISTS `sistema` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sistema`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`) VALUES
(1, 'SUZUKI', 'SUZUKI@gmail.com', '1234');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Banco de dados: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
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
  `data_criacao` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `artigos`
--

INSERT INTO `artigos` (`idart`, `titulo`, `artigo`, `iduser`, `status`, `data_criacao`) VALUES
(4, 'Um artigo de Teste', 'esse é um artigo muito legal de teste', 2, 'aprovado', '2026-09-07 07:13:25'),
(9, 'Artigo testando tags 2', 'Esse artigo é para testar as tags e ver se está funcionando', 2, 'rejeitado', '2026-09-07 08:11:44'),
(10, 'Testando para saber se funciona as tags', 'tem que testar né ne né Estevão buxaa', 2, 'aprovado', '2026-09-07 08:26:03'),
(12, 'Verificar se adiciona as tags no artigos_tags', 'Se funcionar, eu mereço uma coxinha', 2, 'aprovado', '2026-09-07 08:37:20'),
(13, 'Artigo gamer', 'Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem ', 3, 'pendente', '2026-09-07 20:00:24'),
(16, 'Artigo gamerrrr', 'Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem eita eita eita', 3, 'aprovado', '2026-09-07 20:06:22'),
(17, 'Muitas letras', 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb', 3, 'aprovado', '2026-09-07 20:08:43'),
(19, 'Outro artigo de teste', 'artigo diferenciado pra ver alguma coisa aí, sabe?', 2, 'rejeitado', '2026-09-08 18:57:45'),
(20, 'Outro artigo de teste', 'artigo diferenciado pra ver alguma coisa aí, sabe?', 2, 'pendente', '2026-09-08 19:23:33'),
(21, 'Outro artigo de teste222', 'artigo diferenciado pra ver alguma coisa aí, sabe?2222222', 2, 'pendente', '2026-09-08 19:24:57'),
(22, 'Outro artigo de teste333', 'artigo diferenciado pra ver alguma coisa aí, sabe333333', 2, 'pendente', '2026-09-08 19:28:29'),
(23, 'Outro artigo de teste333', 'artigo diferenciado pra ver alguma coisa aí, sabe333333', 2, 'pendente', '2026-09-08 19:34:14'),
(24, 'Meu artigo', 'Conteúdo...', 2, 'pendente', '2026-09-08 19:37:57'),
(25, 'Meu artigo', 'Conteúdo...', 2, 'pendente', '2026-09-08 19:39:08'),
(26, 'Teste frontend', 'Artigo vindo direto do front', 2, 'aprovado', '2026-09-08 20:06:22');

-- --------------------------------------------------------

--
-- Estrutura para tabela `artigos_fontes`
--

CREATE TABLE `artigos_fontes` (
  `idart` int(11) NOT NULL,
  `idfont` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `artigos_fontes`
--

INSERT INTO `artigos_fontes` (`idart`, `idfont`, `nome`) VALUES
(10, 9, 'Lol'),
(12, 11, 'Localhost'),
(13, 12, 'Tiktok'),
(16, 15, 'Google'),
(17, 16, 'Figma'),
(20, 18, 'Que'),
(23, 18, 'Que3333'),
(24, 18, 'Figma'),
(24, 19, 'Documentação oficial'),
(24, 20, 'Google'),
(25, 18, 'Figma'),
(25, 19, 'Documentação oficial'),
(25, 20, 'Google'),
(26, 21, 'Front');

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
(17, 13),
(19, 6),
(19, 7),
(19, 9),
(19, 13),
(20, 6),
(20, 7),
(20, 9),
(20, 13),
(21, 6),
(21, 7),
(21, 9),
(22, 6),
(22, 7),
(22, 9),
(23, 6),
(23, 7),
(23, 9),
(24, 9),
(24, 13),
(25, 9),
(25, 13),
(26, 9),
(26, 10);

-- --------------------------------------------------------

--
-- Estrutura para tabela `fontes`
--

CREATE TABLE `fontes` (
  `idfont` int(11) NOT NULL,
  `link` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `fontes`
--

INSERT INTO `fontes` (`idfont`, `link`) VALUES
(9, '67.com'),
(21, 'criar.html'),
(18, 'figma.com'),
(19, 'https://exemplo.com/docs'),
(20, 'https://google.com'),
(16, 'https://www.figma.com/'),
(15, 'https://www.google.com/'),
(11, 'localhost.com'),
(12, 'tiktok.com');

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
(2, 26),
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
  MODIFY `idart` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de tabela `fontes`
--
ALTER TABLE `fontes`
  MODIFY `idfont` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

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
