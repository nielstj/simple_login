import 'dart:async';

enum TwoFAStatus { waiting, verifying, authenticated, unauthenticated }

class TwoFARepository {
  final _controller = StreamController<TwoFAStatus>();

  Stream<TwoFAStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield TwoFAStatus.waiting;
    yield* _controller.stream;
  }

  Future<void> requestOTP({required String phone}) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(TwoFAStatus.waiting),
    );
  }

  Future<void> verifyOTP({
    required String password,
  }) async {
    _controller.add(TwoFAStatus.verifying);
    await Future.delayed(
      const Duration(milliseconds: 300),
      () {
        if (password == '111111') {
          _controller.add(TwoFAStatus.authenticated);
        }
        _controller.add(TwoFAStatus.unauthenticated);
      },
    );
  }

  void dispose() => _controller.close();
}
