import 'package:sqlbrite/sqlbrite.dart';

class SQLException extends DatabaseException {
  String? message;
  SQLException(String? message) : super(message);

  @override
  int? getResultCode() {
    if (isSyntaxError()) {
      return 1;
    } else if (isReadOnlyError()) {
      return 8;
    } else {
      return null;
    }
  }

  @override
  Object? get result => getResultCode();
}
