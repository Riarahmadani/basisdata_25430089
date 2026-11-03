-- ============================================================
-- Berkas : p06_data_25430089.sql
-- Praktikum Basis Data - Modul 6 (DML & Data Sampel Proyek)
-- Nama   : Ria Rahmadani
-- NIM    : 25430089 (Parameter P = 9)
-- Tema   : Akademik (akad_089)
-- ============================================================

USE akad_089;

-- Matikan sementara periksa foreign key agar truncating/penghapusan aman
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE detail_krs;
TRUNCATE TABLE krs;
TRUNCATE TABLE kelas;
TRUNCATE TABLE mata_kuliah;
TRUNCATE TABLE mahasiswa;
TRUNCATE TABLE dosen;
TRUNCATE TABLE semester;

SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------
-- 1. TABEL MASTER: dosen (5 baris)
-- ------------------------------------------------------------
INSERT INTO dosen (id_dosen, nidn_dosen, nama_dosen, email_dosen, status_dosen) VALUES
(1, '0215088001', 'Dedi Irawan, S.Kom., M.T.I.', 'dedi.irawan@ummetro.ac.id', 'aktif'),
(2, '0210048502', 'Ahmad Ridwan, M.Kom.', 'ahmad.ridwan@ummetro.ac.id', 'aktif'),
(3, '0222117803', 'Siti Nurjanah, M.T.', 'siti.nurjanah@ummetro.ac.id', 'aktif'),
(4, '0205018204', 'Budi Santoso, M.Cs.', 'budi.santoso@ummetro.ac.id', 'aktif'),
(5, '0219098705', 'Eka Rahmawati, M.T.I.', 'eka.rahmawati@ummetro.ac.id', 'aktif');

-- ------------------------------------------------------------
-- 2. TABEL MASTER: semester (5 baris)
-- ------------------------------------------------------------
INSERT INTO semester (id_semester, kode_semester, nama_semester, status_semester) VALUES
(1, '20241', 'Ganjil 2024/2025', 'lulus'),
(2, '20242', 'Genap 2024/2025', 'lulus'),
(3, '20251', 'Ganjil 2025/2026', 'lulus'),
(4, '20252', 'Genap 2025/2026', 'lulus'),
(5, '20261', 'Ganjil 2026/2027', 'aktif');

-- ------------------------------------------------------------
-- 3. TABEL MASTER: mahasiswa (10 baris)
-- ------------------------------------------------------------
INSERT INTO mahasiswa (id_mahasiswa, nim_mahasiswa, nama_mahasiswa, prodi_mahasiswa, angkatan_mahasiswa, status_mahasiswa) VALUES
(1, '25430089', 'Ria Rahmadani', 'Ilmu Komputer', '2025', 'aktif'),
(2, '25430001', 'Aditya Pratama', 'Ilmu Komputer', '2025', 'aktif'),
(3, '25430002', 'Bella Safitri', 'Ilmu Komputer', '2025', 'aktif'),
(4, '25430003', 'Citra Dewi', 'Ilmu Komputer', '2025', 'aktif'),
(5, '25430004', 'Deni Setiawan', 'Ilmu Komputer', '2025', 'aktif'),
(6, '24430010', 'Eko Prasetyo', 'Ilmu Komputer', '2024', 'aktif'),
(7, '24430011', 'Fani Rahma', 'Ilmu Komputer', '2024', 'aktif'),
(8, '24430012', 'Gilang Ramadhan', 'Ilmu Komputer', '2024', 'aktif'),
(9, '23430020', 'Hani Wijaya', 'Ilmu Komputer', '2023', 'aktif'),
(10, '23430021', 'Indah Permata', 'Ilmu Komputer', '2023', 'aktif');

