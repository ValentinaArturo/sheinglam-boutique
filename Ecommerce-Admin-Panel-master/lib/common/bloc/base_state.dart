import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();

  @override
  List<Object> get props => <Object>[];
}

class InitialState extends BaseState {}

class ServerClientError extends BaseState {}
