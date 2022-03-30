import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationState extends StateNotifier<String?> {
  AuthenticationState(String? state) : super(state);

  Future<bool> loadToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("auth_token");
    state = token;
    return token != null && token.isNotEmpty;
  }

  setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("auth_token", token);

    state = token;
  }

  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    state = null;
  }

  bool isAuthenticated() {
    return state != null && state!.isNotEmpty;
  }
}

final authenticationProvider = StateNotifierProvider<AuthenticationState, String?>((ref) => AuthenticationState(null));