import 'package:intl/intl.dart';

extension IntlDateTimeX on DateTime {
  // 10/23/2024
  String get yMd => DateFormat.yMd().format(this);

  // July 16, 2024
  String get yMMMMd => DateFormat.yMMMMd().format(this);

  // Oct 2024
  String get yMMM => DateFormat.yMMM().format(this);

  // October 2024
  String get yMMMM => DateFormat.yMMMM().format(this);

  // Wed, Oct 23, 2024
  String get yMMMEd => DateFormat.yMMMEd().format(this);

  // Wednesday, October 23, 2024
  String get yMMMMEEEEd => DateFormat.yMMMMEEEEd().format(this);

  // 23/10/2024, 2.30 AM
  String get yMdhmma => DateFormat("dd/MM/yyyy, h:mm a").format(this);
}
