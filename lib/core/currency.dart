import 'package:intl/intl.dart';

class Currency {
  Currency._();

  static String setPrice(
      {String value, String currency = 'Rp. ', String errorMessage}) {
    final currencys = new NumberFormat("#,##0", "en_US");
    var valid = int.tryParse(value);
    if (valid == null) {
      return value;
    } else {
      String result = currency + currencys.format(valid);
      return result;
    }
  }

  static int decodePrice({String value}) {
    final currencys = value.replaceAll('Rp. ', '').replaceAll(',', '');
    int result = int.parse(currencys);
    return result;
  }
}
