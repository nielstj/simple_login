import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, verified, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  String? _username;
  String? _password;

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
      () {
        if (username == _username && _password == password) {
          _controller.add(AuthenticationStatus.verified);
        } else {
          _username = username;
          _password = password;

          _controller.add(AuthenticationStatus.authenticated);
        }
      },
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
          _username = null;
          _password = null;
          throw Exception('something went wrong');
        }
      },
    );
  }

  void logOut(bool clearCache) {
    if (clearCache) {
      _username = null;
      _password = null;
    }
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
