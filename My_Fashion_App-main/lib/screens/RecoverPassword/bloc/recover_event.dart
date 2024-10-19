part of 'recover_bloc.dart';

abstract class RecoverEvent extends Equatable {
  const RecoverEvent();

  @override
  List<Object> get props => [];
}

class EmailRecovered extends RecoverEvent {
  final String email;

  const EmailRecovered({
    required this.email,
  });
}
