-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 14/06/2025 às 03:32
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
-- Banco de dados: `jmpgames`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `biblioteca`
--

CREATE TABLE `biblioteca` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `jogo_id` int(11) NOT NULL,
  `data_compra` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `biblioteca`
--

INSERT INTO `biblioteca` (`id`, `usuario_id`, `jogo_id`, `data_compra`) VALUES
(1, 8, 20, '2025-06-12 23:01:29'),
(2, 8, 21, '2025-06-12 23:07:39'),
(3, 8, 6, '2025-06-12 23:07:39'),
(4, 8, 22, '2025-06-12 23:07:39'),
(5, 8, 17, '2025-06-12 23:09:32'),
(6, 8, 42, '2025-06-12 23:44:25'),
(7, 8, 38, '2025-06-13 16:55:25'),
(8, 8, 41, '2025-06-13 17:44:53');

-- --------------------------------------------------------

--
-- Estrutura para tabela `carrinho`
--

CREATE TABLE `carrinho` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `jogo` varchar(255) NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `quantidade` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `categorias`
--

INSERT INTO `categorias` (`id`, `nome`) VALUES
(1, 'Ação'),
(2, 'Aventura'),
(5, 'Esportes'),
(4, 'Estratégia'),
(3, 'RPG'),
(6, 'Simulação');

-- --------------------------------------------------------

--
-- Estrutura para tabela `jogos`
--

