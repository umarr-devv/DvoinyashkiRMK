import 'package:app/blocs/blocs.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Container();
  }
}
