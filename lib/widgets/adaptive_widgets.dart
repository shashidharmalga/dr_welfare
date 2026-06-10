import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../navigation_provider.dart';
import '../theme.dart';
import 'drawer_menu.dart';

bool isIOS(BuildContext context) {
  if (kIsWeb) return false;
  return Theme.of(context).platform == TargetPlatform.iOS;
}

/// Adaptive Scaffold that renders [CupertinoPageScaffold] on iOS and [Scaffold] on Android.
class AdaptiveScaffold extends StatelessWidget {
  final ObstructingPreferredSizeWidget? navigationBar;
  final PreferredSizeWidget? appBar;
  final Widget child;
  final Widget? drawer;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;

  const AdaptiveScaffold({
    super.key,
    this.navigationBar,
    this.appBar,
    required this.child,
    this.drawer = const DrawerMenu(),
    this.backgroundColor,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isIOS(context)) {
      return CupertinoPageScaffold(
        navigationBar: navigationBar,
        backgroundColor: backgroundColor ?? CupertinoColors.systemGroupedBackground,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        child: SafeArea(
          // If we have a navigation bar, CupertinoPageScaffold already pushes content,
          // but we wrap in Material to support any Material child elements.
          top: navigationBar == null,
          bottom: false,
          child: Material(
            type: MaterialType.transparency,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: navigationBar == null ? appBar : null,
              drawer: drawer,
              body: child,
              bottomNavigationBar: bottomNavigationBar,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: appBar,
        drawer: drawer,
        backgroundColor: backgroundColor,
        bottomNavigationBar: bottomNavigationBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: child,
      );
    }
  }
}

/// Adaptive App Bar that renders [CupertinoNavigationBar] on iOS and [AppBar] on Android.
class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;

  const AdaptiveAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (isIOS(context)) {
      return CupertinoNavigationBar(
        leading: leading,
        middle: title,
        trailing: actions != null && actions!.isNotEmpty
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!,
              )
            : null,
        backgroundColor: backgroundColor ?? CupertinoColors.white,
        border: const Border(
          bottom: BorderSide(
            color: CupertinoColors.systemGrey5,
            width: 0.5,
          ),
        ),
      );
    } else {
      return AppBar(
        leading: leading,
        title: title,
        actions: actions,
        centerTitle: centerTitle,
        backgroundColor: backgroundColor ?? Colors.white,
        elevation: 0,
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kMinInteractiveDimensionCupertino);
}

/// Adaptive Button that renders [CupertinoButton] on iOS and [ElevatedButton]/[OutlinedButton]/[TextButton] on Android.
class AdaptiveButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool isOutlined;
  final bool isTextOnly;

  const AdaptiveButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 8,
    this.padding,
    this.isOutlined = false,
    this.isTextOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isIOS(context)) {
      if (isTextOnly) {
        return CupertinoButton(
          padding: padding ?? EdgeInsets.zero,
          minSize: 0,
          onPressed: onPressed,
          child: DefaultTextStyle.merge(
            style: TextStyle(
              color: textColor ?? AppTheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            child: child,
          ),
        );
      } else if (isOutlined) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: backgroundColor ?? AppTheme.primary, width: 1.5),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: CupertinoButton(
            padding: padding ?? const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            borderRadius: BorderRadius.circular(borderRadius),
            minSize: 0,
            onPressed: onPressed,
            child: Center(
              child: DefaultTextStyle.merge(
                style: TextStyle(
                  color: textColor ?? backgroundColor ?? AppTheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                child: child,
              ),
            ),
          ),
        );
      } else {
        return CupertinoButton(
          color: backgroundColor ?? AppTheme.primary,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          borderRadius: BorderRadius.circular(borderRadius),
          minSize: 0,
          onPressed: onPressed,
          child: Center(
            child: DefaultTextStyle.merge(
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              child: child,
            ),
          ),
        );
      }
    } else {
      if (isTextOnly) {
        return TextButton(
          style: TextButton.styleFrom(
            padding: padding,
            foregroundColor: textColor ?? AppTheme.primary,
          ),
          onPressed: onPressed,
          child: child,
        );
      } else if (isOutlined) {
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: textColor ?? backgroundColor ?? AppTheme.primary,
            side: BorderSide(color: backgroundColor ?? AppTheme.primary, width: 1.5),
            padding: padding ?? const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          onPressed: onPressed,
          child: child,
        );
      } else {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppTheme.primary,
            foregroundColor: textColor ?? Colors.white,
            padding: padding ?? const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            elevation: 0,
          ),
          onPressed: onPressed,
          child: child,
        );
      }
    }
  }
}

