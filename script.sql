USE [master]
GO
/****** Object:  Database [BlockChainTech]    Script Date: 11/4/2023 1:14:49 PM ******/
CREATE DATABASE [BlockChainTech]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BlockChainTech', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BlockChainTech.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BlockChainTech_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\BlockChainTech_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [BlockChainTech] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BlockChainTech].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BlockChainTech] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BlockChainTech] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BlockChainTech] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BlockChainTech] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BlockChainTech] SET ARITHABORT OFF 
GO
ALTER DATABASE [BlockChainTech] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BlockChainTech] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BlockChainTech] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BlockChainTech] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BlockChainTech] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BlockChainTech] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BlockChainTech] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BlockChainTech] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BlockChainTech] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BlockChainTech] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BlockChainTech] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BlockChainTech] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BlockChainTech] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BlockChainTech] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BlockChainTech] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BlockChainTech] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BlockChainTech] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BlockChainTech] SET RECOVERY FULL 
GO
ALTER DATABASE [BlockChainTech] SET  MULTI_USER 
GO
ALTER DATABASE [BlockChainTech] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BlockChainTech] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BlockChainTech] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BlockChainTech] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BlockChainTech] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BlockChainTech] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'BlockChainTech', N'ON'
GO
ALTER DATABASE [BlockChainTech] SET QUERY_STORE = ON
GO
ALTER DATABASE [BlockChainTech] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BlockChainTech]
GO
/****** Object:  Table [dbo].[blocks]    Script Date: 11/4/2023 1:14:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[blocks](
	[blockId] [int] IDENTITY(1,1) NOT NULL,
	[blockNumber] [int] NULL,
	[hash] [varchar](66) NULL,
	[parentHash] [varchar](66) NULL,
	[miner] [varchar](255) NULL,
	[blockReward] [decimal](38, 0) NULL,
	[gasLimit] [decimal](38, 0) NULL,
	[gasUsed] [decimal](38, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[blockId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transactions]    Script Date: 11/4/2023 1:14:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transactions](
	[transactionId] [int] IDENTITY(1,1) NOT NULL,
	[blockID] [int] NULL,
	[hash] [varchar](66) NULL,
	[From_] [varchar](42) NULL,
	[to_] [varchar](42) NULL,
	[value_] [decimal](38, 0) NULL,
	[gas] [decimal](38, 0) NULL,
	[gasPrice] [decimal](38, 0) NULL,
	[transactionIndex] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[transactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[blocks] ON 

INSERT [dbo].[blocks] ([blockId], [blockNumber], [hash], [parentHash], [miner], [blockReward], [gasLimit], [gasUsed]) VALUES (2, 17016603, N'0xd1a225e00fdf99d231e20ae9de85b9bcfedf0c1c55600f8cd6b3bf9d8a26c5e2', N'0x47caffc05f00f295d4eda44bd2b42b7416689476bafbdf99cd99816103294c40', N'61e4fc27457b515ea20e03fd0912e209b9e62a1d721412fb403c49f47d89f376', CAST(0 AS Decimal(38, 0)), CAST(30000000 AS Decimal(38, 0)), CAST(295985 AS Decimal(38, 0)))
INSERT [dbo].[blocks] ([blockId], [blockNumber], [hash], [parentHash], [miner], [blockReward], [gasLimit], [gasUsed]) VALUES (3, 17016610, N'0xf611a8beb96b94a4e8f4c5c9c856c83949edf66f35f17f9cbd0a989779ebffed', N'0x9aa5a24905964f30f1b010b6d56c30beeb602fa64ac83584cfe294a7be030a42', N'c8c89157de1d4762f8cdaf5b8448415dab39a1968af412b3d35122bcc165fde5', CAST(0 AS Decimal(38, 0)), CAST(30000000 AS Decimal(38, 0)), CAST(270215 AS Decimal(38, 0)))
INSERT [dbo].[blocks] ([blockId], [blockNumber], [hash], [parentHash], [miner], [blockReward], [gasLimit], [gasUsed]) VALUES (4, 17016614, N'0x7ff4558e3f1040250709f456a2d13bdee4abad395efecf2c52c08ced470309e0', N'0x56792d9feda842b09f4a14323359618a55bb6df9a1ff08cf627ee1b0fec8c8b7', N'4f3599ab8e532f043e123df4db9c79ec55cffb52e94e1ff525b7edc522795569', CAST(0 AS Decimal(38, 0)), CAST(30000000 AS Decimal(38, 0)), CAST(302175 AS Decimal(38, 0)))
INSERT [dbo].[blocks] ([blockId], [blockNumber], [hash], [parentHash], [miner], [blockReward], [gasLimit], [gasUsed]) VALUES (5, 17016675, N'0xd101d1558c0838c069796693b90a81a20bfce519e7b6393d5672e26b2abf011b', N'0x67e5f5a9a42ccc2dcd793777c86196b9b2c52b39ad7138ee63bb4800e14be861', N'7f37ebbd59ccd08f0fcea334fd0ae90a31e6c0f30f4475ef19a7304ce262c104', CAST(0 AS Decimal(38, 0)), CAST(30000000 AS Decimal(38, 0)), CAST(197020 AS Decimal(38, 0)))
INSERT [dbo].[blocks] ([blockId], [blockNumber], [hash], [parentHash], [miner], [blockReward], [gasLimit], [gasUsed]) VALUES (6, 17016691, N'0x8c3f900e8c76ee27ba18fb7f496828d29540db08a77912328419d91cef7e8dd7', N'0x491bb4aafb92a889a6cac07a1960bb9905278176d1defa0f61433e96e4e17c75', N'e6cd765e3c0dc8aad2a2a4f50ce95e6a09178da086587ebdfb2b0164bd0c9497', CAST(0 AS Decimal(38, 0)), CAST(30000000 AS Decimal(38, 0)), CAST(296506 AS Decimal(38, 0)))
INSERT [dbo].[blocks] ([blockId], [blockNumber], [hash], [parentHash], [miner], [blockReward], [gasLimit], [gasUsed]) VALUES (7, 17016704, N'0x6a179751f468fca323acdc0260c57acc7ff06c611a771838996ce7516b2f16ef', N'0xa284a00e53572186d0db882dc06e2eacda8a409038d7a68c156eaa252732e8e0', N'd22d2f9b8ada8d4b430034ae42e5785f3252509c798a49de543dc1f73c685933', CAST(0 AS Decimal(38, 0)), CAST(30000000 AS Decimal(38, 0)), CAST(467955 AS Decimal(38, 0)))
INSERT [dbo].[blocks] ([blockId], [blockNumber], [hash], [parentHash], [miner], [blockReward], [gasLimit], [gasUsed]) VALUES (8, 17016729, N'0x5ae14fb4419a8bf3ed0780e72d5572226d24e8400547a275aa0879e94e90cb70', N'0x0098eee7dbf9ba68d3c9e01a86fa035900b2194412526ecb7183aae7f11d7b27', N'60cce229accc002d631bd48501a3c1b6a52ce36e1f07ff527470b6c28cb9e9a3', CAST(0 AS Decimal(38, 0)), CAST(30000000 AS Decimal(38, 0)), CAST(316264 AS Decimal(38, 0)))
INSERT [dbo].[blocks] ([blockId], [blockNumber], [hash], [parentHash], [miner], [blockReward], [gasLimit], [gasUsed]) VALUES (9, 17016916, N'0xe7163ac6f033076f76d6fd5dd75d16b8995291d939cd4b85c3eba65f9a4f012d', N'0x4c93bdfdc9308ccda58085e6c891a6620a1811912f5c4e5e5db6e2e8bf2cb781', N'7f37ebbd59ccd08f0fcea334fd0ae90a31e6c0f30f4475ef19a7304ce262c104', CAST(0 AS Decimal(38, 0)), CAST(30000000 AS Decimal(38, 0)), CAST(197020 AS Decimal(38, 0)))
SET IDENTITY_INSERT [dbo].[blocks] OFF
GO
SET IDENTITY_INSERT [dbo].[transactions] ON 

INSERT [dbo].[transactions] ([transactionId], [blockID], [hash], [From_], [to_], [value_], [gas], [gasPrice], [transactionIndex]) VALUES (1, NULL, N'0x6a179751f468fca323acdc0260c57acc7ff06c611a771838996ce7516b2f16ef', N'0x4dd36c49b200a6d52ebb365f01bf0e4db8b9f765', N'0x6af1a16fde7346e7729fa921ad2ddf6a462061e2', CAST(0 AS Decimal(38, 0)), CAST(467955 AS Decimal(38, 0)), CAST(19625769167 AS Decimal(38, 0)), 0)
INSERT [dbo].[transactions] ([transactionId], [blockID], [hash], [From_], [to_], [value_], [gas], [gasPrice], [transactionIndex]) VALUES (2, NULL, N'0x5ae14fb4419a8bf3ed0780e72d5572226d24e8400547a275aa0879e94e90cb70', N'0x0b64aa727412fc4c527aa8f14ba83cd8cf5e75fe', N'0x7636a5bfd763cefec2da9858c459f2a9b0fe8a6c', CAST(0 AS Decimal(38, 0)), CAST(316264 AS Decimal(38, 0)), CAST(28064019524 AS Decimal(38, 0)), 0)
INSERT [dbo].[transactions] ([transactionId], [blockID], [hash], [From_], [to_], [value_], [gas], [gasPrice], [transactionIndex]) VALUES (3, NULL, N'0xe7163ac6f033076f76d6fd5dd75d16b8995291d939cd4b85c3eba65f9a4f012d', N'0xae2fc483527b8ef99eb5d9b44875f005ba1fae13', N'0x6b75d8af000000e20b7a7ddf000ba900b4009a80', CAST(223844887 AS Decimal(38, 0)), CAST(197020 AS Decimal(38, 0)), CAST(19087073593 AS Decimal(38, 0)), 0)
SET IDENTITY_INSERT [dbo].[transactions] OFF
GO
ALTER TABLE [dbo].[transactions]  WITH CHECK ADD FOREIGN KEY([blockID])
REFERENCES [dbo].[blocks] ([blockId])
GO
USE [master]
GO
ALTER DATABASE [BlockChainTech] SET  READ_WRITE 
GO
