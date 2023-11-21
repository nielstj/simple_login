import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:simple_login/otp/bloc/otp_cubit.dart';
import 'package:timer_button/timer_button.dart';

class OTPForm extends StatelessWidget {
  const OTPForm({super.key, required this.target});

  final String target;

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OTPCubit, OTPStatus>(
      listener: (context, state) {
        switch (state) {
          case OTPStatus.resentSuccess:
            _showSnackBar(context, 'OTP resent to $target');
          case OTPStatus.resentFailed:
            _showSnackBar(context, 'Something went wrong, please try again');
          case OTPStatus.failure:
            _showSnackBar(context, 'Failed to verify OTP');
          default:
            return;
        }
      },
      child: Column(
        children: [
          const SizedBox(height: 40),
          Text(
            'Enter Authentication Code',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          Text(
            'Sent to $target',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 20),
          _OTPInput(),
          const SizedBox(height: 100),
          TimerButton(
            label: 'Resend',
            buttonType: ButtonType.outlinedButton,
            onPressed: () =>
                BlocProvider.of<OTPCubit>(context).resentOTP(phone: target),
            timeOutInSeconds: 30,
          )
        ],
      ),
    );
  }
}

class _OTPInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OTPCubit, OTPStatus>(builder: (context, state) {
      return state == OTPStatus.verifying
          ? const CircularProgressIndicator()
          : OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width * 0.75,
              fieldStyle: FieldStyle.box,
              onChanged: (_) {},
              onCompleted: (value) =>
                  BlocProvider.of<OTPCubit>(context).verifyOTP(password: value),
            );
    });
  }
}
