import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'view/inicio.dart';
import 'bloc/treino_bloc.dart';
import 'data/treino_data_provider.dart';
import 'repo/treino_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bloc/auth_bloc.dart';
import 'data/auth_data_provider.dart';
import 'repo/auth_repository.dart';

void main() {
  final treinoDataProvider = TreinoDataProvider(dio: Dio());
  final treinoRepository = TreinoRepository(dataProvider: treinoDataProvider);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TreinoBloc(treinoRepository: treinoRepository),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authRepository: AuthRepository(
              authDataProvider: AuthDataProvider(dio: Dio()),
            ),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

//tome

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        /*home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(),
          ),
          BlocProvider(
            create: (_) => ProfileBloc(),
          ),
        ],
        child: BottomNavigationLayout(),
      ),*/

        home: Inicio());
  }
}
