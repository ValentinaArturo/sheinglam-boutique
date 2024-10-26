import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/resources/constants.dart';
import 'package:my_fashion_app/screens/returns/model/return_list_model.dart';
import 'package:my_fashion_app/screens/returns/service/return_service.dart';

part 'return_event.dart';
part 'return_state.dart';

class ReturnBloc extends Bloc<ReturnEvent, ReturnState> {
  ReturnBloc() : super(ReturnInitial()) {
    on<ReturnShown>(getReturnList);
  }

  final ReturnService service = ReturnService();

  Future<void> getReturnList(
    ReturnShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ReturnInProgress(),
    );
    try {
      final List<ReturnListModel> resp = await service.getReturns();
      emit(
        ReturnSuccess(devoluciones: resp),
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
          ReturnError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
