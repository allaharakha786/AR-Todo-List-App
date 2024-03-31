import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/bussinessLogics/blocs/hiveBloc/hive_bloc.dart';
import 'package:todo_app/bussinessLogics/blocs/hiveBloc/hive_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/helper/constants/colors_resources.dart';
import 'package:todo_app/helper/constants/dimentions_resources.dart';
import 'package:todo_app/helper/constants/screen_percentage.dart';
import 'package:todo_app/helper/constants/string_resources.dart';
import 'package:todo_app/helper/utills/text_style.dart';

// ignore: must_be_immutable
class DeleteItemAlertDialog extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var index;
  DeleteItemAlertDialog({super.key, required this.index});

  @override
  State<DeleteItemAlertDialog> createState() => _DeleteItemAlertDialogState();
}

class _DeleteItemAlertDialogState extends State<DeleteItemAlertDialog> {
  late HiveBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<HiveBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return AlertDialog(
      elevation: 0,
      backgroundColor: ColorsResources.WHITE_COLOR,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(DimensionsResource.RADIUS_DEFAULT),
              topRight: Radius.circular(DimensionsResource.RADIUS_DEFAULT))),
      insetPadding: const EdgeInsets.only(
          left: DimensionsResource.PADDING_SIZE_SMALL,
          right: DimensionsResource.PADDING_SIZE_SMALL),
      content: SizedBox(
        height: mediaQuerySize.height * ScreenPercentage.SCREEN_SIZE_19.h,
        width: mediaQuerySize.width * ScreenPercentage.SCREEN_SIZE_100.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              StringResources.DELETE_ITEM,
              style: TextStyles.titleStyle(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: DimensionsResource.PADDING_SIZE_LARGE,
                  right: DimensionsResource.PADDING_SIZE_LARGE),
              child: Text(
                StringResources.DELETE_ALERT,
                style: TextStyles.tileStyle(),
              ),
            ),
            const Spacer(),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(
                  left: DimensionsResource.PADDING_SIZE_EXTRA_LARGE,
                  right: DimensionsResource.PADDING_SIZE_EXTRA_LARGE),
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        StringResources.CANCEL,
                        style:
                            TextStyles.buttonStyle(ColorsResources.GREEN_COLOR),
                      )),
                  const Spacer(),
                  TextButton(
                      onPressed: () async {
                        await widget.index.delete();
                        bloc.add(GettingDataEvent());
                        Navigator.pop(context);
                      },
                      child: Text(StringResources.DELETE,
                          style: TextStyles.buttonStyle(
                              ColorsResources.RED_COLOR)))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
