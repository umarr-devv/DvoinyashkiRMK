part of 'uds_customer_cubit.dart';

class UdsCustomerState extends Equatable {
  const UdsCustomerState({this.customer});

  final UDSCustomerScheme? customer;

  UdsCustomerState copyWith(UDSCustomerScheme? customer) {
    return UdsCustomerState(customer: customer ?? this.customer);
  }

  UdsCustomerState.from(UdsCustomerState other) : customer = other.customer;

  @override
  List<Object?> get props => [customer];
}

final class UdsCustomerInitial extends UdsCustomerState {}

final class UdsCustomerLoading extends UdsCustomerState {
  UdsCustomerLoading(super.state) : super.from();
}

final class UdsCustomerLoaded extends UdsCustomerState {
  UdsCustomerLoaded(super.state) : super.from();
}

final class UdsCustomerFailure extends UdsCustomerState {
  UdsCustomerFailure(super.state) : super.from();
}
