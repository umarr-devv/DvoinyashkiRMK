import 'package:app/blocs/blocs.dart';
import 'package:app/features/work_time/blocs/blocs.dart';
import 'package:app/service/print.dart';
import 'package:app/service/print_schemes/session.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class EndSessionDialog {
  EndSessionDialog(this.rootContext);

  final BuildContext rootContext;

  void show() {
    showFDialog(
      context: rootContext,
      builder: (context, style, animation) {
        return BlocListener<SessionCubit, SessionState>(
          bloc: BlocProvider.of<SessionCubit>(context),
          listener: (context, state) async {
            if (state is SessionEnded && state.currentWorkShift != null) {
              final settingsCubit = BlocProvider.of<SettingsCubit>(context);
              final dataCubit = BlocProvider.of<DataCubit>(context);
              final cubit = DetailSessionCubit(state.currentWorkShift!.refKey);
              final data = await cubit.update();
              if (data != null && settingsCubit.state.printer != null) {
                try {
                  PrintService(printerUrl: settingsCubit.state.printer).print(
                    PrintSessionScheme(
                      session: data,
                      dataState: dataCubit.state,
                      // ignore: use_build_context_synchronously
                      context: context,
                    ),
                    // ignore: use_build_context_synchronously
                    context,
                  );
                } catch (exc, st) {
                  GetIt.I<Talker>().error(exc, st);
                }
              }
            }
          },
          child: FDialog(
            title: Text('Закончить смену'),
            direction: Axis.horizontal,
            body: Text('Нажмитне кнопку "Закончить", чтобы закончить смену'),
            actions: [
              FButton(
                onPress: () {
                  AutoRouter.of(context).maybePop();
                },
                style: FButtonStyle.outline(),
                child: Text('Отмена'),
              ),
              FButton(
                onPress: () {
                  BlocProvider.of<SessionCubit>(context).end();
                  BlocProvider.of<WorkShiftsCubit>(context).update();
                  AutoRouter.of(context).maybePop();
                },
                style: FButtonStyle.primary(),
                child: Text('Закончить'),
              ),
            ],
          ),
        );
      },
    );
  }
}
