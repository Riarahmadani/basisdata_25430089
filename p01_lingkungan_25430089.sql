-- Praktikum Basis Data
-- Nama: Ria Rahmadani
-- NIM: 25430089
-- Kelas: D

SELECT VERSION();

SELECT USER();

SHOW DATABASES;

CREATE DATABASE IF NOT EXISTS kopma_089
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'Ria_089'@'localhost'
IDENTIFIED BY '<PASSWORD>';

GRANT ALL PRIVILEGES ON kopma_089.* 
TO 'Ria_089'@'localhost';

USE kopma_089;

SHOW TABLES;

SELECT @@sql_mode;
CREATE USER IF NOT EXISTS 'tamu_089'@'localhost'
IDENTIFIED BY '<PASSWORD>';

GRANT SELECT ON kopma_089.* 
TO 'tamu_089'@'localhost';



-- Milestone Proyek 1

-- Tema: Akademik


CREATE DATABASE IF NOT EXISTS akad_089

CHARACTER SET utf8mb4

COLLATE utf8mb4_unicode_ci;



CREATE USER IF NOT EXISTS 'dev_089'@'localhost'

IDENTIFIED BY '161006'; 



GRANT ALL PRIVILEGES ON akad_089.*

TO 'dev_089'@'localhost';