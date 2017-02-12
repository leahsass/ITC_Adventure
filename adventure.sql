/* might not need since heroku server*/
-- CREATE DATABASE adventure_story;
-- USE adventure_story;

/*Table: Questions, Options, Users (name, save progress)  */

DROP TABLE IF EXISTS `questions_table`;
CREATE TABLE `questions_table` (
`question_id` int(8),
`question` varchar(500) default NULL,
`image` varchar(100) default NULL,
PRIMARY KEY  (`question_id`)
); -- ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `questions_table` (`question_id`,`question`,`image`) VALUES
(1,'A great famine has struck the land! Your father asks you to go into the woods to collect wood to sell in town so your family won\'t starve during the impending cold, winter months. What do you do?','1famine.jpg'),
(2,'You come upon a fork in the path. What do you do?','path.jpg'),
(3,'You lose 5 life points for playing too hard and you\'re getting tired. What do you do next?','3hillsAreAlive.jpg'),
(4,'You chose to go left.','path.jpg'),
(5,'You chose to go right.','path.jpg'),
(6,'The wolves are moving slowly towards you and you can see the drool dripping from their hungry jaws.','6wolves.jpg'),
(7,'You continue down the path and see a house. You walk to the front door and knock. An old lady answers…','7ScaryHouse.gif'),
(8,'You\'re inside the old lady\'s house. What happens?','8creepyInsideHouse.jpg'),
(9,'YOU WIN! Your father is very happy with your success. Now he can sell the wood in town and your family won\'t starve.','victory.png'),
(10,'YOU LOSE! Your father is very angry at your insubordination. He beats you to death.','gameover.png'),
(11,'YOU WIN! You find the wood along the way and go home.','victory.png'),
(12,'YOU LOSE! You lose because you are an idiot.','loser.jpg'),
(13,'YOU LOSE! Your father is very angry at your insubordination. He beats you to death','gameover.png'),
(14,'YOU LOSE! You lazy ****','loser.jpg'),
(15,'YOU LOSE! You accidentally went deeper into the forest to search for a way out. Instead you get more lost and will never find your way home.','gameover.png'),
(16,'YOU WIN! Your father is very happy with your success. Now he can sell the wood in town and your family won\'t starve','victory.png'),
(17,'YOU LOSE! The young girl was secretly a witch in disguise. She casts a spell on you to turn you into a wolf forever. You can never go home now.','gameover.png'),
(18,'YOU LOSE! Don\'t play with spiders you idiot.','loser.jpg'),
(19,'YOU LOSE! The wolves quickly encircle you and you can\'t escape. RIP my friend.','gameover.png'),
(20,'YOU LOSE! You weren\'t fast enough to outrun the wolves. They catch you and tear you apart limb by limb and leave you to die.','gameover.png'),
(21,'YOU LOSE! The old lady tricked you. She\'s really an evil witch! She poisoned your tea and you die.','gameover.png'),
(22,'YOU WIN! You have food and wood for your family.','victory.png'),
(23,'YOU WIN! She\'s a witch! The town thanks you and rewards you handsomely for your triumphs.','victory.png'),
(24,'YOU LOSE! Don\'t eat food from strangers. It was poisoned.','skull.png'),
(25,'YOU WIN! You sing songs with the old lady and make her very happy. She sends you on your way with food for your family.','victory.png'),
(26,'YOU LOSE! You\'ve been tricked! She instead hypnotizes you and makes you her slave apprentice for eternity.','gameover.png'),
(27,'YOU WIN! You discovered that she was a witch! You see a pot of water on the fire and throw it on her. She melts and you can go home. Don\'t forget to get the wood for your father on your way home!','victory.png');


DROP TABLE IF EXISTS `answers_table`;
CREATE TABLE `answers_table` (
`answer_id` varchar(2),
`question_id` int(2) NOT NULL,
`answers` varchar(500) default NULL,
`coins` int(3) NOT NULL,
`life` int(3) NOT NULL, 
`outcome` int(2) NOT NULL,
FOREIGN KEY (`question_id`) REFERENCES questions_table(`question_id`),
FOREIGN KEY (`outcome`) REFERENCES questions_table(`question_id`),
PRIMARY KEY  (`answer_id`)
); -- ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `answers_table` (`answer_id`,`question_id`,`answers`,`coins`,`life`,`outcome`) VALUES
('A',1,'You go into the woods, find wood, and return home.',0,0,9),
('B',1,'You go into the woods and become distracted by the pretty fall leaves. You continue further down the path.',0,0,2),
('C',1,'You decide that you would rather go play in the field nearby.',0,-5,3),
('D',1,'Say no.',-10,0,10),
('E',2,'Go left.',0,0,4),
('F',2,'Go right.',0,0,5),
('G',2,'Turn around and go home.',0,0,11),
('H',2,'Pick it up.',0,0,12),
('I',3,'You hear your father shouting. It\'s starting to get dark. You go home and tell your father you didn\'t get the wood.',-10,-100,13),
('J',3,'You become bored and decide to go get the wood after all.',0,0,1),
('K',3,'You notice a house far away in the field that you\'ve never seen before.',0,0,7),
('L',3,'Keep playing…',0,-10,14),
('M',4,'You encounter a hungry pack of wolves.',0,0,6),
('N',4,'It starts to get dark quickly and you realize you need to get home quickly.',0,-100,15),
('O',4,'You gather the wood and go home.',0,0,16),
('P',4,'Find nothing and turn around to take the other path.',0,0,5),
('Q',5,'You continue farther down the path and notice it\'s getting dark quickly. You see a house in the near distance.',0,0,7),
('R',5,'You encounter a young girl crying.',-10,-100,17),
('S',5,'You decide to play with a web of spiders.',0,-100,18),
('T',5,'You find a sack of coins and continue on your way.',40,0,2),
('U',6,'Fight them off.',20,-50,2),
('V',6,'You freeze out of fear and do nothing.',-10,-100,19),
('W',6,'You decide to play dead.',0,-20,7),
('X',6,'You try to run away.',-10,-100,20),
('Y',7,'She invites you in for tea and you accept.',-10,-100,21),
('Z',7,'You enter the house, steal the old lady\'s food and run away.',0,0,22),
('AA',7,'She invites you inside.',0,0,8),
('BB',7,'You murder her with the ax.',0,0,23),
('CC',8,'She offers soup and you accept.',0,-100,24),
('DD',8,'She offers to teach you songs.',0,0,25),
('EE',8,'She tells you she\'s a good witch, and offers to cast a spell for you.',0,-100,26),
('FF',8,'You notice she has a strange accent and realize…',0,0,27);



DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
`user_id`  int(11) AUTO_INCREMENT, 
`username` varchar(20) default NULL,
`question_id` int(11) NOT NULL default '1',
`coins`  int(11) NOT NULL default '0',
`life`  int(11) NOT NULL default '0',
FOREIGN KEY (`question_id`) REFERENCES questions_table(`question_id`),
PRIMARY KEY (`user_id`)
);