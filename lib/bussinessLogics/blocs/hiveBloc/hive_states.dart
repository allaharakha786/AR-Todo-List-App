import 'package:todo_app/helper/enums/status_enum.dart';
import 'package:todo_app/providerModel/hiveDataModel/hive_items.dart';

class HiveStates {
  StatusEnum states;
  List<HiveItems> items;
  List<bool> checkBoxes;
  HiveStates(
      {this.states = StatusEnum.INITIAL_STATE,
      this.items = const [],
      this.checkBoxes = const []});

  HiveStates copyWith(
      {StatusEnum? states, List<HiveItems>? items, List<bool>? checkBoxes}) {
    return HiveStates(
        items: items ?? this.items,
        states: states ?? this.states,
        checkBoxes: checkBoxes ?? this.checkBoxes);
  }

  List<Object>? get props => [states, items, checkBoxes];
}
