import 'package:flutter/material.dart';
import 'package:todo_app/providerModel/hiveDataModel/hive_items.dart';

class HiveEvents {}

class AddingDataEvent extends HiveEvents {
  String item;
  AddingDataEvent({required this.item});
}

class GettingDataEvent extends HiveEvents {}

class FilterDataEvent extends HiveEvents {
  String controller;
  FilterDataEvent({required this.controller});
}

class CheckBoxEvent extends HiveEvents {
  int index;
  bool value;
  CheckBoxEvent({required this.index, required this.value});
}

class EditDataEvent extends HiveEvents {
  HiveItems box;
  TextEditingController controller;
  EditDataEvent({required this.box, required this.controller});
}
