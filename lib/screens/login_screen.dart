import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../navigation_provider.dart';
import '../theme.dart';
import '../widgets/adaptive_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin(NavigationProvider navProvider) {
    if (_formKey.currentState!.validate()) {
      // Mock login: extract name from email or default to Jane Doe
      String email = _emailController.text.trim();
      String name = 'Dr. Jane Doe';
      if (email.contains('@')) {
        String prefix = email.split('@')[0];
        if (prefix.isNotEmpty) {
          name = 'Dr. ' + prefix[0].toUpperCase() + prefix.substring(1);
        }
      }

      navProvider.registerUser(
        name: name,
        email: email,
        qualification: 'MBBS, MD (General Medicine)',
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logged in successfully as $name!'),
          backgroundColor: AppTheme.success,
        ),
      );

      navProvider.closeLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);

    final isIOSVal = isIOS(context);

    return AdaptiveScaffold(
      backgroundColor: Colors.white,
      appBar: AdaptiveAppBar(
        leading: IconButton(
          icon: Icon(
            isIOSVal ? CupertinoIcons.back : Icons.arrow_back,
            color: AppTheme.primary,
          ),
          onPressed: () {
            navProvider.closeLogin();
          },
        ),
        title: const Text('Login'),
        centerTitle: true,
      ),
      child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shield Icon
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryLight,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primary.withOpacity(0.08),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/login_shield.png',
                          width: 60,
                          height: 60,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.security_rounded,
                                color: AppTheme.primary,
                                size: 44,
                              ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Welcome text
                  Center(
                    child: Text(
                      'Welcome Back',
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(
                            color: AppTheme.primary,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      'Sign in to access your Doctors Welfare account',
                      style: TextStyle(
                        color: AppTheme.textMedium,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Email/Username Input
                  const Text(
                    'Email Address or Username',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _emailController,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_outline, size: 20),
                      hintText: 'Enter email or username',
                      hintStyle: const TextStyle(
                        color: AppTheme.textLight,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return 'Please enter your email or username';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password Input
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline, size: 20),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      hintText: '••••••••',
                      hintStyle: const TextStyle(
                        color: AppTheme.textLight,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Please enter your password';
                      if (value.length < 6)
                        return 'Password must be at least 6 characters';
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),

                  // Remember Me & Forgot Password Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (isIOSVal)
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                  value: _rememberMe,
                                  onChanged: (val) {
                                    setState(() {
                                      _rememberMe = val;
                                    });
                                  },
                                ),
                              ),
                            )
                          else
                            Checkbox(
                              value: _rememberMe,
                              activeColor: AppTheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  _rememberMe = val ?? false;
                                });
                              },
                            ),
                          const Text(
                            'Remember me',
                            style: TextStyle(
                              color: AppTheme.textDark,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Password reset instructions sent to your email.',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: AppTheme.primary,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: AdaptiveButton(
                      onPressed: () => _submitLogin(navProvider),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Login securely',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            isIOSVal ? CupertinoIcons.arrow_right : Icons.arrow_forward,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Don't have an account link
                  Center(
                    child: InkWell(
                      onTap: () {
                        navProvider.openRegistration();
                      },
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            color: AppTheme.textMedium,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(text: 'Don\'t have an account yet? '),
                            TextSpan(
                              text: 'Join DRS Welfare',
                              style: TextStyle(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
