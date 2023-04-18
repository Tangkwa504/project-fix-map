import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

class CookieSet {
  String id;
  String user;
  String name;
  CookieSet({required this.id, required this.user, required this.name});
}

void cookieset(id, user, name) async {
  final SharedPreferences ref = await prefs;
  CookieSet _cookie = CookieSet(id: id, user: user, name: name);
  ref.setString("id", _cookie.id);
  ref.setString("user", _cookie.user);
  ref.setString("name", _cookie.name);
}

class Cookies {
  static bool get check {
    login.then((value) {
      return value;
    });
    return false;
  }

  static String get user {
    rawuser.then((value) {
      return value;
    });
    return "";
  }

  static Future<String> get rawuser async {
    final SharedPreferences pref = await prefs;
    return pref.getString("user") ?? "";
  }

  static Future<bool> get login async {
    final SharedPreferences pref = await prefs;
    return pref.getBool("id") ?? false;
  }
}