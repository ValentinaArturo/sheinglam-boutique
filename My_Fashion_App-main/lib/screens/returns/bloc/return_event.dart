part of 'return_bloc.dart';

abstract class ReturnEvent extends Equatable {
  const ReturnEvent();

  @override
  List<Object> get props => [];
}

class ReturnShown extends ReturnEvent {}
