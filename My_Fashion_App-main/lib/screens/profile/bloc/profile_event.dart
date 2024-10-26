part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileShown extends ProfileEvent {
  final int id;

  const ProfileShown({
    required this.id,
  });
}