-- ------------------------------------------------------------
-- 4. TABEL MASTER: mata_kuliah (9 baris)
-- ------------------------------------------------------------
INSERT INTO mata_kuliah (id_mata_kuliah, kode_mata_kuliah, nama_mata_kuliah, sks_mata_kuliah, semester_mata_kuliah) VALUES
(1, 'INF301', 'Basis Data', 3, 3),
(2, 'INF302', 'Pemrograman Berorientasi Objek', 3, 3),
(3, 'INF303', 'Struktur Data & Algoritma', 3, 3),
(4, 'INF304', 'Jaringan Komputer', 3, 3),
(5, 'INF305', 'Sistem Operasi', 3, 3),
(6, 'INF501', 'Kecerdasan Buatan', 3, 5),
(7, 'INF502', 'Analisis & Perancangan Sistem', 3, 5),
(8, 'INF101', 'Algoritma Pemrograman', 4, 1),
(9, 'INF102', 'Matematika Diskrit', 3, 1);

-- ------------------------------------------------------------
-- 5. TABEL MASTER: kelas (9 baris)
-- ------------------------------------------------------------
INSERT INTO kelas (id_kelas, id_mata_kuliah, id_dosen, id_semester, nama_kelas, kuota_kelas) VALUES
(1, 1, 1, 5, 'KLS-BD-D', 40),
(2, 2, 2, 5, 'KLS-PBO-D', 40),
(3, 3, 3, 5, 'KLS-SDA-D', 40),
(4, 4, 4, 5, 'KLS-JARKOM-D', 40),
(5, 5, 5, 5, 'KLS-SO-D', 40),
(6, 6, 2, 5, 'KLS-AI-D', 40),
(7, 7, 3, 5, 'KLS-APS-D', 40),
(8, 8, 4, 1, 'KLS-ALPRO-A', 40),
(9, 9, 5, 1, 'KLS-MATDIS-A', 40);

-- ------------------------------------------------------------
-- 6. TABEL TRANSAKSI KEPALA: krs (10 baris, 3 tanggal berbeda)
-- ------------------------------------------------------------
INSERT INTO krs (id_krs, id_mahasiswa, id_semester, tgl_krs, status_krs) VALUES
(1, 1, 5, '2026-08-15 08:30:00', 'disetujui'),
(2, 2, 5, '2026-08-15 09:15:00', 'disetujui'),
(3, 3, 5, '2026-08-15 10:00:00', 'disetujui'),
(4, 4, 5, '2026-08-16 11:20:00', 'disetujui'),
(5, 5, 5, '2026-08-16 13:45:00', 'disetujui'),
(6, 6, 5, '2026-08-16 14:10:00', 'disetujui'),
(7, 7, 5, '2026-08-17 09:00:00', 'disetujui'),
(8, 8, 5, '2026-08-17 10:30:00', 'disetujui'),
(9, 9, 5, '2026-08-17 11:15:00', 'disetujui'),
(10, 10, 5, '2026-08-17 15:00:00', 'disetujui');

-- ------------------------------------------------------------
-- 7. TABEL TRANSAKSI DETAIL: detail_krs
-- Total 90 baris detail (10 mahasiswa x 9 mata kuliah = 90)
-- ------------------------------------------------------------
INSERT INTO detail_krs (id_krs, id_kelas, tgl_ambil_detail_krs) VALUES
-- KRS 1 (Ria Rahmadani)
(1, 1, '2026-08-15 08:31:00'), (1, 2, '2026-08-15 08:32:00'), (1, 3, '2026-08-15 08:33:00'),
(1, 4, '2026-08-15 08:34:00'), (1, 5, '2026-08-15 08:35:00'), (1, 6, '2026-08-15 08:36:00'),
(1, 7, '2026-08-15 08:37:00'), (1, 8, '2026-08-15 08:38:00'), (1, 9, '2026-08-15 08:39:00'),

-- KRS 2 (Aditya Pratama)
(2, 1, '2026-08-15 09:16:00'), (2, 2, '2026-08-15 09:17:00'), (2, 3, '2026-08-15 09:18:00'),
(2, 4, '2026-08-15 09:19:00'), (2, 5, '2026-08-15 09:20:00'), (2, 6, '2026-08-15 09:21:00'),
(2, 7, '2026-08-15 09:22:00'), (2, 8, '2026-08-15 09:23:00'), (2, 9, '2026-08-15 09:24:00'),

