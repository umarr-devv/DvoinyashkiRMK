import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/blocs/blocs.dart';
import 'package:app/shared/dialogs/dialogs.dart';
import 'package:app/shared/icons/icons.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:window_manager/window_manager.dart';

class WindowBar extends StatefulWidget {
  const WindowBar({super.key});

  @override
  State<WindowBar> createState() => _WindowBarState();
}

class _WindowBarState extends State<WindowBar> with WindowListener {
  bool _isFullscreen = false;
  bool _isMaximized = true;

  Future<void> _syncWindowState() async {
    final newFullscreen = await windowManager.isFullScreen();
    final newMaximized = await windowManager.isMaximized();

    if (_isFullscreen != newFullscreen || _isMaximized != newMaximized) {
      _isFullscreen = newFullscreen;
      _isMaximized = newMaximized;
      setState(() {});
    }
  }

  @override
  void onWindowMove() {
    _syncWindowState();
  }

  @override
  void onWindowMaximize() {
    _syncWindowState();
  }

  @override
  void onWindowMinimize() {
    _syncWindowState();
  }

  @override
  void onWindowDocked() {
    _syncWindowState();
  }

  @override
  void onWindowUnmaximize() {
    _syncWindowState();
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DragToMoveArea(child: WindowBarLogo()),
              Expanded(child: DragToMoveArea(child: Container(height: 36))),
              _ThemeSwithcer(),
              _WindowBarButton(
                onPressed: () {
                  NotificationSheetDialog(rootContext: context).show();
                },
                icon: FluentIcons.alert_24_regular,
              ),
              SizedBox(
                height: 20,
                child: VerticalDivider(color: theme.custom.border, width: 8),
              ),
              _WindowBarButton(
                onPressed: () {
                  windowManager.setFullScreen(!_isFullscreen);
                  _syncWindowState();
                },
                icon: _isFullscreen
                    ? FluentIcons.full_screen_minimize_24_regular
                    : FluentIcons.full_screen_maximize_24_regular,
              ),
              _WindowBarButton(
                onPressed: () {
                  windowManager.minimize();
                },
                icon: FluentIcons.subtract_24_regular,
              ),
              _WindowBarButton(
                onPressed: () {
                  if (_isMaximized) {
                    windowManager.unmaximize();
                  } else {
                    windowManager.maximize();
                  }
                },
                icon: _isMaximized
                    ? FluentIcons.square_multiple_24_regular
                    : FluentIcons.square_24_regular,
              ),
              _WindowBarButton(
                onPressed: () {
                  WindowCloseDialog().show(context);
                },
                color: theme.custom.destructive,
                icon: Icons.close,
              ),
            ],
          ),
        ),
        _ConnectivityBanner(),
      ],
    );
  }
}

class _ConnectivityBanner extends StatelessWidget {
  const _ConnectivityBanner();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, state) {
        if (state is ConnectivityOnline) {
          return const SizedBox.shrink();
        }
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          color: theme.custom.destructive,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              Icon(
                FluentIcons.wifi_off_24_regular,
                color: theme.custom.destructiveForeground,
                size: 16,
              ),
              Text(
                'Нет подключения к интернету или серверу',
                style: TextStyle(
                  color: theme.custom.destructiveForeground,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class WindowBarLogo extends StatelessWidget {
  const WindowBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        spacing: 6,
        children: [
          CustomIcons.icon(size: 24, color: theme.custom.foreground),
          Transform.translate(
            offset: Offset(0, 2),
            child: CustomIcons.logo(size: 18, color: theme.custom.foreground),
          ),
        ],
      ),
    );
  }
}

class _WindowBarButton extends StatelessWidget {
  const _WindowBarButton({
    required this.icon,
    required this.onPressed,
    this.color,
  });

  final IconData icon;
  final void Function() onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      width: 64,
      child: IconButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(),
          hoverColor: color,
        ),
        icon: Icon(icon, size: 20),
      ),
    );
  }
}

class _ThemeSwithcer extends StatelessWidget {
  const _ThemeSwithcer();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SettingsCubit>(context);
    final theme = Theme.of(context);
    return ThemeSwitcher(
      builder: (context) {
        final isDarkTheme = theme.brightness == Brightness.dark;
        return SizedBox(
          height: 36,
          width: 64,
          child: IconButton(
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(),
              // hoverColor: color,
            ),
            onPressed: () {
              ThemeSwitcher.of(context).changeTheme(
                theme: isDarkTheme ? lightTheme.toTheme() : darkTheme.toTheme(),
                isReversed: !isDarkTheme,
              );
              cubit.setSettings(isDarkTheme: !isDarkTheme);
            },
            icon: Icon(
              isDarkTheme
                  ? FluentIcons.weather_moon_24_regular
                  : FluentIcons.weather_sunny_24_regular,
              size: 20,
            ),
          ),
        );
      },
    );
  }
}

class WindowCloseDialog {
  void show(BuildContext context) async {
    showFDialog(
      context: context,
      builder: (context, style, animation) {
        return FDialog(
          title: Text('Закрыть программу Двойняшки РМК'),
          body: Text('Некоторые действия могут быть прерваны'),
          direction: Axis.horizontal,
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
                windowManager.close();
              },
              style: FButtonStyle.destructive(),
              child: Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }
}
