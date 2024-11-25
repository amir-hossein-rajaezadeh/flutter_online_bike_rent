import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_bike_shopping/cubit/app_cubit.dart';
import 'package:online_bike_shopping/models.dart';
import 'package:online_bike_shopping/screens/checkout_screen.dart';
import 'package:online_bike_shopping/screens/item_detail_screen.dart';
import 'package:online_bike_shopping/screens/main_screen.dart';
import 'package:online_bike_shopping/screens/shop_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/shop',
        builder: (context, state) => const ShoppingScreen(),
      ),
      GoRoute(
        path: '/item_detail',
        builder: (context, state) {
          final BikeModel bikeItem = state.extra as BikeModel;
          return ItemDetailScreen(
            bikeItem: bikeItem,
          );
        },
      ),
      GoRoute(
        path: '/checkout',
        builder: (context, state) => const CheckOutScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: MaterialApp.router(
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
