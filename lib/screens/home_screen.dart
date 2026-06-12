import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../navigation_provider.dart';
import '../theme.dart';
import '../widgets/adaptive_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    final isIOSVal = isIOS(context);

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(
                isIOSVal ? CupertinoIcons.bars : Icons.menu,
                color: AppTheme.primary,
                size: 28,
              ),
              onPressed: () => handleMenuPress(context),
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/splash_logo.png',
              height: 28,
              errorBuilder: (context, error, stackTrace) => Icon(
                isIOSVal ? CupertinoIcons.plus_rectangle : Icons.local_hospital,
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
              onTap: () => handleProfilePress(context),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: AppTheme.primaryLight,
                child: Icon(
                  navProvider.isRegistered
                      ? (isIOSVal ? CupertinoIcons.person_fill : Icons.person)
                      : (isIOSVal ? CupertinoIcons.person : Icons.person_outline),
                  color: AppTheme.primary,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            _buildHeroSection(context, navProvider),

            // "Built by Doctors, For Doctors" Section
            _buildBuiltByDoctorsSection(context, navProvider),

            // "Why Choose Doctors Welfare" Section
            _buildWhyChooseSection(context),

            // Bottom CTA
            _buildBottomCTA(context, navProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(
    BuildContext context,
    NavigationProvider navProvider,
  ) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F2B5C), // Deep premium navy
            Color(0xFF0A58CA), // Brand primary blue
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          // Heading
          Text(
            'Empowering Medical Professionals Together',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 16),
          // Subheading
          const Text(
            'Join Doctors Welfare — An initiative by Professionals Welfare Trust (PWT). A member-based mutual self-support platform designed exclusively for registered doctors.',
            style: TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),
          // Buttons
          Row(
            children: [
              Expanded(
                child: AdaptiveButton(
                  backgroundColor: Colors.white,
                  textColor: AppTheme.primary,
                  onPressed: () {
                    navProvider.openRegistration();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Join Now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        isIOS(context) ? CupertinoIcons.arrow_right : Icons.arrow_forward,
                        color: AppTheme.primary,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AdaptiveButton(
                  isOutlined: true,
                  backgroundColor: Colors.white,
                  textColor: Colors.white,
                  onPressed: () {
                    navProvider.setTab(2); // Go to How It Works
                  },
                  child: const Text(
                    'Learn More',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildBuiltByDoctorsSection(BuildContext context, NavigationProvider navProvider) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
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
            child: Text(
              'Medical tools',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppTheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Heading
          Text(
            'Built by Doctors, For Doctors',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppTheme.textDark,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 20),

          // Image
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: AppTheme.cardShadow,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/hero_doctor.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppTheme.primaryLight,
                    child: const Center(
                      child: Icon(
                        Icons.medical_services_outlined,
                        color: AppTheme.primary,
                        size: 64,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Bullet Points
          _buildBulletPoint(
            context,
            'Open to Doctors, Dentists, Dermatologists, Surgeons, Pediatricians, Ophthalmologists & other Medical Doctors',
          ),
          const SizedBox(height: 16),
          _buildBulletPoint(
            context,
            'Voluntary mutual assistance — contributions go directly from members to the nominee\'s bank account',
          ),
          const SizedBox(height: 16),
          _buildBulletPoint(
            context,
            'Transparent, app-based coordination with full accountability',
          ),
          const SizedBox(height: 16),
          _buildBulletPoint(
            context,
            'Public Charitable & Welfare Trust — Non-Profit, not an insurance or investment scheme',
          ),
          const SizedBox(height: 28),

          // Button
          SizedBox(
            width: double.infinity,
            child: AdaptiveButton(
              backgroundColor: AppTheme.primary,
              onPressed: () {
                navProvider.setTab(4); // Go to Membership details
              },
              child: const Text(
                'View Membership Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.check_circle_outline,
          color: AppTheme.primary,
          size: 22,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppTheme.textMedium,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWhyChooseSection(BuildContext context) {
    return Container(
      color: AppTheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Section Title
          Text(
            'Why Choose Doctors Welfare?',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppTheme.textDark,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),

          // Subtitle
          const Text(
            'A voluntary, member-driven mutual support model where doctors help each other through difficult times',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.textMedium,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 28),

          // Cards List
          _buildWhyChooseCard(
            context: context,
            icon: Icons.shield_outlined,
            title: 'Mutual Self-Support',
            body:
                'Members voluntarily contribute to support the family/nominee of a deceased member. PWT coordinates — it does not collect or hold funds.',
          ),
          const SizedBox(height: 16),
          _buildWhyChooseCard(
            context: context,
            icon: Icons.people_outline,
            title: 'Doctors Community',
            body:
                'Join a network of doctors, dentists, dermatologists, surgeons, pediatricians & other medical doctors who support each other.',
          ),
          const SizedBox(height: 16),
          _buildWhyChooseCard(
            context: context,
            icon: Icons.favorite_border,
            title: 'Nominee Protection',
            body:
                'In the event of a member\'s passing, contributions from fellow members are transferred directly to the designated nominee\'s bank account.',
          ),
        ],
      ),
    );
  }

  Widget _buildWhyChooseCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String body,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border, width: 1),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.primaryLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppTheme.primary,
              size: 24,
            ),
          ),
          const SizedBox(height: 16),

          // Title
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 8),

          // Body Text
          Text(
            body,
            style: const TextStyle(
              color: AppTheme.textMedium,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCTA(BuildContext context, NavigationProvider navProvider) {
    return Container(
      width: double.infinity,
      color: AppTheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Ready to Join Our Community of Doctors?',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            'Take the first step towards mutual support. Membership is open to all registered doctors aged 60 or below (Indian citizens only).',
            style: TextStyle(
              color: Color(0xFFEFF6FF),
              fontSize: 14,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: AdaptiveButton(
              backgroundColor: Colors.white,
              textColor: AppTheme.primary,
              borderRadius: 8,
              padding: const EdgeInsets.symmetric(vertical: 16),
              onPressed: () {
                navProvider.openRegistration();
              },
              child: const Text(
                'Start Your Application Today',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
