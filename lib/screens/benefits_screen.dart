import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../navigation_provider.dart';
import '../theme.dart';

class BenefitsScreen extends StatelessWidget {
  const BenefitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: AppTheme.primary, size: 28),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash_logo.png',
              height: 28,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.local_hospital,
                color: AppTheme.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'DRS Welfare',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                if (navProvider.isRegistered) {
                  Scaffold.of(context).openDrawer();
                } else {
                  navProvider.openLogin();
                }
              },
              child: CircleAvatar(
                radius: 16,
                backgroundColor: AppTheme.primaryLight,
                child: Icon(
                  navProvider.isRegistered ? Icons.person : Icons.person_outline,
                  color: AppTheme.primary,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Text(
                  'Trusted Care Partners',
                  style: TextStyle(
                    color: AppTheme.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Heading
              Text(
                'Dedicated to Clinical Excellence',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppTheme.primary,
                  fontSize: 26,
                  height: 1.3,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              
              // Description
              const Text(
                'Professional support and mutual assistance programs designed to foster a secure, cooperative environment for medical professionals.',
                style: TextStyle(
                  color: AppTheme.textMedium,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),
              
              // Mission, Vision, Heritage Cards with exact placeholders
              _buildConceptCard(
                context: context,
                icon: Icons.track_changes_outlined,
                iconColor: const Color(0xFFD35400),
                iconBg: const Color(0xFFFFF0E6),
                title: 'Our Mission',
                placeholder: '{{DATA:DOCUMENT:DOCUMENT_43}}',
              ),
              const SizedBox(height: 20),
              
              _buildConceptCard(
                context: context,
                icon: Icons.visibility_outlined,
                iconColor: AppTheme.primary,
                iconBg: AppTheme.primaryLight,
                title: 'Our Vision',
                placeholder: '{{DATA:DOCUMENT:DOCUMENT_43}}',
              ),
              const SizedBox(height: 20),
              
              _buildConceptCard(
                context: context,
                icon: Icons.history_edu_outlined,
                iconColor: const Color(0xFF198754),
                iconBg: const Color(0xFFD1E7DD),
                title: 'Our Heritage',
                placeholder: '{{DATA:DOCUMENT:DOCUMENT_43}}',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConceptCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String placeholder,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border, width: 1),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 14),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.border, width: 0.5),
            ),
            child: Text(
              placeholder,
              style: const TextStyle(
                fontFamily: 'Courier',
                color: AppTheme.textDark,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
