import 'package:app/blocs/blocs.dart';
import 'package:app/models/models.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:app/shared/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:intl/intl.dart';

class OfflineChecksDialog {
  OfflineChecksDialog(this.rootContext);

  final BuildContext rootContext;

  void show() {
    showFDialog(
      context: rootContext,
      barrierDismissible: true,
      builder: (context, style, animation) {
        return BlocProvider.value(
          value: BlocProvider.of<OfflineChecksCubit>(rootContext),
          child: const _OfflineChecksDialogContent(),
        );
      },
    );
  }
}

class _OfflineChecksDialogContent extends StatelessWidget {
  const _OfflineChecksDialogContent();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<OfflineChecksCubit>(context);
    return BlocListener<OfflineChecksCubit, OfflineChecksState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is OfflineChecksSent) {
          AutoRouter.of(context).maybePop();
        }
      },
      child: FDialog.raw(
        builder: (context, style) {
          return Material(
            type: MaterialType.transparency,
            child: SizedBox(
              width: 560,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: BlocBuilder<OfflineChecksCubit, OfflineChecksState>(
                  bloc: cubit,
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _OfflineChecksHeader(),
                        const SizedBox(height: 16),
                        if (state.checks.isEmpty)
                          _EmptyOfflineChecks()
                        else
                          _OfflineChecksList(cubit: cubit, state: state),
                        const SizedBox(height: 16),
                        _OfflineChecksActions(cubit: cubit, state: state),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _OfflineChecksHeader extends StatelessWidget {
  const _OfflineChecksHeader();

  @override
  Widget build(BuildContext context) {
    return FHeader.nested(
      prefixes: [Icon(FluentIcons.cloud_off_24_regular)],
      title: Text('Оффлайн чеки'),
      titleAlignment: Alignment.centerLeft,
      suffixes: [
        FButton.icon(
          onPress: () => AutoRouter.of(context).maybePop(),
          child: Icon(Icons.close),
        ),
      ],
    );
  }
}

class _EmptyOfflineChecks extends StatelessWidget {
  const _EmptyOfflineChecks();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Column(
          spacing: 8,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FluentIcons.checkmark_circle_24_regular,
              size: 40,
              color: theme.custom.mutedForeground,
            ),
            Text(
              'Нет оффлайн чеков',
              style: TextStyle(color: theme.custom.mutedForeground),
            ),
          ],
        ),
      ),
    );
  }
}

class _OfflineChecksList extends StatelessWidget {
  const _OfflineChecksList({required this.cubit, required this.state});

  final OfflineChecksCubit cubit;
  final OfflineChecksState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final checks = state.checks;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 360),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: checks.length,
        separatorBuilder: (_, _) => const CustomDottedLine(),
        itemBuilder: (context, index) {
          final check = checks[index];
          return _OfflineCheckTile(
            check: check,
            index: index,
            cubit: cubit,
            isLoading: state is OfflineChecksSending,
            theme: theme,
          );
        },
      ),
    );
  }
}

class _OfflineCheckTile extends StatelessWidget {
  const _OfflineCheckTile({
    required this.check,
    required this.index,
    required this.cubit,
    required this.isLoading,
    required this.theme,
  });

  final CreateCheckScheme check;
  final int index;
  final OfflineChecksCubit cubit;
  final bool isLoading;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat('dd.MM.yyyy HH:mm').format(check.date);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      leading: Icon(
        FluentIcons.receipt_24_regular,
        color: theme.custom.mutedForeground,
      ),
      title: Text(
        'Чек от $dateFormatted',
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        'Сумма: ${NumberFormat.currency(symbol: '').format(check.documentSum)} • ${check.paymentForm}',
        style: TextStyle(color: theme.custom.mutedForeground, fontSize: 12),
      ),
      trailing: isLoading
          ? null
          : FButton.icon(
              onPress: () => cubit.removeCheck(index),
              style: FButtonStyle.ghost(),
              child: Icon(
                Icons.close,
                size: 16,
                color: theme.custom.destructiveTextForeground,
              ),
            ),
    );
  }
}

class _OfflineChecksActions extends StatelessWidget {
  const _OfflineChecksActions({required this.cubit, required this.state});

  final OfflineChecksCubit cubit;
  final OfflineChecksState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSending = state is OfflineChecksSending;
    final hasError = state is OfflineChecksSendFailure;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Не удалось отправить некоторые чеки. Проверьте соединение и повторите.',
              style: TextStyle(
                color: theme.custom.destructiveTextForeground,
                fontSize: 13,
              ),
            ),
          ),
        Row(
          spacing: 12,
          children: [
            Expanded(
              child: FButton(
                onPress: () => AutoRouter.of(context).maybePop(),
                style: FButtonStyle.outline(),
                child: Text('Закрыть'),
              ),
            ),
            Expanded(
              child: FButton(
                onPress: state.checks.isEmpty || isSending
                    ? null
                    : () => cubit.sendAll(),
                prefix: isSending ? FCircularProgress() : null,
                style: (style) => style.copyWith(
                  decoration: FWidgetStateMap.all(
                    BoxDecoration(
                      color: state.checks.isEmpty
                          ? theme.custom.success.withValues(alpha: 0.4)
                          : theme.custom.success,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                child: Text(
                  isSending ? 'Отправка...' : 'Отправить все',
                  style: TextStyle(color: theme.custom.actionForeground),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
