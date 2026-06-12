import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../navigation_provider.dart';
import '../theme.dart';
import '../widgets/adaptive_widgets.dart';

class MembershipDetailsScreen extends StatelessWidget {
  const MembershipDetailsScreen({super.key});

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
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primary, Color(0xFF04409C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Membership Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Voluntary membership in a mutual self-support trust for registered doctors — benefits strictly restricted to registered members only',
                    style: TextStyle(
                      color: Color(0xFFEFF6FF),
                      fontSize: 14,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),

            // How Mutual Support Works
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How Mutual Support Works',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.textDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'PWT coordinates voluntary contributions from members to the nominee of a deceased member — directly and transparently',
                    style: TextStyle(
                      color: AppTheme.textMedium,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Swipable Carousel
                  const SupportCarousel(),
                ],
              ),
            ),

            // Member Obligations & Support Details (Inside Blue Container Box)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: AppTheme.cardShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Member Obligations & Support Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildObligationCard(
                      context: context,
                      title: 'Contribution Compliance',
                      bulletIcon: Icons.check,
                      iconColor: AppTheme.primary,
                      bullets: [
                        'Members must contribute voluntarily to the nominee of a deceased member as per prescribed guidelines',
                        'All contributions transferred directly to nominee\'s bank account',
                        'Must upload valid payment receipts via website or designated Google Form',
                        'Failure to contribute or upload proof renders member ineligible for assistance',
                        'Non-cooperation automatically suspends membership',
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildObligationCard(
                      context: context,
                      title: 'Conditions for Assistance',
                      bulletIcon: Icons.check,
                      iconColor: AppTheme.primary,
                      bullets: [
                        'Death due to natural causes, accidents, or critical illnesses (including cancer)',
                        'Member must have completed the 12-month lock-in period',
                        'Member must have fulfilled all contribution obligations',
                        'No fraud, suppression of facts, or misrepresentation',
                        'Final decision rests solely with the Trustees',
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildObligationCard(
                      context: context,
                      title: 'Lock-In Period',
                      bulletIcon: Icons.check,
                      iconColor: AppTheme.primary,
                      bullets: [
                        'Mandatory lock-in period of 12 months from date of joining',
                        'No assistance or claim entertained during lock-in',
                        'Lock-in is non-waivable under any circumstances',
                        'After lock-in, member becomes eligible for mutual support',
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildObligationCard(
                      context: context,
                      title: 'Exclusions',
                      bulletIcon: Icons.warning_amber_rounded,
                      iconColor: const Color(0xFFF1C40F),
                      bullets: [
                        'Death involving suicide or homicide allegations involving nominee',
                        'Criminal proceedings or misrepresentation',
                        'PWT does not guarantee any amount — assistance depends on voluntary cooperation',
                        'No claim is enforceable as a right or debt',
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Eligibility Criteria Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.border, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Eligibility Criteria',
                        style: TextStyle(
                          color: AppTheme.textDark,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Who Can Join?
                    const Text(
                      'Who Can Join?',
                      style: TextStyle(
                        color: AppTheme.textDark,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Membership is open to Indian citizens only — registered medical and dental doctors in the following categories:',
                      style: TextStyle(
                        color: AppTheme.textMedium,
                        fontSize: 13,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _buildCheckmarkRow(const Text('Doctors (MBBS, MD, MS)', style: TextStyle(color: AppTheme.textMedium, fontSize: 13))),
                    _buildCheckmarkRow(const Text('Dentists (BDS, MDS)', style: TextStyle(color: AppTheme.textMedium, fontSize: 13))),
                    _buildCheckmarkRow(const Text('Dermatologists', style: TextStyle(color: AppTheme.textMedium, fontSize: 13))),
                    _buildCheckmarkRow(const Text('Surgeons & Physicians', style: TextStyle(color: AppTheme.textMedium, fontSize: 13))),
                    _buildCheckmarkRow(const Text('Pediatricians', style: TextStyle(color: AppTheme.textMedium, fontSize: 13))),
                    _buildCheckmarkRow(const Text('Ophthalmologists', style: TextStyle(color: AppTheme.textMedium, fontSize: 13))),
                    _buildCheckmarkRow(const Text('Orthopedic Specialists', style: TextStyle(color: AppTheme.textMedium, fontSize: 13))),
                    _buildCheckmarkRow(const Text('Other Registered Medical Doctors', style: TextStyle(color: AppTheme.textMedium, fontSize: 13))),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: AppTheme.border),
                    ),

                    // Age & Membership Rules
                    const Text(
                      'Age & Membership Rules',
                      style: TextStyle(
                        color: AppTheme.textDark,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _buildCheckmarkRow(
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'Applicants must be aged '),
                            TextSpan(text: '60 or below', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                            TextSpan(text: ' at the time of enrollment'),
                          ],
                        ),
                        style: TextStyle(color: AppTheme.textMedium, fontSize: 13),
                      ),
                    ),
                    _buildCheckmarkRow(
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'Membership terminates automatically at age '),
                            TextSpan(text: '65', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                          ],
                        ),
                        style: TextStyle(color: AppTheme.textMedium, fontSize: 13),
                      ),
                    ),
                    _buildCheckmarkRow(const Text('Membership is non-transferable and non-assignable', style: TextStyle(color: AppTheme.textMedium, fontSize: 13))),
                    _buildCheckmarkRow(const Text('A yearly membership fee of ₹100 is required to register and maintain membership', style: TextStyle(color: AppTheme.textMedium, fontSize: 13))),
                    _buildCheckmarkRow(const Text('Membership does not create any legal or contractual right to benefits', style: TextStyle(color: AppTheme.textMedium, fontSize: 13))),
                    _buildCheckmarkRow(const Text('Voluntary withdrawals may rejoin after fulfilling all financial obligations', style: TextStyle(color: AppTheme.textMedium, fontSize: 13))),
                    _buildCheckmarkRow(const Text('Participation may be discontinued at any time, subject to terms', style: TextStyle(color: AppTheme.textMedium, fontSize: 13))),
                  ],
                ),
              ),
            ),

            // Bottom CTA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Ready to Join?',
                    style: TextStyle(
                      color: AppTheme.textDark,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Become part of a doctors community built on voluntary mutual support. Read our By-Laws before applying.',
                    style: TextStyle(
                      color: AppTheme.textMedium,
                      fontSize: 14,
                      height: 1.45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: AdaptiveButton(
                      backgroundColor: AppTheme.primary,
                      onPressed: () {
                        navProvider.openRegistration();
                      },
                      child: const Text(
                        'Apply for Membership',
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildObligationCard({
    required BuildContext context,
    required String title,
    required IconData bulletIcon,
    required Color iconColor,
    required List<String> bullets,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 12),
          ...bullets.map((bullet) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(bulletIcon, color: iconColor, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        bullet,
                        style: const TextStyle(
                          color: AppTheme.textMedium,
                          fontSize: 13,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildCheckmarkRow(Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check,
            color: AppTheme.primary,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class SupportCarousel extends StatefulWidget {
  const SupportCarousel({super.key});

  @override
  State<SupportCarousel> createState() => _SupportCarouselState();
}

class _SupportCarouselState extends State<SupportCarousel> {
  int _currentIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'icon': Icons.volunteer_activism_outlined,
        'title': 'Voluntary Membership',
        'desc': 'Membership is purely voluntary. No person shall be compelled to join or continue their membership.',
      },
      {
        'icon': Icons.currency_rupee_outlined,
        'title': 'Direct Contributions',
        'desc': 'All contributions are transferred directly from members to the nominee\'s bank account. PWT is not a financial intermediary.',
      },
      {
        'icon': Icons.family_restroom_outlined,
        'title': 'Nominee Protection',
        'desc': 'Designated nominee receives voluntary support from fellow members in the event of the member\'s passing.',
      },
      {
        'icon': Icons.phone_android_outlined,
        'title': 'App-Based Coordination',
        'desc': 'Digital platform for crisis alerts, information sharing, coordination of support, and doctor networking.',
      },
    ];

    return Column(
      children: [
        SizedBox(
          height: 255,
          child: PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final item = items[index];
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.08)).clamp(0.92, 1.0);
                  } else {
                    value = index == _currentIndex ? 1.0 : 0.92;
                  }
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.border, width: 1),
                    boxShadow: AppTheme.cardShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(item['icon'] as IconData, color: AppTheme.primary, size: 36),
                      const SizedBox(height: 14),
                      Text(
                        item['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Text(
                          item['desc'] as String,
                          style: const TextStyle(
                            color: AppTheme.textMedium,
                            fontSize: 14,
                            height: 1.5,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            items.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 6,
              width: _currentIndex == index ? 16 : 6,
              decoration: BoxDecoration(
                color: _currentIndex == index ? AppTheme.primary : AppTheme.border,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
