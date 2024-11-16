import 'dart:async';

enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

mixin Kinerja {
  int produktivitas = 0;

  void tambahProduktivitas(int nilai) {
    if (nilai >= 0 && nilai <= 100) {
      produktivitas += nilai;
      if (produktivitas > 100) produktivitas = 100;
    }
  }

  void cekProduktivitas() {
    print("\nProduktivitas saat ini: $produktivitas%\n");
  }
}

abstract class Karyawan {
  final String nama;
  final int umur;
  final String peran;

  Karyawan(this.nama, this.umur, this.peran);

  void bekerja();
}

class KaryawanTetap extends Karyawan with Kinerja {
  KaryawanTetap(String nama, int umur, String peran) : super(nama, umur, peran);

  @override
  void bekerja() {
    print("$nama bekerja penuh waktu sebagai $peran.\n");
  }
}

class KaryawanKontrak extends Karyawan {
  KaryawanKontrak(String nama, int umur, String peran)
      : super(nama, umur, peran);

  @override
  void bekerja() {
    print("$nama bekerja sebagai $peran pada proyek tertentu.\n");
  }
}

class ProdukDigital {
  final String namaProduk;
  double harga;
  final String kategori;

  ProdukDigital(this.namaProduk, this.harga, this.kategori);

  void terapkanDiskon() {
    if (kategori == "NetworkAutomation" && harga > 200000) {
      harga *= 0.85;
      if (harga < 200000) {
        harga = 200000;
      }
    }
  }
}

class Proyek {
  FaseProyek faseSaatIni = FaseProyek.Perencanaan;
  List<Karyawan> timProyek = [];
  int durasiHari = 0;

  void tambahKaryawan(Karyawan karyawan) {
    timProyek.add(karyawan);
    print("${karyawan.nama} ditambahkan ke tim proyek.\n");
  }

  void pindahFase(FaseProyek faseBaru) {
    if (faseSaatIni == FaseProyek.Perencanaan &&
        faseBaru == FaseProyek.Pengembangan &&
        timProyek.length >= 5) {
      faseSaatIni = faseBaru;
      print("Proyek berpindah ke fase Pengembangan.\n");
    } else if (faseSaatIni == FaseProyek.Pengembangan &&
        faseBaru == FaseProyek.Evaluasi &&
        durasiHari > 45) {
      faseSaatIni = faseBaru;
      print("Proyek berpindah ke fase Evaluasi.\n");
    } else {
      print("Syarat untuk berpindah fase belum terpenuhi.\n");
    }
  }
}

class Perusahaan {
  final String nama;
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];
  final int batasKaryawanAktif = 20;

  Perusahaan(this.nama);

  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < batasKaryawanAktif) {
      karyawanAktif.add(karyawan);
      print("${karyawan.nama} ditambahkan ke daftar karyawan aktif.\n");
    } else {
      print(
          "Tidak dapat menambahkan ${karyawan.nama}, batas karyawan aktif tercapai.\n");
    }
  }

  void tampilkanKaryawanAktif() {
    print("Daftar Karyawan Aktif di $nama:");
    for (var karyawan in karyawanAktif) {
      print("- ${karyawan.nama}, Peran: ${karyawan.peran}");
    }
  }

  void resignKaryawan(Karyawan karyawan) {
    if (karyawanAktif.contains(karyawan)) {
      karyawanAktif.remove(karyawan);
      karyawanNonAktif.add(karyawan);
      print("${karyawan.nama} sekarang menjadi karyawan non-aktif.\n");
    } else {
      print("${karyawan.nama} tidak ditemukan di daftar karyawan aktif.\n");
    }
  }
}

void main() {
  var tongIT = Perusahaan("SM Ent");

  var dev1 = KaryawanTetap("Dea Revananda", 20, " Frontend Developer");
  var dev2 = KaryawanKontrak("Jasiska", 19, "Backend Developer");

  tongIT.tambahKaryawan(dev1);
  tongIT.tambahKaryawan(dev2);
  tongIT.tampilkanKaryawanAktif();

  dev1.tambahProduktivitas(50);
  dev1.cekProduktivitas();

  var produk1 = ProdukDigital("Data Management Tool", 150000, "DataManagement");
  var produk2 =
      ProdukDigital("Network Automation", 250000, "NetworkAutomation");

  print("Harga produk sebelum diskon: ${produk2.harga}");
  produk2.terapkanDiskon();
  print("Harga produk setelah diskon: ${produk2.harga}");

  var proyek1 = Proyek();
  proyek1.tambahKaryawan(dev1);
  proyek1.tambahKaryawan(dev2);

  proyek1.pindahFase(FaseProyek.Pengembangan);
  proyek1.durasiHari = 50;
  proyek1.pindahFase(FaseProyek.Evaluasi);
}