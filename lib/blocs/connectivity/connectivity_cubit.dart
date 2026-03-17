import 'dart:async';

import 'package:app/service/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker/talker.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(const ConnectivityOnline()) {
    _startHeartbeat();
  }

  Timer? _timer;
  final _talker = GetIt.I<Talker>();
  final _dio = Dio(
    BaseOptions(
      baseUrl: DioConfigure.url,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'Authorization': DioConfigure.authorization,
      },
      validateStatus: (status) => status == null || status < 500,
    ),
  );

  void _startHeartbeat() {
    _checkStatus();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _checkStatus();
    });
  }

  Future<void> _checkStatus() async {
    try {
      final response = await _dio.get('');
      if (response.statusCode != null && response.statusCode! < 500) {
        if (state is ConnectivityOffline) {
          _talker.info('Connectivity: Online (Status ${response.statusCode})');
          emit(const ConnectivityOnline());
        }
      } else {
        if (state is ConnectivityOnline) {
          _talker.warning('Connectivity: Offline (Status ${response.statusCode})');
          emit(const ConnectivityOffline());
        }
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode != null && e.response!.statusCode! < 500) {
        if (state is ConnectivityOffline) {
          _talker.info('Connectivity: Online (Status ${e.response!.statusCode})');
          emit(const ConnectivityOnline());
        }
      } else {
        if (state is ConnectivityOnline) {
          _talker.warning('Connectivity: Offline (DioException: ${e.message})');
          emit(const ConnectivityOffline());
        }
      }
    } catch (e) {
      if (state is ConnectivityOnline) {
        _talker.warning('Connectivity: Offline (Error: $e)');
        emit(const ConnectivityOffline());
      }
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
