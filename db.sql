/*
SQLyog Community v13.0.1 (64 bit)
MySQL - 8.0.33 : Database - career
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`career` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `career`;

/*Table structure for table `capp_application` */

DROP TABLE IF EXISTS `capp_application`;

CREATE TABLE `capp_application` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `status` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `STUDENT_id` bigint NOT NULL,
  `VACCANCY_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Capp_application_STUDENT_id_685055cd_fk_Capp_student_id` (`STUDENT_id`),
  KEY `Capp_application_VACCANCY_id_63b72d71_fk_Capp_job_and_vacancy_id` (`VACCANCY_id`),
  CONSTRAINT `Capp_application_STUDENT_id_685055cd_fk_Capp_student_id` FOREIGN KEY (`STUDENT_id`) REFERENCES `capp_student` (`id`),
  CONSTRAINT `Capp_application_VACCANCY_id_63b72d71_fk_Capp_job_and_vacancy_id` FOREIGN KEY (`VACCANCY_id`) REFERENCES `capp_job_and_vacancy` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `capp_application` */

insert  into `capp_application`(`id`,`status`,`date`,`STUDENT_id`,`VACCANCY_id`) values 
(7,'accepted','2024-02-05',1,3),
(24,'rejected','2024-02-07',3,4),
(25,'pending','2024-02-07',1,2),
(32,'rejected','2024-02-16',3,5),
(35,'pending','2024-02-16',3,3);

/*Table structure for table `capp_college` */

DROP TABLE IF EXISTS `capp_college`;

CREATE TABLE `capp_college` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `place` varchar(100) NOT NULL,
  `post` varchar(100) NOT NULL,
  `pin` int NOT NULL,
  `phone` bigint NOT NULL,
  `email` varchar(100) NOT NULL,
  `image` varchar(100) NOT NULL,
  `STAFF_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Capp_college_STAFF_id_4df204ba_fk_Capp_staff_id` (`STAFF_id`),
  CONSTRAINT `Capp_college_STAFF_id_4df204ba_fk_Capp_staff_id` FOREIGN KEY (`STAFF_id`) REFERENCES `capp_staff` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `capp_college` */

insert  into `capp_college`(`id`,`name`,`place`,`post`,`pin`,`phone`,`email`,`image`,`STAFF_id`) values 
(1,'Devagiri','Calicut','Calicut',654321,9876543212,'devagiri@gmail.com','devagiri.jpg',1),
(2,'ABC','Calicut','Calicut',654321,9123456789,'abc@gmail.com','img2.jpeg',1),
(3,'providence','kozhikode','malaparamb',786678,9889766588,'joyal@gmail.com','download.jpg',1),
(4,'st theresa\'s','kochi','ekm',682026,9656893342,'stc@edu','20231216_125048.jpg',1);

/*Table structure for table `capp_company` */

DROP TABLE IF EXISTS `capp_company`;

CREATE TABLE `capp_company` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cname` varchar(100) NOT NULL,
  `place` varchar(100) NOT NULL,
  `post` varchar(100) NOT NULL,
  `pin` int NOT NULL,
  `phone` bigint NOT NULL,
  `email` varchar(100) NOT NULL,
  `image` varchar(100) NOT NULL,
  `LOGIN_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Capp_company_LOGIN_id_8a1e51a0_fk_Capp_login_id` (`LOGIN_id`),
  CONSTRAINT `Capp_company_LOGIN_id_8a1e51a0_fk_Capp_login_id` FOREIGN KEY (`LOGIN_id`) REFERENCES `capp_login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `capp_company` */

insert  into `capp_company`(`id`,`cname`,`place`,`post`,`pin`,`phone`,`email`,`image`,`LOGIN_id`) values 
(1,'Infosys','Cochin','Cochin',654321,9876543213,'infosys@gmail.com','img4.jpeg',3),
(2,'TCS','Mumbai','Mumbai',653421,9123456785,'tcs@gmail.com','img4.jpeg',5);

/*Table structure for table `capp_complaint` */

DROP TABLE IF EXISTS `capp_complaint`;

CREATE TABLE `capp_complaint` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `complaint` varchar(100) NOT NULL,
  `reply` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `STUDENT_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Capp_complaint_STUDENT_id_80ca3dc7_fk_Capp_student_id` (`STUDENT_id`),
  CONSTRAINT `Capp_complaint_STUDENT_id_80ca3dc7_fk_Capp_student_id` FOREIGN KEY (`STUDENT_id`) REFERENCES `capp_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `capp_complaint` */

insert  into `capp_complaint`(`id`,`complaint`,`reply`,`date`,`STUDENT_id`) values 
(1,'ytytyt','OKKKK','2024-02-04',1),
(7,'hloo','pending','2024-02-04',1),
(8,'bad','pending','2024-02-07',1),
(9,'bad service ','ok','2024-02-16',3);

/*Table structure for table `capp_course` */

DROP TABLE IF EXISTS `capp_course`;

CREATE TABLE `capp_course` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `details` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `COLLEGE_id` bigint NOT NULL,
  `area` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Capp_course_COLLEGE_id_78f04a1a_fk_Capp_college_id` (`COLLEGE_id`),
  CONSTRAINT `Capp_course_COLLEGE_id_78f04a1a_fk_Capp_college_id` FOREIGN KEY (`COLLEGE_id`) REFERENCES `capp_college` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `capp_course` */

