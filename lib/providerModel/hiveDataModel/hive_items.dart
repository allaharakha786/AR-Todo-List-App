import 'package:hive/hive.dart';
part 'hive_items.g.dart';

@HiveType(typeId: 0)
class HiveItems extends HiveObject {
  @HiveField(0)
  String itemName;
  HiveItems({required this.itemName});
}
