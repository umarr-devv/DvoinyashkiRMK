import 'package:app/blocs/blocs.dart';
import 'package:app/models/user.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

import 'terminal_user_found.dart';

class TerminalDialog {
  TerminalDialog(this.rootContext);

  final BuildContext rootContext;

  void show() {
    showFDialog(
      context: rootContext,
      builder: (context, style, animation) {
        return _TerminalDialogWidget(rootContext: rootContext);
      },
    );
  }
}

class _TerminalDialogWidget extends StatefulWidget {
  const _TerminalDialogWidget({required this.rootContext});

  final BuildContext rootContext;

  @override
  State<_TerminalDialogWidget> createState() => _TerminalDialogWidgetState();
}

class _TerminalDialogWidgetState extends State<_TerminalDialogWidget> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String? _errorText;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _searchUser(String barcode) {
    if (barcode.trim().isEmpty) return;

    final users = context.read<DataCubit>().state.users;
    final user = users.cast<UserScheme?>().firstWhere(
      (u) => u?.barcode == barcode,
      orElse: () => null,
    );

    if (user != null) {
      AutoRouter.of(context).maybePop().then((_) {
        if (mounted) {
          // ignore: use_build_context_synchronously
          TerminalUserFoundDialog(widget.rootContext, user: user).show();
        }
      });
    } else {
      setState(() {
        _errorText = 'Пользователь не найден';
      });
      _controller.clear();
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FDialog(
      title: const Text('Терминал'),
      direction: Axis.horizontal,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Отсканируйте штрихкод или введите его вручную:'),
          const SizedBox(height: 16),
          FTextField(
            focusNode: _focusNode,
            autofocus: true,
            label: const Text('Штрихкод'),
            description: _errorText != null
                ? Text(
                    _errorText!,
                    style: TextStyle(
                      color: theme.custom.destructiveTextForeground,
                    ),
                  )
                : null,
            control: FTextFieldControl.managed(
              controller: _controller,
              onChange: (value) {},
            ),
            onSubmit: (value) => _searchUser(_controller.text),
          ),
        ],
      ),
      actions: [
        FButton(
          onPress: () => AutoRouter.of(context).maybePop(),
          style: FButtonStyle.outline(),
          child: const Text('Отмена'),
        ),
        FButton(
          onPress: () => _searchUser(_controller.text),
          style: FButtonStyle.primary(),
          child: const Text('Найти'),
        ),
      ],
    );
  }
}
