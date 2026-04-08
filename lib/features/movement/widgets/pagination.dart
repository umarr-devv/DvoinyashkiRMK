import 'package:app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

class MovementPagination extends StatelessWidget {
  const MovementPagination({super.key, required this.tabIndex});
  
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    if (tabIndex == 0) {
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
    } else {
      final cubit = BlocProvider.of<TransfersCubit>(context);
      return BlocBuilder<TransfersCubit, TransfersState>(
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
}
