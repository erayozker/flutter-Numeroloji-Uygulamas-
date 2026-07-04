# Numeroloji Uygulamasi

Flutter ile gelistirilmis, koyu mor ve altin sari tonlarinda mistik/astroloji temali bir numeroloji uygulamasidir.

Uygulama; dogum tarihi ve ad soyad bilgilerine gore temel numeroloji sayilarini hesaplar, gunluk numeroloji yorumu sunar, sayilarin anlamlarini listeler ve hesaplama gecmisini lokal olarak saklar.

## Ozellikler

- Modern Material 3 tasarim
- Koyu mor arka plan ve altin sari vurgu rengi
- Bottom navigation ile ekranlar arasi gecis
- Dogum tarihinden yasam yolu sayisi hesaplama
- Isimden kader sayisi, ruh arzusu ve kisilik sayisi hesaplama
- Turkce karakter destekli isim analizi
- Sonuc ekrani ve kisiye ozel yorum alani
- 1-9 sayilari ile 11, 22 ve 33 master sayilarinin anlamlari
- Gunluk numeroloji sayisi ve gunluk oneriler
- SharedPreferences ile lokal gecmis kaydi
- Gecmis kayitlari silme
- Ayarlar ekranindan lokal verileri temizleme

## Ekranlar

- Ana Sayfa
- Numeroloji Hesaplama
- Sonuc Ekrani
- Sayilarin Anlamlari
- Gunluk Numeroloji
- Gecmis Sonuclar
- Ayarlar

## Kullanilan Paketler

```yaml
dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.8
  shared_preferences: ^2.3.2
```

## Proje Yapisi

```txt
lib/
├── main.dart
├── app/
│   ├── app_routes.dart
│   ├── app_theme.dart
│   ├── main_navigation.dart
│   └── numerology_app.dart
├── core/
│   └── utils/
│       └── numerology_calculator.dart
├── data/
│   ├── models/
│   │   ├── history_item_model.dart
│   │   └── numerology_result_model.dart
│   └── repositories/
│       └── history_repository.dart
├── features/
│   ├── calculation/
│   ├── daily/
│   ├── history/
│   ├── home/
│   ├── meanings/
│   ├── result/
│   └── settings/
└── shared/
    └── enums/
        └── calculation_type.dart
```

## Kurulum

Projeyi calistirmadan once Flutter SDK'nin kurulu oldugundan emin olun.

Bagimliliklari yuklemek icin:

```bash
flutter pub get
```

Analiz calistirmak icin:

```bash
flutter analyze
```

Testleri calistirmak icin:

```bash
flutter test
```

Uygulamayi calistirmak icin:

```bash
flutter run
```

## Notlar

Windows desktop hedefinde `shared_preferences` gibi plugin kullanan Flutter projeleri icin Developer Mode acik olmalidir. Aksi halde symlink destegi hatasi alinabilir.

Web build kontrolu icin:

```bash
flutter build web
```

## Surum

```txt
1.0.0+1
```