-- KRS 3 (Bella Safitri)
(3, 1, '2026-08-15 10:01:00'), (3, 2, '2026-08-15 10:02:00'), (3, 3, '2026-08-15 10:03:00'),
(3, 4, '2026-08-15 10:04:00'), (3, 5, '2026-08-15 10:05:00'), (3, 6, '2026-08-15 10:06:00'),
(3, 7, '2026-08-15 10:07:00'), (3, 8, '2026-08-15 10:08:00'), (3, 9, '2026-08-15 10:09:00'),

-- KRS 4 (Citra Dewi)
(4, 1, '2026-08-16 11:21:00'), (4, 2, '2026-08-16 11:22:00'), (4, 3, '2026-08-16 11:23:00'),
(4, 4, '2026-08-16 11:24:00'), (4, 5, '2026-08-16 11:25:00'), (4, 6, '2026-08-16 11:26:00'),
(4, 7, '2026-08-16 11:27:00'), (4, 8, '2026-08-16 11:28:00'), (4, 9, '2026-08-16 11:29:00'),

-- KRS 5 (Deni Setiawan)
(5, 1, '2026-08-16 13:46:00'), (5, 2, '2026-08-16 13:47:00'), (5, 3, '2026-08-16 13:48:00'),
(5, 4, '2026-08-16 13:49:00'), (5, 5, '2026-08-16 13:50:00'), (5, 6, '2026-08-16 13:51:00'),
(5, 7, '2026-08-16 13:52:00'), (5, 8, '2026-08-16 13:53:00'), (5, 9, '2026-08-16 13:54:00'),

-- KRS 6 (Eko Prasetyo)
(6, 1, '2026-08-16 14:11:00'), (6, 2, '2026-08-16 14:12:00'), (6, 3, '2026-08-16 14:13:00'),
(6, 4, '2026-08-16 14:14:00'), (6, 5, '2026-08-16 14:15:00'), (6, 6, '2026-08-16 14:16:00'),
(6, 7, '2026-08-16 14:17:00'), (6, 8, '2026-08-16 14:18:00'), (6, 9, '2026-08-16 14:19:00'),

-- KRS 7 (Fani Rahma)
(7, 1, '2026-08-17 09:01:00'), (7, 2, '2026-08-17 09:02:00'), (7, 3, '2026-08-17 09:03:00'),
(7, 4, '2026-08-17 09:04:00'), (7, 5, '2026-08-17 09:05:00'), (7, 6, '2026-08-17 09:06:00'),
(7, 7, '2026-08-17 09:07:00'), (7, 8, '2026-08-17 09:08:00'), (7, 9, '2026-08-17 09:09:00'),

-- KRS 8 (Gilang Ramadhan)
(8, 1, '2026-08-17 10:31:00'), (8, 2, '2026-08-17 10:32:00'), (8, 3, '2026-08-17 10:33:00'),
(8, 4, '2026-08-17 10:34:00'), (8, 5, '2026-08-17 10:35:00'), (8, 6, '2026-08-17 10:36:00'),
(8, 7, '2026-08-17 10:37:00'), (8, 8, '2026-08-17 10:38:00'), (8, 9, '2026-08-17 10:39:00'),

-- KRS 9 (Hani Wijaya)
(9, 1, '2026-08-17 11:16:00'), (9, 2, '2026-08-17 11:17:00'), (9, 3, '2026-08-17 11:18:00'),
(9, 4, '2026-08-17 11:19:00'), (9, 5, '2026-08-17 11:20:00'), (9, 6, '2026-08-17 11:21:00'),
(9, 7, '2026-08-17 11:22:00'), (9, 8, '2026-08-17 11:23:00'), (9, 9, '2026-08-17 11:24:00'),

-- KRS 10 (Indah Permata)
(10, 1, '2026-08-17 15:01:00'), (10, 2, '2026-08-17 15:02:00'), (10, 3, '2026-08-17 15:03:00'),
(10, 4, '2026-08-17 15:04:00'), (10, 5, '2026-08-17 15:05:00'), (10, 6, '2026-08-17 15:06:00'),
(10, 7, '2026-08-17 15:07:00'), (10, 8, '2026-08-17 15:08:00'), (10, 9, '2026-08-17 15:09:00');