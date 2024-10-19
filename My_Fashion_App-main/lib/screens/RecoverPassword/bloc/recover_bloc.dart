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
    on<EmailRecovered>(recoverEmail);
  }

  final RecoveredService service = RecoveredService();

  Future<void> recoverEmail(
    EmailRecovered event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      RecoverInProgress(),
    );
    try {
      await service.recoverPassword(
        email: event.email,
      );
      emit(
        RecoverEmailSuccess(),
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
          RecoverError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
