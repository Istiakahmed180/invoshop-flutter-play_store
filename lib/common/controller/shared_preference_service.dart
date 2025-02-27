import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _currencyNameKey = 'currency_name';
  static const String _currencySymbolKey = 'currency_symbol';

  Future<void> setCurrencyInfo(
      String currencyName, String currencySymbol) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currencyNameKey, currencyName);
    await prefs.setString(_currencySymbolKey, currencySymbol);
  }

  Future<String?> getCurrencyName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currencyNameKey);
  }

  Future<String?> getCurrencySymbol() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currencySymbolKey);
  }
}
