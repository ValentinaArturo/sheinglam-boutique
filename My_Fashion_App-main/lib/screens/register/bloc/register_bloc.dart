import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/resources/constants.dart';
import 'package:my_fashion_app/screens/register/service/register_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterNewUser>(registerUser);
  }

  final RegisterService service = RegisterService();

  Future<void> registerUser(
    RegisterNewUser event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      RegisterInProgress(),
    );
    try {
      await service.registerUser(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      emit(
        RegisterUserSuccess(),
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == null ||
          error.response!.statusCode! >= 500 ||
          error.response!.data[responseCode] == null) {
        emit(
          ServerClientError(),
        );
      } else {
        emit(
          RegisterError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
