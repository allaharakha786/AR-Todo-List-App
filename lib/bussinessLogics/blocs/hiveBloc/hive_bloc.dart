import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/bussinessLogics/blocs/hiveBloc/hive_events.dart';
import 'package:todo_app/bussinessLogics/blocs/hiveBloc/hive_states.dart';
import 'package:todo_app/helper/enums/status_enum.dart';
import 'package:todo_app/providerModel/hiveDataModel/hive_items.dart';

class HiveBloc extends Bloc<HiveEvents, HiveStates> {
  late List<bool> checkBox;

  HiveBloc() : super(HiveStates()) {
    on<AddingDataEvent>(addDataMethod);
    on<GettingDataEvent>(gettingDataMethod);
    on<EditDataEvent>(editDataMethod);
    on<FilterDataEvent>(filterDataMethod);
    on<CheckBoxEvent>(checkBoxMethod);
  }

  addDataMethod(AddingDataEvent event, Emitter<HiveStates> emit) async {
    try {
      var box = await Hive.openBox<HiveItems>('items');

      HiveItems items = HiveItems(itemName: event.item);
      await box.add(items);
      emit(state.copyWith(states: StatusEnum.ADDED_STATE));
    } catch (e) {
      emit(state.copyWith(states: StatusEnum.ERROR_STATE));
    }
  }

  editDataMethod(EditDataEvent event, Emitter<HiveStates> emit) async {
    try {
      event.box.itemName = event.controller.text.toString();
      event.box.save();
    } catch (e) {
      emit(state.copyWith(states: StatusEnum.ERROR_STATE));
    }
  }

  checkBoxMethod(CheckBoxEvent event, Emitter<HiveStates> emit) async {
    try {
      checkBox[event.index] = event.value;
      emit(state.copyWith(
          checkBoxes: checkBox, states: StatusEnum.CHECKBOX_STATE));
    } catch (e) {
      emit(state.copyWith(states: StatusEnum.ERROR_STATE));
    }
  }

  filterDataMethod(FilterDataEvent event, Emitter<HiveStates> emit) async {
    try {
      var box = await Hive.openBox<HiveItems>('items');
      List<HiveItems> values = box.values
          .where(
              (item) => item.itemName.toLowerCase().contains(event.controller))
          .toList();
      emit(state.copyWith(items: values));
    } catch (e) {
      emit(state.copyWith(states: StatusEnum.ERROR_STATE));
    }
  }

  gettingDataMethod(GettingDataEvent event, Emitter<HiveStates> emit) async {
    try {
      var box = await Hive.openBox<HiveItems>('items');
      List<HiveItems> values = box.values.toList();
      checkBox = List.generate(values.length, (index) => false);
      emit(state.copyWith(
          items: values,
          checkBoxes: checkBox,
          states: StatusEnum.INITIAL_STATE));
    } catch (e) {
      emit(state.copyWith(states: StatusEnum.ERROR_STATE));
    }
  }
}
