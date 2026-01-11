import 'package:app/blocs/blocs.dart';
import 'package:app/models/models.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final formKey = GlobalKey<FormState>();

  final user = ValueNotifier<UserScheme?>(null);
  final password = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return FCard(
      title: Text('Вход'),
      subtitle: Text('Введите данные для авторизации'),
      child: Form(
        key: formKey,
        child: Column(
          spacing: 16,
          children: [
            _AuthFormUserSelect(user),
            _AuthFormUserPassword(password),
            FButton(
              onPress: () {
                if (formKey.currentState?.validate() ?? false) {}
                // AutoRouter.of(context).replace(MenuRoute());
              },
              child: Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthFormUserPassword extends StatelessWidget {
  const _AuthFormUserPassword(this.password);

  final ValueNotifier<String> password;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: FTextFormField.password(
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
        onSaved: (value) {
          if (value != null) {
            password.value = value;
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Необходимо ввести пароль';
          }
          return null;
        },
        hint: 'Введите пароль',
      ),
    );
  }
}

class _AuthFormUserSelect extends StatelessWidget {
  const _AuthFormUserSelect(this.user);

  final ValueNotifier<UserScheme?> user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      bloc: BlocProvider.of<UsersCubit>(context),
      builder: (context, state) {
        return FSelect<UserScheme>.searchBuilder(
          validator: (value) {
            if (value == null) {
              return 'Необходимо выбрать сотрудика';
            }
            return null;
          },
          onSaved: (value) {
            user.value = value;
          },
          contentBuilder: (context, query, values) {
            return values
                .map(
                  (value) =>
                      FSelectItem(title: Text(value.description), value: value),
                )
                .take(5)
                .toList();
          },
          format: (value) => value.description,
          filter: (query) {
            if (query.isNotEmpty) {
              return state.users
                  .where(
                    (user) => user.description.toLowerCase().contains(
                      query.toLowerCase(),
                    ),
                  )
                  .toList();
            }
            return [];
          },
          hint: 'Выберите сотрудника',
          searchFieldProperties: FSelectSearchFieldProperties(hint: 'Поиск'),
          contentEmptyBuilder: (context, style) {
            if (state is UsersLoading) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: FCircularProgress(),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text('Ничего не найдено'),
              );
            }
          },
        );
      },
    );
  }
}
