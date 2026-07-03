class WeatherHelper {
  static String getWeatherIcon(int code) {
    if (code == 0) return 'â˜€ï¸';
    if (code >= 1 && code <= 3) return 'â›…';
    if (code >= 45 && code <= 48) return 'ðŸŒ«ï¸';
    if (code >= 51 && code <= 67) return 'ðŸŒ§ï¸';
    if (code >= 71 && code <= 77) return 'â„ï¸';
    if (code >= 80 && code <= 82) return 'ðŸŒ¦ï¸';
    if (code >= 95 && code <= 99) return 'â›ˆï¸';
    return 'â“';
  }

  static String formatTemp(double temp, bool isCelsius) {
    if (isCelsius) return '${temp.toStringAsFixed(1)}Â°C';
    double fahrenheit = (temp * 9 / 5) + 32;
    return '${fahrenheit.toStringAsFixed(1)}Â°F';
  }
}
