import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/bussinessLogics/blocs/hiveBloc/hive_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/presentation/screens/splash_screen.dart';
import 'package:todo_app/providerModel/hiveDataModel/hive_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.openBox<HiveItems>('items');
  Hive.registerAdapter(HiveItemsAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: Size(mediaQuerySize.width, mediaQuerySize.height),
      builder: (context, child) => BlocProvider(
        create: (context) => HiveBloc(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false, home: const SplashScreen()),
      ),
    );
  }
}
