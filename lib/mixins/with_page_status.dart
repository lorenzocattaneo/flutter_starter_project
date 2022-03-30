import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_project/page_state_provider.dart';

class WithPageStatus {
  setIdle(Reader read) {
    read(pageStateProvider.notifier).setIdle();
  }

  setLoading(Reader read) {
    read(pageStateProvider.notifier).setLoading();
  }

  setError(Reader read, String error) {
    read(pageStateProvider.notifier).setError(error);
    Future.delayed(Duration(seconds: 2), () => read(pageStateProvider.notifier).setIdle());
  }

  setMessage(Reader read, String message) {
    read(pageStateProvider.notifier).setMessage(message);
    Future.delayed(Duration(seconds: 2), () => read(pageStateProvider.notifier).setIdle());
  }
}