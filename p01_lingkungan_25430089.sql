-- Praktikum Basis Data
-- Nama: Ria Rahmadani
-- NIM: 25430089
-- Kelas: D

SELECT VERSION();

SELECT USER();

SHOW DATABASES;

CREATE DATABASE kopma_089
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

CREATE USER 'Ria_089'@'localhost'
IDENTIFIED BY '<PASSWORD>';

GRANT ALL PRIVILEGES ON kopma_089.* 
TO 'Ria_089'@'localhost';

USE kopma_089;

SHOW TABLES;

SELECT @@sql_mode;