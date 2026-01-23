import 'package:app/blocs/blocs.dart';
import 'package:app/models/models.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:talker/talker.dart';

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
            _AuthFormSubmit(formKey: formKey, user: user, password: password),
          ],
        ),
      ),
    );
  }
}

class _AuthFormUserSelect extends StatelessWidget {
  const _AuthFormUserSelect(this.user);

  final ValueNotifier<UserScheme?> user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(context),
      builder: (context, state) {
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            return FSelect<UserScheme>.searchBuilder(
              label: Row(
                spacing: 4,
                children: [
                  Icon(
                    FluentIcons.person_24_regular,
                    size: 18,
                    color: theme.custom.foreground,
                  ),
                  Text('Сотрудник'),
                ],
              ),
              control: FSelectControl.managed(
                onChange: (value) {
                  user.value = value;
                },
              ),
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
                    .map((value) {
                      final lastUser = authState.lastUsers
                          .firstWhereLogTypeOrNull(
                            (i) => i.refKey == value.refKey,
                          );
                      return FSelectItem(
                        title: Text(value.description),
                        prefix: lastUser != null
                            ? Icon(
                                FluentIcons.star_24_filled,
                                color: theme.custom.secondaryAccent,
                              )
                            : null,
                        value: value,
                      );
                    })
                    .take(10)
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
                return authState.lastUsers;
              },
              hint: 'Выберите сотрудника',
              searchFieldProperties: FSelectSearchFieldProperties(
                hint: 'Поиск',
              ),
              contentEmptyBuilder: (context, style) {
                if (state is DataLoading) {
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
      },
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
        control: FTextFieldControl.managed(
          onChange: (value) {
            password.value = value.text;
          },
        ),
        label: Row(
          spacing: 4,
          children: [
            Icon(
              FluentIcons.key_24_regular,
              size: 18,
              color: theme.custom.foreground,
            ),
            Text('Пароль'),
          ],
        ),
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

class _AuthFormSubmit extends StatelessWidget {
  const _AuthFormSubmit({
    required this.formKey,
    required this.user,
    required this.password,
  });

  final GlobalKey<FormState> formKey;
  final ValueNotifier<UserScheme?> user;
  final ValueNotifier<String?> password;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    final theme = Theme.of(context);
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: cubit,
      builder: (context, state) {
        return Column(
          spacing: 8,
          children: [
            if (state is AuthInvalidPassword)
              Text(
                'Неправильный пароль',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: theme.custom.destructiveTextForeground,
                ),
              ),
            if (state is AuthFailure)
              Text(
                'Произашла сетевая ошибка',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: theme.custom.destructiveTextForeground,
                ),
              ),
            FButton(
              onPress: () {
                if ((formKey.currentState?.validate() ?? false) &&
                    (user.value != null) &&
                    (password.value?.isNotEmpty ?? false)) {
                  cubit.login(user: user.value!, password: password.value!);
                }
              },
              prefix: state is AuthLoading ? null : Icon(FIcons.logIn),
              child: state is AuthLoading ? FCircularProgress() : Text('Войти'),
            ),
          ],
        );
      },
    );
  }
}
