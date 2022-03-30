import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageStateNotifier extends StateNotifier<PageStatus> {
  PageStateNotifier() : super(PageIdle());

  setIdle() {
    state = PageIdle();
  }

  setLoading() {
    state = PageLoading();
  }

  setError(String error) {
    state = PageError(errorMessage: error);
    Future.delayed(Duration(seconds: 2), () => state  = PageIdle());
  }

  setMessage(String message) {
    state = PageMessage(message: message);
    Future.delayed(Duration(seconds: 2), () => state = PageIdle());
  }
}

final pageStateProvider = StateNotifierProvider<PageStateNotifier, PageStatus>((ref) => PageStateNotifier());

abstract class PageStatus {}

class PageIdle extends PageStatus {}

class PageLoading extends PageStatus {}

class PageError extends PageStatus {
  String errorMessage;
  PageError({required this.errorMessage});
}

class PageMessage extends PageStatus {
  String message;
  PageMessage({required this.message});
}