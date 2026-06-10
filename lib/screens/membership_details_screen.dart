import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../navigation_provider.dart';
import '../theme.dart';

class MembershipDetailsScreen extends StatelessWidget {
  const MembershipDetailsScreen({super.key});

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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Membership Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Voluntary membership in a mutual self-support trust for registered doctors — benefits strictly restricted to registered members only.',
                    style: TextStyle(
                      color: Colors.blue[100],
                      fontSize: 14,
                      height: 1.4,
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
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 4 Cards grid
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.8,
                    children: [
                      _buildSupportCard(
                        icon: Icons.volunteer_activism_outlined,
                        title: 'Voluntary Membership',
                        desc:
                            'Membership is purely voluntary. No person shall be compelled to join the self-support scheme.',
                      ),
                      _buildSupportCard(
                        icon: Icons.currency_rupee_outlined,
                        title: 'Direct Contributions',
                        desc:
                            'All contributions are transferred directly from members to the nominee\'s bank account. PWT is not a financial intermediary.',
                      ),
                      _buildSupportCard(
                        icon: Icons.family_restroom_outlined,
                        title: 'Nominee Protection',
                        desc:
                            'Designated nominee receives voluntary support from fellow members in the event of the member\'s passing.',
                      ),
                      _buildSupportCard(
                        icon: Icons.phone_android_outlined,
                        title: 'App-Based Coordination',
                        desc:
                            'Digital platform for crisis alerts, contribution tracking, info sharing, and doctor networking.',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Member Obligations & Support Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Member Obligations & Support Details',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.textDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildObligationCard(
                    context: context,
                    title: 'Contribution Compliance',
                    icon: Icons.assignment_turned_in_outlined,
                    iconBg: AppTheme.primaryLight,
                    iconColor: AppTheme.primary,
                    desc:
                        'Mandatory voluntary nominee contributions, receipt uploads via the website or designated Google form. Non-cooperation suspends membership.',
                  ),
                  const SizedBox(height: 16),

                  _buildObligationCard(
                    context: context,
                    title: 'Conditions for Assistance',
                    icon: Icons.fact_check_outlined,
                    iconBg: const Color(0xFFD1E7DD),
                    iconColor: AppTheme.success,
                    desc:
                        'Natural passing, accident, or critical illness (e.g. cancer) support after completing the 12-month lock-in period without misrepresentation.',
                  ),
                  const SizedBox(height: 16),

                  _buildObligationCard(
                    context: context,
                    title: 'Lock-In Period',
                    icon: Icons.hourglass_empty_outlined,
                    iconBg: AppTheme.warningLight,
                    iconColor: AppTheme.warningText,
                    desc:
                        'A 12-month lock-in period applies post-enrollment. Assistance is restricted to accident-related claims during this duration.',
                  ),
                  const SizedBox(height: 16),

                  // Exclusions (Warning Card)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.dangerLight,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.danger.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: AppTheme.danger,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Exclusions & Disclaimers',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.dangerText,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Suicide or homicide allegations involving the nominee immediately exclude assistance; no claim is enforceable as a legally binding right or debt. Contributions are voluntary support acts.',
                                style: TextStyle(
                                  color: AppTheme.dangerText,
                                  fontSize: 13,
                                  height: 1.4,
                                ),
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

            // Eligibility Criteria (Who Can Join?)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Eligibility Criteria (Who Can Join?)',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.textDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Doctors registered with relevant State Medical Councils in India practicing in the following specialties:',
                    style: TextStyle(color: AppTheme.textMedium, fontSize: 14),
                  ),
                  const SizedBox(height: 16),

                  // Specialties Grid
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        [
                              'MBBS',
                              'MD',
                              'MS',
                              'BDS',
                              'MDS',
                              'Dermatologists',
                              'Surgeons',
                              'Physicians',
                              'Pediatricians',
                              'Ophthalmologists',
                              'Orthopedics',
                            ]
                            .map(
                              (spec) => Chip(
                                label: Text(spec),
                                backgroundColor: Colors.white,
                                labelStyle: const TextStyle(
                                  color: AppTheme.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                                side: const BorderSide(
                                  color: AppTheme.primaryLight,
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ],
              ),
            ),

            // Age & Membership Rules
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Age & Membership Rules',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.textDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildRuleRow(
                    Icons.arrow_forward_ios,
                    'Minimum enrollment age is 18; maximum age to join is 60 years.',
                  ),
                  const SizedBox(height: 10),
                  _buildRuleRow(
                    Icons.arrow_forward_ios,
                    'Membership automatically terminates upon completing 65 years of age.',
                  ),
                  const SizedBox(height: 10),
                  _buildRuleRow(
                    Icons.arrow_forward_ios,
                    'Lock-in period of 12 months is mandatory starting from the registration approval date.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // CTA Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    navProvider.openRegistration();
                  },
                  child: const Text(
                    'Apply for Membership',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Footer
            // _buildFooter(context, navProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportCard({
    required IconData icon,
    required String title,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border, width: 1),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.primary, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(
                color: AppTheme.textMedium,
                fontSize: 10,
                height: 1.4,
              ),
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildObligationCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String desc,
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
            padding: const EdgeInsets.all(8),
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
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  desc,
                  style: const TextStyle(
                    color: AppTheme.textMedium,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRuleRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.arrow_right_alt, color: AppTheme.primary, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppTheme.textMedium,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildFooter(BuildContext context, NavigationProvider navProvider) {
  //   return Container(
  //     color: const Color(0xFF0F172A), // Very Dark Slate
  //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // Logo & Name
  //         Row(
  //           children: [
  //             Container(
  //               width: 32,
  //               height: 32,
  //               decoration: const BoxDecoration(
  //                 color: Colors.white24,
  //                 shape: BoxShape.circle,
  //               ),
  //               child: const Center(
  //                 child: Icon(Icons.local_hospital, color: Colors.white, size: 18),
  //               ),
  //             ),
  //             const SizedBox(width: 10),
  //             const Text(
  //               'DRS Welfare',
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 18,
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 16),

  //         // Description
  //         const Text(
  //           'A mutual self-support digital trust created by professionals, dedicated to assisting families of healthcare practitioners in times of need.',
  //           style: TextStyle(
  //             color: Color(0xFF94A3B8),
  //             fontSize: 12,
  //             height: 1.5,
  //           ),
  //         ),
  //         const SizedBox(height: 24),

  //         // Quick Links
  //         const Text(
  //           'Quick Links',
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontWeight: FontWeight.bold,
  //             fontSize: 14,
  //           ),
  //         ),
  //         const SizedBox(height: 12),
  //         _buildFooterLink('Home', () => navProvider.setTab(0)),
  //         _buildFooterLink('About Us', () => navProvider.setTab(1)),
  //         _buildFooterLink('Eligibility', () => navProvider.setTab(2)),
  //         _buildFooterLink('FAQs', () => navProvider.navigateToFAQ()),
  //         _buildFooterLink('Contact Us', () => navProvider.navigateToContactUs()),
  //         const SizedBox(height: 24),

  //         // Contact details
  //         const Text(
  //           'Contact Info',
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontWeight: FontWeight.bold,
  //             fontSize: 14,
  //           ),
  //         ),
  //         const SizedBox(height: 12),
  //         _buildFooterContactRow(Icons.location_on, 'Hyderabad, Telangana, India'),
  //         _buildFooterContactRow(Icons.email, 'drswelfareindia@gmail.com'),
  //         const SizedBox(height: 24),

  //         // Live visitor counter
  //         Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
  //           decoration: BoxDecoration(
  //             color: Colors.white.withOpacity(0.06),
  //             borderRadius: BorderRadius.circular(6),
  //             border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
  //           ),
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               const Icon(Icons.people_alt_outlined, color: Colors.greenAccent, size: 16),
  //               const SizedBox(width: 8),
  //               Text(
  //                 'Total Visitors: 46',
  //                 style: TextStyle(
  //                   color: Colors.greenAccent[100],
  //                   fontSize: 12,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(height: 28),

  //         // Copyright
  //         const Divider(color: Colors.white10),
  //         const SizedBox(height: 12),
  //         const Center(
  //           child: Text(
  //             '© 2025 Professionals Welfare Trust. All Rights Reserved.',
  //             style: TextStyle(
  //               color: Color(0xFF475569),
  //               fontSize: 11,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  //   Widget _buildFooterLink(String text, VoidCallback onTap) {
  //     return InkWell(
  //       onTap: onTap,
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 4),
  //         child: Text(
  //           text,
  //           style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
  //         ),
  //       ),
  //     );
  //   }

  //   Widget _buildFooterContactRow(IconData icon, String text) {
  //     return Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 4),
  //       child: Row(
  //         children: [
  //           Icon(icon, color: const Color(0xFF64748B), size: 16),
  //           const SizedBox(width: 10),
  //           Text(
  //             text,
  //             style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
}