insert  into `capp_course`(`id`,`name`,`details`,`date`,`COLLEGE_id`,`area`) values 
(1,'BCA','3 Year','2024-02-06',1,'Science & Technology'),
(2,'BSc Computer Science','3 Year','2024-02-06',2,'Science & Technology'),
(3,'BCom Finanace','3 Year','2024-02-06',1,'Commerce'),
(4,'BCom CA','3 Year','2024-02-06',1,'Commerce'),
(5,'BA mass comm','3 year','2024-02-16',4,'Literature');

/*Table structure for table `capp_enquiry` */

DROP TABLE IF EXISTS `capp_enquiry`;

CREATE TABLE `capp_enquiry` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `enquiries` varchar(100) NOT NULL,
  `reply` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `STUDENT_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Capp_enquiry_STUDENT_id_af6fa2ab_fk_Capp_student_id` (`STUDENT_id`),
  CONSTRAINT `Capp_enquiry_STUDENT_id_af6fa2ab_fk_Capp_student_id` FOREIGN KEY (`STUDENT_id`) REFERENCES `capp_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `capp_enquiry` */

insert  into `capp_enquiry`(`id`,`enquiries`,`reply`,`date`,`STUDENT_id`) values 
(1,'Hi','pending','2024-02-03',1),
(6,'ghgh','pending','2024-02-03',1),
(7,'eeee','pending','2024-02-03',1),
(8,'Help','pending','2024-02-04',1),
(9,'zhdh','pending','2024-02-07',1),
(10,'do you have a vacancy in stc?','no','2024-02-16',3),
(11,'ghghgh','pending','2024-02-18',5),
(12,'yoo','pending','2024-02-18',3),
(13,'yoo','pending','2024-02-18',3);

/*Table structure for table `capp_feedback_and_rating` */

DROP TABLE IF EXISTS `capp_feedback_and_rating`;

CREATE TABLE `capp_feedback_and_rating` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `feedback` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `rate` varchar(100) NOT NULL,
  `STUDENT_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Capp_feedback_and_rating_STUDENT_id_9c5672b6_fk_Capp_student_id` (`STUDENT_id`),
  CONSTRAINT `Capp_feedback_and_rating_STUDENT_id_9c5672b6_fk_Capp_student_id` FOREIGN KEY (`STUDENT_id`) REFERENCES `capp_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `capp_feedback_and_rating` */

insert  into `capp_feedback_and_rating`(`id`,`feedback`,`date`,`rate`,`STUDENT_id`) values 
(1,'tyty','2024-02-04','2.0',1),
(2,'uiui','2024-02-04','3.0',1),
(3,'good','2024-02-07','2.0',1);

/*Table structure for table `capp_job_and_vacancy` */

DROP TABLE IF EXISTS `capp_job_and_vacancy`;

CREATE TABLE `capp_job_and_vacancy` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `details` varchar(100) NOT NULL,
  `qualification` varchar(100) NOT NULL,
  `last_date` date NOT NULL,
  `no_of_vaccancy` int NOT NULL,
  `COMPANY_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Capp_job_and_vacancy_COMPANY_id_a59e3958_fk_Capp_company_id` (`COMPANY_id`),
  CONSTRAINT `Capp_job_and_vacancy_COMPANY_id_a59e3958_fk_Capp_company_id` FOREIGN KEY (`COMPANY_id`) REFERENCES `capp_company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `capp_job_and_vacancy` */

insert  into `capp_job_and_vacancy`(`id`,`name`,`details`,`qualification`,`last_date`,`no_of_vaccancy`,`COMPANY_id`) values 
(1,'Frontend Developer','Full Time','B.Tech','2024-02-15',5,1),
(2,'Marketting','Full Time','Any Degree','2024-02-25',2,2),
(3,'Flutter Developer','Python Dart Java c SQL','B.Tech,BSc, BCA','2024-03-22',6,1),
(4,'Business Analyst','Full Time','B.Com,M.Com.','2024-02-07',5,1),
(5,'tech lead',' Flutter Dart','BCA','2024-02-23',1,1);

/*Table structure for table `capp_login` */

DROP TABLE IF EXISTS `capp_login`;

CREATE TABLE `capp_login` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Username` varchar(100) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `capp_login` */

insert  into `capp_login`(`id`,`Username`,`Password`,`Type`) values 
(1,'admin','123','admin'),
(2,'staff','123','staff'),
(3,'infosys','123','company'),
(4,'arun','123','student'),
(5,'tcs','123','company'),
(6,'abcd','123','student'),
(8,'abcd','123','student'),
(9,'Kavya','123','staff'),
(10,'aswin','Aswin@123','student'),
(11,'akshay','Akshaypk18','student'),
(12,'hari','Hari@1234','student');

/*Table structure for table `capp_notification` */

DROP TABLE IF EXISTS `capp_notification`;

