import 'package:app/data/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

class ThemeCubit extends Cubit<bool?> {
  ThemeCubit() : super(null);

  final storage = GetIt.I<GeneralStorage>();

  void init() {
    final isDarkMode = storage.getValue(GeneralStorageKey.isDarkMode) ?? false;
    emit(isDarkMode);
  }

  Future toggleTheme() async {
    final currentTheme = state ?? false;
    await storage.setValue(GeneralStorageKey.isDarkMode, !currentTheme);
    emit(!currentTheme);
  }
}
