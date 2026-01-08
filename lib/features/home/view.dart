import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/features/home/widgets/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [HomeAppBar(), SliverFillRemaining()]),
    );
  }
}
