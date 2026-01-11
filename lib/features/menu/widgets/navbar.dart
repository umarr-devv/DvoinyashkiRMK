import 'dart:typed_data';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/blocs/auth/auth_cubit.dart';
import 'package:app/core/router/router.dart';
import 'package:app/features/menu/dialogs/dialogs.dart';
import 'package:app/models/user.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          Expanded(child: _NavBarTabs()),
          _MenuNavBarUser(),
        ],
      ),
    );
  }
}

class _NavBarTabs extends StatelessWidget {
  const _NavBarTabs();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
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
      ),
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
            color: active ? theme.custom.secondaryAccent : theme.custom.muted,
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
        return BlocConsumer<AuthCubit, AuthState>(
          bloc: BlocProvider.of<AuthCubit>(context),
          listener: (context, state) {
            if (state is AuthLoggedOut) {
              AutoRouter.of(context).replace(AuthRoute());
            }
          },
          builder: (context, state) {
            if (state.user != null) {
              final user = state.user!;
              return Row(
                spacing: 12,
                children: [
                  _UserAvatar(user: user),
                  _UserInfo(user: user),
                  FButton.icon(
                    onPress: controller.toggle,
                    style: FButtonStyle.ghost(),
                    child: Icon(
                      FluentIcons.more_horizontal_24_filled,
                      size: 24,
                    ),
                  ),
                  _ThemeSwitchButton(),
                ],
              );
            } else {
              return SizedBox();
            }
          },
        );
      },
    );
  }
}

class _ThemeSwitchButton extends StatelessWidget {
  const _ThemeSwitchButton();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ThemeSwitcher(
      builder: (context) {
        final isDarkTheme = theme.brightness == Brightness.dark;
        return FButton.icon(
          onPress: () {
            ThemeSwitcher.of(context).changeTheme(
              theme: isDarkTheme ? lightTheme.toTheme() : darkTheme.toTheme(),
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
    );
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo({required this.user});

  final DetailUserScheme user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.description,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: theme.custom.foreground,
          ),
        ),
        if (user.jobTitle?.isNotEmpty ?? false)
          Text(
            user.jobTitle!,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: theme.custom.mutedForeground,
            ),
          ),
      ],
    );
  }
}

class _UserAvatar extends StatefulWidget {
  const _UserAvatar({required this.user});

  final DetailUserScheme user;

  @override
  State<_UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<_UserAvatar> {
  Uint8List? imageBytes;

  @override
  void initState() {
    imageBytes = widget.user.imageBytes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FAvatar.raw(
      child: imageBytes?.isNotEmpty ?? false
          ? Image.memory(imageBytes!, fit: BoxFit.cover, height: 48, width: 48)
          : Icon(FluentIcons.person_24_regular),
    );
  }
}
