import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
import 'widgets/bottom_nav_bar.dart';
import 'widgets/adaptive_widgets.dart';

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
  bool _loginRouteOpen = false;
  bool _registrationRouteOpen = false;

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
    final isIOSVal = isIOS(context);

    // Sync Login Screen Route (allows native iOS back gesture & transition)
    if (navProvider.showLogin && !_loginRouteOpen) {
      _loginRouteOpen = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).push(
          isIOSVal
              ? CupertinoPageRoute(builder: (context) => const LoginScreen())
              : MaterialPageRoute(builder: (context) => const LoginScreen()),
        ).then((_) {
          _loginRouteOpen = false;
          if (navProvider.showLogin) {
            navProvider.closeLogin();
          }
        });
      });
    } else if (!navProvider.showLogin && _loginRouteOpen) {
      _loginRouteOpen = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
    }

    // Sync Registration Screen Route (allows native iOS back gesture & transition)
    if (navProvider.showRegistration && !_registrationRouteOpen) {
      _registrationRouteOpen = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).push(
          isIOSVal
              ? CupertinoPageRoute(builder: (context) => const RegistrationFormScreen())
              : MaterialPageRoute(builder: (context) => const RegistrationFormScreen()),
        ).then((_) {
          _registrationRouteOpen = false;
          if (navProvider.showRegistration) {
            navProvider.closeRegistration();
          }
        });
      });
    } else if (!navProvider.showRegistration && _registrationRouteOpen) {
      _registrationRouteOpen = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
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

    if (isIOSVal) {
      return CupertinoTheme(
        data: const CupertinoThemeData(
          primaryColor: AppTheme.primary,
          barBackgroundColor: CupertinoColors.white,
          scaffoldBackgroundColor: Color(0xFFF3F6FA),
        ),
        child: Scaffold(
          backgroundColor: CupertinoColors.systemGroupedBackground,
          body: activeBody,
          bottomNavigationBar: const CustomBottomNavBar(),
        ),
      );
    }

    return Scaffold(
      body: activeBody,
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
