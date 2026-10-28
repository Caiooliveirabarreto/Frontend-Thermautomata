-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 28/10/2026 às 11:58
-- Versão do servidor: 10.4.28-MariaDB
-- Versão do PHP: 8.2.4

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
(28, 'Inteligência artificial na educação', 'A inteligência artificial generativa passou a fazer parte da rotina de muitos estudantes brasileiros. Segundo uma pesquisa divulgada pelo Centro Regional de Estudos para o Desenvolvimento da Sociedade da Informação (Cetic.br), sete em cada dez alunos do ensino médio que utilizam a internet recorrem a ferramentas de inteligência artificial, como ChatGPT e Gemini, para realizar pesquisas escolares.\n\nApesar da popularização dessas tecnologias, a pesquisa apontou que apenas 32% dos estudantes receberam orientação escolar sobre como utilizá-las. Esse cenário evidencia a importância de ensinar os jovens a verificar informações, reconhecer possíveis erros nas respostas geradas e utilizar a inteligência artificial de maneira ética e responsável.\n\nA tecnologia pode contribuir para o aprendizado, facilitar a compreensão de conteúdos e ajudar na organização de pesquisas. Entretanto, seu uso deve complementar o desenvolvimento do raciocínio crítico, e não substituir a leitura, a interpretação e a produção de conhecimento pelos próprios estudantes.', 3, 'aprovado', '2026-10-28 07:52:29'),
(29, 'Crescimento da economia brasileira', 'A economia brasileira registrou crescimento de 2,3% em 2025, de acordo com os dados divulgados pelo Instituto Brasileiro de Geografia e Estatística (IBGE). Com esse resultado, o país completou cinco anos consecutivos de expansão econômica. No quarto trimestre do ano, entretanto, a variação foi de apenas 0,1% em comparação com o trimestre anterior.\n\nO Produto Interno Bruto (PIB), indicador que representa o valor dos bens e serviços finais produzidos em um país, alcançou R$ 12,7 trilhões em valores correntes. Esse indicador é utilizado para acompanhar o desempenho da economia e avaliar mudanças na atividade produtiva.\n\nO crescimento econômico pode estar relacionado a fatores como consumo das famílias, investimentos, produção industrial e desempenho dos serviços. Apesar de ser um indicador importante, o aumento do PIB não significa necessariamente que todos os brasileiros tenham experimentado uma melhora equivalente na renda ou nas condições de vida.\n\nPor isso, a análise da economia também exige observar a distribuição de renda, o emprego, a inflação e o acesso da população a serviços essenciais.', 3, 'aprovado', '2026-10-28 07:53:05'),
(30, 'Poluição por microplásticos', 'A contaminação por microplásticos representa um desafio ambiental que exige ações coordenadas entre governos, empresas, pesquisadores e população. Um relatório da Academia Brasileira de Ciências analisou os impactos desses pequenos fragmentos de plástico e apresentou estratégias para reduzir sua presença no meio ambiente.\n\nDe acordo com os dados apresentados pela Agência Brasil, o Brasil contribui anualmente com até 190 mil toneladas de lixo no ambiente marinho. Mundialmente, são produzidas aproximadamente 400 milhões de toneladas de plástico por ano, das quais menos de 10% são recicladas.\n\nGrande parte dos resíduos plásticos que chega aos oceanos tem origem em atividades realizadas em terra, incluindo o turismo, a indústria, a ocupação urbana desordenada e a gestão inadequada dos resíduos sólidos.\n\nO enfrentamento desse problema depende de medidas como melhorar a coleta seletiva, ampliar a reciclagem, reduzir o consumo de plásticos descartáveis e aperfeiçoar as políticas de gerenciamento de resíduos. Além disso, a conscientização ambiental é fundamental para incentivar hábitos de consumo mais responsáveis e proteger os ecossistemas aquáticos.', 2, 'pendente', '2026-10-28 07:54:12'),
(31, 'Saneamento básico e infraestrutura', 'O acesso ao saneamento básico continua sendo um desafio importante no Brasil. Cinco anos após a entrada em vigor do novo Marco Legal do Saneamento Básico, um estudo divulgado pelo Instituto Trata Brasil apontou que os indicadores do setor não apresentaram avanços significativos.\n\nSegundo os dados apresentados pela Agência Brasil, aproximadamente 34 milhões de pessoas ainda não tinham acesso a sistemas formais de abastecimento de água, enquanto mais de 90 milhões não contavam com coleta e tratamento de esgoto.\n\nA ausência desses serviços pode provocar consequências para a saúde pública, aumentar a contaminação de rios e solos e ampliar as desigualdades entre regiões e grupos sociais. Comunidades sem infraestrutura adequada ficam mais expostas a doenças relacionadas à água contaminada e a condições sanitárias precárias.\n\nPara enfrentar o problema, é necessário ampliar os investimentos, melhorar a gestão dos serviços e fortalecer o planejamento das obras de saneamento. A universalização do abastecimento de água e do tratamento de esgoto também depende da fiscalização das metas e da cooperação entre governos, prestadores de serviços e sociedade.', 2, 'pendente', '2026-10-28 07:54:52'),
(32, 'Saúde mental e uso de telas nas escolas', 'O impacto das tecnologias digitais na saúde mental dos estudantes tornou-se um tema cada vez mais presente nas escolas brasileiras. Uma pesquisa TIC Educação 2025, realizada pelo Centro Regional de Estudos para o Desenvolvimento da Sociedade da Informação (Cetic.br), indicou que 80% das instituições de ensino fundamental e médio discutiram o assunto em 2025. Em 2024, esse percentual era de 62%.\n\nO aumento mostra que as instituições de ensino estão dando mais atenção às possíveis consequências do uso de dispositivos digitais entre crianças e adolescentes. Celulares, computadores e tablets podem facilitar o acesso à informação e apoiar atividades pedagógicas, mas seu uso excessivo ou inadequado também pode levantar preocupações relacionadas ao bem-estar e à rotina dos estudantes.\n\nNesse contexto, a escola e a família desempenham papéis importantes na orientação dos jovens. Conversas sobre hábitos digitais, equilíbrio entre atividades on-line e presenciais e uso responsável da tecnologia podem contribuir para uma relação mais saudável com as telas.\n\nO debate também reforça a importância de desenvolver estratégias educacionais que aproveitem os benefícios dos recursos digitais sem ignorar seus possíveis efeitos sobre a saúde e o aprendizado.', 2, 'pendente', '2026-10-28 07:55:43');

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
(28, 23, 'Agência Brasil'),
(29, 24, 'Agência Brasil'),
(30, 25, 'Agência Brasil'),
(31, 26, 'Agência Brasil'),
(32, 27, 'Agência Brasil');

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
(28, 9),
(28, 10),
(28, 14),
(29, 6),
(29, 7),
(29, 14),
(30, 8),
(30, 13),
(30, 14),
(31, 6),
(31, 11),
(31, 15),
(32, 9),
(32, 10),
(32, 11),
(32, 14);

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
(26, 'https://agenciabrasil.ebc.com.br/direitos-humanos/noticia/2025-08/estudo-aponta-estagnacao-no-saneamento-5-anos-apos-novo-marco-legal?utm_source=chatgpt.com'),
(23, 'https://agenciabrasil.ebc.com.br/educacao/noticia/2025-09/sete-em-cada-10-alunos-do-ensino-medio-usam-ia-generativa-em-pesquisas?utm_source=chatgpt.com'),
(24, 'https://agenciabrasil.ebc.com.br/educacao/noticia/2026-03/economia-brasileira-cresce-23-em-2025-revela-ibge?utm_source=chatgpt.com'),
(27, 'https://agenciabrasil.ebc.com.br/educacao/noticia/2026-08/impacto-das-telas-na-saude-mental-ja-e-debatido-em-80-das-escolas?utm_source=chatgpt.com'),
(25, 'https://agenciabrasil.ebc.com.br/meio-ambiente/noticia/2025-08/pesquisadores-propoem-estrategias-de-combate-ao-microplastico-no-pais?utm_source=chatgpt.com'),
(19, 'https://exemplo.com/docs'),
(20, 'https://google.com'),
(16, 'https://www.figma.com/'),
(15, 'https://www.google.com/'),
(22, 'https://www.google.com/search?sca_esv=3525fe30c2ac1638&sxsrf=AKL5yDgwTT_VBCDD3axFbEfoKlkWrwEd_g:1793183776503&udm=2&fbs=ACAhTvwdifjn2dKXmjtOfBxVFl_koHVe5RLSnJlTH2QYaq_YVdbYfq_upmJPcFgYr-v9gSTVyD5sdmH9TPzYOdGBFKOTmwRHfjznPgw66KUD0uZp7whnXjfFo8CctIJy-hvWAWj'),
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
(10, 'Yukimiya', 'yukimiya@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$VFnnShYHQUZ5p5GK3eOCDQ$CVESIBI3SJ8xZZeNFFLMnA0BeBJnwQe6mwZYTh77Bj4', 0, '51232554-7bac-4bc3-9743-d3e3bfc1346f.jpg'),
(11, 'edu', 'edugold697@gmail.com', '$argon2id$v=19$m=65536,t=3,p=4$54rE0Cn4zivhpXikMsyawA$6WHiOyZqnNs2lAae83EluCpqAuVRFtxWeb2ILYhGFOk', 0, '81c112a8-b093-4000-ac02-644a801ddeec.webp');

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
  MODIFY `idart` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de tabela `fontes`
--
ALTER TABLE `fontes`
  MODIFY `idfont` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de tabela `tags`
--
ALTER TABLE `tags`
  MODIFY `idtag` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `iduser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
