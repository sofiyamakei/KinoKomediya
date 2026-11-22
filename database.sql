-- KinoKomediya: создание структуры и заполнение данными.
-- Запускайте на сервере, где база KinoKomediya ещё не создана.
-- Если база уже существует, повторный запуск приведёт к ошибкам создания таблиц/дублирования данных.

USE [master]
GO
/****** Объект:  Database [KinoKomediya]    Дата создания скрипта: 22.11.2026 21:51:21 ******/ 
IF DB_ID(N'KinoKomediya') IS NULL
    CREATE DATABASE [KinoKomediya];
GO
ALTER DATABASE [KinoKomediya] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [KinoKomediya].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [KinoKomediya] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [KinoKomediya] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [KinoKomediya] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [KinoKomediya] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [KinoKomediya] SET ARITHABORT OFF 
GO
ALTER DATABASE [KinoKomediya] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [KinoKomediya] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [KinoKomediya] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [KinoKomediya] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [KinoKomediya] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [KinoKomediya] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [KinoKomediya] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [KinoKomediya] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [KinoKomediya] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [KinoKomediya] SET  ENABLE_BROKER 
GO
ALTER DATABASE [KinoKomediya] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [KinoKomediya] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [KinoKomediya] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [KinoKomediya] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [KinoKomediya] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [KinoKomediya] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [KinoKomediya] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [KinoKomediya] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [KinoKomediya] SET  MULTI_USER 
GO
ALTER DATABASE [KinoKomediya] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [KinoKomediya] SET DB_CHAINING OFF 
GO
ALTER DATABASE [KinoKomediya] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [KinoKomediya] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [KinoKomediya] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [KinoKomediya] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [KinoKomediya] SET QUERY_STORE = OFF
GO
USE [KinoKomediya]
GO
/****** Объект:  Table [dbo].[Countries]    Дата создания скрипта: 22.11.2026 21:51:23 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryID] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Films]    Дата создания скрипта: 22.11.2026 21:51:23 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Films](
	[FilmID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[ReleaseYear] [smallint] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Rating] [decimal](3, 1) NULL,
	[CountryID] [int] NULL,
	[PosterURL] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[FilmID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Genres]    Дата создания скрипта: 22.11.2026 21:51:23 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genres](
	[GenreID] [int] IDENTITY(1,1) NOT NULL,
	[GenreName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[GenreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[FilmGenres]    Дата создания скрипта: 22.11.2026 21:51:23 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilmGenres](
	[FilmID] [int] NOT NULL,
	[GenreID] [int] NOT NULL,
 CONSTRAINT [PK_FilmGenres] PRIMARY KEY CLUSTERED 
(
	[FilmID] ASC,
	[GenreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[People]    Дата создания скрипта: 22.11.2026 21:51:23 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[People](
	[PersonID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](150) NOT NULL,
	[BirthYear] [smallint] NULL,
	[PersonType] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[FilmPeople]    Дата создания скрипта: 22.11.2026 21:51:23 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilmPeople](
	[FilmID] [int] NOT NULL,
	[PersonID] [int] NOT NULL,
	[RoleName] [nvarchar](20) NOT NULL,
	[CharacterName] [nvarchar](150) NULL,
 CONSTRAINT [PK_FilmPeople] PRIMARY KEY CLUSTERED 
(
	[FilmID] ASC,
	[PersonID] ASC,
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[FilmRelations]    Дата создания скрипта: 22.11.2026 21:51:23 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilmRelations](
	[RelationID] [int] IDENTITY(1,1) NOT NULL,
	[FilmID1] [int] NOT NULL,
	[FilmID2] [int] NOT NULL,
	[RelationType] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[RelationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Countries] ON 

INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (2, N'Великобритания')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (1, N'США')
INSERT [dbo].[Countries] ([CountryID], [CountryName]) VALUES (3, N'Франция')
SET IDENTITY_INSERT [dbo].[Countries] OFF
GO
SET IDENTITY_INSERT [dbo].[Films] ON 

INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (1, N'Один дома', 1990, N'Семейная комедия о мальчике, который случайно остаётся дома один на Рождество.', CAST(7.7 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (2, N'Один дома 2: Затерянный в Нью-Йорке', 1992, N'Кевин снова оказывается вдали от семьи.', CAST(7.0 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (3, N'Маска', 1994, N'Банковский служащий находит волшебную маску.', CAST(7.9 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (4, N'Тупой и ещё тупее', 1994, N'Два друга отправляются в невероятное путешествие.', CAST(7.3 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (5, N'Брюс Всемогущий', 2003, N'Телеведущий получает божественные способности.', CAST(7.2 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (6, N'Эйс Вентура: Розыск домашних животных', 1994, N'Эксцентричный детектив ищет пропавших животных.', CAST(7.3 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (7, N'Лжец, лжец', 1997, N'Адвокат на один день теряет способность лгать.', CAST(7.3 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (8, N'День сурка', 1993, N'Телеведущий переживает один и тот же день.', CAST(8.1 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (9, N'Ночь в музее', 2006, N'Ночью экспонаты музея оживают.', CAST(7.0 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (10, N'Ночь в музее 2', 2009, N'Новые приключения оживших музейных экспонатов.', CAST(6.6 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (11, N'Мистер Бин на отдыхе', 2007, N'Мистер Бин отправляется на юг Франции.', CAST(6.5 AS Decimal(3, 1)), 2, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (12, N'Агент Джонни Инглиш', 2003, N'Неуклюжий агент спасает страну.', CAST(6.2 AS Decimal(3, 1)), 2, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (13, N'Джонни Инглиш: Перезагрузка', 2011, N'Агент возвращается к шпионской работе.', CAST(6.3 AS Decimal(3, 1)), 2, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (14, N'Такси', 1998, N'Марсельский таксист помогает полиции.', CAST(7.0 AS Decimal(3, 1)), 3, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (15, N'Такси 2', 2000, N'Таксист Даниэль снова помогает полиции.', CAST(6.5 AS Decimal(3, 1)), 3, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (16, N'1+1', 2011, N'Неожиданная дружба двух очень разных людей.', CAST(8.5 AS Decimal(3, 1)), 3, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (17, N'Амели', 2001, N'Молодая парижанка меняет жизни окружающих.', CAST(7.9 AS Decimal(3, 1)), 3, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (18, N'Большой Лебовски', 1998, N'Беззаботный герой оказывается в центре путаницы.', CAST(8.1 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (19, N'Знакомство с родителями', 2000, N'Знакомство с семьёй невесты идёт не по плану.', CAST(7.0 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (20, N'Знакомство с Факерами', 2004, N'Две очень разные семьи встречаются.', CAST(6.3 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (21, N'Мальчишник в Вегасе', 2009, N'Друзья пытаются восстановить события бурной ночи.', CAST(7.7 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (22, N'Предложение', 2009, N'Начальница и помощник изображают помолвку.', CAST(6.7 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (23, N'Отпуск по обмену', 2006, N'Две женщины меняются домами на праздники.', CAST(7.0 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (24, N'Дьявол носит Prada', 2006, N'Молодая журналистка начинает работать в модном журнале.', CAST(7.0 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (25, N'Школа рока', 2003, N'Музыкант становится учителем и создаёт рок-группу.', CAST(7.2 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (26, N'Пингвины мистера Поппера', 2011, N'Жизнь бизнесмена меняется из-за пингвинов.', CAST(6.0 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (27, N'Мы — Миллеры', 2013, N'Необычная компания притворяется семьёй.', CAST(7.0 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (28, N'Стажёр', 2015, N'Пенсионер становится стажёром в интернет-компании.', CAST(7.1 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (29, N'Отель «Гранд Будапешт»', 2014, N'Приключения консьержа и его помощника.', CAST(8.1 AS Decimal(3, 1)), 1, NULL)
INSERT [dbo].[Films] ([FilmID], [Title], [ReleaseYear], [Description], [Rating], [CountryID], [PosterURL]) VALUES (30, N'Круэлла', 2021, N'История молодой талантливой дизайнерши.', CAST(7.3 AS Decimal(3, 1)), 1, NULL)
SET IDENTITY_INSERT [dbo].[Films] OFF
GO
SET IDENTITY_INSERT [dbo].[Genres] ON 

INSERT [dbo].[Genres] ([GenreID], [GenreName], [Description]) VALUES (1, N'Комедия', N'Фильмы, основная цель которых — вызвать смех')
INSERT [dbo].[Genres] ([GenreID], [GenreName], [Description]) VALUES (2, N'Семейная комедия', N'Комедии для семейного просмотра')
INSERT [dbo].[Genres] ([GenreID], [GenreName], [Description]) VALUES (3, N'Романтическая комедия', N'Комедии с романтической сюжетной линией')
INSERT [dbo].[Genres] ([GenreID], [GenreName], [Description]) VALUES (4, N'Чёрная комедия', N'Комедии, использующие мрачные или табуированные темы')
SET IDENTITY_INSERT [dbo].[Genres] OFF
GO
SET IDENTITY_INSERT [dbo].[People] ON 

INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (1, N'Крис Коламбус', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (2, N'Маколей Калкин', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (3, N'Бен Стиллер', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (4, N'Билл Мюррей', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (5, N'Брэдли Купер', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (6, N'Гарольд Рэмис', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (7, N'Джей Роуч', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (8, N'Джейсон Судейкис', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (9, N'Джек Блэк', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (10, N'Дженнифер Энистон', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (11, N'Джефф Бриджес', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (12, N'Джим Керри', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (13, N'Джоэл Коэн', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (14, N'Дэвид Фрэнкел', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (15, N'Жан-Пьер Жёне', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (16, N'Жерар Кравчик', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (17, N'Жерар Пирес', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (18, N'Итан Коэн', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (19, N'Кейт Уинслет', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (20, N'Крейг Гиллеспи', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (21, N'Кэмерон Диас', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (22, N'Марк Уотерс', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (23, N'Мэрил Стрип', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (24, N'Нэнси Майерс', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (25, N'Одри Тоту', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (26, N'Оливер Паркер', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (27, N'Оливье Накаш', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (28, N'Омар Си', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (29, N'Питер Фаррелли', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (30, N'Питер Хауитт', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (31, N'Ричард Линклейтер', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (32, N'Роберт Де Ниро', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (33, N'Робин Уильямс', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (34, N'Роусон Маршалл Тёрбер', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (35, N'Роуэн Аткинсон', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (36, N'Рэйф Файнс', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (37, N'Сами Насери', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (38, N'Сандра Буллок', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (39, N'Стив Бенделак', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (40, N'Тодд Филлипс', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (41, N'Том Шэдьяк', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (42, N'Уэс Андерсон', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (43, N'Франсуа Клюзе', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (44, N'Чак Рассел', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (45, N'Шон Леви', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (46, N'Эд Хелмс', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (47, N'Эмма Стоун', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (48, N'Энн Флетчер', NULL, N'Режиссёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (49, N'Энн Хэтэуэй', NULL, N'Актёр')
INSERT [dbo].[People] ([PersonID], [FullName], [BirthYear], [PersonType]) VALUES (50, N'Эрик Толедано', NULL, N'Режиссёр')
SET IDENTITY_INSERT [dbo].[People] OFF
GO
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (1, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (1, 2)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (2, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (3, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (4, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (5, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (6, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (7, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (8, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (9, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (10, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (11, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (12, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (13, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (14, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (15, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (16, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (17, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (17, 3)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (18, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (18, 4)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (19, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (20, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (21, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (22, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (22, 3)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (23, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (23, 3)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (24, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (25, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (26, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (27, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (28, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (29, 1)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (29, 4)
INSERT [dbo].[FilmGenres] ([FilmID], [GenreID]) VALUES (30, 1)
GO
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (1, 1, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (1, 2, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (2, 1, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (2, 2, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (3, 12, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (3, 44, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (4, 12, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (4, 29, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (5, 12, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (5, 41, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (6, 12, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (6, 41, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (7, 12, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (7, 41, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (8, 4, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (8, 6, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (9, 3, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (9, 33, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (9, 45, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (10, 3, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (10, 33, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (10, 45, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (11, 35, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (11, 39, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (12, 30, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (12, 35, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (13, 26, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (13, 35, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (14, 17, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (14, 37, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (15, 16, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (15, 37, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (16, 27, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (16, 28, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (16, 43, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (16, 50, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (17, 15, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (17, 25, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (18, 11, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (18, 13, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (18, 18, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (19, 3, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (19, 7, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (19, 32, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (20, 3, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (20, 7, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (20, 32, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (21, 5, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (21, 40, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (21, 46, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (22, 38, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (22, 48, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (23, 19, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (23, 21, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (23, 24, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (24, 14, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (24, 23, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (24, 49, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (25, 9, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (25, 31, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (26, 12, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (26, 22, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (27, 8, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (27, 10, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (27, 34, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (28, 24, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (28, 32, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (29, 36, N'Актёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (29, 42, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (30, 20, N'Режиссёр', NULL)
INSERT [dbo].[FilmPeople] ([FilmID], [PersonID], [RoleName], [CharacterName]) VALUES (30, 47, N'Актёр', NULL)
GO
SET IDENTITY_INSERT [dbo].[FilmRelations] ON 

INSERT [dbo].[FilmRelations] ([RelationID], [FilmID1], [FilmID2], [RelationType], [Description]) VALUES (1, 1, 2, N'Продолжение', N'Второй фильм является продолжением первого')
INSERT [dbo].[FilmRelations] ([RelationID], [FilmID1], [FilmID2], [RelationType], [Description]) VALUES (2, 9, 10, N'Продолжение', N'Второй фильм является продолжением первого')
INSERT [dbo].[FilmRelations] ([RelationID], [FilmID1], [FilmID2], [RelationType], [Description]) VALUES (3, 14, 15, N'Продолжение', N'Второй фильм является продолжением первого')
INSERT [dbo].[FilmRelations] ([RelationID], [FilmID1], [FilmID2], [RelationType], [Description]) VALUES (4, 19, 20, N'Продолжение', N'Второй фильм является продолжением первого')
SET IDENTITY_INSERT [dbo].[FilmRelations] OFF
GO
/****** Объект:  View [dbo].[vw_FilmCatalog]    Дата создания скрипта: 22.11.2026 21:51:23 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Представление каталога фильмов
CREATE   VIEW [dbo].[vw_FilmCatalog]
AS
SELECT
    f.FilmID,
    f.Title,
    f.ReleaseYear,
    f.Description,
    f.Rating,
    c.CountryName
FROM dbo.Films AS f
LEFT JOIN dbo.Countries AS c ON c.CountryID = f.CountryID;

GO
/****** Объект:  View [dbo].[vw_FilmGenres]    Дата создания скрипта: 22.11.2026 21:51:23 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Представление: жанры каждого фильма
CREATE   VIEW [dbo].[vw_FilmGenres]
AS
SELECT f.FilmID, f.Title, f.ReleaseYear, g.GenreName
FROM dbo.Films AS f
INNER JOIN dbo.FilmGenres AS fg ON fg.FilmID = f.FilmID
INNER JOIN dbo.Genres AS g ON g.GenreID = fg.GenreID;

GO
/****** Объект:  View [dbo].[vw_FilmPeople]    Дата создания скрипта: 22.11.2026 21:51:23 ******/ 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Представление: актёры и режиссёры каждого фильма
CREATE   VIEW [dbo].[vw_FilmPeople]
AS
SELECT f.FilmID, f.Title, p.FullName, fp.RoleName, fp.CharacterName
FROM dbo.Films AS f
INNER JOIN dbo.FilmPeople AS fp ON fp.FilmID = f.FilmID
INNER JOIN dbo.People AS p ON p.PersonID = fp.PersonID;

GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [UQ__Countrie__E056F2014DBA011D]    Дата создания скрипта: 22.11.2026 21:51:24 ******/ 
ALTER TABLE [dbo].[Countries] ADD UNIQUE NONCLUSTERED 
(
	[CountryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [UQ_FilmRelations]    Дата создания скрипта: 22.11.2026 21:51:24 ******/ 
ALTER TABLE [dbo].[FilmRelations] ADD  CONSTRAINT [UQ_FilmRelations] UNIQUE NONCLUSTERED 
(
	[FilmID1] ASC,
	[FilmID2] ASC,
	[RelationType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Объект:  Index [IX_Films_ReleaseYear]    Дата создания скрипта: 22.11.2026 21:51:24 ******/ 
CREATE NONCLUSTERED INDEX [IX_Films_ReleaseYear] ON [dbo].[Films]
(
	[ReleaseYear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [IX_Films_Title]    Дата создания скрипта: 22.11.2026 21:51:24 ******/ 
CREATE NONCLUSTERED INDEX [IX_Films_Title] ON [dbo].[Films]
(
	[Title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [UQ__Genres__BBE1C339775EED2B]    Дата создания скрипта: 22.11.2026 21:51:24 ******/ 
ALTER TABLE [dbo].[Genres] ADD UNIQUE NONCLUSTERED 
(
	[GenreName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Объект:  Index [IX_People_FullName]    Дата создания скрипта: 22.11.2026 21:51:24 ******/ 
CREATE NONCLUSTERED INDEX [IX_People_FullName] ON [dbo].[People]
(
	[FullName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FilmGenres]  WITH CHECK ADD  CONSTRAINT [FK_FilmGenres_Films] FOREIGN KEY([FilmID])
REFERENCES [dbo].[Films] ([FilmID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FilmGenres] CHECK CONSTRAINT [FK_FilmGenres_Films]
GO
ALTER TABLE [dbo].[FilmGenres]  WITH CHECK ADD  CONSTRAINT [FK_FilmGenres_Genres] FOREIGN KEY([GenreID])
REFERENCES [dbo].[Genres] ([GenreID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FilmGenres] CHECK CONSTRAINT [FK_FilmGenres_Genres]
GO
ALTER TABLE [dbo].[FilmPeople]  WITH CHECK ADD  CONSTRAINT [FK_FilmPeople_Films] FOREIGN KEY([FilmID])
REFERENCES [dbo].[Films] ([FilmID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FilmPeople] CHECK CONSTRAINT [FK_FilmPeople_Films]
GO
ALTER TABLE [dbo].[FilmPeople]  WITH CHECK ADD  CONSTRAINT [FK_FilmPeople_People] FOREIGN KEY([PersonID])
REFERENCES [dbo].[People] ([PersonID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FilmPeople] CHECK CONSTRAINT [FK_FilmPeople_People]
GO
ALTER TABLE [dbo].[FilmRelations]  WITH CHECK ADD  CONSTRAINT [FK_FilmRelations_Film1] FOREIGN KEY([FilmID1])
REFERENCES [dbo].[Films] ([FilmID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FilmRelations] CHECK CONSTRAINT [FK_FilmRelations_Film1]
GO
ALTER TABLE [dbo].[FilmRelations]  WITH CHECK ADD  CONSTRAINT [FK_FilmRelations_Film2] FOREIGN KEY([FilmID2])
REFERENCES [dbo].[Films] ([FilmID])
GO
ALTER TABLE [dbo].[FilmRelations] CHECK CONSTRAINT [FK_FilmRelations_Film2]
GO
ALTER TABLE [dbo].[Films]  WITH CHECK ADD  CONSTRAINT [FK_Films_Countries] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Countries] ([CountryID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Films] CHECK CONSTRAINT [FK_Films_Countries]
GO
ALTER TABLE [dbo].[FilmPeople]  WITH CHECK ADD  CONSTRAINT [CK_FilmPeople_RoleName] CHECK  (([RoleName]=N'Режиссёр' OR [RoleName]=N'Актёр'))
GO
ALTER TABLE [dbo].[FilmPeople] CHECK CONSTRAINT [CK_FilmPeople_RoleName]
GO
ALTER TABLE [dbo].[FilmRelations]  WITH CHECK ADD  CONSTRAINT [CK_FilmRelations_DifferentFilms] CHECK  (([FilmID1]<>[FilmID2]))
GO
ALTER TABLE [dbo].[FilmRelations] CHECK CONSTRAINT [CK_FilmRelations_DifferentFilms]
GO
ALTER TABLE [dbo].[Films]  WITH CHECK ADD  CONSTRAINT [CK_Films_Rating] CHECK  (([Rating] IS NULL OR [Rating]>=(0) AND [Rating]<=(10)))
GO
ALTER TABLE [dbo].[Films] CHECK CONSTRAINT [CK_Films_Rating]
GO
ALTER TABLE [dbo].[Films]  WITH CHECK ADD  CONSTRAINT [CK_Films_ReleaseYear] CHECK  (([ReleaseYear]>=(1888) AND [ReleaseYear]<=(2100)))
GO
ALTER TABLE [dbo].[Films] CHECK CONSTRAINT [CK_Films_ReleaseYear]
GO
ALTER TABLE [dbo].[People]  WITH CHECK ADD  CONSTRAINT [CK_People_PersonType] CHECK  (([PersonType]=N'Актёр и режиссёр' OR [PersonType]=N'Режиссёр' OR [PersonType]=N'Актёр'))
GO
ALTER TABLE [dbo].[People] CHECK CONSTRAINT [CK_People_PersonType]
GO
USE [master]
GO
ALTER DATABASE [KinoKomediya] SET  READ_WRITE 
GO