/// Adaptive Switch that renders [CupertinoSwitch] on iOS and [Switch] on Android.
class AdaptiveSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;

  const AdaptiveSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    if (isIOS(context)) {
      return CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor ?? AppTheme.primary,
      );
    } else {
      return Switch(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor ?? AppTheme.primary,
      );
    }
  }
}

/// Adaptive Activity Indicator that renders [CupertinoActivityIndicator] on iOS and [CircularProgressIndicator] on Android.
class AdaptiveActivityIndicator extends StatelessWidget {
  final double radius;
  final Color? color;

  const AdaptiveActivityIndicator({
    super.key,
    this.radius = 10,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (isIOS(context)) {
      return CupertinoActivityIndicator(
        radius: radius,
        color: color,
      );
    } else {
      return CircularProgressIndicator(
        strokeWidth: radius / 4,
        valueColor: color != null ? AlwaysStoppedAnimation<Color>(color!) : null,
      );
    }
  }
}

/// Handle leading menu button presses based on the platform.
void handleMenuPress(BuildContext context) {
  if (isIOS(context)) {
    showiOSMenu(context);
  } else {
    Scaffold.of(context).openDrawer();
  }
}

/// Handle profile image button presses based on the platform.
void handleProfilePress(BuildContext context) {
  final navProvider = Provider.of<NavigationProvider>(context, listen: false);
  if (isIOS(context)) {
    if (navProvider.isRegistered) {
      showProfileDetails(context);
    } else {
      navProvider.openLogin();
    }
  } else {
    if (navProvider.isRegistered) {
      Scaffold.of(context).openDrawer();
    } else {
      navProvider.openLogin();
    }
  }
}

/// Show iOS native navigation options sheet.
void showiOSMenu(BuildContext context) {
  final navProvider = Provider.of<NavigationProvider>(context, listen: false);
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: const Text('Navigation Menu'),
      message: const Text('Go to a section of Doctors Welfare'),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            navProvider.setTab(0);
          },
          child: const Text('Home'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            navProvider.setTab(1);
          },
          child: const Text('About Us / Benefits'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            navProvider.setTab(2);
          },
          child: const Text('How It Works / Membership Details'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            navProvider.openRegistration();
          },
          child: const Text('Apply for Membership'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            navProvider.navigateToFAQ();
          },
          child: const Text('FAQs'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            navProvider.navigateToContactUs();
          },
          child: const Text('Contact Us'),
        ),
        if (!navProvider.isRegistered)
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              navProvider.openLogin();
            },
            child: const Text('Login'),
          )
        else ...[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              showProfileDetails(context);
            },
            child: Text('Profile (${navProvider.userName})'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              showAdaptiveDialog(
                context: context,
                title: 'Logout',
                content: 'Are you sure you want to logout?',
                confirmLabel: 'Logout',
                onConfirm: () {
                  navProvider.logout();
                },
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Cancel'),
      ),
    ),
  );
}

/// Show Profile details in a native-styled dialog.
void showProfileDetails(BuildContext context) {
  final navProvider = Provider.of<NavigationProvider>(context, listen: false);
  if (!navProvider.isRegistered) return;

  if (isIOS(context)) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Member Profile'),
        content: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                navProvider.userName ?? 'Doctor',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 6),
              Text(
                navProvider.userQualification ?? 'MBBS',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 6),
              Text(
                navProvider.userEmail ?? '',
                style: const TextStyle(fontSize: 13, color: CupertinoColors.secondaryLabel),
              ),
            ],
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              navProvider.logout();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Member Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${navProvider.userName}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Qualification: ${navProvider.userQualification}'),
            const SizedBox(height: 8),
            Text('Email: ${navProvider.userEmail}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              navProvider.logout();
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

/// Show an adaptive confirmation dialog.
void showAdaptiveDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String confirmLabel,
  required VoidCallback onConfirm,
  String cancelLabel = 'Cancel',
}) {
  if (isIOS(context)) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: Text(cancelLabel),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(cancelLabel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Text(
              confirmLabel,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
