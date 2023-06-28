import 'widgets/expenses.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.green); // using the fromSeed method creates a color palatte for the overall all from 1 color
var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,// this tells the method that we are creating a palatte for dark mode
    seedColor: const Color.fromARGB(255, 26, 93, 30));
void main(List<String> args) {
  // this is widget locks the device orientation in place


  // WidgetsFlutterBinding.ensureInitialized();
  // this method is to lock the system orientation
  // how can this app be viewd in everyones phones
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]) // it ensure that the app only renders in PortrainUP mode
  //     .then((value) {
    runApp(
      MaterialApp(
        // in the material app using theme properties to set the normal and dark mode themes
        darkTheme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: kDarkColorScheme,
          // setting the general stlying for the Card widget
          cardTheme: const CardTheme().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          // setting the general stlying for the ElevatedButton Widget
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer, // using the color from the seedColor
              foregroundColor: kDarkColorScheme.onPrimaryContainer,
            ),
          ),
        ),
        theme: ThemeData().copyWith( // this copywith method helps keeping the normal material ui styling + our own styling
          useMaterial3: true,
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimaryContainer,
              foregroundColor: kColorScheme.primaryContainer,
              ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
              foregroundColor: kColorScheme.onPrimaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 16,
                ),
              ),
        ),
        debugShowCheckedModeBanner: false,
        home: const Expenses(),
      ),
    );
  // }
  // );
}
