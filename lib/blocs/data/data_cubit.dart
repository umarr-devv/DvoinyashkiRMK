import 'dart:async';

import 'package:app/blocs/blocs.dart';
import 'package:app/client/client.dart';
import 'package:app/core/consts/consts.dart';
import 'package:app/models/group.dart';
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
  DataCubit() : super(DataInitial()) {
    _updateTimer = Timer.periodic(const Duration(hours: 1), (_) {
      smallUpdate();
    });
  }

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();
  Timer? _updateTimer;

  @override
  Future<void> close() {
    _updateTimer?.cancel();
    return super.close();
  }

  Future update() async {
    if (state.update == null ||
        DateTime.now().difference(state.update!) > Duration(hours: 12)) {
      await forceUpdate();
    } else {
      await smallUpdate();
    }

    if (state.update == null ||
        DateTime.now().difference(state.update!) > Duration(days: 7)) {
      await forceUpdateImages();
    }
  }

  Future smallUpdate() async {
    if (state is DataLoading) return;
    emit(DataLoading(state.copyWith(comment: 'Загрузка цен')));
    final prices = await client.getPrices();
    final products = DataCubitUtils.getProducts(
      nomenclatures: state.nomenclatures,
      characteristics: state.characteristics,
      prices: prices.value,
      barcodes: state.barcodes,
      priceTypes: state.priceTypes,
      specifications: state.specifications,
    );
    final newState = state.copyWith(prices: prices.value, products: products);
    emit(DataLoaded(newState));
  }

  Future forceUpdate() async {
    if (state is DataLoading) return;
    emit(DataLoading(state));
    try {
      emit(DataLoading(state.copyWith(comment: 'Загрузка касс')));
      final cashRegisters = await client.getCashRegisters();

      emit(DataLoading(state.copyWith(comment: 'Загрузка категорий')));
      final categories = await client.getCategories();

      emit(DataLoading(state.copyWith(comment: 'Загрузка групп')));
      final groups = await client.getGroups(
        fullPath: buildODataQuery({
          '\$filter':
              'IsFolder eq true and Parent_Key eq guid\'1d449a23-82d6-11ed-a84d-18d6c704b66b\'',
          '\$format': 'json',
        }),
      );

      emit(DataLoading(state.copyWith(comment: 'Загрузка номенклатуры')));
      final nomenclatures = await client.getNomenclatures();

      emit(DataLoading(state.copyWith(comment: 'Загрузка характеристик')));
      final characteristics = await client.getCharacteristics();

      emit(DataLoading(state.copyWith(comment: 'Загрузка цен')));
      final prices = await client.getPrices();

      emit(DataLoading(state.copyWith(comment: 'Загрузка типов цен')));
      final priceTypes = await client.getPriceTypes();

      emit(DataLoading(state.copyWith(comment: 'Загрузка штрихкодов')));
      final barcodes = await client.getBarcodes();

      emit(
        DataLoading(state.copyWith(comment: 'Загрузка магазинов и складов')),
      );
      final structureUnits = await client.getStructureUnits();

      emit(DataLoading(state.copyWith(comment: 'Загрузка пользователей')));
      final users = await client.getUsers();

      emit(DataLoading(state.copyWith(comment: 'Загрузка авторов')));
      final authors = await client.getAuthors();

      emit(DataLoading(state.copyWith(comment: 'Загрузка спецификаций')));
      final specifications = await client.getSpecifications();

      final products = DataCubitUtils.getProducts(
        nomenclatures: nomenclatures.value,
        characteristics: characteristics.value,
        prices: prices.value,
        barcodes: barcodes.value,
        priceTypes: priceTypes.value,
        specifications: specifications.value,
      );

      final newState = state.copyWith(
        cashRegisters: cashRegisters.cashRegisters,
        categories: categories.categories,
        nomenclatures: nomenclatures.value,
        characteristics: characteristics.value,
        groups: groups.value,
        prices: prices.value,
        priceTypes: priceTypes.value,
        barcodes: barcodes.value,
        structureUnits: structureUnits.structureUnits,
        users: users.users,
        authors: authors.authors,
        products: products,
        specifications: specifications.value,
        update: DateTime.now(),
      );
      emit(DataLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(DataFailure(state));
    }
  }

  Future forceUpdateImages() async {
    if (state is DataAltLoading) return;
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
