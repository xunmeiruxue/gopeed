import 'package:flutter/services.dart';

/// A [TextInputFormatter] that restricts input to a numerical range between [min] and [max].
///
/// [max] is optional: leaving it null keeps only the lower bound, so values
/// such as connection counts can exceed any fixed ceiling.
class NumericalRangeFormatter extends TextInputFormatter {
  final int min;
  final int? max;

  NumericalRangeFormatter({required this.min, this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    var intVal = int.tryParse(newValue.text);
    if (intVal == null) {
      return oldValue;
    }
    final upper = max;
    if (intVal < min) {
      return newValue.copyWith(text: min.toString());
    } else if (upper != null && intVal > upper) {
      return oldValue.copyWith(text: upper.toString());
    } else {
      return newValue;
    }
  }
}
