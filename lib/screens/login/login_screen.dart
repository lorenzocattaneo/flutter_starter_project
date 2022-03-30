import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_project/screens/login/login_provider.dart';
import 'package:flutter_starter_project/widgets/scaffold_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
    return ScaffoldScreen(
      title: "Login",
      pageBuilder:  (context, ref, child) => SafeArea(
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email...',
                ),
                onChanged: (val) {},
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci la tua email';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Password...',
                ),
                obscureText: true,
                onChanged: (val) {},
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci la tua password';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_loginFormKey.currentState!.validate() == false) return;
                  var success = await ref.read(loginProvider.notifier).login();
                  print("login success");
                  print(success);
                  if (!success) return; //TODO mostrare errore
                  Beamer.of(context).beamToReplacementNamed("/bottombar");
                },
                child: const Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
