import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/resources/constants.dart';
import 'package:my_fashion_app/screens/RecoverPassword/service/recover_password_service.dart';

part 'recover_event.dart';
part 'recover_state.dart';

class RecoverBloc extends Bloc<RecoverEvent, RecoverState> {
  RecoverBloc() : super(RecoverInitial()) {
    on<PinSent>(sendPinViaEmail);
    on<PinValidated>(validatePin);
    on<UserUpdatedPassword>(updateUserPassword);
  }

  final RecoveredService service = RecoveredService();

  Future<void> sendPinViaEmail(
    PinSent event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      RecoverInProgress(),
    );
    try {
      await service.sendPinViaEmail(
        email: event.email,
      );
      emit(
        RecoverPinSendSuccess(),
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == null ||
          error.response!.statusCode! >= 500) {
        emit(
          ServerClientError(),
        );
      } else {
        emit(
          RecoverError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> validatePin(
    PinValidated event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      RecoverInProgress(),
    );
    try {
      await service.validatePin(
        email: event.email,
        pin: event.pin,
      );
      emit(
        RecoverPinValidatedSuccess(),
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == null ||
          error.response!.statusCode! >= 500) {
        emit(
          ServerClientError(),
        );
      } else {
        emit(
          RecoverError(
            message: "Pin inválido, inntenta de nuevo",
          ),
        );
      }
    }
  }

  Future<void> updateUserPassword(
    UserUpdatedPassword event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      RecoverInProgress(),
    );
    try {
      await service.updatePassword(
        email: event.email,
        password: event.password,
      );
      emit(
        RecoverUserUpdatedSuccess(),
      );
    } on DioException catch (error) {
      if (error.response?.statusCode == null ||
          error.response!.statusCode! >= 500) {
        emit(
          ServerClientError(),
        );
      } else {
        emit(
          RecoverError(
            message: "Ocurrio un error ${error.response!.statusCode!}",
          ),
        );
      }
    }
  }
}
