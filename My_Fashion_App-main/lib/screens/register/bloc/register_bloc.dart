import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/resources/constants.dart';
import 'package:my_fashion_app/screens/register/model/address_model.dart';
import 'package:my_fashion_app/screens/register/model/cliente_model.dart';
import 'package:my_fashion_app/screens/register/service/register_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterNewUser>(registerUser);
    on<ClientListShown>(getClientes);
    on<DireccionListShown>(getDirecciones);
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
        lastName: event.lastName,
        email: event.email,
        password: event.password,
        idRol: event.idRol,
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

  Future<void> updateUser(
    RegisterUserUpdated event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      RegisterInProgress(),
    );
    try {
      await service.updateUser(
        id: event.id,
        name: event.name,
        lastName: event.lastName,
        email: event.email,
        password: event.password,
        idRol: event.idRol,
      );
      emit(
        RegisterUserUpdatedSuccess(),
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

  Future<void> getClientes(
    ClientListShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      RegisterInProgress(),
    );
    try {
      final List<ClienteListModel> response = await service.getClientes();
      emit(
        RegisterClientListSuccess(clientes: response),
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

  Future<void> getDirecciones(
    DireccionListShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      RegisterInProgress(),
    );
    try {
      final List<AddressListModel> response = await service.getAddress();
      emit(
        RegisterAddressListSuccess(direcciones: response),
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
