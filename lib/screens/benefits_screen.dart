import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../navigation_provider.dart';
import '../theme.dart';
import '../widgets/adaptive_widgets.dart';

class BenefitsScreen extends StatelessWidget {
  const BenefitsScreen({super.key});

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
            // Header Banner
            Container(
              width: double.infinity,
              color: AppTheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Doctors Welfare',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'A Member-Based Mutual Self Support Trust — Public Charitable & Welfare Trust (Non-Profit)',
                    style: TextStyle(
                      color: Color(0xFFEFF6FF),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Our Story Heading
                  Text(
                    'Our Story',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.primary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Logo container matching the image
                  Center(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F5FD), // Light blue-ish background from the image
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/splash_logo.png',
                          height: 160,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 160,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.local_hospital_rounded,
                              color: AppTheme.primary,
                              size: 64,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Story Paragraphs
                  const Text(
                    'Doctors Welfare was founded with a singular vision: to create a voluntary mutual self-support system exclusively for registered doctors. Operating as an initiative under the Professionals Welfare Trust (PWT), it brings together individuals who believe in the power of collective support.',
                    style: TextStyle(
                      color: AppTheme.textDark,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 14),

                  const Text(
                    'Doctors Welfare is not an insurance company, investment scheme, or profit-making entity. The platform operates under PWT, a public charitable and welfare trust where members voluntarily contribute to support the families and nominees of deceased members — directly, transparently, and with full accountability.',
                    style: TextStyle(
                      color: AppTheme.textDark,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 14),

                  const Text(
                    'Today, Doctors Welfare serves registered medical doctors across India — including Doctors, Dentists, Dermatologists, Surgeons, Physicians, Pediatricians, Ophthalmologists, and Orthopedic Specialists — providing them with the assurance that their medical community stands together in times of need.',
                    style: TextStyle(
                      color: AppTheme.textDark,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Concept Cards (Mission, Vision, etc.)
                  _buildConceptCard(
                    context: context,
                    icon: Icons.track_changes,
                    title: 'Our Mission',
                    text: "To coordinate voluntary mutual assistance among registered doctors for the benefit of members' nominees",
                    isIOSVal: isIOSVal,
                  ),
                  const SizedBox(height: 20),

                  _buildConceptCard(
                    context: context,
                    icon: Icons.visibility,
                    title: 'Our Vision',
                    text: 'To be the most trusted mutual self-support trust for doctors nationwide, built on transparency and voluntary cooperation',
                    isIOSVal: isIOSVal,
                  ),
                  const SizedBox(height: 20),

                  _buildConceptCard(
                    context: context,
                    icon: Icons.verified,
                    title: 'Our Values',
                    text: 'Integrity, transparency, voluntary cooperation, and unwavering commitment to our members and the trust\'s charitable purpose',
                    isIOSVal: isIOSVal,
                  ),
                  const SizedBox(height: 20),

                  _buildConceptCard(
                    context: context,
                    icon: Icons.trending_up,
                    title: 'Our Growth',
                    text: 'Continuously expanding our community of doctors who believe in mutual support and collective welfare',
                    isIOSVal: isIOSVal,
                  ),
                  const SizedBox(height: 36),

                  // Why We're Different Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: AppTheme.cardShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Why We're Different",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildDifferentSection(
                          title: "Not Insurance or Investment",
                          text: "Doctors Welfare operates under PWT, a public charitable trust — not an insurance company, not an investment scheme, and not a profit-making entity. We facilitate voluntary mutual support among doctors.",
                        ),
                        const Divider(color: Color(0x26FFFFFF), height: 32),
                        _buildDifferentSection(
                          title: "Direct Member-to-Nominee Transfers",
                          text: "All contributions are made directly from members to the nominee's bank account. PWT acts only as a coordinating and facilitating entity — not as a financial intermediary.",
                        ),
                        const Divider(color: Color(0x26FFFFFF), height: 32),
                        _buildDifferentSection(
                          title: "Transparent Operations",
                          text: "We maintain complete transparency through our digital platform.",
                        ),
                        const Divider(color: Color(0x26FFFFFF), height: 32),
                        _buildDifferentSection(
                          title: "Medical Doctors Community",
                          text: "Open to Doctors, Dentists, Dermatologists, Surgeons, Physicians, Pediatricians, Ophthalmologists, Orthopedic Specialists, and other registered medical doctors.",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConceptCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String text,
    required bool isIOSVal,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border, width: 1),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular Icon Container
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppTheme.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 16),
          // Title
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          // Description Text
          Text(
            text,
            style: const TextStyle(
              color: AppTheme.textMedium,
              fontSize: 14,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDifferentSection({
    required String title,
    required String text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xE6FFFFFF), // 90% white opacity equivalent
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
