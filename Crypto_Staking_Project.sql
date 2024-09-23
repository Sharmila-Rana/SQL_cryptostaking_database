create database crypto_staking_project;
use  crypto_staking_project;

--  table 1 (user)
create table Users (Id int auto_increment primary key  , User_name varchar(20) not null , Password varchar(20), 
Email varchar (20) unique  , Created_at datetime , Verified_at boolean , Status Boolean , Role varchar(30), 
Referralcode varchar(50) unique  ,Referred_by int ,foreign key(Referred_by) references Users(Id) ) ;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` TRIGGER `users_AFTER_INSERT` AFTER INSERT ON `users` FOR EACH ROW BEGIN
insert into wallet(user_id)
Values(new.Id);
END$$
DELIMITER ;


-- table 2 (wallet)
create table Wallet (Id int auto_increment primary key ,User_id int , foreign key (User_id) references Users(Id) 
on update cascade on delete cascade, Available_Balance float , Reserved_Balance float , 
Level_Income float , Referral_Income float , Reward_Income float , ROI_Income float , Status varchar(20));



-- table 3 (packages)
create table Packages (Id int auto_increment primary key ,Package_name varchar(30) unique   ,Amount float , 
Period datetime , ROI_per_day float , Status boolean);


-- table 4 (user membership)
create table User_Membership (Id int auto_increment primary key , User_Id int , foreign key (User_Id) references Users(Id) 
on update cascade on delete cascade, Package_Id int ,foreign key (Package_Id) references Packages(Id)
on update cascade on delete cascade, Created_at datetime , Status boolean, ROI_Recevied_date datetime, Next_date datetime);



-- table 5 (ROI income ) 
create table ROI_Income (Id int auto_increment primary key , foreign key (Id) references User_Membership(Id) 
on update cascade on delete cascade,Date_time datetime , ROI_Received float);

DELIMITER $$

CREATE DEFINER=`root`@`localhost` TRIGGER `roi_income_AFTER_INSERT` AFTER INSERT ON `roi_income` FOR EACH ROW BEGIN
insert into wallet(roi_income)
Values(new.roi_received);
END$$
DELIMITER ;

-- table 6 (userreferral)
create table User_Referral (Id int auto_increment primary key , Child_Id int , foreign key (Child_Id) references Users(Id) 
on update cascade on delete cascade, Parent_Id int , foreign key (Parent_Id) references Users(Id) 
on update cascade on delete cascade, Date_time datetime , Referral_income int);

DELIMITER $$

CREATE DEFINER=`root`@`localhost` TRIGGER `user_referral_AFTER_INSERT` AFTER INSERT ON `user_referral` FOR EACH ROW BEGIN
insert into wallet(rfeferral_income)
Values(new.referral_income);
END$$
DELIMITER ;



--  table 7 (levels)
create table Levels (Id int auto_increment  primary key , Points decimal(10,2));

-- table 8 (levelincome)
create table Level_Income (Id int auto_increment primary key , Child_Id int ,  foreign key (Child_Id) references Users(Id) 
on update cascade on delete cascade, Parent_Id int , foreign key (Parent_Id) references Users(Id) 
on update cascade on delete cascade, Date datetime , Level_Income_Received varchar(30), 
Level_Id int , foreign key (Level_Id) references Levels(Id) on update cascade on delete cascade);

DELIMITER $$

CREATE DEFINER=`root`@`localhost` TRIGGER `level_income_AFTER_INSERT` AFTER INSERT ON `level_income` FOR EACH ROW BEGIN
insert into wallet(level_income)
Values(new.level_income_received);
END$$
DELIMITER ;


--  table 9 (reward)
create table Rewards (Id int auto_increment primary key , Reward_name varchar(50), Reward varchar(50),
Business_required varchar(50) , Status boolean);


-- table 10 (user reward )
create table User_Reward (Id int auto_increment primary key , User_Id int , foreign key (User_Id) references Users(Id) 
on update cascade on delete cascade, Reward_Id int , foreign key (Reward_Id) references Rewards(Id) 
on update cascade on delete cascade,Date datetime , Reward_received varchar(30));

DELIMITER $$

CREATE DEFINER=`root`@`localhost` TRIGGER `user_reward_AFTER_INSERT` AFTER INSERT ON `user_reward` FOR EACH ROW BEGIN
insert into wallet(reward_income)
Values(new.reward_received);
END$$
DELIMITER ;



-- table 11 (transactions)
create table Transactions (Id int auto_increment primary key , Wallet_Id int , foreign key (Wallet_Id) references Wallet(Id) 
on update cascade on delete cascade,Opening_balance float , Closing_balance float , Credit float , Debit float , 
Type_income varchar(30), Date_time datetime , Status boolean , Amount float , Comment varchar(30));
