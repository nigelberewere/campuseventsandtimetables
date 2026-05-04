import 'package:campuseventsandtimetables/pages/landing.dart';
import 'package:flutter/material.dart';
import 'pages/admin.dart';
import 'pages/events.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/manage_notifications.dart';
import 'pages/manage_users.dart';
import 'pages/notifications.dart';
import 'pages/profile.dart';
import 'pages/signup.dart';
import 'pages/timetables.dart';
import 'pages/addEvent.dart';
import 'pages/addClass.dart';
import 'pages/create_broadcast.dart';
import 'services/notification_service.dart';

const String loginRoute = '/login';
const String signupRoute = '/signup';
const String homeRoute = '/home';
const String eventsRoute = '/events';
const String landingRoute = '/landing';
const String timetablesRoute = '/timetables';
const String addEventRoute = '/addEvent';
const String addClassRoute = '/addClass';
const String notificationsRoute = '/notifications';
const String manageNotificationsRoute = '/manageNotifications';
const String manageUsersRoute = '/manageUsers';
const String profileRoute = '/profile';
const String adminRoute = '/admin';
const String createBroadcastRoute = '/createBroadcast';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
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
      initialRoute: landingRoute,
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
            return MaterialPageRoute(builder: (_) => const LandingPage());
          case timetablesRoute:
            return MaterialPageRoute(builder: (_) => const TimetablesPage());
          case addEventRoute:
            return MaterialPageRoute(builder: (_) => const AddEventPage());
          case addClassRoute:
            return MaterialPageRoute(builder: (_) => const AddClassPage());
          case notificationsRoute:
            return MaterialPageRoute(builder: (_) => const NotificationsPage());
          case manageNotificationsRoute:
            return MaterialPageRoute(
              builder: (_) => const ManageNotificationsPage(),
            );
          case manageUsersRoute:
            return MaterialPageRoute(builder: (_) => const ManageUsersPage());
          case profileRoute:
            return MaterialPageRoute(builder: (_) => const ProfilePage());
          case adminRoute:
            return MaterialPageRoute(builder: (_) => const AdminPage());
          case createBroadcastRoute:
            return MaterialPageRoute(
              builder: (_) => const CreateBroadcastPage(),
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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}

// Backwards-compatible wrapper for tests expecting `MyApp`.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const CampusEventsApp();
}
