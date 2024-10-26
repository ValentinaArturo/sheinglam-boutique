part of 'orderdetail_bloc.dart';

abstract class OrderdetailEvent extends Equatable {
  const OrderdetailEvent();

  @override
  List<Object> get props => [];
}

class OrderDetailShown extends OrderdetailEvent {
  final int id;

  const OrderDetailShown({
    required this.id,
  });
}
