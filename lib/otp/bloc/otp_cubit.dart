import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum OTPStatus {
  idle,
  resentSuccess,
  resentFailed,
  verifying,
  success,
  failure,
}

class OTPCubit extends Cubit<OTPStatus> {
  OTPCubit(
    super.initialState, {
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  Future<void> resentOTP({required String phone}) async {
    final result = await _authenticationRepository.requestOTP(phone: phone);
    emit(result ? OTPStatus.resentSuccess : OTPStatus.resentFailed);
  }

  Future<void> verifyOTP({required String password}) async {
    emit(OTPStatus.verifying);
    try {
      final _ = await _authenticationRepository.validateOTP(password: password);
      emit(OTPStatus.success);
    } catch (_) {
      emit(OTPStatus.failure);
    }
  }
}
