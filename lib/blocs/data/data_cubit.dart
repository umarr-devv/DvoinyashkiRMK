import 'package:app/blocs/blocs.dart';
import 'package:app/client/client.dart';
import 'package:app/core/consts/consts.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    if (state.update == null ||
        DateTime.now().difference(state.update!) > Duration(days: 7)) {
      await forceUpdateImages();
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
      final structureUnits = await client.getStructureUnits();
      final users = await client.getUsers();
      final authors = await client.getAuthors();

      final products = DataCubitUtils.getProducts(
        nomenclatures: nomenclatures.nomenclatures,
        characteristics: characteristics.characteristics,
        prices: prices.prices,
        productImages: [],
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

  Future forceUpdateImages() async {
    emit(DataAltLoading(state));
    final response = await client.getProductImages();

    final Map<String, String> productImages = {};

    for (final i in response.productImages) {
      if (i.image?.isNotEmpty ?? false) {
        final filePath = await saveImageToCache(
          i.imageBytes!,
          i.nomenclatureKey,
        );
        productImages[i.nomenclatureKey] = filePath;
      }
    }

    final newState = state.copyWith(productImages: productImages);
    emit(DataAltLoaded(newState));
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
