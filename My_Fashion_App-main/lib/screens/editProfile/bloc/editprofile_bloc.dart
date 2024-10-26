import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/resources/constants.dart';
import 'package:my_fashion_app/screens/editProfile/model/edit_profile_model.dart';
import 'package:my_fashion_app/screens/editProfile/model/profile_model.dart';
import 'package:my_fashion_app/screens/editProfile/service/edit_profile_service.dart';

part 'editprofile_event.dart';
part 'editprofile_state.dart';

class EditprofileBloc extends Bloc<EditprofileEvent, EditprofileState> {
  EditprofileBloc() : super(EditProfileInitial()) {
    on<ProfileShown>(getUserProfile);
    on<AddressShown>(getUserAddress);
    on<ProfileEdited>(editProfile);
  }

  final EditProfileService service = EditProfileService();

  Future<void> editProfile(
    ProfileEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      EditProfileInProgress(),
    );
    try {
      await service.editProfile(
        id: event.id,
        name: event.name,
        lastName: event.lastName,
        email: event.email,
        password: event.password,
        direccion: event.address,
        telefono: event.phone,
        direccionEnvio: event.direccionEnvio,
        codigoPostal: event.codigoPostal,
        idCiudad: event.idCiudad,
        idPais: event.idPais,
      );
      await service.updateDireccionEnvio();
      emit(
        EditProfileSuccess(),
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
          EditprofileError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> getUserProfile(
    ProfileShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      EditProfileInProgress(),
    );
    try {
      final resp = await service.getProfile(id: event.id);
      emit(
        ProfileSuccess(userProfile: resp),
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
          EditprofileError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }

  Future<void> getUserAddress(
    AddressShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      EditProfileInProgress(),
    );
    try {
      final resp = await service.getUserAddress(id: event.id);
      emit(
        AddressSuccess(addressModel: resp),
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
          EditprofileError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
