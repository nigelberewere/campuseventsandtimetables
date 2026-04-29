import 'package:flutter/material.dart';
import 'pages/events.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/signup.dart';

const String loginRoute = '/login';
const String signupRoute = '/signup';
const String homeRoute = '/home';
const String eventsRoute = '/events';
const String landingRoute = '/landing';
const String timetablesRoute = '/timetables';
const String notificationsRoute = '/notifications';
const String profileRoute = '/profile';
const String adminRoute = '/admin';

void main() {
  runApp(const CampusEventsApp());
}

class CampusEventsApp extends StatelessWidget {
  const CampusEventsApp({super.key});

  @override
  Widget build(BuildContext context) {
    const amberSmoke = Color(0xFFF2E0D0);
    const blueMirage = Color(0xFF5E88B0);
    const fallbackBlueMirage = Color(0xFF5C6D7C);

    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: blueMirage,
          brightness: Brightness.light,
        ).copyWith(
          primary: blueMirage,
          secondary: fallbackBlueMirage,
          tertiary: amberSmoke,
          surface: const Color(0xFFFFFBF6),
        );

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'campuseventsandtimetables',
        initialRoute: loginRoute,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case loginRoute:
              return MaterialPageRoute(builder: (_) => const LoginPage());
            case signupRoute:
              return MaterialPageRoute(builder: (_) => const SignupPage());
            case homeRoute:
              return MaterialPageRoute(builder: (_) => const HomePage());
            case eventsRoute:
              return MaterialPageRoute(builder: (_) => const EventsPage());
            case landingRoute:
              return MaterialPageRoute(
                builder: (_) => const _PlaceholderPage(
                  title: 'Landing',
                  message: 'Landing page wiring is in place. Build this screen when ready.',
                ),
              );
            case timetablesRoute:
              return MaterialPageRoute(
                builder: (_) => const _PlaceholderPage(
                  title: 'Timetable',
                  message: 'Timetable page wiring is in place. Build this screen when ready.',
                ),
              );
            case notificationsRoute:
              return MaterialPageRoute(
                builder: (_) => const _PlaceholderPage(
                  title: 'Notifications',
                  message: 'Notifications page wiring is in place. Build this screen when ready.',
                ),
              );
            case profileRoute:
              return MaterialPageRoute(
                builder: (_) => const _PlaceholderPage(
                  title: 'Profile',
                  message: 'Profile page wiring is in place. Build this screen when ready.',
                ),
              );
            case adminRoute:
              return MaterialPageRoute(
                builder: (_) => const _PlaceholderPage(
                  title: 'Admin',
                  message: 'Admin page wiring is in place. Build this screen when ready.',
                ),
              );
            default:
              return MaterialPageRoute(builder: (_) => const LoginPage());
          }
        },
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: colorScheme,
          scaffoldBackgroundColor: const Color(0xFFFFFBF6),
          appBarTheme: const AppBarTheme(
            centerTitle: false,
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: fallbackBlueMirage,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFFF9F6F0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Color(0xFFE6D6C5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: blueMirage, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          ),
        ),
        home: const LoginPage(),
      );
    }
  }
 
  // Backwards-compatible wrapper for tests expecting `MyApp`.
  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) => const CampusEventsApp();
  }

  class _PlaceholderPage extends StatelessWidget {
    const _PlaceholderPage({required this.title, required this.message});

    final String title;
    final String message;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      );
    }
  }