part of 'profile_bloc.dart';

abstract class ProfileState extends BaseState {}

class ProfileInitial extends ProfileState {}

class ProfileInProgress extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileListModel perfil;

  ProfileSuccess({
    required this.perfil,
  });
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError({
    required this.message,
  });
}
