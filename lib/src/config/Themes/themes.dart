import '../../main_index.dart';

final BorderRadius radius = BorderRadius.circular(6.0);

final ThemeData kAppTheme = ThemeData(
  fontFamily: 'ProductSans',
  scaffoldBackgroundColor: secondaryColor,
  primaryColor: kPrimary,
  backgroundColor: darkColor,
  disabledColor: Colors.grey[300],
  dividerColor: Color(0xfff6f8fa),
  hintColor: Color(0xffc7c7c7),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: mainColor,
    foregroundColor: secondaryColor,
  ),

  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom()),

  ///appBar theme
  appBarTheme: AppBarTheme(
    textTheme: TextTheme(
      headline6: TextStyle(
          fontSize: 20.0,
          color: secondaryColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'ProductSans'),
    ),
    color: mainColor,
    iconTheme: IconThemeData(color: secondaryColor),
    elevation: 0.0,
  ),

  ///text theme
  textTheme: TextTheme(
    caption: TextStyle(color: disabledTextColor),
    button: TextStyle(fontSize: 16.0, letterSpacing: 1, color: secondaryColor),
    bodyText1: kTextMedium,
    subtitle1: TextStyle(),
    subtitle2: TextStyle(color: Color(0xff9c9c9c), fontWeight: FontWeight.w400),
    bodyText2: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    headline6: TextStyle(fontWeight: FontWeight.bold),
    overline: TextStyle(color: secondaryColor, letterSpacing: 1),
  ),
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
    hoverColor: kPrimary,
    buttonColor: kPrimary,
    focusColor: Colors.amber);
