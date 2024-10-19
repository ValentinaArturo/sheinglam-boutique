import 'package:dio/dio.dart';
import 'package:ecommerce_admin_panel/common/bloc/base_state.dart';
import 'package:ecommerce_admin_panel/repository/user_repository.dart';
import 'package:ecommerce_admin_panel/screens/login/model/login_model.dart';
import 'package:ecommerce_admin_panel/screens/login/service/login_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginOnLoad>(getReminderMail);
    on<LoginWithEmailPassword>(userLogin);
  }

  final UserRepository _userRepository = UserRepository();

  Future<void> getReminderMail(
    LoginOnLoad event,
    Emitter<BaseState> emit,
  ) async {
    final String isRememberMail = await _userRepository.getRememberUser();
    if (isRememberMail.isNotEmpty) {
      emit(
        LoginReminderMailSuccess(
          reminderMail: isRememberMail,
        ),
      );
    }
  }

  Future<void> userLogin(
    LoginWithEmailPassword event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      LoginInProgress(),
    );

    final LoginService service = LoginService();

    try {
      final LoginModel resp = await service.authUser(
        username: event.codeEmail,
        password: event.password,
      );

      _userRepository.setToken(
        resp.token,
      );

      emit(
        LoginSuccess(),
      );
    } on DioException catch (error) {
      emit(
        LoginError(error: "Ocurrió un error ${error.response?.statusCode}"),
      );
    }
  }
}
