import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'app/env.dart';
import 'app/helpers/app_router.dart';
import 'app/helpers/extentions.dart';
import 'app/modules/home/settings/reminder/model/reminder_model.dart';
import 'app/utils/app_constants.dart';
import 'app/utils/prefferences.dart';
import 'background_nt.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppPref.init();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(ReminderAdapter().typeId)) {
    Hive.registerAdapter(ReminderAdapter());
  }
  await BackgroundNt.init();
  await BackgroundNt.getToken();
  Stripe.publishableKey = Environments.stripePublishableKey;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppConstants().providers,
      builder: (context, child) => LayoutBuilder(
        builder: (context, constraints) => OrientationBuilder(
          builder: (context, orientation) {
            Responsive().init(constraints, orientation);
            return MaterialApp.router(
              title: 'Sophwe',
              debugShowCheckedModeBanner: false,
              routeInformationProvider:
                  AppRouter.router.routeInformationProvider,
              routeInformationParser: AppRouter.router.routeInformationParser,
              routerDelegate: AppRouter.router.routerDelegate,
            );
          },
        ),
      ),
    );
  }
}
