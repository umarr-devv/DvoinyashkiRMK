import 'package:app/blocs/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      toolbarHeight: 64,
      pinned: true,
      floating: true,
      snap: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(),
        title: Text('Главная'),
        centerTitle: true,
      ),
      elevation: 8,
      actions: [
        IconButton(
          icon: const Icon(Icons.dark_mode),
          onPressed: () {
            BlocProvider.of<ThemeCubit>(context).toggleTheme();
          },
        ),
      ],
    );
  }
}
