import 'package:app/blocs/withdraws/withdraws_cubit.dart';
import 'package:app/features/withdraw/widgets/total_info.dart';
import 'package:app/features/withdraw/widgets/widgets.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

@RoutePage()
class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WithdrawsCubit>(context).update(updateCash: true);
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: Column(
        crossAxisAlignment: .start,
        children: [WithdrawHeader(), WithdrawInfo()],
      ),
      footer: WithdrawPagination(),
      child: WithdrawTable(),
    );
  }
}
