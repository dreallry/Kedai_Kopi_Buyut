-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 06, 2026 at 06:05 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kedai_kopi_mbah_buyut`
--

-- --------------------------------------------------------

--
-- Table structure for table `aturan_koin`
--

CREATE TABLE `aturan_koin` (
  `id` int(11) NOT NULL,
  `persen_reward` decimal(5,2) NOT NULL DEFAULT 5.00 COMMENT 'Misal 5% dari total belanja dijadikan koin',
  `nilai_koin_rupiah` decimal(10,2) NOT NULL DEFAULT 1.00 COMMENT '1 koin = Rp 1',
  `minimal_belanja` decimal(12,2) NOT NULL DEFAULT 10000.00,
  `aktif` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `aturan_koin`
--

INSERT INTO `aturan_koin` (`id`, `persen_reward`, `nilai_koin_rupiah`, `minimal_belanja`, `aktif`) VALUES
(1, 5.00, 1.00, 15000.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `jam_operasional`
--

CREATE TABLE `jam_operasional` (
  `id` int(11) NOT NULL,
  `hari` enum('Senin','Selasa','Rabu','Kamis','Jumat','Sabtu','Minggu') NOT NULL,
  `buka` time NOT NULL,
  `tutup` time NOT NULL,
  `libur` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jam_operasional`
--

INSERT INTO `jam_operasional` (`id`, `hari`, `buka`, `tutup`, `libur`) VALUES
(1, 'Senin', '09:00:00', '23:00:00', 0),
(2, 'Selasa', '09:00:00', '23:00:00', 0),
(3, 'Rabu', '09:00:00', '23:00:00', 0),
(4, 'Kamis', '09:00:00', '23:00:00', 0),
(5, 'Jumat', '13:00:00', '23:30:00', 0),
(6, 'Sabtu', '08:00:00', '00:00:00', 0),
(7, 'Minggu', '08:00:00', '23:00:00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id` int(11) NOT NULL,
  `nama_kategori` varchar(100) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `aktif` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id`, `nama_kategori`, `keterangan`, `aktif`) VALUES
(1, 'Kopi Tubruk & Tradisional', 'Kopi racikan khas warung Mbah Buyut', 1),
(2, 'Kopi Susu Kekinian', 'Paduan espresso dan krimer gula aren', 1),
(3, 'Wedangan & Non-Kopi', 'Minuman herbal rempah dan non-kafein', 1),
(4, 'Camilan', 'Gorengan dan jajanan pendamping ngopi', 1);

-- --------------------------------------------------------

--
-- Table structure for table `meja`
--

CREATE TABLE `meja` (
  `id` int(11) NOT NULL,
  `no_meja` varchar(20) NOT NULL,
  `kapasitas` int(11) NOT NULL DEFAULT 2,
  `kode_qr` varchar(100) NOT NULL,
  `status` enum('kosong','terisi','reservasi','tutup') NOT NULL DEFAULT 'kosong',
  `dibuat_pada` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `meja`
--

INSERT INTO `meja` (`id`, `no_meja`, `kapasitas`, `kode_qr`, `status`, `dibuat_pada`) VALUES
(1, 'Meja 01', 4, 'QR-MEJA-01', '', '2026-10-06 03:33:08'),
(2, 'Meja 02', 2, 'QR-MEJA-02', '', '2026-10-06 03:33:08'),
(3, 'Meja Lesehan 01', 6, 'QR-LESEHAN-01', '', '2026-10-06 03:33:08');

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `id` int(11) NOT NULL,
  `id_kategori` int(11) NOT NULL,
  `kode_menu` varchar(30) NOT NULL,
  `nama_menu` varchar(150) NOT NULL,
  `deskripsi` text DEFAULT NULL,
  `harga` decimal(12,2) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `tersedia` tinyint(1) NOT NULL DEFAULT 1,
  `dibuat_pada` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id`, `id_kategori`, `kode_menu`, `nama_menu`, `deskripsi`, `harga`, `foto`, `tersedia`, `dibuat_pada`) VALUES