CREATE TABLE `jogos` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `desconto` int(11) DEFAULT 0,
  `imagem` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  `categoria_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `jogos`
--

INSERT INTO `jogos` (`id`, `nome`, `preco`, `desconto`, `imagem`, `descricao`, `categoria_id`) VALUES
(1, 'FIFA', 100.00, 20, 'https://image.api.playstation.com/vulcan/ap/rnd/202409/1317/7e17c704fdb79e5f57be69bb4d8fbc07dda7abb85336b705.png', NULL, 5),
(2, 'Minecraft', 99.00, 10, 'https://m.media-amazon.com/images/I/81gsSy5r13L.png', NULL, 6),
(3, 'Red Dead Redemption 2', 50.00, 50, 'https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/1174180/header.jpg?t=1720558643', NULL, 1),
(4, 'GTA V', 99.00, 30, 'https://upload.wikimedia.org/wikipedia/pt/8/80/Grand_Theft_Auto_V_capa.png', NULL, 1),
(5, 'Stardew Valley', 20.00, 15, 'https://sm.ign.com/ign_br/cover/s/stardew-va/stardew-valley_k54m.jpg', NULL, 6),
(6, 'Among Us', 20.00, 40, 'https://assets.nintendo.com/image/upload/c_fill,w_1200/q_auto:best/f_auto/dpr_2.0/ncom/software/switch/70010000036098/758ab0b61205081da2466386940752c70e0e5ea43bd39e8b9b13eaa455c69b7e', NULL, 4),
(10, 'Hollow Knight', 29.99, 20, 'https://cdn.akamai.steamstatic.com/steam/apps/367520/header.jpg', NULL, 2),
(12, 'Elden Ring', 249.90, 30, 'https://cdn.akamai.steamstatic.com/steam/apps/1245620/header.jpg', NULL, 3),
(13, 'The Witcher 3: Wild Hunt', 89.90, 40, 'https://cdn.akamai.steamstatic.com/steam/apps/292030/header.jpg', NULL, 3),
(14, 'Valorant', 0.00, 0, 'https://store-images.s-microsoft.com/image/apps.21507.13663857844271189.4c1de202-3961-4c40-a0aa-7f4f1388775a.20ed7782-0eda-4f9d-b421-4cc47492edc6', NULL, 1),
(17, 'Alan Wake 2', 299.00, 5, 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/header.jpg', NULL, NULL),
(18, 'Starfield', 349.90, 10, 'https://cdn.akamai.steamstatic.com/steam/apps/1716740/header.jpg', NULL, NULL),
(20, 'Lies of P', 199.90, 20, 'https://cdn.akamai.steamstatic.com/steam/apps/1627720/header.jpg', NULL, NULL),
(21, 'Super Mario Bros. Wonder', 299.00, 0, 'https://www.mobygames.com/images/covers/l/742293-super-mario-bros-wonder-nintendo-switch-front-cover.jpg', NULL, NULL),
(22, 'Avatar: Frontiers of Pandora', 349.90, 10, 'https://cdn.akamai.steamstatic.com/steam/apps/2439730/header.jpg', NULL, NULL),
(23, 'Forza Horizon 5', 249.90, 25, 'https://cdn.akamai.steamstatic.com/steam/apps/1551360/header.jpg', 'Sua maior aventura Horizon te espera! Explore as paisagens vibrantes e em constante evolução do México em mundo aberto.', 1),
(24, 'The Sims 4', 89.00, 50, 'https://cdn.akamai.steamstatic.com/steam/apps/1222670/header.jpg', 'Solte a imaginação e crie um mundo de Sims que é uma expressão da sua personalidade.', 6),
(25, 'Fall Guys', 0.00, 0, 'https://cdn.akamai.steamstatic.com/steam/apps/1097150/header.jpg', 'Você está convidado para tropeçar até a vitória na Cúpula do Tombão. Sozinho ou com amigos, divirta-se nesta gincana multiplayer.', 4),
(26, 'Cuphead', 36.99, 15, 'https://cdn.akamai.steamstatic.com/steam/apps/268910/header.jpg', 'Cuphead é um jogo de ação e tiros clássico, com grande foco nas batalhas de chefes. Inspirado nas animações dos anos 1930.', 1),
(27, 'Celeste', 36.99, 0, 'https://cdn.akamai.steamstatic.com/steam/apps/504230/header.jpg', 'Ajude Madeline a sobreviver à sua jornada para o topo da Montanha Celeste neste jogo de plataforma super afiado.', 2),
(28, 'Sekiro: Shadows Die Twice', 199.90, 30, 'https://cdn.akamai.steamstatic.com/steam/apps/814380/header.jpg', 'Trace seu próprio caminho para a vingança nesta nova aventura dos criadores de Bloodborne e da série Dark Souls.', 1),
(29, 'Stray', 69.90, 10, 'https://cdn.akamai.steamstatic.com/steam/apps/1332010/header.jpg', 'Perdido, sozinho e separado da sua família, um gato de rua precisa desvendar um mistério ancestral para escapar de uma cidade esquecida.', 2),
(30, 'It Takes Two', 199.00, 50, 'https://cdn.akamai.steamstatic.com/steam/apps/1426210/header.jpg', 'Embarque na jornada mais maluca da sua vida em It Takes Two, uma aventura de plataforma que revoluciona o gênero.', 2),
(31, 'Diablo IV', 349.90, 15, 'https://cdn.akamai.steamstatic.com/steam/apps/2344520/header.jpg', 'Junte-se à luta por Santuário em Diablo IV, um RPG de ação e aventura com combates intermináveis contra as forças do mal.', 3),
(32, 'Baldur\'s Gate 3', 199.99, 0, 'https://cdn.akamai.steamstatic.com/steam/apps/1086940/header.jpg', 'Reúna seu grupo e retorne aos Reinos Esquecidos em um conto de companheirismo e traição, sacrifício e sobrevivência.', 3),
(33, 'Cities: Skylines II', 199.00, 10, 'https://cdn.akamai.steamstatic.com/steam/apps/949230/header.jpg', 'Construa uma cidade do zero e a transforme em uma metrópole próspera. A simulação mais realista de construção de cidades.', 6),
(34, 'XCOM 2', 99.90, 75, 'https://cdn.akamai.steamstatic.com/steam/apps/268500/header.jpg', 'Vinte anos se passaram desde que os líderes mundiais se renderam incondicionalmente às forças alienígenas. A XCOM deve se reerguer.', 4),
(35, 'Persona 5 Royal', 299.90, 20, 'https://cdn.akamai.steamstatic.com/steam/apps/1687950/header.jpg', 'Vista a máscara dos Ladrões-Fantasma de Copas e encene grandes assaltos, infiltre-se nas mentes dos corruptos e faça-os mudar!', 3),
(36, 'Mortal Kombat 1', 299.99, 25, 'https://cdn.akamai.steamstatic.com/steam/apps/1971870/header.jpg', 'Descubra um novo Universo de Mortal Kombat, criado pelo Deus do Fogo Liu Kang. Mortal Kombat 1 inaugura uma nova era da franquia.', 1),
(37, 'Street Fighter 6', 249.90, 15, 'https://cdn.akamai.steamstatic.com/steam/apps/1364780/header.jpg', 'Aqui vem o mais novo desafiante da Capcom! Street Fighter 6 é a mais nova evolução da série Street Fighter.', 1),
(38, 'F1 23', 359.00, 60, 'https://cdn.akamai.steamstatic.com/steam/apps/2108330/header.jpg', 'Seja o último a frear no EA SPORTS F1 23, o videogame oficial do 2023 FIA Formula One World Championship.', 5),
(39, 'NBA 2K24', 299.90, 50, 'https://cdn.akamai.steamstatic.com/steam/apps/2338770/header.jpg', 'Vivencie o passado, o presente e o futuro da cultura do basquete no NBA 2K24.', 5),
(40, 'Civilization VI', 129.00, 85, 'https://cdn.akamai.steamstatic.com/steam/apps/289070/header.jpg', 'Originalmente criado pelo lendário Sid Meier, Civilization é um jogo de estratégia por turnos no qual você tenta construir um império.', 4),
(41, 'The Elder Scrolls V: Skyrim', 149.00, 75, 'https://cdn.akamai.steamstatic.com/steam/apps/489830/header.jpg', 'Vencedor de mais de 200 prêmios de Jogo do Ano, Skyrim Special Edition traz a fantasia épica à vida com detalhes impressionantes.', 3),
(42, 'Portal 2', 28.99, 80, 'https://cdn.akamai.steamstatic.com/steam/apps/620/header.jpg', 'O \"modo cooperativo de duas pessoas\" de Portal 2 traz uma campanha completamente nova com uma história, personagens e jogabilidade únicas.', 2);

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = comum, 1 = admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`, `is_admin`) VALUES
(8, 'maria', 'maria@gmail.com', 'scrypt:32768:8:1$rPPhyvURALprSJA7$d269a8b19e729fe1f6fdb822cfe801eda47dd9e8e0d6e2923c4e5cec85833913d433dd0c5cd7bc4d2113e5be596e00e536ec05dc03af9158a9372d19d40a1903', 1),
(9, 'pedro', 'pedro@gmail.com', 'scrypt:32768:8:1$6x2hhekTxHFdydAJ$1f906cb4c8db971a57d4ccc1da73eceb6df31cd5f2e844dc3ac54663ba80fe24a6ebd2bacd528c2c39c10ed7d99bc0e121e33e74361f826ea9feaafc1102e812', 0);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `biblioteca`
--
ALTER TABLE `biblioteca`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `jogo_id` (`jogo_id`);

--
-- Índices de tabela `carrinho`
--
ALTER TABLE `carrinho`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Índices de tabela `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nome` (`nome`);

--
-- Índices de tabela `jogos`
--
ALTER TABLE `jogos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_jogos_categorias` (`categoria_id`);

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
-- AUTO_INCREMENT de tabela `biblioteca`
--
ALTER TABLE `biblioteca`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `carrinho`
--
ALTER TABLE `carrinho`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `jogos`
--
ALTER TABLE `jogos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `biblioteca`
--
ALTER TABLE `biblioteca`
  ADD CONSTRAINT `biblioteca_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `biblioteca_ibfk_2` FOREIGN KEY (`jogo_id`) REFERENCES `jogos` (`id`);

--
-- Restrições para tabelas `carrinho`
--
ALTER TABLE `carrinho`
  ADD CONSTRAINT `carrinho_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Restrições para tabelas `jogos`
--
ALTER TABLE `jogos`
  ADD CONSTRAINT `fk_jogos_categorias` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
