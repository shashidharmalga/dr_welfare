import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../navigation_provider.dart';
import '../theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final currentTab = navProvider.currentTab;
    final displayIndex = (currentTab == 4 || currentTab == 2) ? 2 : (currentTab > 3 ? 0 : currentTab);

    if (isIOS) {
      return CupertinoTabBar(
        currentIndex: displayIndex,
        onTap: (index) {
          if (index == 2) {
            navProvider.setTab(4);
          } else {
            navProvider.setTab(index);
          }
        },
        activeColor: AppTheme.primary,
        inactiveColor: AppTheme.textMedium,
        backgroundColor: CupertinoColors.white,
        border: const Border(
          top: BorderSide(
            color: CupertinoColors.systemGrey5,
            width: 0.5,
          ),
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            activeIcon: Icon(CupertinoIcons.house_fill),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.briefcase),
            activeIcon: Icon(CupertinoIcons.briefcase_fill),
            label: 'Benefits',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.creditcard),
            activeIcon: Icon(CupertinoIcons.creditcard_fill),
            label: 'Membership',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.question_circle),
            activeIcon: Icon(CupertinoIcons.question_circle_fill),
            label: 'Support',
          ),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(top: BorderSide(color: AppTheme.border, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: displayIndex,
        onTap: (index) {
          if (index == 2) {
            navProvider.setTab(4);
          } else {
            navProvider.setTab(index);
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppTheme.primary,
        unselectedItemColor: AppTheme.textMedium,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        elevation: 0,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            activeIcon: Icon(Icons.work),
            label: 'Benefits',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.badge_outlined),
            activeIcon: Icon(Icons.badge),
            label: 'Membership',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.help_outline),
            activeIcon: const Icon(Icons.help),
            label: navProvider.showContactUsUnderSupport
                ? 'Support'
                : 'Support',
          ),
        ],
      ),
    );
  }
}
