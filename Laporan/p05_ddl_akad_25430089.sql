CREATE DATABASE IF NOT EXISTS akad_089;
USE akad_089;

-- 1. Tabel MAHASISWA
CREATE TABLE mahasiswa (
    id_mahasiswa INT AUTO_INCREMENT PRIMARY KEY,
    nim CHAR(15) UNIQUE,
    nama_mahasiswa VARCHAR(100) NOT NULL,
    program_studi VARCHAR(100) NOT NULL,
    angkatan INT NOT NULL,
    no_hp VARCHAR(20) NULL,
    status_aktif ENUM('Aktif', 'Cuti', 'Keluar')
        NOT NULL DEFAULT 'Aktif'
) ENGINE=InnoDB;

-- 2. Tabel DOSEN
CREATE TABLE dosen (
    id_dosen INT AUTO_INCREMENT PRIMARY KEY,
    kode_dosen CHAR(15) NOT NULL UNIQUE,
    nama_dosen VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    prodi VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

-- 3. Tabel MATA_KULIAH
CREATE TABLE mata_kuliah (
    id_mk INT AUTO_INCREMENT PRIMARY KEY,
    kode_mk CHAR(15) NOT NULL UNIQUE,
    nama_mk VARCHAR(100) NOT NULL,
    sks SMALLINT CHECK (sks > 0),
    semester_kurikulum SMALLINT
        CHECK (semester_kurikulum > 0)
) ENGINE=InnoDB;

-- 4. Tabel KRS
CREATE TABLE krs (
    id_krs INT AUTO_INCREMENT PRIMARY KEY,
    no_krs VARCHAR(30) NOT NULL UNIQUE,
    nim CHAR(15) NOT NULL,
    semester_aktif VARCHAR(20) NOT NULL,
    tanggal_pengajuan DATE NOT NULL,
    status_persetujuan
        ENUM('Pending', 'Disetujui', 'Ditolak')
        NOT NULL DEFAULT 'Pending',

    FOREIGN KEY (nim)
        REFERENCES mahasiswa(nim)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 5. Tabel KELAS_PERKULIAHAN
CREATE TABLE kelas_perkuliahan (
    id_kelas INT AUTO_INCREMENT PRIMARY KEY,
    kode_kelas CHAR(15) NOT NULL UNIQUE,
    kode_mk INT NOT NULL,
    kode_dosen INT NOT NULL,
    ruangan VARCHAR(50) NOT NULL,
    kapasitas SMALLINT CHECK (kapasitas >= 0),

    FOREIGN KEY (kode_mk)
        REFERENCES mata_kuliah(id_mk)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (kode_dosen)
        REFERENCES dosen(id_dosen)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 6. Tabel DETAIL_KRS
CREATE TABLE detail_krs (
    id_krs INT NOT NULL,
    id_kelas INT NOT NULL,

    PRIMARY KEY (id_krs, id_kelas),

    FOREIGN KEY (id_krs)
        REFERENCES krs(id_krs)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (id_kelas)
        REFERENCES kelas_perkuliahan(id_kelas)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 7. Tabel PENILAIAN
CREATE TABLE penilaian (
    id_nilai INT AUTO_INCREMENT PRIMARY KEY,
    nim CHAR(15) NOT NULL,
    id_kelas INT NOT NULL,
    nilai_tugas DECIMAL(5,2),
    nilai_uts DECIMAL(5,2),
    nilai_uas DECIMAL(5,2),
    nilai_akhir DECIMAL(5,2),
    grade ENUM('A', 'AB', 'B', 'BC', 'C', 'D', 'E'),

    FOREIGN KEY (nim)
        REFERENCES mahasiswa(nim)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (id_kelas)
        REFERENCES kelas_perkuliahan(id_kelas)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;