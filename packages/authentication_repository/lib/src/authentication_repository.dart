import 'dart:async';

import 'package:meta/meta.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future login(@required String username, @required String password) async {
    assert(username != null);
    assert(password != null);
    await Future.delayed(Duration(seconds: 1));
    _controller.add(AuthenticationStatus.authenticated);
  }

  void logout() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
