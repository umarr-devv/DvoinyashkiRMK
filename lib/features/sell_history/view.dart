import 'package:app/blocs/blocs.dart';
import 'package:app/features/sell_history/widgets/widgets.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';

@RoutePage()
class SellHistoryScreen extends StatefulWidget {
  const SellHistoryScreen({super.key});

  @override
  State<SellHistoryScreen> createState() => _SellHistoryScreenState();
}

class _SellHistoryScreenState extends State<SellHistoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChecksCubit>(context).update();
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: SellHistoryHeader(),
      footer: SellHistoryPagination(),
      child: SellHistoryTable(),
    );
  }
}
