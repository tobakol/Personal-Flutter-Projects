
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  String? name;
  String? id;
  Place({this.name,}):id = uuid.v4();
}
//thinking of adding id by generating random string and adding
//to a list, 10 digits, if id is in list, generate another