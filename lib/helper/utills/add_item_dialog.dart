import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/bussinessLogics/blocs/hiveBloc/hive_bloc.dart';
import 'package:todo_app/bussinessLogics/blocs/hiveBloc/hive_events.dart';
import 'package:todo_app/helper/constants/colors_resources.dart';
import 'package:todo_app/helper/constants/dimentions_resources.dart';
import 'package:todo_app/helper/constants/screen_percentage.dart';
import 'package:todo_app/helper/constants/string_resources.dart';
import 'package:todo_app/helper/utills/text_style.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({
    super.key,
  });

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  late HiveBloc bloc;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    bloc = BlocProvider.of<HiveBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(DimensionsResource.RADIUS_DEFAULT),
            topRight: Radius.circular(DimensionsResource.RADIUS_DEFAULT)),
      ),
      backgroundColor: ColorsResources.BACKGROUND_COLOR,
      elevation: 0.0,
      insetPadding: const EdgeInsets.only(
          left: DimensionsResource.PADDING_SIZE_SMALL,
          right: DimensionsResource.PADDING_SIZE_SMALL),
      content: SizedBox(
          height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_21.h,
          width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  StringResources.NEW_TODO_ITEM,
                  style: TextStyles.titleStyle(),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return StringResources.EMPTY_FIELD;
                    }
                    return null;
                  },
                  controller: controller,
                  style: TextStyles.tileStyle(),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorsResources.WHITE_COLOR,
                      hintStyle: TextStyles.tileStyle(),
                      contentPadding: const EdgeInsets.all(
                          DimensionsResource.PADDING_SIZE_SMALL),
                      hintText: StringResources.ADD_ITEM,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(
                              DimensionsResource.RADIUS_DEFAULT)),
                          borderSide: BorderSide.none)),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(0),
                        backgroundColor: MaterialStatePropertyAll(
                            ColorsResources.WHITE_COLOR)),
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        bloc.add(AddingDataEvent(item: controller.text));
                        bloc.add(GettingDataEvent());
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      StringResources.ADD,
                      style:
                          TextStyles.buttonStyle(ColorsResources.BLACK_COLOR),
                    ))
              ],
            ),
          )),
    );
  }
}
