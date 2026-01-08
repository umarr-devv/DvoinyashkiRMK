import 'package:app/shared/icons/icons.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:window_manager/window_manager.dart';

class WindowBar extends StatefulWidget {
  const WindowBar({super.key});

  @override
  State<WindowBar> createState() => _WindowBarState();
}

class _WindowBarState extends State<WindowBar> {
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    _syncWindowState();
  }

  Future<void> _syncWindowState() async {
    _isFullscreen = await windowManager.isFullScreen();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DragToMoveArea(child: WindowBarLogo()),
          Expanded(child: DragToMoveArea(child: Container(height: 36))),
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
              windowManager.maximize();
            },
            icon: FluentIcons.square_24_regular,
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
    );
  }
}

class WindowBarLogo extends StatelessWidget {
  const WindowBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(top: 2, left: 16),
      child: Row(
        spacing: 6,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomIcons.icon(size: 20, color: theme.custom.foreground),
          CustomIcons.logo(size: 14, color: theme.custom.foreground),
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
