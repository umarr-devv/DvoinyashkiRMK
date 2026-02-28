import 'dart:io';

import 'package:app/blocs/blocs.dart';
import 'package:app/features/movement/blocs/blocs.dart';
import 'package:app/features/order/dialogs/dialogs.dart';
import 'package:app/models/models.dart';
import 'package:app/shared/icons/icons.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:talker/talker.dart';

class MovementCard extends StatelessWidget {
  const MovementCard({super.key, required this.cubit, required this.product});

  final CreateMovementCubit cubit;
  final ProductData product;

  CreateMovementItemData? getMovementItem(List<CreateMovementItemData> items) {
    return items.firstWhereLogTypeOrNull(
      (i) => product.uniqueId == i.product.uniqueId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final warehouseItem = product.warehouseItem(context);
    return BlocBuilder<CreateMovementCubit, CreateMovementState>(
      bloc: cubit,
      buildWhen: (previous, current) {
        final previousItem = getMovementItem(previous.items);
        final currentItem = getMovementItem(current.items);
        return previousItem?.quantity != currentItem?.quantity;
      },
      builder: (context, state) {
        final movementItem = getMovementItem(state.items);
        return FTooltip(
          hoverEnterDuration: Duration(milliseconds: 125),
          tipBuilder: (context, controller) => Text(
            product.name,
            style: TextStyle(color: theme.custom.foreground),
          ),
          child: GestureDetector(
            onTap: () {
              if (movementItem != null) {
                cubit.setItem(movementItem.copyWith(movementItem.quantity + 1));
              } else {
                cubit.setItem(
                  CreateMovementItemData(product: product, quantity: 1),
                );
              }
            },
            onLongPress: () {
              DetailProductDialog(context, product: product).show();
            },
            onSecondaryTap: () {
              DetailProductDialog(context, product: product).show();
            },
            child: FCard.raw(
              style: (style) {
                if (movementItem != null) {
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
                  Expanded(flex: 4, child: _ProductCardImage(product)),
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
                          _ProductWarehouse(product),
                          Expanded(child: SizedBox()),
                          Align(
                            alignment: Alignment.centerRight,
                            child: MovementCardAddButton(
                              product: product,
                              cubit: cubit,
                              movementItem: movementItem,
                              warehouseItem: warehouseItem,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(context),
      buildWhen: (previous, current) => current is DataAltLoaded,
      builder: (context, state) {
        final image = state.productImages[product.nomenclature.refKey];
        return Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.all(8),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: theme.custom.muted,
            borderRadius: BorderRadius.circular(4),
          ),
          child: image != null
              ? Image.file(File(image), fit: BoxFit.cover)
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

class ProductCardFavoriteButton extends StatelessWidget {
  const ProductCardFavoriteButton(
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

class _ProductWarehouse extends StatelessWidget {
  const _ProductWarehouse(this.product);

  final ProductData product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final warehouseItem = product.warehouseItem(context);
    return Container(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        'В Складе: ${NumberFormat.decimalPattern().format(warehouseItem?.quantity ?? 0)}',
        style: TextStyle(
          color: (warehouseItem?.quantity ?? 0) < 0
              ? theme.custom.destructiveTextForeground
              : theme.custom.foreground,
        ),
      ),
    );
  }
}

class MovementCardAddButton extends StatelessWidget {
  const MovementCardAddButton({
    super.key,
    required this.product,
    required this.cubit,
    this.movementItem,
    this.warehouseItem,
  });

  final ProductData product;
  final CreateMovementCubit cubit;
  final CreateMovementItemData? movementItem;
  final WarehouseItemScheme? warehouseItem;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (movementItem != null) {
      return FCard.raw(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            spacing: 6,
            mainAxisSize: MainAxisSize.min,
            children: [
              FButton.icon(
                onPress: () {
                  if (movementItem?.quantity == 1) {
                    cubit.deleteItem(movementItem!);
                  }
                  cubit.setItem(
                    movementItem!.copyWith(movementItem!.quantity - 1),
                  );
                },
                style: FButtonStyle.secondary(),
                child: Icon(Icons.remove, size: 16),
              ),
              Text(
                movementItem!.quantity.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: theme.custom.foreground,
                ),
              ),
              FButton.icon(
                onPress: () {
                  cubit.setItem(
                    movementItem!.copyWith(movementItem!.quantity + 1),
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
          cubit.setItem(CreateMovementItemData(product: product, quantity: 1));
        },
        style: FButtonStyle.outline(),
        child: Icon(FIcons.plus),
      );
    }
  }
}

class MovementItemQuantity extends StatefulWidget {
  const MovementItemQuantity(this.item, this.cubit, {super.key});

  final CreateMovementItemData item;
  final CreateMovementCubit cubit;

  @override
  State<MovementItemQuantity> createState() => _MovementItemQuantityState();
}

class _MovementItemQuantityState extends State<MovementItemQuantity> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.item.quantity.toStringAsFixed(2),
    );
  }

  @override
  void didUpdateWidget(covariant MovementItemQuantity oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newText = widget.item.quantity.toStringAsFixed(2);

    if (_controller.text != newText) {
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = widget.cubit;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 8,
      children: [
        FButton.icon(
          onPress: () {
            cubit.setItem(widget.item.copyWith(widget.item.quantity - 1));
          },
          style: FButtonStyle.secondary(),
          child: Icon(Icons.remove),
        ),
        SizedBox(
          width: 80,
          child: FTextField(
            textAlign: TextAlign.right,
            control: FTextFieldControl.managed(
              controller: _controller,
              onChange: (value) {
                final value_ = double.tryParse(value.text);
                if (value_ != null) {
                  cubit.setItem(widget.item.copyWith(value_));
                }
              },
            ),
            inputFormatters: [
              CurrencyInputFormatter(
                thousandSeparator: ThousandSeparator.Space,
                mantissaLength: 2,
              ),
            ],
          ),
        ),
        FButton.icon(
          onPress: () {
            cubit.setItem(widget.item.copyWith(widget.item.quantity + 1));
          },
          style: FButtonStyle.primary(),
          child: Icon(Icons.add),
        ),
      ],
    );
  }
}
