# Klimato

Aplikasi cuaca berbasis Flutter menggunakan **wttr.in API** dengan antarmuka Bahasa Indonesia.

## Fitur

- **Cuaca Saat Ini** — Lihat suhu, kecepatan angin, dan kondisi cuaca terkini
- **Prakiraan 7 Hari** — Lihat prediksi suhu maks/min harian
- **Cari Kota** — Cari kota di seluruh dunia
- **Simpan Kota** — Simpan kota favorit untuk akses cepat
- **Unit Suhu** — Ganti antara Celsius dan Fahrenheit
- **Bahasa Indonesia** — Seluruh antarmuka menggunakan Bahasa Indonesia
- **Clean Architecture** — Data, Domain, Presentation layers
- **State Management** — BLoC (flutter_bloc)
- **Dependency Injection** — get_it

## Cara Menjalankan

```bash
# Clone & masuk folder
cd klimato

# Install dependencies
flutter pub get

# Run di device/emulator
flutter run

# Build APK release
flutter build apk --release
```

## Tech Stack

| Komponen | Library |
|----------|---------|
| State Management | flutter_bloc |
| HTTP Client | http |
| Local Storage | shared_preferences |
| DI | get_it |
| Functional | dartz |
| Geocoding | Open-Meteo Geocoding API |

## Struktur Proyek

```
lib/
├── core/           # Shared utilities, errors, usecase
├── data/           # Data layer (models, datasources, repositories)
│   ├── datasources/   # API & local storage calls
│   ├── models/        # JSON serialization
│   └── repositories/  # Repository implementations
├── domain/         # Domain layer (entities, repositories, usecases)
│   ├── entities/      # Business objects
│   ├── repositories/  # Abstract repository interfaces
│   └── usecases/      # Business logic
├── presentation/   # Presentation layer (BLoCs, pages)
│   ├── blocs/         # State management
│   └── pages/         # UI screens
└── injection_container.dart  # DI setup
```

## API

- **Cuaca**: [wttr.in](https://wttr.in) — API cuaca gratis tanpa API key
- **Geocoding**: [Open-Meteo Geocoding API](https://open-meteo.com/en/docs/geocoding-api) — pencarian kota
