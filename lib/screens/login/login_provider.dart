import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_project/authentication_provider.dart';
import 'package:flutter_starter_project/mixins/with_http.dart';
import 'package:flutter_starter_project/mixins/with_page_status.dart';

class LoginState {
  String email = "";
  String password = "";
}

class LoginNotifier extends StateNotifier<LoginState> with WithHttp, WithPageStatus {
  final Reader read;
  LoginNotifier(this.read) : super(LoginState());

  Future<bool> login() async {
      setLoading(read);
      // var response = await dio.post("/login", data: {
      //   "email": "eve.holt@reqres.in",
      //   "password": "cityslicka"
      // });

      await Future.delayed(Duration(seconds: 3), () {});
      var response = await httpRequest(read, (d) => d.post("/login", data: {
        "email": "eve.holt@reqres.in",
        "password": "cityslicka"
      }));

      if (response == null) return false;

      setIdle(read);
      if (response.statusCode != 200) return false;

      final token = response.data["token"];

      read(authenticationProvider.notifier).setToken(token);
      return true;
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) => LoginNotifier(ref.read));