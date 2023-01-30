import '../../main_index.dart';

final BorderRadius radius = BorderRadius.circular(6.0);

final ThemeData kAppTheme = ThemeData(
  primaryColor: kPrimaryDark,
  primaryColorLight: kPrimaryDark,
  primaryColorDark: kPrimaryDark,
  disabledColor: kGreyColor,
  splashColor: kPrimaryDark,
  //-----
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kPrimaryDark,
    focusColor: kPrimaryDark,
  ),
  //------------
  cardTheme: const CardTheme(
    color: kPrimaryLight,
    shadowColor: kPrimaryDark,
  ),
  //---------
  appBarTheme: const AppBarTheme(
    color: kPrimaryDark,
    centerTitle: true,
    shadowColor: kPrimaryDark,
    actionsIconTheme: IconThemeData(color: kPrimaryDark),
    elevation: 0,
    titleTextStyle: TextStyle(
        color: kPrimaryDark, fontSize: 18
    ),
    iconTheme:
    IconThemeData(color: kPrimaryDark, size: 22),
  ),
  //----------
  buttonTheme: const ButtonThemeData(
    shape: StadiumBorder(),
    disabledColor: kGreyColor,
    buttonColor: kPrimaryDark,
    splashColor: kPrimaryDark,
  ),
  //--------------
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          color: kPrimaryLight,
          fontSize: 16,
        ),

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16))),
  ),

  //------------------
  textTheme: const TextTheme(
    displayLarge: kTextExtraBold,
    headlineLarge: kTextLabel,
    titleMedium: kTextMedium,

    bodyLarge: kTextMedium,
    bodySmall: kTextRegular,
  ),
  //-------------
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(20),
    hintStyle: kTextRegular.copyWith(color: kGreyColor),
    labelStyle: kTextLabelNormal,
    errorStyle: kTextRegular,
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: kPrimaryDark,
      ),
      borderRadius: BorderRadius.circular(2),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 5,
      ),
      borderRadius: BorderRadius.circular(2),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: kErrorColor),
      borderRadius: BorderRadius.circular(2),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: kPrimaryDark),
      borderRadius: BorderRadius.circular(2),
    ),
  ),
  //-----------
);

final kAppTheme2 =    ThemeData(
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: const MaterialColor(
      0xff1e866f,
      <int, Color>{
        50: Color(0xff1e866f),
        100: Color(0xff1e866f),
        200: Color(0xff1e866f),
        300: Color(0xff1e866f),
        400: Color(0xff1e866f),
        500: Color(0xff1e866f),
        600: Color(0xff1e866f),
        700: Color(0xff1e866f),
        800: Color(0xff1e866f),
        900: Color(0xff1e866f),
      },
    ),
    hoverColor: kPrimaryDark,
    buttonColor: kPrimaryDark,
    focusColor: Colors.amber);
