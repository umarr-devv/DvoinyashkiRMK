import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:talker/talker.dart';

part 'data_cubit.g.dart';
part 'data_models.dart';
part 'data_state.dart';
part 'data_utils.dart';

class DataCubit extends HydratedCubit<DataState> {
  DataCubit() : super(DataInitial());

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  Future update() async {
    if (state.update == null ||
        DateTime.now().difference(state.update!) > Duration(hours: 12)) {
      await forceUpdate();
    }
  }

  Future forceUpdate() async {
    emit(DataLoading(state));
    try {
      final cashRegisters = await client.getCashRegisters();
      final categories = await client.getCategories();
      final nomenclatures = await client.getNomenclatures();
      final characteristics = await client.getCharacteristics();
      final prices = await client.getPrices();
      final priceTypes = await client.getPriceTypes();
      final barcodes = await client.getBarcodes();
      final productImages = await client.getProductImages();
      final structureUnits = await client.getStructureUnits();
      final users = await client.getUsers();
      final authors = await client.getAuthors();

      final products = DataCubitUtils.getProducts(
        nomenclatures: nomenclatures.nomenclatures,
        characteristics: characteristics.characteristics,
        prices: prices.prices,
        productImages: productImages.productImages,
        barcodes: barcodes.barcodes,
        priceTypes: priceTypes.priceTypes,
      );

      final newState = state.copyWith(
        cashRegisters: cashRegisters.cashRegisters,
        categories: categories.categories,
        nomenclatures: nomenclatures.nomenclatures,
        characteristics: characteristics.characteristics,
        prices: prices.prices,
        priceTypes: priceTypes.priceTypes,
        barcodes: barcodes.barcodes,
        structureUnits: structureUnits.structureUnits,
        productImages: productImages.productImages,
        users: users.users,
        authors: authors.authors,
        products: products,
        update: DateTime.now(),
      );
      emit(DataLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(DataFailure(state));
    }
  }

  @override
  DataState? fromJson(Map<String, dynamic> json) {
    return DataState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(DataState state) {
    return state.toJson();
  }
}