CREATE TABLE `capp_notification` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `notification` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `STAFF_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Capp_notification_STAFF_id_25cbc7d4_fk_Capp_staff_id` (`STAFF_id`),
  CONSTRAINT `Capp_notification_STAFF_id_25cbc7d4_fk_Capp_staff_id` FOREIGN KEY (`STAFF_id`) REFERENCES `capp_staff` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `capp_notification` */

insert  into `capp_notification`(`id`,`notification`,`date`,`STAFF_id`) values 
(1,'gggggggggggggggggggggggggggggggggggggggggg','2024-02-15',1),
(2,'vacancy in stc','2024-02-16',1);

/*Table structure for table `capp_resume` */

DROP TABLE IF EXISTS `capp_resume`;

CREATE TABLE `capp_resume` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `score` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `resume` varchar(100) NOT NULL,
  `APPLICATION_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Capp_resume_APPLICATION_id_14f341db_fk_Capp_application_id` (`APPLICATION_id`),
  CONSTRAINT `Capp_resume_APPLICATION_id_14f341db_fk_Capp_application_id` FOREIGN KEY (`APPLICATION_id`) REFERENCES `capp_application` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `capp_resume` */

insert  into `capp_resume`(`id`,`score`,`date`,`resume`,`APPLICATION_id`) values 
(7,'20.303047565772367','2024-02-05','20240207-142604.pdf',7),
(24,'14.458880781356399','2024-02-07','20240207-162108.pdf',24),
(25,'16.695677422593644','2024-02-07','20240207-181616.pdf',25),
(32,'6.071767407189163','2024-02-16','20240216-150543.pdf',32),
(35,'4.553825555391873','2024-02-16','20240216-175342.pdf',35);

/*Table structure for table `capp_staff` */

DROP TABLE IF EXISTS `capp_staff`;

CREATE TABLE `capp_staff` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fname` varchar(100) NOT NULL,
  `lname` varchar(100) NOT NULL,
  `place` varchar(100) NOT NULL,
  `post` varchar(100) NOT NULL,
  `pin` int NOT NULL,
  `phone` bigint NOT NULL,
  `email` varchar(100) NOT NULL,
  `image` varchar(100) NOT NULL,
  `LOGIN_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Capp_staff_LOGIN_id_3a900d95_fk_Capp_login_id` (`LOGIN_id`),
  CONSTRAINT `Capp_staff_LOGIN_id_3a900d95_fk_Capp_login_id` FOREIGN KEY (`LOGIN_id`) REFERENCES `capp_login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `capp_staff` */

insert  into `capp_staff`(`id`,`fname`,`lname`,`place`,`post`,`pin`,`phone`,`email`,`image`,`LOGIN_id`) values 
(1,'Meera','K P','Calicut','Calicut',654321,9876543213,'meera@gmail.com','img2.jpeg',2),
(2,'Kavya','P K','Wayanad','Kalpetta',673579,9207391867,'kavya@gmail.com','img2.jpeg',9);

/*Table structure for table `capp_student` */

DROP TABLE IF EXISTS `capp_student`;

CREATE TABLE `capp_student` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fname` varchar(100) NOT NULL,
  `lname` varchar(100) NOT NULL,
  `place` varchar(100) NOT NULL,
  `post` varchar(100) NOT NULL,
  `pin` int NOT NULL,
  `phone` bigint NOT NULL,
  `email` varchar(100) NOT NULL,
  `image` varchar(100) NOT NULL,
  `LOGIN_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Capp_student_LOGIN_id_a4a10db6_fk_Capp_login_id` (`LOGIN_id`),
  CONSTRAINT `Capp_student_LOGIN_id_a4a10db6_fk_Capp_login_id` FOREIGN KEY (`LOGIN_id`) REFERENCES `capp_login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `capp_student` */

insert  into `capp_student`(`id`,`fname`,`lname`,`place`,`post`,`pin`,`phone`,`email`,`image`,`LOGIN_id`) values 
(1,'Arun','A P','Calicut','Calicut',654321,9876543212,'arun@gmail.com','img2.jpeg',4),
(2,'a','b','c','d',654321,9876543212,'a@gmail.com','20240204-094031.jpg',8),
(3,'Aswin','P K','Calicut','Calicut',673879,9876544321,'aswin@gmail.com','20240207-140815.jpg',10),
(4,'Akshay','P K','Calicut','Calicut',657918,9876543215,'akshay@gmail.com','20240207-141150.jpg',11),
(5,'Hari','Krishna','Calicut','Calicut',654123,9852367415,'hari@gmail.com','20240218-102417.jpg',12);

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(7,'Capp','application'),
(8,'Capp','college'),
(9,'Capp','company'),
(19,'Capp','complaint'),
(18,'Capp','course'),
(17,'Capp','enquiry'),
(16,'Capp','feedback_and_rating'),
(15,'Capp','job_and_vacancy'),
(10,'Capp','login'),
(14,'Capp','notification'),
(13,'Capp','resume'),
(12,'Capp','staff'),
(11,'Capp','student'),
(5,'contenttypes','contenttype'),
(6,'sessions','session');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
