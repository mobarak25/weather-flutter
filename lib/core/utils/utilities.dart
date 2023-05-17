import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ImageFile {
  ImageFile({required this.name, required this.file});

  final String name;
  final XFile file;
}

String getDate(String dateData) {
  final date = DateTime.parse(dateData);
  final formatedDate = DateFormat('EEEE, MMM d, yyyy').format(date);
  return formatedDate;
}

String getDateByDay(String dateData) {
  final date = DateTime.parse(dateData);
  final formatedDate = DateFormat('d MMM').format(date);
  return formatedDate;
}

String getTime(String timeData) {
  final date = DateTime.parse(timeData);
  final formatedTime = DateFormat('j').format(date);
  return formatedTime;
}
