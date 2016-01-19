-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2015-12-31 05:59:47
-- 服务器版本： 10.1.8-MariaDB
-- PHP Version: 5.6.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `exam_bank`
--

-- --------------------------------------------------------

--
-- 表的结构 `Admin`
--

CREATE TABLE `Admin` (
  `a_ID` varchar(20) NOT NULL,
  `a_Name` varchar(20) DEFAULT NULL,
  `a_Pwd` varchar(100) DEFAULT NULL,
  `a_Permission` int(11) DEFAULT NULL,
  `a_RegDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `Article`
--

CREATE TABLE `Article` (
  `a_No` varchar(20) NOT NULL,
  `qt_No` varchar(20) DEFAULT NULL,
  `ep_No` varchar(20) DEFAULT NULL,
  `a_Content` varchar(1000) DEFAULT NULL,
  `a_Ans` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `Choice`
--

CREATE TABLE `Choice` (
  `choice_No` varchar(20) NOT NULL,
  `qt_No` varchar(20) DEFAULT NULL,
  `ep_No` varchar(20) DEFAULT NULL,
  `choice_Title` varchar(1000) DEFAULT NULL,
  `choice_Content` varchar(4000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `Choice`
--

INSERT INTO `Choice` (`choice_No`, `qt_No`, `ep_No`, `choice_Title`, `choice_Content`) VALUES
('1000', '1000', '20150601LV4', NULL, 'http://127.0.0.1/mp3/mp3.mp3'),
('1001', '1000', '20150601LV4', '', 'http://127.0.0.1/mp3/mp3.mp3'),
('1002', '1000', '20150601LV4', '', 'http://127.0.0.1/mp3/mp3.mp3'),
('1003', '1000', '20150601LV4', '', 'http://127.0.0.1/mp3/mp3.mp3'),
('1004', '1000', '20150601LV4', '', 'http://127.0.0.1/mp3/mp3.mp3'),
('1005', '1000', '20150601LV4', '', 'http://127.0.0.1/mp3/mp3.mp3'),
('1006', '1000', '20150601LV4', '', 'http://127.0.0.1/mp3/mp3.mp3'),
('1007', '1000', '20150601LV4', '', 'http://127.0.0.1/mp3/mp3.mp3'),
('1008', '1001', '20150601LV4', 'Questions 9 to 12 are based on the conversation you just heard', 'http://127.0.0.1/mp3/mp3.mp3'),
('1009', '1001', '20150601LV4', 'Questions 13 to 15 are based on the conversation you have just heard.', 'http://127.0.0.1/mp3/mp3.mp3'),
('1010', '1002', '20150601LV4', 'Passage one\rQuestions 16 to 18 are based on the passage you have just heard.\r', 'http://127.0.0.1/mp3/mp3.mp3'),
('1011', '1002', '20150601LV4', 'Passage Two\rQuestions 19-21 are based on the passage you have just heard\r', 'http://127.0.0.1/mp3/mp3.mp3'),
('1012', '1002', '20150601LV4', 'Passage Three\rQuestions 22 to 25 are based on the passage you have just heard.\r', 'http://127.0.0.1/mp3/mp3.mp3'),
('1013', '1004', '20150601LV4', 'Passage One\r????Question 56 to 60 are based on the following passage.', 'Across the rich world, well-educated people increasingly work longer than the less-skilled. Some 65% of American men aged 62-74 with a professional degree are in the workforce, compared with 32% of men with only a high-school certificate. This gap is part of a deepening divide between the well-education well off and the unskilled poor. Rapid technological advance has raised the incomes of the highly skilled while squeezing those of the unskilled. The consequences, for individual and society, are profound.\r\nThe world is facing as astonishing rise in the number of old people, and they will live longer than ever before. Over the next 20 years the global population of those aged 65 or more will almost double, from 600 million to 1.1 billion. The experience of the 20th century, when greater longevity (…)translated into more years in retirement rather than more years at work, has persuaded many observers that this shift will lead to slower economic growth, while the swelling ranks of pensioners will create government budget problems.\r\n　　But the notion of a sharp division between the working young and the idle old misses a new trend, the growing gap between the skilled and the unskilled. Employment rates are falling among younger unskilled people, whereas older skilled folk are working longer. The divide is most extreme in America, where well-educated baby-boomers (二战后生育高峰期出生的美国人) are putting off retirement while many less-skilled younger people have dropped out of the workforce.\r\n　　That even the better-off must work longer to have a comfortable retirement. But the changing nature of work also plays a big role. Pay has risen sharply for the highly educated, and those people continue to reap rich rewards into old age because these days the educated elderly are more productive than the preceding generation. Technological change may well reinforce that shift: the skills that complement computers, from management knowhow to creativity. Do not necessarily decline with age.'),
('1014', '1004', '20150601LV4', 'Passage Two\r????Questions 61-65 are based on the following passage.\r', 'Some of the worlds most significant problems never hit headlines.One example comes from agriculture. Food riots and hunger make news. But the trend lying behind these matters is rarely talked about. This is the decline in the growth in yields of some of the worlds major crops.A new study by the University of Minnesota and McGill University in Montreal looks at where, and how far, this decline is occurring.\r\nThe authors take a vast number of data points for the four most important crops: rice, wheat corn and soybeans(''F). They find that on between 24% and 39% of all harvested areas, the improvement in yields that tood place before the 1980s slowed down in the 1990s and 2000s.\r\nThere are two worrying features of the slowdown. One is that it has been particularly sharp in the worlds most populous(R\Z) countries, India and China. Their ability to feed themselves has been an important source of relative stability both within the countries and on world food markets. That self-sufficiency cannot be taken foror granted if yields continue to slow down or reverse.\r\n\0\0Second, yield growth has been lower in wheat and rice than in corn and soyabeans. This is problematic because wheat and rice are more important as foods, accounting for around half of all calories consumed. Corn and soyabeans are more important as feed grains. The authors note that we have preferentially focused our crop improvement efforts on feeding animals and cars rather than on crops that feed people and are the basis of food security in much of the world.\r\n\0\0The report qualifies the more optimistic findings of another new paper which suggests that the world will not have to dig up a lot more land for farming in order to feed 9 billion people in 2050, as the Food and Agriculture Organisation has argued.\r\n\0\0Instead, it says, thanks to slowing population growth, land currently  ploughted up for crops might be able to revert(回返)to forest or wilderness. This could happen. The trouble is that the forecast assumes continued improvements in yields, which may not actually happen.');

-- --------------------------------------------------------

--
-- 表的结构 `ChoiceQuestion`
--

CREATE TABLE `ChoiceQuestion` (
  `co_No` varchar(20) NOT NULL,
  `choice_No` varchar(20) DEFAULT NULL,
  `co_HadAns` int(11) DEFAULT NULL,
  `co_Right` int(11) DEFAULT NULL,
  `co_Ans` varchar(1000) DEFAULT NULL,
  `co_AnsType` int(11) DEFAULT NULL,
  `co_question` varchar(1000) DEFAULT NULL,
  `co_A` varchar(1000) DEFAULT NULL,
  `co_B` varchar(1000) DEFAULT NULL,
  `co_C` varchar(1000) DEFAULT NULL,
  `co_D` varchar(1000) DEFAULT NULL,
  `co_E` varchar(1000) DEFAULT NULL,
  `co_F` varchar(1000) DEFAULT NULL,
  `co_G` varchar(1000) DEFAULT NULL,
  `co_H` varchar(1000) DEFAULT NULL,
  `co_I` varchar(1000) DEFAULT NULL,
  `co_J` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `ChoiceQuestion`
--

INSERT INTO `ChoiceQuestion` (`co_No`, `choice_No`, `co_HadAns`, `co_Right`, `co_Ans`, `co_AnsType`, `co_question`, `co_A`, `co_B`, `co_C`, `co_D`, `co_E`, `co_F`, `co_G`, `co_H`, `co_I`, `co_J`) VALUES
('1000', '1000', 1, 1, 'A', 0, NULL, 'He is pleased to sit on the committee.', 'He is willing to offer the woman a hand', 'He will tell the woman his decision later', 'He would like to become a club member', NULL, NULL, NULL, NULL, NULL, NULL),
('1001', '1001', 1, 1, 'A', 0, NULL, 'Their planned trip to Vancouver is obviously overpriced', 'They should borrow a guide book instead of buying one', 'The guide books in the library have the latest information', 'The library can help order guide books about Vancouver', '', '', '', '', '', ''),
('1002', '1002', 1, 1, 'A', 0, NULL, 'He regrets having taken the history course', 'He finds little interests in history books', 'He has trouble finishing his reading assignments', 'He has difficulty in writing the weekly book report', '', '', '', '', '', ''),
('1003', '1003', 1, 1, 'A', 0, NULL, 'The man had better choose another restaurant', 'The new restaurant is a perfect place for dating', 'The new restaurant caught her fancy immediately', 'The man has good taste in choosing the restaurant', '', '', '', '', '', ''),
('1004', '1004', 1, 1, 'A', 0, NULL, 'He has been looking forward to sping', 'He will clean the woman??s boots for spring', 'He has been waiting for the winter sale ', 'He will help the woman put things away', '', '', '', '', '', ''),
('1005', '1005', 1, 1, 'A', 0, NULL, 'At a tailor??s C) In a cloth store', 'At Bob??s home D) In a theatre', 'His guests favors Tibetan drinks', 'Mineral water is good for health', '', '', '', '', '', ''),
('1006', '1006', 1, 1, 'A', 0, NULL, ' His guests favors Tibetan drinks', 'His water is quite extraordinary', 'Plain water will serve the purpose', 'Plain water will serve the purpose', '', '', '', '', '', ''),
('1007', '1007', 1, 1, 'A', 0, NULL, 'Report the result of a discussion', ' Raise some environmental issues', 'Submit an important documentation', 'Revise an environmental report', '', '', '', '', '', ''),
('1009', '1008', 1, 0, 'A', 0, '', 'They pollute the soil used to cover them', 'They are harmful to nearby neighborhoods', 'The rubbish in them takes long to dissolve', 'The gas they emit is extremely poisonous', '', '', '', '', '', ''),
('1010', '1008', 1, 0, 'A', 0, '', 'Growing populations', 'Growing populations', 'Packaging materials ', 'Packaging materials ', '', '', '', '', '', ''),
('1011', '1008', 1, 0, 'A', 0, '', 'We are running out of natural resources soon', 'Only combined efforts can make a difference', 'The waste problem will eventually hurt all of us', 'All of us can actually benefit from recycling', '', '', '', '', '', ''),
('1012', '1008', 1, 0, 'A', 0, '', 'We are running out of natural resources soon', 'Only combined efforts can make a difference', 'The waste problem will eventually hurt all of us', 'All of us can actually benefit from recycling', '', '', '', '', '', ''),
('1013', '1009', 1, 0, 'A', 0, '', 'Miami ', 'Vancouver ', 'Bellingham', 'Boston', '', '', '', '', '', ''),
('1014', '1009', 1, 0, 'A', 0, '', 'To get information on one-way tickets to Canada', 'To inquire about the price of ??Super saver ?? seats', 'To get advice on how to fly as cheaply as possible', 'To inquire about the shortest route to drive home', '', '', '', '', '', ''),
('1015', '1009', 1, 0, 'A', 0, '', 'To get information on one-way tickets to Canada', 'To inquire about the price of ??Super saver ?? seats', 'To get advice on how to fly as cheaply as possible', 'To inquire about the shortest route to drive home', '', '', '', '', '', ''),
('1016', '1010', 1, 0, 'A', 0, '', 'There are mysterious stories behind his works', 'There are many misunderstandings about him', 'His works have no match worldwide', 'His personal history is little known', '', '', '', '', '', ''),
('1017', '1010', 1, 0, 'A', 0, '', 'He moved to Stratford-on-Avon in his childhood', 'He failed to go beyond grammar school', 'He was a member of the town council', 'He once worked in a well-know acting company', '', '', '', '', '', ''),
('1018', '1010', 1, 0, 'A', 0, '', 'He moved to Stratford-on-Avon in his childhood', 'He failed to go beyond grammar school', 'He was a member of the town council', 'He once worked in a well-know acting company', '', '', '', '', '', ''),
('1019', '1011', 1, 0, 'A', 0, '', 'It shows you have been ignoring your health', 'It can seriously affect your thinking process', 'It is an early warning of some illness', 'It is a symptom of two much pressure', '', '', '', '', '', ''),
('1020', '1011', 1, 0, 'A', 0, '', 'It shows you have been ignoring your health', 'It can seriously affect your thinking process', 'It is an early warning of some illness', 'It is a symptom of two much pressure', '', '', '', '', '', ''),
('1021', '1011', 1, 0, 'A', 0, '', 'It shows you have been ignoring your health', 'It can seriously affect your thinking process', 'It is an early warning of some illness', 'It is a symptom of two much pressure', '', '', '', '', '', ''),
('1022', '1012', 1, 0, 'A', 0, '', 'Depending heavily on loans ', 'Spending beyond one??s means', 'Having no budget plans at all ', 'Leaving no room for large bills', '', '', '', '', '', ''),
('1023', '1012', 1, 0, 'A', 0, '', 'Depending heavily on loans ', 'Spending beyond one??s means', 'Having no budget plans at all ', 'Leaving no room for large bills', '', '', '', '', '', ''),
('1024', '1012', 1, 0, 'A', 0, '', 'Depending heavily on loans ', 'Spending beyond one??s means', 'Having no budget plans at all ', 'Leaving no room for large bills', '', '', '', '', '', ''),
('1025', '1012', 1, 0, 'A', 0, '', 'Depending heavily on loans ', 'Spending beyond one??s means', 'Having no budget plans at all ', 'Leaving no room for large bills', '', '', '', '', '', ''),
('1026', '1013', 1, 0, 'A', 1, 'what is happening in the workforce in rich countries?', ' younger people are replacing the elderly', ' well-educated people tend to work longer', 'unemployment rates are rising year after year', 'people with no college degree do not easily find work', '', '', '', '', '', ''),
('1027', '1013', 1, 0, 'A', 1, 'what has helped deepen the divide between the well-off and poor?', 'Longer life expectancies', 'Profound changes in the workforce', 'rapid technological advance.', 'A growing number of well-graduated.', '', '', '', '', '', ''),
('1028', '1013', 1, 0, 'A', 1, 'what do many observers predict in view of the experience of the 20th century?', 'Longer life expectancies', 'Profound changes in the workforce', 'rapid technological advance.', 'A growing number of well-graduated.', '', '', '', '', '', ''),
('1029', '1013', 1, 0, 'A', 1, 'What is the result of policy changes in European countries?', 'Longer life expectancies', 'Profound changes in the workforce', 'rapid technological advance.', 'A growing number of well-graduated.', '', '', '', '', '', ''),
('1030', '1013', 1, 0, 'A', 1, 'What is characteristic of work in the 21st century?', 'Longer life expectancies', 'Profound changes in the workforce', 'rapid technological advance.', 'A growing number of well-graduated.', '', '', '', '', '', ''),
('1031', '1014', 1, 0, 'A', 1, 'What does the author try to draw attention to?', 'It is built on the findings of a new study.', 'It is based on a doubtful assumption.', 'It is backed by strong evidence.', 'It is open to further discussion.', '', '', '', '', '', ''),
('1032', '1014', 1, 0, 'A', 1, 'Why does the author mention India and China in particular?', 'It is built on the findings of a new study.', 'It is based on a doubtful assumption.', 'It is backed by strong evidence.', 'It is open to further discussion.', '', '', '', '', '', ''),
('1033', '1014', 1, 0, 'A', 1, 'What does the new study by the two universities say about recent crop improvement efforts?', 'It is built on the findings of a new study.', 'It is based on a doubtful assumption.', 'It is backed by strong evidence.', 'It is open to further discussion.', '', '', '', '', '', ''),
('1034', '1014', 1, 0, 'A', 1, 'What does the Food and Agriculture Organisation say about world food production in the coming decades?', 'It is built on the findings of a new study.', 'It is based on a doubtful assumption.', 'It is backed by strong evidence.', 'It is open to further discussion.', '', '', '', '', '', ''),
('1035', '1014', 1, 0, 'A', 1, 'How does the author view the argument of the Food and Agriculture Organisation?', 'It is built on the findings of a new study.', 'It is based on a doubtful assumption.', 'It is backed by strong evidence.', 'It is open to further discussion.', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- 表的结构 `Completion`
--

CREATE TABLE `Completion` (
  `cp_No` varchar(20) NOT NULL,
  `qt_No` varchar(20) DEFAULT NULL,
  `ep_No` varchar(20) DEFAULT NULL,
  `cp_Content` varchar(4000) DEFAULT NULL,
  `cp_Ans` varchar(3000) DEFAULT NULL,
  `cp_HadAns` int(11) DEFAULT NULL,
  `cp_Right` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `Completion`
--

INSERT INTO `Completion` (`cp_No`, `qt_No`, `ep_No`, `cp_Content`, `cp_Ans`, `cp_HadAns`, `cp_Right`) VALUES
('1000', '1003', '20150601LV4', 'Perhaps because going to college is so much a part of the American dream, many people go for no(26)_____reason. Some go because their parents ecpect it, others because its what their friends are doing.Then, theres the belief that a college degree will(27)____ensure a good job and high pay.\r\nSome students (28)____ through for years ,attending classes, or skipping(™) them as the case may be, reading only what cant be avoided, looking for less(29)_____courses,and never being touched or changed in any important way. For a few of these people, college provides no(30)____yet because of parental or peer pressure, they cannot voluntarily leave. They stop trying in the hope that their teachers will make the decision for them by(31)____ them.\r\nTo put it bluntly(舄S0)unless youre willing to make your college years count, you might be(32)_____ doing something else. Not everyone should attend college, nor should everyone who does attend begin right after high school. Many college students(33)_____ taking a yeaear or so off. A year out in the world helps some people to(34)_____their priorities and goals. If you’re really going to get something out of going to college, you have to make it mean something, and to do that you must have some idea why you’re there, what you hope to get out of it, and (35)_____even what you hope to become.', 'a#a#a#a#a#a#a#a#a', 1, 0);

-- --------------------------------------------------------

--
-- 表的结构 `Course`
--

CREATE TABLE `Course` (
  `c_No` varchar(20) NOT NULL,
  `c_Name` varchar(50) DEFAULT NULL,
  `c_Introduction` varchar(400) DEFAULT NULL,
  `c_AppdendTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `Course`
--

INSERT INTO `Course` (`c_No`, `c_Name`, `c_Introduction`, `c_AppdendTime`) VALUES
('20015LV4', '大学英语四级', NULL, '2015-12-26 00:00:00'),
('c-1000', '  四级英语', NULL, '2015-11-29 00:00:00');

-- --------------------------------------------------------

--
-- 表的结构 `ExaminationPaper`
--

CREATE TABLE `ExaminationPaper` (
  `ep_No` varchar(20) NOT NULL,
  `c_No` varchar(20) DEFAULT NULL,
  `ep_Name` varchar(50) DEFAULT NULL,
  `ep_ModifyTime` datetime DEFAULT NULL,
  `ep_AppdendTime` datetime DEFAULT NULL,
  `ep_Type` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `ExaminationPaper`
--

INSERT INTO `ExaminationPaper` (`ep_No`, `c_No`, `ep_Name`, `ep_ModifyTime`, `ep_AppdendTime`, `ep_Type`) VALUES
('20150601LV4', '20015LV4', '大学英语四级2015年06月真题(一)', '2015-12-26 00:00:00', '2015-12-26 00:00:00', NULL),
('20150602LV4', '20015LV4', '大学英语四级2015年06月真题(二)', '2015-12-26 00:00:00', '2015-12-26 00:00:00', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `LeaveMessages`
--

CREATE TABLE `LeaveMessages` (
  `lm_No` int(11) NOT NULL,
  `u_ID` varchar(20) DEFAULT NULL,
  `lm_Message` varchar(400) DEFAULT NULL,
  `lm_Type` int(11) DEFAULT NULL,
  `lm_AppendTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `QuestionType`
--

CREATE TABLE `QuestionType` (
  `qt_No` varchar(20) NOT NULL,
  `c_No` varchar(20) DEFAULT NULL,
  `qt_Type` varchar(50) DEFAULT NULL,
  `qt_Directions` varchar(1000) DEFAULT NULL,
  `qt_ChoiceNum` int(11) DEFAULT NULL,
  `qt_AnsNum` int(11) DEFAULT NULL,
  `qt_AnsScore` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `QuestionType`
--

INSERT INTO `QuestionType` (`qt_No`, `c_No`, `qt_Type`, `qt_Directions`, `qt_ChoiceNum`, `qt_AnsNum`, `qt_AnsScore`) VALUES
('1000', '20015LV4', 'LV4SC', 'Directions: In this section, you will bear 8 short conversations and 2 long conversations. At the end of each conversation, one or more questions will be asked about what was said. Both the conversation and the questions will be spoken only once. After each questions there will be a pause. During the pause, you must read the four choices marked A), B),C) and D), and decide which is the best answer. Then mark the corresponding letter on Answer sheet 1 with a single line through the center.', 4, 1, 1),
('1001', '20015LV4', 'LV4LC', '', 4, 1, 1),
('1002', '20015LV4', 'LV4SP', 'Section B\r????Directions: In this section, you will hear 3 short passages. At the end of each passage, you will hear some questions. Both the passage and the questions will be spoken only once. After you hear a question, you must choose the best answer from the four choices marketed A), B),C) and D). Then marked the correspond letter on Answer sheet I with a single line through the centre.\r', 4, 1, 1),
('1003', '20015LV4', 'LV4CP', 'Section C\rDirections: in this section,you will hear a paasage three times. When the passage is read for the first time, you should listen carefully for its general idea. When the passage is read for the second time, you are required to fill in the blanks with the exact words you have just heard. Finally, when the passage is reaf for the third time, you should check what you have written.\r', 0, 10, 1),
('1004', '20015LV4', 'LV4ER', 'Section C\r????Directions: There are 2 passages in this section. Each passage is followed by some questions or unfinished statements. For each of them there are four choices marked A), B),C) and D). You should decide on the best choice and mark the corresponding letter on Answer Sheet 2 with a single line through the center.\r', 4, 1, 2);

-- --------------------------------------------------------

--
-- 表的结构 `Test`
--

CREATE TABLE `Test` (
  `u_ID` varchar(20) NOT NULL,
  `ep_No` varchar(20) NOT NULL,
  `record` varchar(1000) DEFAULT NULL,
  `ans` varchar(5000) DEFAULT NULL,
  `final_TimeSlot` float DEFAULT NULL,
  `submit_Time` datetime DEFAULT NULL,
  `score` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `Translation`
--

CREATE TABLE `Translation` (
  `t_No` varchar(20) NOT NULL,
  `ep_No` varchar(20) DEFAULT NULL,
  `qt_No` varchar(20) DEFAULT NULL,
  `t_Content` varchar(1000) DEFAULT NULL,
  `t_Ans` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `USER`
--

CREATE TABLE `USER` (
  `u_ID` varchar(20) NOT NULL,
  `u_Email` varchar(30) DEFAULT NULL,
  `u_Pwd` varchar(100) DEFAULT NULL,
  `u_Name` varchar(20) DEFAULT NULL,
  `u_RegDate` datetime DEFAULT NULL,
  `u_IndeviResume` varchar(200) DEFAULT NULL,
  `u_Sex` int(11) DEFAULT NULL,
  `u_PhoneNo` char(13) DEFAULT NULL,
  `u_Type` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `USER`
--

INSERT INTO `USER` (`u_ID`, `u_Email`, `u_Pwd`, `u_Name`, `u_RegDate`, `u_IndeviResume`, `u_Sex`, `u_PhoneNo`, `u_Type`) VALUES
('10000', 'pzyyll@gmail.com', '9636a9f488ef6d56253302da2968c882', 'pzyyll', '2015-11-29 00:00:00', NULL, 1, '13342232190', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Admin`
--
ALTER TABLE `Admin`
  ADD PRIMARY KEY (`a_ID`);

--
-- Indexes for table `Article`
--
ALTER TABLE `Article`
  ADD PRIMARY KEY (`a_No`),
  ADD KEY `FK_article_part_exam` (`ep_No`),
  ADD KEY `FK_article_part_questionType` (`qt_No`);

--
-- Indexes for table `Choice`
--
ALTER TABLE `Choice`
  ADD PRIMARY KEY (`choice_No`),
  ADD KEY `FK_choice_part_questionType` (`qt_No`),
  ADD KEY `FK_choice_part_exam` (`ep_No`);

--
-- Indexes for table `ChoiceQuestion`
--
ALTER TABLE `ChoiceQuestion`
  ADD PRIMARY KEY (`co_No`),
  ADD KEY `FK_choiceQue_part_choice` (`choice_No`);

--
-- Indexes for table `Completion`
--
ALTER TABLE `Completion`
  ADD PRIMARY KEY (`cp_No`),
  ADD KEY `FK_completion_part_questionType` (`qt_No`),
  ADD KEY `FK_completion_part_exam` (`ep_No`);

--
-- Indexes for table `Course`
--
ALTER TABLE `Course`
  ADD PRIMARY KEY (`c_No`);

--
-- Indexes for table `ExaminationPaper`
--
ALTER TABLE `ExaminationPaper`
  ADD PRIMARY KEY (`ep_No`),
  ADD KEY `FK_exam_part_course` (`c_No`);

--
-- Indexes for table `LeaveMessages`
--
ALTER TABLE `LeaveMessages`
  ADD PRIMARY KEY (`lm_No`),
  ADD KEY `FK_leaveMess_part_u_ID` (`u_ID`);

--
-- Indexes for table `QuestionType`
--
ALTER TABLE `QuestionType`
  ADD PRIMARY KEY (`qt_No`),
  ADD KEY `FK_questionType_part_course` (`c_No`);

--
-- Indexes for table `Test`
--
ALTER TABLE `Test`
  ADD PRIMARY KEY (`u_ID`,`ep_No`),
  ADD KEY `FK_Test` (`ep_No`);

--
-- Indexes for table `Translation`
--
ALTER TABLE `Translation`
  ADD PRIMARY KEY (`t_No`),
  ADD KEY `FK_Translation_part_exam` (`ep_No`),
  ADD KEY `FK_translation_part_questionType` (`qt_No`);

--
-- Indexes for table `USER`
--
ALTER TABLE `USER`
  ADD PRIMARY KEY (`u_ID`);

--
-- 限制导出的表
--

--
-- 限制表 `Article`
--
ALTER TABLE `Article`
  ADD CONSTRAINT `FK_article_part_exam` FOREIGN KEY (`ep_No`) REFERENCES `ExaminationPaper` (`ep_No`),
  ADD CONSTRAINT `FK_article_part_questionType` FOREIGN KEY (`qt_No`) REFERENCES `QuestionType` (`qt_No`);

--
-- 限制表 `Choice`
--
ALTER TABLE `Choice`
  ADD CONSTRAINT `FK_choice_part_exam` FOREIGN KEY (`ep_No`) REFERENCES `ExaminationPaper` (`ep_No`),
  ADD CONSTRAINT `FK_choice_part_questionType` FOREIGN KEY (`qt_No`) REFERENCES `QuestionType` (`qt_No`);

--
-- 限制表 `ChoiceQuestion`
--
ALTER TABLE `ChoiceQuestion`
  ADD CONSTRAINT `FK_choiceQue_part_choice` FOREIGN KEY (`choice_No`) REFERENCES `Choice` (`choice_No`);

--
-- 限制表 `Completion`
--
ALTER TABLE `Completion`
  ADD CONSTRAINT `FK_completion_part_exam` FOREIGN KEY (`ep_No`) REFERENCES `ExaminationPaper` (`ep_No`),
  ADD CONSTRAINT `FK_completion_part_questionType` FOREIGN KEY (`qt_No`) REFERENCES `QuestionType` (`qt_No`);

--
-- 限制表 `ExaminationPaper`
--
ALTER TABLE `ExaminationPaper`
  ADD CONSTRAINT `FK_exam_part_course` FOREIGN KEY (`c_No`) REFERENCES `Course` (`c_No`);

--
-- 限制表 `LeaveMessages`
--
ALTER TABLE `LeaveMessages`
  ADD CONSTRAINT `FK_leaveMess_part_u_ID` FOREIGN KEY (`u_ID`) REFERENCES `USER` (`u_ID`);

--
-- 限制表 `QuestionType`
--
ALTER TABLE `QuestionType`
  ADD CONSTRAINT `FK_questionType_part_course` FOREIGN KEY (`c_No`) REFERENCES `Course` (`c_No`);

--
-- 限制表 `Test`
--
ALTER TABLE `Test`
  ADD CONSTRAINT `FK_Test` FOREIGN KEY (`ep_No`) REFERENCES `ExaminationPaper` (`ep_No`),
  ADD CONSTRAINT `FK_Test2` FOREIGN KEY (`u_ID`) REFERENCES `USER` (`u_ID`);

--
-- 限制表 `Translation`
--
ALTER TABLE `Translation`
  ADD CONSTRAINT `FK_Translation_part_exam` FOREIGN KEY (`ep_No`) REFERENCES `ExaminationPaper` (`ep_No`),
  ADD CONSTRAINT `FK_translation_part_questionType` FOREIGN KEY (`qt_No`) REFERENCES `QuestionType` (`qt_No`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