(1, 1, 'KOP-01', 'Kopi Tubruk Robusta Mbah Buyut', 'Kopi hitam mantap aroma pekat khas pedesaan', 10000.00, NULL, 1, '2026-10-06 03:33:08'),
(2, 2, 'KOP-02', 'Es Kopi Susu Gula Jawa', 'Espresso, susu segar, dan gula kelapa asli', 16000.00, NULL, 1, '2026-10-06 03:33:08'),
(3, 3, 'NON-01', 'Wedang Uwuh Rempah', 'Seduhan jahe, kayu secang, dan cengkih', 12000.00, NULL, 1, '2026-10-06 03:33:08'),
(4, 4, 'SNK-01', 'Mendoan Anget Sambel Kecap', 'Isi 4 lembar tempe mendoan gurih', 12000.00, NULL, 1, '2026-10-06 03:33:08');

-- --------------------------------------------------------

--
-- Table structure for table `mutasi_koin`
--

CREATE TABLE `mutasi_koin` (
  `id` int(11) NOT NULL,
  `id_pelanggan` int(11) NOT NULL,
  `id_pesanan` int(11) DEFAULT NULL,
  `jenis` enum('pemasukan','penukaran','penyesuaian') NOT NULL,
  `jumlah_koin` int(11) NOT NULL,
  `saldo_akhir` int(11) NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `waktu` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mutasi_koin`
--

INSERT INTO `mutasi_koin` (`id`, `id_pelanggan`, `id_pesanan`, `jenis`, `jumlah_koin`, `saldo_akhir`, `keterangan`, `waktu`) VALUES
(1, 3, 1, 'penukaran', 1000, 2000, 'Tukar diskon Rp 1.000 pada nota NOTA-202610-001', '2026-10-06 03:33:09'),
(2, 3, 1, 'pemasukan', 1500, 3500, 'Dapat koin 5% dari transaksi Rp 30.000', '2026-10-06 03:33:09');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id` int(11) NOT NULL,
  `id_pesanan` int(11) NOT NULL,
  `kode_bayar` varchar(50) NOT NULL,
  `metode` enum('tunai','qris','transfer','ewallet') NOT NULL,
  `total_tagihan` decimal(12,2) NOT NULL,
  `nominal_diterima` decimal(12,2) NOT NULL DEFAULT 0.00,
  `kembalian` decimal(12,2) NOT NULL DEFAULT 0.00,
  `status` enum('menunggu','lunas','batal') NOT NULL DEFAULT 'menunggu',
  `bukti_bayar` varchar(255) DEFAULT NULL,
  `waktu_bayar` datetime DEFAULT NULL,
  `dibuat_pada` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id`, `id_pesanan`, `kode_bayar`, `metode`, `total_tagihan`, `nominal_diterima`, `kembalian`, `status`, `bukti_bayar`, `waktu_bayar`, `dibuat_pada`) VALUES
(1, 1, 'BAYAR-QRIS-0001', 'qris', 30000.00, 30000.00, 0.00, 'lunas', NULL, '2026-10-06 10:33:09', '2026-10-06 03:33:09');

-- --------------------------------------------------------

--
-- Table structure for table `pengguna`
--

CREATE TABLE `pengguna` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `no_hp` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `kata_sandi` varchar(255) NOT NULL,
  `peran` enum('admin','kasir','pelanggan') NOT NULL DEFAULT 'pelanggan',
  `saldo_koin` int(11) NOT NULL DEFAULT 0,
  `foto` varchar(255) DEFAULT NULL,
  `dibuat_pada` timestamp NOT NULL DEFAULT current_timestamp(),
  `diubah_pada` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pengguna`
--

INSERT INTO `pengguna` (`id`, `nama`, `no_hp`, `email`, `kata_sandi`, `peran`, `saldo_koin`, `foto`, `dibuat_pada`, `diubah_pada`) VALUES
(1, 'Pak Darmo (Owner/Admin)', '081234567890', 'admin@mbahbuyut.com', '$2y$10$adminhash', 'admin', 0, NULL, '2026-10-06 03:33:08', '2026-10-06 03:33:08'),
(2, 'Siti Barista (Kasir)', '081234567891', 'kasir@mbahbuyut.com', '$2y$10$kasirhash', 'kasir', 0, NULL, '2026-10-06 03:33:08', '2026-10-06 03:33:08'),
(3, 'Dimas Wahyu (Pelanggan)', '085712345678', 'dimas@gmail.com', '$2y$10$pelangganhash', 'pelanggan', 3000, NULL, '2026-10-06 03:33:08', '2026-10-06 03:33:08');

-- --------------------------------------------------------

--
-- Table structure for table `pesanan`
--

CREATE TABLE `pesanan` (
  `id` int(11) NOT NULL,
  `no_nota` varchar(50) NOT NULL,
  `id_pelanggan` int(11) DEFAULT NULL COMMENT 'NULL jika tamu tanpa akun / kasir manual',
  `id_kasir` int(11) DEFAULT NULL COMMENT 'Kasir yang menerima/konfirmasi',
  `id_meja` int(11) DEFAULT NULL COMMENT 'NULL jika pesanan dibawa pulang',
  `tipe_pesanan` enum('di_tempat','bawa_pulang') NOT NULL DEFAULT 'di_tempat',
  `status` enum('menunggu','diproses','siap','selesai','batal') NOT NULL DEFAULT 'menunggu',
  `catatan` text DEFAULT NULL,
  `subtotal` decimal(12,2) NOT NULL DEFAULT 0.00,
  `potongan_koin` decimal(12,2) NOT NULL DEFAULT 0.00,
  `koin_dipakai` int(11) NOT NULL DEFAULT 0,
  `total_bayar` decimal(12,2) NOT NULL DEFAULT 0.00,
  `dibuat_pada` timestamp NOT NULL DEFAULT current_timestamp(),
  `diubah_pada` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pesanan`
--

INSERT INTO `pesanan` (`id`, `no_nota`, `id_pelanggan`, `id_kasir`, `id_meja`, `tipe_pesanan`, `status`, `catatan`, `subtotal`, `potongan_koin`, `koin_dipakai`, `total_bayar`, `dibuat_pada`, `diubah_pada`) VALUES
(1, 'NOTA-202610-001', 3, 2, 1, 'di_tempat', 'selesai', 'Kopinya es ya mas, mendoan jangan terlalu garing', 31000.00, 1000.00, 1000, 30000.00, '2026-10-06 03:33:08', '2026-10-06 03:33:08');

-- --------------------------------------------------------

--
-- Table structure for table `pesanan_item`
--

CREATE TABLE `pesanan_item` (
  `id` int(11) NOT NULL,
  `id_pesanan` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL DEFAULT 1,
  `harga_satuan` decimal(12,2) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `catatan` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pesanan_item`
--

INSERT INTO `pesanan_item` (`id`, `id_pesanan`, `id_menu`, `jumlah`, `harga_satuan`, `subtotal`, `catatan`) VALUES
(1, 1, 2, 1, 16000.00, 19000.00, 'Es Kopi Susu + Ekstra Shot'),
(2, 1, 4, 1, 12000.00, 12000.00, 'Mendoan anget');

-- --------------------------------------------------------

--
-- Table structure for table `pesanan_varian`
--

CREATE TABLE `pesanan_varian` (
  `id` int(11) NOT NULL,
  `id_pesanan_item` int(11) NOT NULL,
  `nama_grup` varchar(50) NOT NULL,
  `nama_opsi` varchar(100) NOT NULL,
  `harga_tambahan` decimal(12,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pesanan_varian`
--

INSERT INTO `pesanan_varian` (`id`, `id_pesanan_item`, `nama_grup`, `nama_opsi`, `harga_tambahan`) VALUES
(1, 1, 'Suhu', 'Es Dingin', 0.00),
(2, 1, 'Tingkat Manis', 'Sedikit Gula (Less Sugar)', 0.00),
(3, 1, 'Ekstra', 'Tambah Espresso Shot', 3000.00);

-- --------------------------------------------------------

--
-- Table structure for table `varian`
--

CREATE TABLE `varian` (
  `id` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL,
  `grup` varchar(50) NOT NULL COMMENT 'Contoh: Suhu, Gula, Ukuran, Topping',
  `nama_opsi` varchar(100) NOT NULL COMMENT 'Contoh: Dingin, Panas, Less Sugar, Extra Espresso',
  `harga_tambahan` decimal(12,2) NOT NULL DEFAULT 0.00,
  `tersedia` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `varian`
--

INSERT INTO `varian` (`id`, `id_menu`, `grup`, `nama_opsi`, `harga_tambahan`, `tersedia`) VALUES
(1, 2, 'Suhu', 'Es Dingin', 0.00, 1),
(2, 2, 'Suhu', 'Hangat / Panas', 0.00, 1),
(3, 2, 'Tingkat Manis', 'Normal', 0.00, 1),
(4, 2, 'Tingkat Manis', 'Sedikit Gula (Less Sugar)', 0.00, 1),
(5, 2, 'Ekstra', 'Tambah Espresso Shot', 3000.00, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aturan_koin`
--
ALTER TABLE `aturan_koin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jam_operasional`
--
ALTER TABLE `jam_operasional`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `hari` (`hari`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `meja`
--
ALTER TABLE `meja`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `no_meja` (`no_meja`),
  ADD UNIQUE KEY `kode_qr` (`kode_qr`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kode_menu` (`kode_menu`),
  ADD KEY `idx_menu_kategori` (`id_kategori`);

--
-- Indexes for table `mutasi_koin`
--
ALTER TABLE `mutasi_koin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pesanan` (`id_pesanan`),
  ADD KEY `idx_koin_pelanggan` (`id_pelanggan`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_pesanan` (`id_pesanan`),
  ADD UNIQUE KEY `kode_bayar` (`kode_bayar`),
  ADD KEY `idx_status_bayar` (`status`);

--
-- Indexes for table `pengguna`
--
ALTER TABLE `pengguna`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_peran` (`peran`);

--
-- Indexes for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `no_nota` (`no_nota`),
  ADD KEY `id_pelanggan` (`id_pelanggan`),
  ADD KEY `id_kasir` (`id_kasir`),
  ADD KEY `id_meja` (`id_meja`),
  ADD KEY `idx_status_pesanan` (`status`),
  ADD KEY `idx_tanggal_pesanan` (`dibuat_pada`);

--
-- Indexes for table `pesanan_item`
--
ALTER TABLE `pesanan_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pesanan` (`id_pesanan`),
  ADD KEY `id_menu` (`id_menu`);

--
-- Indexes for table `pesanan_varian`
--
ALTER TABLE `pesanan_varian`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pesanan_item` (`id_pesanan_item`);

--
-- Indexes for table `varian`
--
ALTER TABLE `varian`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_menu` (`id_menu`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aturan_koin`
--
ALTER TABLE `aturan_koin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `jam_operasional`
--
ALTER TABLE `jam_operasional`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `meja`
--
ALTER TABLE `meja`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `mutasi_koin`
--
ALTER TABLE `mutasi_koin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pesanan`
--
ALTER TABLE `pesanan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pesanan_item`
--
ALTER TABLE `pesanan_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pesanan_varian`
--
ALTER TABLE `pesanan_varian`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `varian`
--
ALTER TABLE `varian`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `mutasi_koin`
--
ALTER TABLE `mutasi_koin`
  ADD CONSTRAINT `mutasi_koin_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `pengguna` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mutasi_koin_ibfk_2` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD CONSTRAINT `pesanan_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `pengguna` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `pesanan_ibfk_2` FOREIGN KEY (`id_kasir`) REFERENCES `pengguna` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `pesanan_ibfk_3` FOREIGN KEY (`id_meja`) REFERENCES `meja` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `pesanan_item`
--
ALTER TABLE `pesanan_item`
  ADD CONSTRAINT `pesanan_item_ibfk_1` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pesanan_item_ibfk_2` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id`);

--
-- Constraints for table `pesanan_varian`
--
ALTER TABLE `pesanan_varian`
  ADD CONSTRAINT `pesanan_varian_ibfk_1` FOREIGN KEY (`id_pesanan_item`) REFERENCES `pesanan_item` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `varian`
--
ALTER TABLE `varian`
  ADD CONSTRAINT `varian_ibfk_1` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
