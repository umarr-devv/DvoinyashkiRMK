import 'package:app/blocs/blocs.dart';
import 'package:app/client/client.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker/talker.dart';

part 'transfers_state.dart';

class TransfersCubit extends Cubit<TransfersState> {
  TransfersCubit(this.settingsCubit) : super(const TransfersInitial());

  final SettingsCubit settingsCubit;
  final client = GetIt.I<RestClient>();
  final talker = GetIt.I<Talker>();

  StructureUnitScheme? get store => settingsCubit.state.store;

  Future update() async {
    if (store == null) return;
    if (state is TransfersLoading) return;
    emit(TransfersLoading(state));
    try {
      final Map<String, dynamic> params = {
        '\$top': state.limit.toString(),
        '\$skip': state.offset.toString(),
        '\$filter':
            'СтруктурнаяЕдиницаПолучатель_Key eq guid\'${store!.refKey}\'',
        '\$orderby': 'Date desc',
        '\$format': 'json',
      };

      final response = await client.getTransfer(
        fullPath: buildODataQuery(params),
      );
      final newState = state.copyWith(
        transfers: response.value,
      );
      emit(TransfersLoaded(newState));
    } catch (exc, st) {
      talker.error(exc, st);
      emit(TransfersFailure(state));
    }
  }

  Future setPageNum(int pageNum) async {
    if (pageNum == state.pageNum) return;
    final newState = state.copyWith(pageNum: pageNum);
    emit(TransfersUpdate(newState));
    await update();
  }
}
