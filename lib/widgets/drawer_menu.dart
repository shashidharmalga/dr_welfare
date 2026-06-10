import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../navigation_provider.dart';
import '../theme.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);

    // Determine active menu item
    bool isHomeActive =
        navProvider.currentTab == 0 &&
        !navProvider.showRegistration &&
        !navProvider.showLogin;
    bool isAboutUsActive =
        navProvider.currentTab == 1 &&
        !navProvider.showRegistration &&
        !navProvider.showLogin;
    bool isHowItWorksActive =
        navProvider.currentTab == 2 &&
        !navProvider.showRegistration &&
        !navProvider.showLogin;
    bool isMembershipActive = navProvider.showRegistration;
    bool isFAQsActive =
        navProvider.currentTab == 3 &&
        !navProvider.showContactUsUnderSupport &&
        !navProvider.showRegistration &&
        !navProvider.showLogin;
    bool isContactUsActive =
        navProvider.currentTab == 3 &&
        navProvider.showContactUsUnderSupport &&
        !navProvider.showRegistration &&
        !navProvider.showLogin;
    bool isLoginActive = navProvider.showLogin;

    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          // Drawer Header
          Container(
            padding: const EdgeInsets.only(
              top: 60,
              bottom: 20,
              left: 24,
              right: 24,
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppTheme.border, width: 1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/splash_logo.png',
                      width: 32,
                      height: 32,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.local_hospital,
                          color: AppTheme.primary,
                          size: 24,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'DRS Welfare',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Text(
                        'Clinical Excellence & Care',
                        style: TextStyle(
                          color: AppTheme.textMedium,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Drawer Navigation Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              children: [
                _buildDrawerItem(
                  context: context,
                  icon: Icons.home_outlined,
                  label: 'Home',
                  isActive: isHomeActive,
                  onTap: () {
                    navProvider.setTab(0);
                    Navigator.pop(context);
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.info_outline,
                  label: 'About Us',
                  isActive: isAboutUsActive,
                  onTap: () {
                    navProvider.setTab(1);
                    Navigator.pop(context);
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.account_tree_outlined,
                  label: 'How It Works',
                  isActive: isHowItWorksActive,
                  onTap: () {
                    navProvider.setTab(2);
                    Navigator.pop(context);
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.badge_outlined,
                  label: 'Membership',
                  isActive: isMembershipActive,
                  onTap: () {
                    navProvider.openRegistration();
                    Navigator.pop(context);
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.help_outline,
                  label: 'FAQs',
                  isActive: isFAQsActive,
                  onTap: () {
                    navProvider.navigateToFAQ();
                    Navigator.pop(context);
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.question_answer_outlined,
                  label: 'Contact Us',
                  isActive: isContactUsActive,
                  onTap: () {
                    navProvider.navigateToContactUs();
                    Navigator.pop(context);
                  },
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.shield_outlined,
                  label: 'Login',
                  isActive: isLoginActive,
                  onTap: () {
                    navProvider.openLogin();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),

          // Drawer Bottom Profile/Status Area
          if (navProvider.isRegistered)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppTheme.border, width: 1),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppTheme.primary,
                    child: Text(
                      navProvider.userName
                              ?.substring(
                                0,
                                min(navProvider.userName?.length ?? 0, 2),
                              )
                              .toUpperCase() ??
                          'DR',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          navProvider.userName ?? 'Doctor',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          navProvider.userQualification ?? 'MBBS',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textMedium,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout, color: AppTheme.danger),
                    onPressed: () {
                      navProvider.logout();
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  int min(int a, int b) => a < b ? a : b;

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? AppTheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Icon(
                icon,
                color: isActive ? Colors.white : AppTheme.textMedium,
                size: 22,
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.white : AppTheme.textDark,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
