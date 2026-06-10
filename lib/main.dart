import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navigation_provider.dart';
import 'theme.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/benefits_screen.dart';
import 'screens/membership_details_screen.dart';
import 'screens/faq_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_form_screen.dart';
import 'widgets/drawer_menu.dart';
import 'widgets/bottom_nav_bar.dart';

void main() {
  runApp(const DrWelfareApp());
}

class DrWelfareApp extends StatelessWidget {
  const DrWelfareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavigationProvider(),
      child: MaterialApp(
        title: 'Doctors Welfare Trust India',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const AppContentManager(),
      ),
    );
  }
}

class AppContentManager extends StatefulWidget {
  const AppContentManager({super.key});

  @override
  State<AppContentManager> createState() => _AppContentManagerState();
}

class _AppContentManagerState extends State<AppContentManager> {
  bool _isSplashFinished = false;

  @override
  Widget build(BuildContext context) {
    if (!_isSplashFinished) {
      return SplashScreen(
        onFinish: () {
          setState(() {
            _isSplashFinished = true;
          });
        },
      );
    }

    final navProvider = Provider.of<NavigationProvider>(context);

    // If Login screen overlay is active
    if (navProvider.showLogin) {
      return const LoginScreen();
    }

    // If Registration screen overlay is active
    if (navProvider.showRegistration) {
      return const RegistrationFormScreen();
    }

    // Active bottom navigation screen
    Widget activeBody;
    switch (navProvider.currentTab) {
      case 0:
        activeBody = const HomeScreen();
        break;
      case 1:
        activeBody = const BenefitsScreen();
        break;
      case 2:
        activeBody = const MembershipDetailsScreen();
        break;
      case 3:
        activeBody = navProvider.showContactUsUnderSupport
            ? const ContactScreen()
            : const FAQScreen();
        break;
      default:
        activeBody = const HomeScreen();
    }

    return Scaffold(
      drawer: const DrawerMenu(),
      body: activeBody,
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
