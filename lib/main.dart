import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../utils/bloc_observer.dart';
import '../utils/network/remote/dio_helper.dart';
import '../utils/styles/app_colors.dart';
import 'data/cache_helper.dart';
import 'ui/home/home_screen.dart';
import 'ui/init_load_screen.dart';
import 'utils/strings/app_preferences.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();

  Widget widget;

  bool? appDbLoaded =
      await CacheHelper.getPrefBool(SharedPrefKeys.appDatabaseLoaded);

  if (appDbLoaded != null)
    widget = HomeScreen();
  else
    widget = InitLoadScreen();

  runApp(
    MyApp(
      startWidget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
              ..loadHomeListView()
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Roboto',
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.baseColor, // status bar color
            brightness: Brightness.dark,
            elevation: 0,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
