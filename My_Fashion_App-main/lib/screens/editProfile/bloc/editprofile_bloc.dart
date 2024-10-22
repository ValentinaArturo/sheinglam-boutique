import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/resources/constants.dart';
import 'package:my_fashion_app/screens/editProfile/model/edit_profile_model.dart';
import 'package:my_fashion_app/screens/editProfile/service/edit_profile_service.dart';

part 'editprofile_event.dart';
part 'editprofile_state.dart';

class EditprofileBloc extends Bloc<EditprofileEvent, EditprofileState> {
  EditprofileBloc() : super(EditprofileInitial()) {
    on<ProfileEdited>(editProfile);
    on<AddressShown>(getUserAddress);
  }

  final EditProfileService service = EditProfileService();

  Future<void> editProfile(
    ProfileEdited event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      EditprofileInProgress(),
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
      );
      emit(
        EditprofileSuccess(),
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
      EditprofileInProgress(),
    );
    try {
      final resp = await service.getUserAddress(id: event.id);
      emit(
        EditprofileAddressSuccess(addressModel: resp),
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
