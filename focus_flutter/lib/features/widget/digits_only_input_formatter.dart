import 'package:flutter/services.dart';

/// Formats digits only text input.
class DigitOnlyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final value = newValue.text;
    final number = (int.tryParse(value) ?? 0).toString();
    return TextEditingValue(
      text: number,
      selection: TextSelection(
        baseOffset: number.length,
        extentOffset: number.length,
      ),
    );
  }
}
