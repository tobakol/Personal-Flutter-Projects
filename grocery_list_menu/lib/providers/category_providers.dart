import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/categories.dart';

final categoryProvider=Provider((ref){
  return categories;
});