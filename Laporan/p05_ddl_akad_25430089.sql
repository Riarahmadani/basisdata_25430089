-- ============================================================================
-- File: p06_data_25430089.sql
-- Modul 6 - Pengisian, Pengubahan, dan Pengujian Data dengan DML
-- Database: akad_089 | NIM: 25430089 | Nama: Ria Rahmadani
-- ============================================================================

USE akad_089;

-- ----------------------------------------------------------------------------
-- 1. PENGISIAN DATA MASTER / INDUK
-- ----------------------------------------------------------------------------

-- A. Data Mahasiswa
INSERT INTO mahasiswa (nim_mahasiswa, nama_mahasiswa, prodi_mahasiswa, angkatan_mahasiswa, no_hp_mahasiswa, status_aktif_mahasiswa) VALUES
('25430089', 'Ria Rahmadani', 'Ilmu Komputer', 2025, '081234567889', 'Aktif'),
('25430001', 'Budi Santoso', 'Ilmu Komputer', 2025, '081234567890', 'Aktif'),
('25430002', 'Siti Aminah', 'Ilmu Komputer', 2025, '081234567891', 'Aktif'),
('25430003', 'Eko Prasetyo', 'Sistem Informasi', 2025, NULL, 'Aktif'),
('25430004', 'Dewi Lestari', 'Teknik Informatika', 2024, '081234567893', 'Cuti');

-- B. Data Dosen
INSERT INTO dosen (kode_dosen, nama_dosen, email_dosen, prodi_dosen) VALUES
('D01', 'Dedi Irawan, S.Kom., M.T.I.', 'dedi@ummetro.ac.id', 'Ilmu Komputer'),
('D02', 'Ahmad Syafii, M.T.', 'syafii@ummetro.ac.id', 'Sistem Informasi'),
('D03', 'Nadia Putri, M.Kom.', 'nadia@ummetro.ac.id', 'Teknik Informatika');

-- C. Data Mata Kuliah
INSERT INTO mata_kuliah (kode_mk, nama_mk, sks, semester_kurikulum) VALUES
('INF301', 'Basis Data', 3, 3),
('INF302', 'Kecerdasan Buatan', 3, 3),
('INF303', 'Statistika dan Probabilitas', 2, 3),
('INF304', 'Organisasi Komputer', 3, 3);

-- ----------------------------------------------------------------------------
-- 2. PENGISIAN DATA RELASI & TRANSAKSI
-- ----------------------------------------------------------------------------

-- D. Data Kelas Perkuliahan
INSERT INTO kelas_perkuliahan (kode_kelas, kode_mk, kode_dosen, ruangan, kapasitas) VALUES
('KLS-INF301-A', 1, 1, 'Lab Komputer 1', 30),
('KLS-INF302-A', 2, 3, 'Ruang 201', 35),
('KLS-INF303-A', 3, 2, 'Ruang 202', 40);

-- E. Data KRS Header
INSERT INTO krs (no_krs, nim, semester_aktif, tanggal_pengajuan, status_persetujuan) VALUES
('KRS-20261-001', '25430089', '20261', '2026-09-01', 'Disetujui'),
('KRS-20261-002', '25430001', '20261', '2026-09-01', 'Disetujui'),
('KRS-20261-003', '25430002', '20261', '2026-09-02', 'Pending');

-- F. Data Detail KRS
INSERT INTO detail_krs (id_krs, id_kelas) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 3);

-- G. Data Penilaian
INSERT INTO penilaian (nim, id_kelas, nilai_tugas, nilai_uts, nilai_uas, nilai_akhir, grade) VALUES
('25430089', 1, 85.00, 80.00, 90.00, 85.50, 'A'),
('25430001', 1, 75.00, 70.00, 80.00, 75.00, 'B');

-- ----------------------------------------------------------------------------
-- 3. UJI UPDATE AMAN (sql_safe_updates)
-- ----------------------------------------------------------------------------
SET SESSION sql_safe_updates = 1;

UPDATE mahasiswa 
SET status_aktif_mahasiswa = 'Aktif' 
WHERE prodi_mahasiswa = 'Ilmu Komputer' AND id_mahasiswa > 0;