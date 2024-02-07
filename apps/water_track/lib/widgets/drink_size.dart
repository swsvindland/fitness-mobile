import 'package:flutter/material.dart';
import 'package:models/preferences.dart';
import 'package:provider/provider.dart';

class DrinkSize extends StatefulWidget {
  const DrinkSize({super.key});

  @override
  State<DrinkSize> createState() => _DrinkSizeState();
}

class _DrinkSizeState extends State<DrinkSize> {
  double _currentSliderValue = 12;

  @override
  Widget build(BuildContext context) {
    var preferences = Provider.of<Preferences>(context);

    double max = preferences.unit == 'imperial' ? 48 : 1500;
    var divisions = preferences.unit == 'imperial' ? 12 : 30;

    _currentSliderValue = preferences.drinkSize.toDouble();

    return Column(
      children: [
        const SizedBox(height: 16),
        Text('Drink Size: ${_currentSliderValue.round()} ${preferences.unit == 'imperial' ? 'oz' : 'ml'}'),
        Slider(
          value: _currentSliderValue,
          max: max,
          divisions: divisions,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });

            preferences.setDrinkSize(value.round());
          },
        ),
      ],
    );
  }
}
