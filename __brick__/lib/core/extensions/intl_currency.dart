import 'package:intl/intl.dart';

extension IntlCurrencyX on num {
  String get inMYR => NumberFormat.currency(locale: "ms_MY", symbol: "RM").format(this);
  String get inCompact => NumberFormat.compact().format(this);
}
