import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/helper/constants/colors_resources.dart';
import 'package:todo_app/helper/constants/dimentions_resources.dart';
import 'package:todo_app/helper/constants/screen_percentage.dart';
import 'package:todo_app/helper/constants/string_resources.dart';
import 'package:todo_app/helper/utills/text_style.dart';
import 'package:todo_app/providerModel/hiveDataModel/hive_items.dart';
import 'package:todo_app/bussinessLogics/blocs/hiveBloc/hive_events.dart';

// ignore: must_be_immutable
class EditItemDialog extends StatefulWidget {
  HiveItems box;
  EditItemDialog({super.key, required this.box});

  @override
  State<EditItemDialog> createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    controller.addListener(() {
      widget.box.itemName = controller.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.text = widget.box.itemName;
    Size mediaQuerySize = MediaQuery.of(context).size;
    return AlertDialog(
      elevation: 0,
      backgroundColor: ColorsResources.BACKGROUND_COLOR,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(DimensionsResource.RADIUS_DEFAULT),
            topRight: Radius.circular(DimensionsResource.RADIUS_DEFAULT)),
      ),
      insetPadding: const EdgeInsets.only(
          left: DimensionsResource.PADDING_SIZE_SMALL,
          right: DimensionsResource.PADDING_SIZE_SMALL),
      content: SizedBox(
          height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_22.h,
          width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  StringResources.EDIT_ALERT,
                  style: TextStyles.titleStyle(),
                ),
                TextFormField(
                  style: TextStyles.tileStyle(),
                  controller: controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return StringResources.EMPTY_FIELD;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorsResources.WHITE_COLOR,
                      contentPadding: const EdgeInsets.all(
                          DimensionsResource.PADDING_SIZE_DEFAULT),
                      hintText: StringResources.EDIT_ITEM,
                      hintStyle: TextStyles.tileStyle(),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      )),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(0),
                        backgroundColor: MaterialStatePropertyAll(
                            ColorsResources.WHITE_COLOR)),
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        EditDataEvent(box: widget.box, controller: controller);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      StringResources.SAVE_CHANGES,
                      style:
                          TextStyles.buttonStyle(ColorsResources.BLACK_COLOR),
                    ))
              ],
            ),
          )),
    );
  }
}
