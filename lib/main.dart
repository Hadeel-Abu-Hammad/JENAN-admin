import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jenan_admin/core/constants/colors/app_colors.dart';
import 'package:jenan_admin/features/auth/bloc/auth_bloc.dart';
import 'package:jenan_admin/features/auth/data/repos/auth_repo.dart';
import 'package:jenan_admin/features/auth/presentation/screens/login_screen.dart';
import 'core/router/app_router.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const JenanAdmin());
}

class JenanAdmin extends StatelessWidget {
  const JenanAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    late  final AuthRepo authRepo = AuthRepo();
    late  final AuthBloc authBloc = AuthBloc(authRepo: authRepo)
      ..add(const AuthCheckEvent());
    return BlocProvider.value(
      value: authBloc,
      // create: (BuildContext context) => AuthBloc(authRepo: authRepo),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "ElMessiri",
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: lightGreen,
          ),
        ),
        locale: const Locale("ar"),
        supportedLocales: const [Locale("ar")],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: AppRouter.createRouter(authBloc),
      ),
    );
  }
}

