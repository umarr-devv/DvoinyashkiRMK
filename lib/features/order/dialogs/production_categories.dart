import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class ProductionCategoriesDialog {
  ProductionCategoriesDialog(this.rootContext);

  final BuildContext rootContext;

  void show() {
    showFDialog(
      context: rootContext,
      builder: (context, style, animation) {
        return FDialog.raw(
          builder: (context, style) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [title()],
              ),
            );
          },
        );
      },
    );
  }

  Widget title() {
    return FHeader.nested(
      title: Text('Категории для авто-сборки'),
      titleAlignment: Alignment.centerLeft,
      prefixes: [Icon(FIcons.coffee, size: 24)],
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
}
