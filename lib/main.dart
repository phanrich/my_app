import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/bloc/login/login_account_bloc.dart';
import 'package:my_app/bloc/task/task_bloc.dart';
import 'package:my_app/repository/auth_repository.dart';
import 'package:my_app/screens/login/login_screen.dart';
import 'package:my_app/utils/app_router.dart';
import 'bloc/app/app_bloc.dart';
import 'bloc/theme/app_theme_bloc.dart';
import 'models/task.dart';
import 'utils/app_theme.dart';

import 'screens/dashboard/dashboard_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  final authRepository = AuthRepository();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  // whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();

  runApp(MyApp(
    authRepository: authRepository,
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {Key? key, this.appRouter, required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(key: key);
  final AppRouter? appRouter;
  final AuthRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppThemeBloc(),
          ),
          BlocProvider(
            create: (context) => TaskBloc(),
          ),
          BlocProvider(
            create: (context) => AppBloc(authRepository: _authRepository),
          ),
          BlocProvider(
            create: (context) => LoginAccountBloc(LoginAccountInitialState()),
          ),
        ],
        child: ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return BlocBuilder<AppThemeBloc, AppThemeState>(
                  builder: (context, state) {
                return MaterialApp(
                  title: 'My App',
                  debugShowCheckedModeBanner: false,
                  theme: state.isDark
                      ? appThemeData[AppTheme.dark]
                      : appThemeData[AppTheme.light],
                  home: const LoginScreen(),
                  onGenerateRoute: appRouter!.onGenerateRoute,
                );
              });
            }));
  }
}
