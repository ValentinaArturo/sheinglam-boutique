part of 'orden_bloc.dart';

abstract class OrdenState extends BaseState {}

final class OrdenInitial extends OrdenState {}

final class OrdenInProgress extends OrdenState {}

final class OrdenSuccess extends OrdenState {
  final List<OrdenListModel> ordenes;

  OrdenSuccess({
    required this.ordenes,
  });
}

final class OrdenCreatedSuccess extends OrdenState {}

final class OrdenEditedSuccess extends OrdenState {}

final class OrdenDeletedSuccess extends OrdenState {}

final class OrdenError extends OrdenState {
  final String message;

  OrdenError({
    required this.message,
  });
}
