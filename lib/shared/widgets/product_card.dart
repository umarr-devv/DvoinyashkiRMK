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

  OrderItem? getOrderItem(OrderData? order) {
    return order?.items.firstWhereLogTypeOrNull(
      (i) => product.uniqueId == i.product.uniqueId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<OrderCubit, OrderState>(
      bloc: BlocProvider.of<OrderCubit>(context),
      buildWhen: (previous, current) {
        final previousItem = getOrderItem(previous.currentOrder);
        final currentItem = getOrderItem(current.currentOrder);
        return previousItem?.quantity != currentItem?.quantity;
      },
      builder: (context, state) {
        final orderItem = getOrderItem(state.currentOrder);
        return FTooltip(
          hoverEnterDuration: Duration(milliseconds: 125),
          tipBuilder: (context, controller) => Text(
            product.name,
            style: TextStyle(color: theme.custom.foreground),
          ),
          child: FCard.raw(
            style: (style) {
              if (orderItem != null) {
                return style.copyWith(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme.custom.foreground,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              }
              return style;
            },
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Stack(
                    children: [
                      _ProductCardImage(product),
                      Align(
                        alignment: Alignment.topRight,
                        child: ProductCatdFavoriteButton(product),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _ProductCardTitle(product),
                        _ProductCardPrice(product),
                        Expanded(child: SizedBox()),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ProductCardAddButton(
                            product: product,
                            orderItem: orderItem,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
            borderRadius: BorderRadius.circular(4),
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

class ProductCatdFavoriteButton extends StatelessWidget {
  const ProductCatdFavoriteButton(
    this.product, {
    super.key,
    this.padding = const EdgeInsets.all(12),
  });

  final ProductData product;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<FavoritesCubit>(context);
    final theme = Theme.of(context);
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      bloc: cubit,
      builder: (context, state) {
        final favorite = state.favoriteKeys.contains(product.uniqueId);
        return Padding(
          padding: padding,
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
              fontSize: 22,
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

class ProductCardAddButton extends StatelessWidget {
  const ProductCardAddButton({
    super.key,
    required this.product,
    this.orderItem,
  });

  final ProductData product;
  final OrderItem? orderItem;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<OrderCubit>(context);
    final theme = Theme.of(context);
    if (orderItem != null) {
      return FCard.raw(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            spacing: 6,
            mainAxisSize: MainAxisSize.min,
            children: [
              FButton.icon(
                onPress: () {
                  if (orderItem?.quantity == 1) {
                    cubit.deleteItem(orderItem!);
                  }
                  cubit.updateItem(
                    orderItem!.copyWith(quantity: orderItem!.quantity - 1),
                  );
                },
                style: FButtonStyle.secondary(),
                child: Icon(Icons.remove, size: 16),
              ),
              Text(
                orderItem!.quantity.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: theme.custom.foreground,
                ),
              ),
              FButton.icon(
                onPress: () {
                  cubit.updateItem(
                    orderItem!.copyWith(quantity: orderItem!.quantity + 1),
                  );
                },
                style: FButtonStyle.primary(),
                child: Icon(Icons.add, size: 16),
              ),
            ],
          ),
        ),
      );
    } else {
      return FButton.icon(
        onPress: () {
          cubit.addItem(
            OrderItem(
              product: product,
              quantity: 1,
              price: product.sellPrice?.price.price.toDouble() ?? 0,
            ),
          );
        },
        style: FButtonStyle.outline(),
        child: Icon(FIcons.plus),
      );
    }
  }
}
