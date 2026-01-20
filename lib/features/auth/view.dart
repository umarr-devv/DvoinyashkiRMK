import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/blocs/blocs.dart';
import 'package:app/core/router/router.dart';
import 'package:app/features/auth/widgets/widgets.dart';
import 'package:app/service/toast.dart';
import 'package:app/shared/widgets/windowsbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      bloc: BlocProvider.of<AuthCubit>(context),
      listener: (context, state) {
        if (state is AuthLoggedIn && state.user != null) {
          ToastService.showToast(
            context,
            notification: NotificationData(
              type: NotificationType.success,
              icon: FIcons.logIn,
              title: 'Авторизация',
              description:
                  'Пользователь ${state.user!.description} успешно авторизован',
            ),
          );
          AutoRouter.of(context).replace(MenuRoute());
        }
      },
      child: ThemeSwitchingArea(
        child: Scaffold(
          body: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: 420,
                  child: Column(
                    spacing: 24,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [AuthLogo(), AuthForm(), AuthRules()],
                  ),
                ),
              ),
              Column(children: [WindowBar()]),
            ],
          ),
        ),
      ),
    );
  }
}
