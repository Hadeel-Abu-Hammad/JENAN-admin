import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenan_admin/features/auth/bloc/auth_bloc.dart';
import 'package:jenan_admin/features/auth/data/repos/auth_repo.dart';
import 'package:jenan_admin/features/auth/presentation/login_screen.dart';
import 'firebase_options.dart';

void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const JenanAdmin());
}

class JenanAdmin extends StatelessWidget {
  const JenanAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    AuthRepo _authRepo = AuthRepo();
    return BlocProvider(
      create: (BuildContext context) => AuthBloc(authRepo: _authRepo),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "ElMessiri",
        ),
        home: LoginScreen(),
      ),
    );
  }
}

