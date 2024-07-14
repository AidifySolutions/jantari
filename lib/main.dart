import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jantari/router/app_router.dart';

// repositories
import 'package:jantari/repositories/product.dart';
import 'package:jantari/repositories/authentication.dart';
import 'package:jantari/repositories/meeting.dart';

// blocs
import 'bloc/homePage/bloc.dart';
import 'bloc/product/bloc.dart';
import 'bloc/auth/bloc.dart';
import 'bloc/meeting/bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Repository? repository;

  MyApp({Key? key}) : super(key: key) {
    // repository = Repository(networkService: NetworkService());
  }

  final AppRouter _appRouter = AppRouter();
  ProductRepository productRepository = ProductRepository();
  AuthenticationRepository authenticationRepository = AuthenticationRepository();
  MeetingRepository meetingRepository = MeetingRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(
              authenticationRepository: authenticationRepository
          ),
        ),
        BlocProvider<ProductBloc>(
          create: (BuildContext context) => ProductBloc(
              productRepository: productRepository
          ),
        ),
        BlocProvider<MeetingBloc>(
          create: (BuildContext context) => MeetingBloc(
              meetingRepository: meetingRepository
          ),
        ),
        BlocProvider<HomePageBloc>(
          create: (BuildContext context) => HomePageBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[200],
          fontFamily: 'OpenSans',
          inputDecorationTheme: buildInputDecorationTheme(),
          bottomSheetTheme:
              const BottomSheetThemeData(backgroundColor: Colors.transparent),
          colorScheme: const ColorScheme.light(primary: Color(0xFF6868fa))
              .copyWith(secondary: Colors.transparent).copyWith(secondary: Colors.black),
        ),
        onGenerateRoute: _appRouter.onGenerateRoute,
        // home: const Login(),
      ),
    );
  }

  InputDecorationTheme buildInputDecorationTheme() {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10)
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
            // color: CustomColors.customPrimaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10)
      ),
      disabledBorder:  const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
            color: Colors.grey,
            width: 2,
            strokeAlign: StrokeAlign.inside),
      ),
    );
  }
}
