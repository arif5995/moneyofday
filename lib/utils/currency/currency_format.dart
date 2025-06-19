import 'package:intl/intl.dart';


extension NumberExtension on num {
  String toKFormat() {
    if (this >= 1000) {
      double divided = this / 1000;
      if (divided == divided.roundToDouble()) {
        return '${divided.toInt()}k';
      } else {
        final formatter = NumberFormat('#.##'); // Adjust precision as needed
        return '${formatter.format(divided)}k';
      }
    }
    return toString();
  }
}

class CurrencyFormat {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  static String formatNumberToSpecificK(int number) {
    // Check if the number is large enough to be represented with 'k'
    // In your example 21,600,000, we'll divide by 1000.
    if (number >= 1000) {
      double valueInThousands = number / 1000;

      // Create a NumberFormat to handle thousand separators.
      // '###,##0' will ensure at least one digit before the comma and
      // handle thousand separators without showing decimals if not needed.
      // If you need exactly 3 decimal places always, even if they are zeros, use '###,##0.000'.
      final formatter =  NumberFormat.currency(
        locale: 'id',
        symbol: 'Rp ',
        decimalDigits: 0,
      ); // 'en_US' for comma as separator

      // Format the value and append 'k'
      return '${formatter.format(valueInThousands)}K';
    } else {
      // If the number is less than 1000, just return it as is.
      return CurrencyFormat.convertToIdr(number, 0);
    }
  }

  static String convertToIdrNoSymbol(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: '',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  // static String convertToNumber(dynamic) {
  //   TextDirection textDirection = TextDirection.
  // }
}