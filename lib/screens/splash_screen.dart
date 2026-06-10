import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../theme.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onFinish;

  const SplashScreen({super.key, required this.onFinish});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  int _dotCount = 1;
  Timer? _dotTimer;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Fade animation for splash elements
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _fadeController.forward();

    // Loading dots animation
    _dotTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _dotCount = (_dotCount % 3) + 1;
        });
      }
    });

    // Proceed to Home Screen after 2.5 seconds
    Timer(const Duration(milliseconds: 2500), () {
      _dotTimer?.cancel();
      widget.onFinish();
    });
  }

  @override
  void dispose() {
    _dotTimer?.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dots = '.' * _dotCount;
    final isIOSVal = Theme.of(context).platform == TargetPlatform.iOS;

    final bodyContent = SafeArea(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 40),

            // Centered Monogram & App Title
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Stylized Logo Circle
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7F1FF),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primary.withOpacity(0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/splash_logo.png',
                      width: 70,
                      height: 70,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          isIOSVal ? CupertinoIcons.plus_rectangle : Icons.local_hospital_rounded,
                          color: AppTheme.primary,
                          size: 48,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // App Title
                Text(
                  'Doctors Welfare\nTrust India',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppTheme.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),

                // Subtitle
                Text(
                  'Excellence in Clinical Care',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textMedium,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            // Bottom Progress/Initializing Indicator
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dot indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      bool active = index < _dotCount;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: active
                              ? AppTheme.primary
                              : AppTheme.textLight.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'INITIALIZING$dots',
                    style: const TextStyle(
                      color: AppTheme.textLight,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    if (isIOSVal) {
      return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.white,
        child: Material(
          type: MaterialType.transparency,
          child: bodyContent,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: bodyContent,
    );
  }
}
