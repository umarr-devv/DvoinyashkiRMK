import 'package:app/blocs/blocs.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';
import 'package:talker/talker.dart';

class DetailProductDialog {
  DetailProductDialog(this.rootContext, {required this.product});

  final BuildContext rootContext;
  final ProductData product;

  void show() {
    showFDialog(
      context: rootContext,
      builder: (context, _, _) {
        return FDialog.raw(
          builder: (context, _) {
            return Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24,
                children: [
                  title(),
                  info(),
                  prices(),
                  warehouse(),
                  specifications(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget title() {
    return FHeader.nested(
      title: Text(product.name),
      titleAlignment: Alignment.centerLeft,
      suffixes: [
        FButton.icon(
          onPress: () {
            AutoRouter.of(rootContext).maybePop();
          },
          child: Icon(Icons.close),
        ),
      ],
    );
  }

  Widget info() {
    return Column(
      spacing: 24,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FLabel(
          label: Text('Номенклатура'),
          axis: Axis.vertical,
          child: Text(product.nomenclature.description ?? '----'),
        ),
        FLabel(
          label: Text('Характеристика'),
          axis: Axis.vertical,
          child: Text(product.characteristic?.description ?? '----'),
        ),
      ],
    );
  }

  Widget prices() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: product.prices.map((price) {
        return FLabel(
          label: Text(price.type?.description ?? ''),
          axis: Axis.vertical,
          child: Text(NumberFormat().format(price.price.price)),
        );
      }).toList(),
    );
  }

  Widget warehouse() {
    final warehoueItem = product.warehouseItem(rootContext);
    return FLabel(
      label: Text('В складе'),
      axis: Axis.vertical,
      child: Text(NumberFormat().format(warehoueItem?.quantity ?? 0)),
    );
  }

  Widget specifications() {
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(rootContext),
      builder: (context, dataState) {
        return Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: product.specifications.map((specification) {
            final index = product.specifications.indexOf(specification);
            return FLabel(
              label: Text(
                'Спецификация ${index + 1} (себестоимость ${specification.totalPrice})',
              ),
              axis: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: specification.items.map((item) {
                  final nomenclature = dataState.nomenclatures
                      .firstWhereLogTypeOrNull(
                        (i) => i.refKey == item.nomenclatureKey,
                      );
                  final characteristic = dataState.characteristics
                      .firstWhereLogTypeOrNull(
                        (i) => i.refKey == item.characteristicKey,
                      );
                  return Text(
                    '${nomenclature?.description ?? ""} ${characteristic?.description ?? ""} - ${item.quantity}',
                  );
                }).toList(),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
