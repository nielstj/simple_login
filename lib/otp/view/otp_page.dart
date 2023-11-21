import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_login/authentication/authentication.dart';
import 'package:simple_login/otp/bloc/otp_cubit.dart';
import 'package:simple_login/otp/view/view.dart';
import 'package:user_repository/user_repository.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({super.key, required this.user});

  final User user;

  static Route<void> route(User user) {
    return MaterialPageRoute<void>(builder: (_) => OTPPage(user: user));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested(clearCache: true));
            },
          )
        ],
      ),
      body: Center(
        child: BlocProvider(
          create: (context) => OTPCubit(OTPStatus.idle,
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context)),
          child: OTPForm(
            target: user.phoneNumber,
          ),
        ),
      ),
    );
  }
}
