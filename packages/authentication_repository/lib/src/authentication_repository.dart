import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, verified, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  Future<bool> requestOTP({
    required String phone,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );
    return true;
  }

  Future<void> validateOTP({required String password}) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () {
        if (password == '111111') {
          _controller.add(AuthenticationStatus.verified);
        } else {
          throw Exception('something went wrong');
        }
      },
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
