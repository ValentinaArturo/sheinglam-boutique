import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_fashion_app/common/bloc/base_state.dart';
import 'package:my_fashion_app/resources/constants.dart';
import 'package:my_fashion_app/screens/profile/model/profile_mode.dart';
import 'package:my_fashion_app/screens/profile/service/profile_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileShown>(getProfileList);
  }

  final ProfileService service = ProfileService();

  Future<void> getProfileList(
    ProfileShown event,
    Emitter<BaseState> emit,
  ) async {
    emit(
      ProfileInProgress(),
    );
    try {
      final ProfileListModel resp = await service.getProfile(
        id: event.id,
      );
      emit(
        ProfileSuccess(perfil: resp),
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
          ProfileError(
            message: error.response!.data[responseMessage],
          ),
        );
      }
    }
  }
}
