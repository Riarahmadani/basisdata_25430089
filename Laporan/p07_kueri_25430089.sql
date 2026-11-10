-- ============================================================
-- Berkas : p07_kueri_25430089.sql
-- Praktikum Basis Data - Modul 7 (SELECT & Fungsi Skalar)
-- Nama   : Ria Rahmadani
-- NIM    : 25430089
-- Tema   : Akademik (akad_089)
-- ============================================================

USE akad_089;

-- ------------------------------------------------------------
-- KI-01: Daftar unik prodi mahasiswa
-- Harapan: Menampilkan nama program studi secara unik tanpa duplikat
-- ------------------------------------------------------------
SELECT DISTINCT prodi_mahasiswa AS program_studi
FROM mahasiswa
ORDER BY program_studi ASC;

-- ------------------------------------------------------------
-- KI-02: Mata kuliah 3 SKS pada semester kurikulum tertentu
-- Harapan: Menampilkan daftar mata kuliah berbobot 3 SKS di semester 3 atau 5
-- ------------------------------------------------------------
SELECT kode_mk, nama_mk, sks, semester_kurikulum
FROM mata_kuliah
WHERE sks = 3 AND semester_kurikulum IN (3, 5)
ORDER BY semester_kurikulum, kode_mk;

-- ------------------------------------------------------------
-- KI-03: Rentang tanggal pengajuan KRS awal semester
-- Harapan: Menampilkan data KRS yang diajukan pada tanggal 15 s.d. 16 Agustus 2026
-- ------------------------------------------------------------
SELECT id_krs, no_krs, nim, semester_aktif, tanggal_pengajuan, status_persetujuan
FROM krs
WHERE tanggal_pengajuan BETWEEN '2026-08-15' AND '2026-08-16'
ORDER BY tanggal_pengajuan ASC;

-- ------------------------------------------------------------
-- KI-04: Daftar mahasiswa aktif prodi Ilmu Komputer
-- Harapan: Menampilkan mahasiswa prodi Ilmu Komputer yang berstatus aktif
-- ------------------------------------------------------------
SELECT nim_mahasiswa, nama_mahasiswa, prodi_mahasiswa, angkatan_mahasiswa, status_aktif_mahasiswa
FROM mahasiswa
WHERE prodi_mahasiswa LIKE '%Ilmu Komputer%' AND status_aktif_mahasiswa = 'Aktif'
ORDER BY angkatan_mahasiswa DESC, nim_mahasiswa ASC;

-- ------------------------------------------------------------
-- KI-05: Daftar dosen pada program studi tertentu
-- Harapan: Menampilkan daftar dosen yang mengajar di program studi Ilmu Komputer
-- ------------------------------------------------------------
SELECT kode_dosen, nama_dosen, email_dosen, prodi_dosen
FROM dosen
WHERE prodi_dosen LIKE '%Ilmu Komputer%'
ORDER BY nama_dosen ASC;

-- ------------------------------------------------------------
-- KI-06: Daftar kelas perkuliahan dengan kapasitas di atas 30
-- Harapan: Menampilkan kelas yang memiliki kapasitas lebih dari 30 mahasiswa
-- ------------------------------------------------------------
SELECT id_kelas, kode_kelas, ruangan, kapasitas
FROM kelas_perkuliahan
WHERE kapasitas > 30
ORDER BY kapasitas DESC;

-- ------------------------------------------------------------
-- KI-07: Daftar penilaian mahasiswa yang mendapatkan grade A
-- Harapan: Menampilkan daftar nilai akhir mahasiswa yang mendapatkan grade 'A'
-- ------------------------------------------------------------
SELECT id_nilai, nim, id_kelas, nilai_akhir, grade
FROM penilaian
WHERE grade = 'A'
ORDER BY nilai_akhir DESC;

-- ------------------------------------------------------------
-- KI-08: Daftar mahasiswa berdasarkan rentang angkatan menggunakan BETWEEN
-- Harapan: Menampilkan mahasiswa dengan angkatan tahun 2023 sampai 2025
-- ------------------------------------------------------------
SELECT nim_mahasiswa, nama_mahasiswa, prodi_mahasiswa, angkatan_mahasiswa, status_aktif_mahasiswa
FROM mahasiswa
WHERE angkatan_mahasiswa BETWEEN 2023 AND 2025
ORDER BY angkatan_mahasiswa DESC, nama_mahasiswa ASC;

-- ------------------------------------------------------------
-- KI-09: Daftar detail KRS berdasarkan ID kelas tertentu
-- Harapan: Menampilkan relasi detail KRS untuk kelas dengan ID = 1
-- ------------------------------------------------------------
SELECT id_krs, id_kelas
FROM detail_krs
WHERE id_kelas = 1
ORDER BY id_krs ASC;

-- ------------------------------------------------------------
-- KI-10: Klasifikasi status mahasiswa menggunakan ekspresi CASE
-- Harapan: Mengelompokkan mahasiswa berdasarkan tingkat studinya menggunakan CASE
-- ------------------------------------------------------------
SELECT
    nim_mahasiswa,
    nama_mahasiswa,
    angkatan_mahasiswa,
    CASE
        WHEN angkatan_mahasiswa >= 2025 THEN 'Mahasiswa Baru / Tingkat Awal'
        WHEN angkatan_mahasiswa = 2024 THEN 'Mahasiswa Tingkat Menengah'
        ELSE 'Mahasiswa Tingkat Akhir'
    END AS kategori_tingkat_studi
FROM mahasiswa
ORDER BY angkatan_mahasiswa DESC, nama_mahasiswa ASC;