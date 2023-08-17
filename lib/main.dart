import 'package:discuss_app/controller/c_explore.dart';
import 'package:discuss_app/controller/c_my_topic.dart';
import 'package:discuss_app/controller/c_user.dart';
import 'package:discuss_app/page/app_route.dart';
import 'package:discuss_app/page/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'controller/c_account.dart';
import 'controller/c_feed.dart';
import 'controller/c_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CUser()),
        ChangeNotifierProvider(create: (context) => CHome()),
        ChangeNotifierProvider(create: (context) => CFeed()),
        ChangeNotifierProvider(create: (context) => CExplore()),
        ChangeNotifierProvider(create: (context) => CMyTopic()),
        ChangeNotifierProvider(create: (context) => CAccount()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: primaryColor,
            colorScheme: const ColorScheme.light().copyWith(
              surface: primaryColor,
              primary: primaryColor,
              secondary: primaryColor,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: primaryColor,
              foregroundColor: whiteColor,
            )),
        routerConfig: AppRoute.routerConfig,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
