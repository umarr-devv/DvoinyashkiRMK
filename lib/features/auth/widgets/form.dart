import 'package:app/shared/theme/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FCard(
      title: Text('Вход'),
      subtitle: Text('Введите данные для авторизации'),
      child: Form(
        child: Column(
          spacing: 16,
          children: [
            FSelect<String>.search(
              label: Row(
                spacing: 6,
                children: [
                  Icon(
                    FluentIcons.person_20_filled,
                    size: 20,
                    color: theme.custom.foreground,
                  ),
                  Text('Сотрудник'),
                ],
              ),
              searchFieldProperties: FSelectSearchFieldProperties(
                hint: 'Поиск',
              ),
              hint: 'Выберите сотрудника',
              items: {
                'Иван Иванов': '1',
                'Кирилл Баранов': '2',
                'Родрига Ло': '3',
                'Рикардо': '4',
                'Бенедикт': '5',
              },
            ),
            FTextFormField.password(
              label: Row(
                spacing: 6,
                children: [
                  Icon(
                    FluentIcons.key_20_filled,
                    size: 20,
                    color: theme.custom.foreground,
                  ),
                  Text('Пароль'),
                ],
              ),
              hint: 'Введите пароль',
            ),
            FButton(onPress: () {}, child: Text('Войти')),
          ],
        ),
      ),
    );
  }
}
