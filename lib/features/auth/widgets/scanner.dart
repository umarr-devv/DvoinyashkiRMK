import 'package:app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker/talker.dart';

class AuthScanner extends StatelessWidget {
  const AuthScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCubit, DataState>(
      bloc: BlocProvider.of<DataCubit>(context),
      builder: (context, state) {
        return BarcodeKeyboardListener(
          onBarcodeScanned: (value) async {
            if (value.length <= 2){
              return;
            }
            final user = state.users.firstWhereLogTypeOrNull(
              (i) => i.barcode == value,
            );
            if (user != null) {
              BlocProvider.of<AuthCubit>(
                context,
              ).login(user: user, password: value);
            }
          },
          child: SizedBox(),
        );
      },
    );
  }
}
