import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:talker/talker.dart';

part 'product_images_cubit.g.dart';
part 'product_images_state.dart';

class ProductImagesCubit extends HydratedCubit<ProductImagesState> {
  ProductImagesCubit() : super(ProductImagesInitial());

  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  Future update() async {
    if (state.update == null ||
        DateTime.now().difference(state.update!) > Duration(hours: 24)) {
      await forceUpdate();
    }
  }

  Future forceUpdate() async {
    emit(ProductImagesLoading(state));
    try {
      final response = await client.getProductImages();
      final newState = state.copyWith(
        images: response.productImages,
        update: DateTime.now(),
      );
      emit(ProductImagesLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(ProductImagesFailure(state));
    }
  }

  @override
  ProductImagesState? fromJson(Map<String, dynamic> json) {
    return ProductImagesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ProductImagesState state) {
    return state.toJson();
  }
}
