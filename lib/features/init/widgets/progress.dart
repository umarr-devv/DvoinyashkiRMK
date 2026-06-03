import 'package:app/blocs/blocs.dart';
import 'package:app/core/router/router.dart';
import 'package:app/shared/icons/icons.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class InitProgress extends StatelessWidget {
  const InitProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      spacing: 12,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIcons.invert_icon(size: 64),
            Transform.translate(
              offset: Offset(0, 6),
              child: CustomIcons.logo(size: 48, color: theme.custom.foreground),
            ),
          ],
        ),
        SizedBox(
          width: 320,
          child: FProgress(
            style: (style) => style.copyWith(
              fillDecoration: BoxDecoration(
                color: theme.custom.accent,
                borderRadius: BorderRadius.circular(6),
              ),
              trackDecoration: BoxDecoration(
                color: theme.custom.muted,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
        BlocBuilder<DataCubit, DataState>(
          bloc: BlocProvider.of<DataCubit>(context),
          builder: (context, state) {
            return Text(
              state.comment,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: theme.custom.foreground,
              ),
            );
          },
        ),
        SizedBox(height: 12),
        SizedBox(
          width: 160,
          child: FButton(
            style: FButtonStyle.outline(),
            onPress: () {
              if (context.read<AuthCubit>().state.user != null) {
                AutoRouter.of(context).push(MenuRoute());
              } else {
                AutoRouter.of(context).push(AuthRoute());
              }
            },
            child: Text('Пропустить'),
          ),
        ),
      ],
    );
  }
}
