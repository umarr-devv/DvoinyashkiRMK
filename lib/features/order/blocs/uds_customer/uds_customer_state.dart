part of 'uds_customer_cubit.dart';

class UdsCustomerState extends Equatable {
  const UdsCustomerState({this.customer});

  final UDSCustomerScheme? customer;

  UdsCustomerState copyWith(Object? customer) {
    return UdsCustomerState(
      customer: undefCompare<UDSCustomerScheme>(customer, this.customer)
    );
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

final class UdsCustomerClear extends UdsCustomerState {
  UdsCustomerClear(super.state) : super.from();
}


final class UdsCustomerFailure extends UdsCustomerState {
  UdsCustomerFailure(super.state) : super.from();
}
