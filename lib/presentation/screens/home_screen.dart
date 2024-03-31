import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:todo_app/bussinessLogics/blocs/hiveBloc/hive_bloc.dart';
import 'package:todo_app/bussinessLogics/blocs/hiveBloc/hive_events.dart';
import 'package:todo_app/bussinessLogics/blocs/hiveBloc/hive_states.dart';
import 'package:todo_app/helper/constants/colors_resources.dart';
import 'package:todo_app/helper/constants/dimentions_resources.dart';
import 'package:todo_app/helper/constants/image_resources.dart';
import 'package:todo_app/helper/constants/screen_percentage.dart';
import 'package:todo_app/helper/constants/string_resources.dart';
import 'package:todo_app/helper/enums/status_enum.dart';
import 'package:todo_app/helper/utills/add_item_dialog.dart';
import 'package:todo_app/helper/utills/delete_alert_dialog.dart';
import 'package:todo_app/helper/utills/edit_item_alert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/helper/utills/text_style.dart';
import 'package:todo_app/providerModel/hiveDataModel/hive_items.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isChecked = false;
  late HiveBloc bloc;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    bloc = BlocProvider.of<HiveBloc>(context);
    bloc.add(GettingDataEvent());
    controller.addListener(() {
      bloc.add(FilterDataEvent(controller: controller.text));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: ColorsResources.WHITE_COLOR,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const AddItemDialog(),
            );
          },
          child: const Icon(Icons.add)),
      appBar: AppBar(
        backgroundColor: ColorsResources.BACKGROUND_COLOR,
        leading: const Icon(Icons.menu),
        actions: [
          Padding(
            padding:
                const EdgeInsets.all(DimensionsResource.PADDING_SIZE_SMALL),
            child: CircleAvatar(
              backgroundImage: AssetImage(ImageResources.AVATAR_URL),
            ),
          )
        ],
      ),
      body: BlocListener<HiveBloc, HiveStates>(
        listener: (context, state) {
          if (state.states == StatusEnum.ERROR_STATE) {
            scaffold(StringResources.ERROR_MESSAGE);
          }

          if (state.states == StatusEnum.ADDED_STATE) {
            scaffold(StringResources.TODO_ITEM_ADDED);
          }
        },
        child: BlocBuilder<HiveBloc, HiveStates>(builder: (context, state) {
          return Container(
            height: mediaQuerySize.height,
            width: mediaQuerySize.width,
            color: ColorsResources.BACKGROUND_COLOR,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(
                    DimensionsResource.PADDING_SIZE_DEFAULT),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: mediaQuerySize.height *
                          ScreenPercentage.SCREEN_SIZE_7.h,
                      decoration: BoxDecoration(
                          color: ColorsResources.WHITE_COLOR,
                          borderRadius: BorderRadius.circular(
                              DimensionsResource.RADIUS_DEFAULT)),
                      child: TextFormField(
                        controller: controller,
                        decoration: InputDecoration(
                            hintText: StringResources.SEARCH,
                            hintStyle: TextStyles.tileStyle(),
                            prefixIcon: const Icon(
                              Icons.search,
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),
                    SizedBox(
                        height: mediaQuerySize.height *
                            ScreenPercentage.SCREEN_SIZE_6.h),
                    Text(StringResources.LIST_OF_TODO,
                        style: TextStyles.titleStyle()),
                    SizedBox(
                      height: mediaQuerySize.height *
                          ScreenPercentage.SCREEN_SIZE_2.h,
                    ),
                    state.items.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.items.length,
                              itemBuilder: (context, index) {
                                HiveItems value = state.items[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: DimensionsResource
                                          .PADDING_SIZE_SMALL),
                                  child: Container(
                                    height: mediaQuerySize.height *
                                        ScreenPercentage.SCREEN_SIZE_8.h,
                                    width: mediaQuerySize.width,
                                    decoration: BoxDecoration(
                                        color: ColorsResources.WHITE_COLOR,
                                        borderRadius: BorderRadius.circular(
                                            DimensionsResource.RADIUS_SMALL)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: DimensionsResource
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      child: ListTile(
                                          iconColor:
                                              ColorsResources.WHITE_COLOR,
                                          contentPadding: EdgeInsets.zero,
                                          leading: Checkbox(
                                            activeColor:
                                                ColorsResources.BLACK_COLOR,
                                            value: state.checkBoxes[index],
                                            onChanged: (value) {
                                              value!
                                                  ? scaffold(StringResources
                                                      .MARK_AS_DONE)
                                                  : scaffold(StringResources
                                                      .MARK_AS_UNDONE);
                                              bloc.add(CheckBoxEvent(
                                                  index: index, value: value));
                                            },
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: ColorsResources
                                                        .GREEN_COLOR,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            DimensionsResource
                                                                .RADIUS_SMALL)),
                                                height: mediaQuerySize.height *
                                                    ScreenPercentage
                                                        .SCREEN_SIZE_5.h,
                                                width: mediaQuerySize.height *
                                                    ScreenPercentage
                                                        .SCREEN_SIZE_5.h,
                                                child: FittedBox(
                                                  child: IconButton(
                                                      iconSize: 35,
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              EditItemDialog(
                                                            box: value,
                                                          ),
                                                        );
                                                      },
                                                      icon: const Center(
                                                          child: Icon(
                                                              Icons.edit))),
                                                ),
                                              ),
                                              SizedBox(
                                                width: mediaQuerySize.width *
                                                    ScreenPercentage
                                                        .SCREEN_SIZE_4.w,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: ColorsResources
                                                        .RED_COLOR,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            DimensionsResource
                                                                .RADIUS_SMALL)),
                                                height: mediaQuerySize.height *
                                                    ScreenPercentage
                                                        .SCREEN_SIZE_5.h,
                                                width: mediaQuerySize.height *
                                                    ScreenPercentage
                                                        .SCREEN_SIZE_5.h,
                                                child: FittedBox(
                                                  child: IconButton(
                                                      iconSize: 30,
                                                      onPressed: () async {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              DeleteItemAlertDialog(
                                                            index: value,
                                                          ),
                                                        );
                                                      },
                                                      icon: const Icon(
                                                          Icons.delete)),
                                                ),
                                              )
                                            ],
                                          ),
                                          title: state.checkBoxes[index]
                                              ? Text(
                                                  state.items[index].itemName,
                                                  style: TextStyle(
                                                      fontFamily:
                                                          StringResources
                                                              .POPPINE_LIGHT,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                )
                                              : Text(
                                                  state.items[index].itemName,
                                                  style: TextStyles.tileStyle(),
                                                )),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: Text(
                            StringResources.NO_ITEM,
                            style: TextStyles.tileStyle(),
                          ))
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  scaffold(String text) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(DimensionsResource.RADIUS_DEFAULT),
              topRight: Radius.circular(DimensionsResource.RADIUS_DEFAULT))),
      elevation: 0.0,
      content: Text(text, style: TextStyles.tileStyle()),
      backgroundColor: ColorsResources.BLUE_COLOR,
    ));
  }
}
