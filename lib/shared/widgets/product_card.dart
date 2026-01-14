import 'dart:typed_data';

import 'package:app/blocs/blocs.dart';
import 'package:app/blocs/product_images/product_images_cubit.dart';
import 'package:app/models/models.dart';
import 'package:app/shared/icons/icons.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:talker/talker.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductData product;

  @override
  Widget build(BuildContext context) {
    return FCard.raw(
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                _ProductCardImage(product),
                Align(
                  alignment: Alignment.topRight,
                  child: _ProductCatdFavoriteButton(product),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ProductCardTitle(product),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ProductCardPrice(product),
                      _ProductCardAddButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCardImage extends StatelessWidget {
  const _ProductCardImage(this.product);

  final ProductData product;

  Uint8List? imageBytes(List<ProductImageScheme> images) {
    if (product.characteristic != null) {
      return images
          .firstWhereLogTypeOrNull(
            (i) =>
                i.nomenclatureKey == product.nomenclature.refKey &&
                i.characteristicKey == product.characteristic?.refKey,
          )
          ?.imageBytes;
    } else {
      return images
          .firstWhereLogTypeOrNull(
            (i) => i.nomenclatureKey == product.nomenclature.refKey,
          )
          ?.imageBytes;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProductImagesCubit, ProductImagesState>(
      bloc: BlocProvider.of<ProductImagesCubit>(context),
      builder: (context, state) {
        final imageBytes_ = imageBytes(state.images);

        return Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.all(8),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: theme.custom.muted,
            borderRadius: BorderRadius.circular(12),
          ),
          child: imageBytes_ != null
              ? Image.memory(imageBytes_, fit: BoxFit.cover)
              : Icon(
                  FIcons.image,
                  size: 64,
                  color: theme.custom.mutedForeground,
                ),
        );
      },
    );
  }
}

class _ProductCardTitle extends StatelessWidget {
  const _ProductCardTitle(this.product);

  final ProductData product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      product.name,
      textAlign: TextAlign.start,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: theme.custom.foreground,
      ),
    );
  }
}

class _ProductCatdFavoriteButton extends StatelessWidget {
  const _ProductCatdFavoriteButton(this.product);

  final ProductData product;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FavoritesCubit>(context);
    final theme = Theme.of(context);
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      bloc: cubit,
      builder: (context, state) {
        final favorite = state.favoriteKeys.contains(product.uniqueId);
        return Padding(
          padding: const EdgeInsets.all(12),
          child: FButton.icon(
            onPress: () {
              if (favorite) {
                cubit.remove(product.uniqueId);
              } else {
                cubit.add(product.uniqueId);
              }
            },
            style: (style) => style.copyWith(
              decoration: FWidgetStateMap.all(
                BoxDecoration(
                  color: theme.custom.background,
                  borderRadius: BorderRadius.circular(64),
                ),
              ),
            ),
            child: favorite
                ? Icon(
                    FluentIcons.star_24_filled,
                    color: theme.custom.secondaryAccent,
                  )
                : Icon(
                    FluentIcons.star_24_regular,
                    color: theme.custom.mutedForeground,
                  ),
          ),
        );
      },
    );
  }
}

class _ProductCardPrice extends StatelessWidget {
  const _ProductCardPrice(this.product);

  final ProductData product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (product.sellPrice != null) {
      return Row(
        spacing: 2,
        children: [
          Text(
            product.sellPrice!.price.price.toStringAsFixed(0),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: theme.custom.foreground,
            ),
          ),
          Transform.translate(
            offset: Offset(0, 3),
            child: CustomIcons.som(
              color: theme.custom.mutedForeground,
              size: 14,
            ),
          ),
        ],
      );
    }
    return SizedBox();
  }
}

class _ProductCardAddButton extends StatelessWidget {
  const _ProductCardAddButton();

  @override
  Widget build(BuildContext context) {
    return FButton.icon(
      onPress: () {},
      style: FButtonStyle.outline(),
      child: Icon(FIcons.plus),
    );
  }
}
