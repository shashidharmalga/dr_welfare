import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../navigation_provider.dart';
import '../theme.dart';
import '../widgets/adaptive_widgets.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

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
            // Top Blue Banner
            Container(
              width: double.infinity,
              color: AppTheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How It Works',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Join Doctors Welfare in simple steps and become part of a voluntary mutual self-support community of doctors',
                    style: TextStyle(
                      color: Color(0xFFEFF6FF),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Process Header Section
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Simple Process, Meaningful Support',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.textDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Our streamlined process ensures you can become a registered member and join a community of doctors working together for mutual welfare',
                    style: TextStyle(
                      color: AppTheme.textMedium,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Step 1
            _buildStepCard(
              context: context,
              stepNumber: '1',
              icon: Icons.person_add_alt_1_outlined,
              title: 'Complete Registration',
              description:
                  'Fill out the membership application form (physical or digital) with your personal details, medical credentials, and nominee information. Membership is open to Indian citizens only, aged 60 or below.',
              bullets: [
                'Provide personal and medical details',
                'Upload required documents and medical certificates',
                'Designate a nominee with their bank account details',
              ],
              images: [
                const StepImage(
                  imageUrl: 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=600&q=80',
                  caption: 'Doctor filling registration form',
                  fallbackIcon: Icons.assignment_outlined,
                ),
                const SizedBox(height: 16),
                const StepImage(
                  imageUrl: 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?auto=format&fit=crop&w=600&q=80',
                  caption: 'Doctor reviewing medical documents',
                  fallbackIcon: Icons.rate_review_outlined,
                ),
              ],
            ),

            // Step 2
            _buildStepCard(
              context: context,
              stepNumber: '2',
              icon: Icons.verified_user_outlined,
              title: 'Trustee Approval',
              description:
                  'Trustees shall review your submitted documents and medical credentials. They have absolute discretion to approve or reject applications. Admission is effective only after registration in Trust records.',
              bullets: [
                'Medical credentials verification',
                'Document authenticity check',
                'Confirmation upon Trustee approval',
              ],
              images: [],
            ),

            // Step 3
            _buildStepCard(
              context: context,
              stepNumber: '3',
              icon: Icons.payment_outlined,
              title: 'Pay Yearly Membership Fee',
              description:
                  'Once approved, complete your yearly membership fee payment. A yearly fee is required to register and maintain your membership. Membership remains valid only as long as you comply with all Rules & Bye-Laws.',
              bullets: [
                'Yearly membership registration fee',
                'Membership is non-transferable and non-assignable',
                'Payment confirmation and registration in Trust records',
              ],
              images: [
                const StepImage(
                  imageUrl: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?auto=format&fit=crop&w=600&q=80',
                  caption: 'Doctor processing membership payment',
                  fallbackIcon: Icons.payment_outlined,
                ),
                const SizedBox(height: 16),
                const StepImage(
                  imageUrl: 'https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca?auto=format&fit=crop&w=600&q=80',
                  caption: 'Healthcare professionals in a supportive team',
                  fallbackIcon: Icons.people_outline,
                ),
              ],
            ),

            // Step 4
            _buildStepCard(
              context: context,
              stepNumber: '4',
              icon: Icons.schedule_outlined,
              title: '12-Month Lock-In & Eligibility',
              description:
                  'A mandatory lock-in period of 12 months applies from the date of joining. No assistance or claim shall be entertained during the lock-in period. After completing the lock-in, you become eligible for mutual support from fellow members.',
              bullets: [
                '12-month mandatory lock-in — non-waivable',
                'Must fulfill all contribution obligations to remain eligible',
                'After lock-in, nominee eligible for voluntary member contributions',
              ],
              images: [],
            ),

            // Disclaimer Box
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDF5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFF1C40F),
                    width: 1.5,
                  ),
                  boxShadow: AppTheme.cardShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Color(0xFFD4AC0D),
                          size: 24,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Important Disclaimer',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF7D6608),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildDisclaimerBullet(
                      'PWT does not assure or guarantee any fixed amount. Assistance depends on voluntary cooperation of members.',
                    ),
                    const SizedBox(height: 12),
                    _buildDisclaimerBullet(
                      'No claim is enforceable as a legal right or debt. PWT is not an insurance or investment entity.',
                    ),
                    const SizedBox(height: 12),
                    _buildDisclaimerBullet(
                      'Membership terminates automatically at age 65, regardless of enrollment date.',
                    ),
                  ],
                ),
              ),
            ),

            // Bottom CTA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: AppTheme.cardShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Ready to Get Started?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Join a community of doctors who believe in mutual support. Enrollment open for registered doctors aged 60 and below.',
                      style: TextStyle(
                        color: Color(0xFFEFF6FF),
                        fontSize: 14,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: AdaptiveButton(
                        backgroundColor: Colors.white,
                        textColor: AppTheme.primary,
                        onPressed: () {
                          navProvider.openRegistration();
                        },
                        child: const Text(
                          'Start Your Application',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCard({
    required BuildContext context,
    required String stepNumber,
    required IconData icon,
    required String title,
    required String description,
    required List<String> bullets,
    required List<Widget> images,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Circular Number
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    stepNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Icon
              Icon(
                icon,
                color: AppTheme.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              // Title
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Description
          Text(
            description,
            style: const TextStyle(
              color: AppTheme.textDark,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          // Checkmark Bullet Points
          ...bullets.map((bullet) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: AppTheme.primary,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        bullet,
                        style: const TextStyle(
                          color: AppTheme.textMedium,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          if (images.isNotEmpty) ...[
            const SizedBox(height: 16),
            ...images,
          ],
        ],
      ),
    );
  }

  Widget _buildDisclaimerBullet(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.brightness_1_outlined,
          color: Color(0xFFD4AC0D),
          size: 14,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF7D6608),
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class StepImage extends StatelessWidget {
  final String imageUrl;
  final String caption;
  final IconData fallbackIcon;

  const StepImage({
    super.key,
    required this.imageUrl,
    required this.caption,
    required this.fallbackIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: AppTheme.cardShadow,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: AppTheme.primaryLight,
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppTheme.primaryLight,
                  child: Center(
                    child: Icon(
                      fallbackIcon,
                      color: AppTheme.primary,
                      size: 48,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          caption,
          style: const TextStyle(
            color: AppTheme.textMedium,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
