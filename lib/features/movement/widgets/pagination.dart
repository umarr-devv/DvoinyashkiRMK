import 'package:app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class MovementPagination extends StatelessWidget {
  const MovementPagination({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MovementsCubit>(context);
    return BlocBuilder<MovementsCubit, MovementsState>(
      bloc: cubit,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 12),
          child: FPagination(
            control: FPaginationControl.managed(
              pages: 100,
              initial: state.pageNum,
              showEdges: true,
              siblings: 4,
              onChange: (page) {
                cubit.setPageNum(page);
              },
            ),
          ),
        );
      },
    );
  }
}
