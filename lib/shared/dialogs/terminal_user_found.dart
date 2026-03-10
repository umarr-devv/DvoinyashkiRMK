import 'package:app/blocs/blocs.dart';
import 'package:app/models/user.dart';
import 'package:app/service/service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class TerminalUserFoundDialog {
  TerminalUserFoundDialog(this.rootContext, {required this.user});

  final BuildContext rootContext;
  final UserScheme user;

  void show() {
    showFDialog(
      context: rootContext,
      builder: (context, style, animation) {
        return BlocProvider(
          create: (_) => TerminalCubit()..getWorkReport(user),
          child: _TerminalUserFoundDialogWidget(user: user),
        );
      },
    );
  }
}

class _TerminalUserFoundDialogWidget extends StatelessWidget {
  const _TerminalUserFoundDialogWidget({required this.user});

  final UserScheme user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TerminalCubit, TerminalState>(
      listener: (context, state) {
        if (state is TerminalFailure) {
          ToastService.showToast(
            context,
            notification: NotificationData(
              title: 'Ошибка',
              description: 'Произошла сетевая ошибка',
              type: NotificationType.error,
            ),
          );
        } else if (state is TerminalUpdated) {
          AutoRouter.of(context).maybePop();
        }
      },
      builder: (context, state) {
        final isLoading = state is TerminalLoading || state is TerminalUpdating;

        // Cast user to DetailUserScheme if possible to access department
        final detailUser = user is DetailUserScheme
            ? user as DetailUserScheme
            : null;

        return FDialog(
          title: const Text('Терминал'),
          direction: Axis.horizontal,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.description,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (detailUser != null && detailUser.department != null) ...[
                const SizedBox(height: 4),
                Text(
                  detailUser.department!,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
              const SizedBox(height: 24),
              if (state is TerminalLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: FCircularProgress(),
                  ),
                )
              else if (state.workReport != null)
                const Text('Текущий статус: На смене')
              else
                const Text('Текущий статус: Смена закрыта'),
            ],
          ),
          actions: [
            FButton(
              onPress: isLoading
                  ? null
                  : () => AutoRouter.of(context).maybePop(),
              style: FButtonStyle.outline(),
              child: const Text('Отмена'),
            ),
            if (state is! TerminalLoading)
              if (state.workReport != null)
                FButton(
                  onPress: isLoading
                      ? null
                      : () => context.read<TerminalCubit>().leave(user),
                  style: FButtonStyle.destructive(),
                  prefix: isLoading
                      ? const FCircularProgress()
                      : const Icon(FluentIcons.arrow_exit_20_regular),
                  child: const Text('Уход'),
                )
              else
                FButton(
                  onPress: isLoading
                      ? null
                      : () {
                          final authors = context
                              .read<DataCubit>()
                              .state
                              .authors;
                          if (authors.isNotEmpty) {
                            // Ищем автора для текущего пользователя (или берем первого, так как логика авторов зависит от бизнес-правил)
                            final author = authors.first;
                            context.read<TerminalCubit>().come(user, author);
                          } else {
                            // Показать сообщение, если авторы не загружены
                          }
                        },
                  style: FButtonStyle.primary(),
                  prefix: isLoading
                      ? const FCircularProgress()
                      : const Icon(FluentIcons.arrow_enter_20_regular),
                  child: const Text('Приход'),
                ),
          ],
        );
      },
    );
  }
}
