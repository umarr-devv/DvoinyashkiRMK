import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:talker/talker.dart';

part 'products_cubit.g.dart';
part 'products_utils.dart';
part 'products_state.dart';

class ProductsCubit extends HydratedCubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  Future update() async {
    if (state.update == null ||
        DateTime.now().difference(state.update!) > Duration(minutes: 30)) {
      await forceUpdate();
    }
  }

  Future forceUpdate() async {
    emit(ProductsLoading(state));
    try {
      final nomenclatures = await client.getNomenclatures();
      final characteristics = await client.getCharacteristics();
      final prices = await client.getPrices();
      final priceTypes = await client.getPriceTypes();
      final barcodes = await client.getBarcodes();
      final newState = state.copyWith(
        nomenclatures: nomenclatures.nomenclatures,
        characteristics: characteristics.characteristics,
        prices: prices.prices,
        priceTypes: priceTypes.priceTypes,
        barcodes: barcodes.barcodes,
        update: DateTime.now(),
      );
      emit(ProductsLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(ProductsFailure(state));
    }
  }

  @override
  ProductsState? fromJson(Map<String, dynamic> json) {
    return ProductsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ProductsState state) {
    return state.toJson();
  }
}
