class Bilgisayarin {
  Bilgisayarin(
      {this.marka = "Belirtilmemiş",
      this.ismi = "Belirtilmemiş",
      this.linki = "Belirtilmemiş",
      this.fiyati = "Belirtilmemiş",
      this.islemciTipi = "Belirtilmemiş",
      this.ssdKapasitesi = "Belirtilmemiş",
      this.isletimSistemi = "Belirtilmemiş",
      this.ekranKarti = "Belirtilmemiş",
      this.ram = "Belirtilmemiş",
      this.cozunurluk = "Belirtilmemiş",
      this.ekranBoyutu = "Belirtilmemiş"});

  String marka;
  String ismi;
  String linki;
  String fiyati;
  String islemciTipi;
  String ssdKapasitesi;
  String isletimSistemi;
  String ekranKarti;
  String ram;
  String cozunurluk;
  String ekranBoyutu;

  Map toJson() => {
        'Bilgisayarın Markası': marka,
        'İsmi': ismi,
        'Linki': linki,
        'Fiyatı': fiyati,
        'İşlemci Tipi': islemciTipi,
        'SSD Kapasitesi': ssdKapasitesi,
        'İşletim Sistemi': isletimSistemi,
        'Ekran Kartı': ekranKarti,
        'Ram Belleği': ram,
        'Çözünürlük': cozunurluk,
        'Ekran Boyutu': ekranBoyutu,
      };
}
