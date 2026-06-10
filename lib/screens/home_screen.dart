import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../navigation_provider.dart';
import '../theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  navProvider.isRegistered
                      ? Icons.person
                      : Icons.person_outline,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            _buildHeroSection(context, navProvider),

            // "Built by Doctors, For Doctors" Section
            _buildBuiltByDoctorsSection(context),

            // "Our Services" Section
            _buildServicesSection(context, navProvider),

            // "Why Choose Doctors Welfare" Section
            _buildWhyChooseSection(context),

            // "Latest Updates" Section
            _buildUpdatesSection(context),

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
      color: Colors.white,
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
            child: Text(
              'Trusted by Professionals',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Heading
          Text(
            'Empowering\nHealthcare\nProfessionals',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: AppTheme.primary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),

          // Subheading
          const Text(
            'Comprehensive welfare solutions, benefits, and support systems designed exclusively for doctors and medical practitioners across India.',
            style: TextStyle(
              color: AppTheme.textMedium,
              fontSize: 15,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),

          // Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    navProvider.openRegistration();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Join Now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                    side: const BorderSide(color: AppTheme.primary, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    navProvider.setTab(2); // Go to Membership details
                  },
                  child: const Text(
                    'Learn More',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),

          // Hero Image Card
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: AppTheme.cardShadow,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
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
        ],
      ),
    );
  }

  Widget _buildBuiltByDoctorsSection(BuildContext context) {
    return Container(
      color: AppTheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.border, width: 1),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: AppTheme.primaryLight,
              child: Icon(
                Icons.local_hospital,
                color: AppTheme.primary,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Built by Doctors, For Doctors',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.textDark,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Our platform is uniquely designed by healthcare professionals who understand the real-world challenges you face daily. We\'re dedicated to improving your professional journey and personal well-being.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.textMedium,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesSection(
    BuildContext context,
    NavigationProvider navProvider,
  ) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Our Services',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.textDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  navProvider.setTab(1); // Go to Benefits
                },
                child: Row(
                  children: const [
                    Text(
                      'View All',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: AppTheme.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Services Cards Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.72,
            children: [
              _buildServiceCard(
                context: context,
                icon: Icons.shield_outlined,
                iconBg: AppTheme.primaryLight,
                iconColor: AppTheme.primary,
                title: 'Comprehensive Insurance',
                body:
                    'Premium health and life insurance covers tailored for medical professionals, ensuring peace of mind for you and your family.',
              ),
              _buildServiceCard(
                context: context,
                icon: Icons.gavel_outlined,
                iconBg: const Color(0xFFF0EFFF),
                iconColor: const Color(0xFF5B50D6),
                title: 'Legal Support',
                body:
                    '24/7 legal assistance and protection against professional indemnity claims.',
              ),
              _buildServiceCard(
                context: context,
                icon: Icons.school_outlined,
                iconBg: const Color(0xFFFFF0E6),
                iconColor: const Color(0xFFD35400),
                title: 'Continuing Education',
                body:
                    'Access to exclusive webinars, workshops, and medical conferences.',
              ),
              _buildServiceCard(
                context: context,
                icon: Icons.forum_outlined,
                iconBg: const Color(0xFFE6FFFA),
                iconColor: const Color(0xFF0D9488),
                title: 'Community Forum',
                body:
                    'Connect with thousands of peers nationwide. Share experiences, seek advice, and build a strong professional network.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required BuildContext context,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String body,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border, width: 1),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              body,
              style: const TextStyle(
                color: AppTheme.textMedium,
                fontSize: 11,
                height: 1.4,
              ),
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyChooseSection(BuildContext context) {
    return Container(
      color: AppTheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why Choose Doctors Welfare',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppTheme.textDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          _buildWhyChoosePoint(
            context: context,
            title: 'Tailored Financial Security',
            body:
                'Specialized plans designed for the unique income cycles and risks of medical practitioners.',
          ),
          const SizedBox(height: 16),
          _buildWhyChoosePoint(
            context: context,
            title: 'Unmatched Legal Protection',
            body:
                'Robust defense mechanisms against malpractice suits and regulatory challenges.',
          ),
          const SizedBox(height: 16),
          _buildWhyChoosePoint(
            context: context,
            title: 'Exclusive Peer Network',
            body:
                'A verified, private community for confidential discussions and referrals.',
          ),
        ],
      ),
    );
  }

  Widget _buildWhyChoosePoint({
    required BuildContext context,
    required String title,
    required String body,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle, color: AppTheme.primary, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 4),
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
        ),
      ],
    );
  }

  Widget _buildUpdatesSection(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Latest Updates',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppTheme.textDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          _buildUpdateCard(
            context: context,
            icon: Icons.campaign,
            iconBg: const Color(0xFFFFF0F1),
            iconColor: AppTheme.danger,
            title: 'New Policy Changes 2024',
            time: '2 hrs ago',
            body:
                'Important updates regarding professional indemnity requirements and revised regulatory standards for clinical practitioners.',
          ),
          const SizedBox(height: 16),
          _buildUpdateCard(
            context: context,
            icon: Icons.calendar_today,
            iconBg: AppTheme.primaryLight,
            iconColor: AppTheme.primary,
            title: 'Annual Medical Symposium',
            time: 'Yesterday',
            body:
                'Registrations are now open for the upcoming National Medical Symposium focusing on clinical excellence and healthcare policies.',
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateCard({
    required BuildContext context,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String time,
    required String body,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border, width: 1),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppTheme.textDark,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        color: AppTheme.textLight,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: const TextStyle(
                    color: AppTheme.textMedium,
                    fontSize: 12,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Ready to Join Our Community?',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            'Take the next step in securing your professional future and well-being today.',
            style: TextStyle(
              color: Color(0xFFD0E1FD),
              fontSize: 14,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppTheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              elevation: 0,
            ),
            onPressed: () {
              navProvider.openRegistration();
            },
            child: const Text(
              'Become a Member Now',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
