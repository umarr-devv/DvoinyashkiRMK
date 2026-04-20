import 'package:app/blocs/blocs.dart';
import 'package:app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:scaled_app/scaled_app.dart';

class ScaleSlider extends StatelessWidget {
  const ScaleSlider({super.key});

  double sliderToPercent(double value) {
    return (75 + value * 50) / 100;
  }

  double percentToSlider(double percent) {
    return (percent * 100 - 75) / 50;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<SettingsCubit>(context);
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return SizedBox(
          width: 420,
          child: Row(
            spacing: 12,
            children: [
              Expanded(
                child: FSlider(
                  label: Text('Масштаб'),
                  control: FSliderControl.managedDiscrete(
                    initial: FSliderValue(max: percentToSlider(state.scale)),
                    onChange: (value) {
                      cubit.setSettings(scale: sliderToPercent(value.max));
                    },
                  ),
                  tooltipBuilder: (controller, value) {
                    return Text(
                      '${(sliderToPercent(value) * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: theme.custom.foreground,
                      ),
                    );
                  },
                  marks: const [
                    FSliderMark(value: 0, label: Text('75%')),
                    FSliderMark(value: 0.1),
                    FSliderMark(value: 0.2),
                    FSliderMark(value: 0.3),
                    FSliderMark(value: 0.4),
                    FSliderMark(value: 0.5, label: Text('100%')),
                    FSliderMark(value: 0.6),
                    FSliderMark(value: 0.7),
                    FSliderMark(value: 0.8),
                    FSliderMark(value: 0.9),
                    FSliderMark(value: 1, label: Text('125%')),
                  ],
                ),
              ),
              FButton.icon(
                onPress: () {
                  ScaledWidgetsFlutterBinding.instance.scaleFactor = (size) =>
                      state.scale;
                },
                child: Icon(Icons.restart_alt),
              ),
            ],
          ),
        );
      },
    );
  }
}
