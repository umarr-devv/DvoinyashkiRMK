part of 'uds_customer_cubit.dart';

class UdsCustomerState extends Equatable {
  const UdsCustomerState({this.customer, this.code});

  final String? code;
  final UDSCustomerScheme? customer;

  UdsCustomerState copyWith(Object? code, Object? customer) {
    return UdsCustomerState(
      code: undefCompare<String?>(code, this.code),
      customer: undefCompare<UDSCustomerScheme?>(customer, this.customer),
    );
  }

  UdsCustomerState.from(UdsCustomerState other)
    : code = other.code,
      customer = other.customer;

  @override
  List<Object?> get props => [code, customer];
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
