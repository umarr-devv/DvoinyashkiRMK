import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/core/router/router.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class MenuNavBar extends StatelessWidget {
  const MenuNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Row(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _NavBarTabs(),
          Row(spacing: 24, children: [_MenuNavBarUser()]),
        ],
      ),
    );
  }
}

class _NavBarTabs extends StatelessWidget {
  const _NavBarTabs();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        _NavBarTabsItem(
          icon: FluentIcons.cart_24_regular,
          label: 'Корзина',
          index: 0,
        ),
        _NavBarTabsItem(
          icon: FluentIcons.receipt_24_regular,
          label: 'История продаж',
          index: 1,
        ),
        _NavBarTabsItem(
          icon: FluentIcons.money_24_regular,
          label: 'Выемка',
          index: 2,
        ),
        _NavBarTabsItem(
          icon: FluentIcons.box_24_regular,
          label: 'Заказ',
          index: 3,
        ),
        _NavBarTabsItem(
          icon: FluentIcons.chart_person_24_regular,
          label: 'Статистика',
          index: 4,
        ),
        _NavBarTabsItem(
          icon: FluentIcons.timer_24_regular,
          label: 'Рабочее время',
          index: 5,
        ),
      ],
    );
  }
}

class _NavBarTabsItem extends StatefulWidget {
  const _NavBarTabsItem({
    required this.icon,
    required this.label,
    required this.index,
  });

  final IconData icon;
  final String label;
  final int index;

  @override
  State<_NavBarTabsItem> createState() => _NavBarTabsItemState();
}

class _NavBarTabsItemState extends State<_NavBarTabsItem> {
  bool get active => AutoTabsRouter.of(context).activeIndex == widget.index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          AutoTabsRouter.of(context).setActiveIndex(widget.index);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          decoration: BoxDecoration(
            color: active ? theme.custom.primary : theme.custom.muted,
            borderRadius: BorderRadius.circular(64),
          ),
          child: Row(
            spacing: 6,
            children: [
              Icon(
                widget.icon,
                size: 20,
                color: active
                    ? theme.custom.primaryForeground
                    : theme.custom.foreground,
              ),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: active
                      ? theme.custom.primaryForeground
                      : theme.custom.foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuNavBarUser extends StatelessWidget {
  const _MenuNavBarUser();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FPopover(
      popoverAnchor: Alignment.topCenter,
      childAnchor: Alignment.bottomCenter,
      offset: Offset(-12, 12),
      popoverBuilder: (context, _) {
        return SizedBox(
          width: 240,
          child: FTileGroup(
            children: [
              FTile(
                prefix: const Icon(FIcons.settings),
                title: const Text('Настройки'),
                suffix: Icon(FIcons.chevronRight),
                onPress: () {
                  AutoRouter.of(context).push(SettingsRoute());
                },
              ),
              FTile(
                prefix: const Icon(FIcons.headphones),
                title: const Text('Поддержка'),
                suffix: Icon(FIcons.chevronRight),
                onPress: () {},
              ),
              FTile(
                prefix: Icon(
                  FIcons.logOut,
                  color: theme.custom.destructiveTextForeground,
                ),
                title: Text(
                  'Выйти',
                  style: TextStyle(
                    color: theme.custom.destructiveTextForeground,
                  ),
                ),
                onPress: () {
                  LogoutDialog().show(context);
                },
              ),
            ],
          ),
        );
      },
      builder: (context, controller, child) {
        return Row(
          spacing: 12,
          children: [
            FAvatar.raw(child: Icon(FluentIcons.person_24_regular)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Иван Генадьев',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: theme.custom.foreground,
                  ),
                ),
                Text(
                  'Кассир',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: theme.custom.mutedForeground,
                  ),
                ),
              ],
            ),
            FButton.icon(
              onPress: controller.toggle,
              style: FButtonStyle.ghost(),
              child: Icon(FluentIcons.more_horizontal_24_filled, size: 24),
            ),

            ThemeSwitcher(
              builder: (context) {
                final isDarkTheme = theme.brightness == Brightness.dark;
                return FButton.icon(
                  onPress: () {
                    ThemeSwitcher.of(context).changeTheme(
                      theme: isDarkTheme
                          ? lightTheme.toTheme()
                          : darkTheme.toTheme(),
                      isReversed: !isDarkTheme,
                    );
                  },
                  child: Icon(
                    isDarkTheme
                        ? FluentIcons.weather_moon_24_filled
                        : FluentIcons.weather_sunny_24_filled,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class LogoutDialog {
  void show(BuildContext context) {
    showFDialog(
      context: context,
      builder: (context, style, animation) {
        return FDialog(
          direction: Axis.horizontal,
          title: Text('Вы хотите выйти из своей учетной записи?'),
          body: Text(
            'Некоторые действия могут быть прерваны из-за выхода из учетной системы',
          ),
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
                AutoRouter.of(context).replace(AuthRoute());
              },
              style: FButtonStyle.destructive(),
              child: Text('Выйти'),
            ),
          ],
        );
      },
    );
  }
}
