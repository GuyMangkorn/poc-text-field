// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

// 1234..
// 12.313.323.
// 1,234.1232
// 123123...
// 123,1231,2,31
// 1123.1
// 1123.12
// dasda

///
/// *PASSED: กรณีที่เป็นการพิมพ์เอาล้วน ๆ
/// *PASSED: กรณีก็อปปี้มาแล้วมาวาง
///

class CustomCurrencyTextInputFormatter extends TextInputFormatter {
  int decimalLength = 0;
  CurrencyInputFormatter currencyFormatter = CurrencyInputFormatter();
  final RegExp _repeatingDecimal = RegExp(r'\.{2,}');
  final RegExp _illegalCharsRegexp = RegExp(r'[^0-9-,.]+');

  String _replaceDuplicateDecimal(String text) {
    return text.replaceAll(_repeatingDecimal, '.');
  }

  int _getDecimalLength(String decimalString) {
    int decimalIndex = decimalString.indexOf('.');
    return decimalIndex == -1 ? 0 : decimalString.length - decimalIndex - 1;
  }

  bool _checkValidDecimal(String value) {
    final listSplit = value.split('.');
    return listSplit.length <= 2;
  }

  bool _isDecimal(String value) {
    return value.contains('.');
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;
    final oldText = oldValue.text;
    final oldCaretIndex = max(oldValue.selection.start, oldValue.selection.end);
    final newCaretIndex = max(newValue.selection.start, newValue.selection.end);

    final isErasing = oldText.length > newText.length;
    final toNumeric = toNumericStringByRegex(newText, allowPeriod: true);

    // * Check is a valid string
    if (_illegalCharsRegexp.hasMatch(newText)) {
      debugPrint('RETURN 1');
      return oldValue;
    }

    final replaceDecimalText = _replaceDuplicateDecimal(newText);

    // * Check is a valid decimal index "."
    if (!_checkValidDecimal(replaceDecimalText)) {
      final parseDecimal =
          toNumericStringByRegex(replaceDecimalText, allowPeriod: true);
      debugPrint('RETURN 2 $parseDecimal');
      return oldValue;
    }

    if (!isErasing) {
      // * use enter "."
      if (replaceDecimalText.endsWith('.')) {
        debugPrint('RETURN 3');
        final replacedText = _replaceDuplicateDecimal(replaceDecimalText);
        return TextEditingValue(
          text: replaceDecimalText,
          selection: TextSelection.collapsed(offset: replacedText.length),
        );
      }

      // * เพิ่ม mantissaLength ตามค่าทศนิยม
      if (oldText.endsWith('.')) {
        decimalLength = 1;
      } else if (oldText.contains('.') &&
          _getDecimalLength(oldText) < 2 &&
          newCaretIndex == replaceDecimalText.length) {
        decimalLength = 2;
      }
    } else {
      // * ลด mantissaLength ตามค่าทศนิยม
      if (_isDecimal(replaceDecimalText) &&
          oldText.length - oldCaretIndex < _getDecimalLength(oldText)) {
        if (decimalLength > 0) decimalLength--;
      }

      if (replaceDecimalText.endsWith('.') && oldCaretIndex == oldText.length) {
        debugPrint('RETURN 4');
        currencyFormatter =
            CurrencyInputFormatter(mantissaLength: decimalLength);
        return currencyFormatter.formatEditUpdate(oldValue, newValue).copyWith(
            selection:
                TextSelection.collapsed(offset: replaceDecimalText.length - 1));
      }

      if (oldText.endsWith('.') && oldCaretIndex == oldText.length) {
        debugPrint('RETURN 5');
        return TextEditingValue(
          text: replaceDecimalText,
          selection: TextSelection.collapsed(offset: replaceDecimalText.length),
        );
      }
    }

    // * Case copy from clipboard
    if (_checkValidDecimal(toNumeric) &&
        decimalLength != _getDecimalLength(toNumeric)) {
      decimalLength = min(_getDecimalLength(toNumeric), 2);
      debugPrint('RETURN 6 decimalLength $decimalLength');
      currencyFormatter = CurrencyInputFormatter(mantissaLength: decimalLength);
      return currencyFormatter.formatEditUpdate(
        TextEditingValue(text: toNumeric.substring(0, toNumeric.length - 1), selection: newValue.selection),
        TextEditingValue(text: toNumeric, selection: newValue.selection),
      );
    }

    debugPrint('RETURN 7');
    currencyFormatter = CurrencyInputFormatter(mantissaLength: decimalLength);
    return currencyFormatter.formatEditUpdate(
        oldValue, newValue.copyWith(text: toNumeric));
  }
}
