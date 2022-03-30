import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_project/authentication_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    Future.delayed(Duration(seconds: 3), () async {
        var auth = await ref.read(authenticationProvider.notifier).loadToken();
        if (!auth) Beamer.of(context).beamToReplacementNamed("/login");
        else Beamer.of(context).beamToReplacementNamed("/bottombar");
    });

    return const Scaffold(
      body: Center(
          child: Text("Splash Screen"),
      ),
    );
  }
}
