import 'package:contacts/provider.dart';

class Contacts {
  int? id;
  late String name;
  late String number;
  late String image;

  Contacts({
    this.id,
    required this.name,
    required this.number,
    required this.image,
  });

  Contacts.fromMap(Map<String, dynamic> map) {
    if (map[columnId] != null) id = map[columnId];
    name = map[columnName];
    number = map[columnNumber];
    image = map[columnImage];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    if (id != null) map[columnId] = id;
    map[columnName] = name;
    map[columnNumber] = number;
    map[columnImage] = image;
    return map;
  }
}
