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
  const ProductCard({
    super.key,
    required this.nomenclature,
    required this.characteristics,
    required this.prices,
  });

  final NomenclatureScheme nomenclature;
  final List<CharacteristicScheme> characteristics;
  final List<PriceScheme> prices;

  @override
  Widget build(BuildContext context) {
    return FCard.raw(
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                _ProductCardImage(nomenclature),
                Align(
                  alignment: Alignment.topRight,
                  child: _ProductCatdFavoriteButton(nomenclature),
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
                  _ProductCardTitle(nomenclature: nomenclature),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ProductCardPrice(prices),
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

class _ProductCardImage extends StatefulWidget {
  const _ProductCardImage(this.nomenclature);

  final NomenclatureScheme nomenclature;

  @override
  State<_ProductCardImage> createState() => _ProductCardImageState();
}

class _ProductCardImageState extends State<_ProductCardImage> {
  Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProductImagesCubit, ProductImagesState>(
      bloc: BlocProvider.of<ProductImagesCubit>(context),
      builder: (context, state) {
        imageBytes = state.images
            .firstWhereLogTypeOrNull(
              (i) => i.nomenclatureKey == widget.nomenclature.refKey,
            )
            ?.imageBytes;
        return GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.all(8),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: theme.custom.muted,
              borderRadius: BorderRadius.circular(12),
            ),
            child: imageBytes != null
                ? Image.memory(imageBytes!, fit: BoxFit.cover)
                : Icon(
                    FIcons.image,
                    size: 64,
                    color: theme.custom.mutedForeground,
                  ),
          ),
        );
      },
    );
  }
}

class _ProductCardTitle extends StatelessWidget {
  const _ProductCardTitle({required this.nomenclature});

  final NomenclatureScheme nomenclature;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      nomenclature.name ?? 'Без названия',
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
  const _ProductCatdFavoriteButton(this.nomenclature);

  final NomenclatureScheme nomenclature;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FavoritesCubit>(context);
    final theme = Theme.of(context);
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      bloc: cubit,
      builder: (context, state) {
        final favorite = state.favoriteKeys.contains(nomenclature.refKey);
        return Padding(
          padding: const EdgeInsets.all(12),
          child: FButton.icon(
            onPress: () {
              if (favorite) {
                cubit.remove(nomenclature.refKey);
              } else {
                cubit.add(nomenclature.refKey);
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
  const _ProductCardPrice(this.prices);

  final List<PriceScheme> prices;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mainPrice = ProductsCubitUtils.getMainPrice(prices);
    if (mainPrice != null) {
      return Row(
        spacing: 2,
        children: [
          Text(
            mainPrice.price.toStringAsFixed(0),
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
