import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../navigation_provider.dart';
import '../theme.dart';
import '../widgets/adaptive_widgets.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  int _expandedIndex = -1;

  final List<Map<String, String>> _faqs = [
    {
      "q": "What is Doctors Welfare?",
      "a": "Doctors Welfare is a member-based mutual self-support platform exclusively for registered doctors. It is operated by the Professionals Welfare Trust (PWT) — a Public Charitable & Welfare Trust (Non-Profit). It is NOT an insurance company, investment scheme, or profit-making entity."
    },
    {
      "q": "Who is eligible to join Doctors Welfare?",
      "a": "Membership is open to Indian citizens only, specifically registered medical and dental doctors including: Doctors (MBBS, MD, MS), Dentists (BDS, MDS), Dermatologists, Surgeons & Physicians, Pediatricians, Ophthalmologists, Orthopedic Specialists, and other registered medical doctors. Applicants must be aged 60 or below at the time of enrollment."
    },
    {
      "q": "Is there an age limit for membership?",
      "a": "Yes. Applicants must be aged 60 or below at the time of enrollment. Membership terminates automatically at age 65, regardless of the enrollment date. Coverage extends from enrollment up to age 65."
    },
    {
      "q": "What is the lock-in period?",
      "a": "A mandatory lock-in period of 12 months applies from the date of joining. No assistance or claim shall be entertained during the lock-in period. The lock-in is non-waivable under any circumstances."
    },
    {
      "q": "What kind of support does PWT provide?",
      "a": "PWT coordinates voluntary contributions from members to the family/nominee of a deceased member. All contributions are transferred directly from members to the nominee's bank account. PWT acts only as a coordinating and facilitating entity — it does not collect or hold contribution funds. Assistance may be coordinated for death due to natural causes, accidents, or critical illnesses (including cancer)."
    },
    {
      "q": "Does PWT guarantee any specific amount?",
      "a": "No. PWT does not assure or guarantee any amount. Assistance depends entirely on the voluntary cooperation of members. No claim is enforceable as a legal right or debt. Members have no legal claim to receive any fixed or guaranteed benefit."
    },
    {
      "q": "How do contributions work?",
      "a": "When a member passes away, all registered members are required to contribute to the deceased member's nominee. Contributions are made directly to the nominee's bank account — PWT facilitates the coordination. Members must upload valid payment receipts via the official website or designated Google Form. Failure to contribute renders a member ineligible for future assistance."
    },
    {
      "q": "What is a nominee and why is it required?",
      "a": "A nominee is the person designated by a member to receive voluntary contributions from fellow members in case of the member's death. Providing nominee details (including bank account information) is mandatory during registration, as all contributions are transferred directly to the nominee's bank account."
    },
    {
      "q": "What are the exclusions for assistance?",
      "a": "No assistance shall be provided where: (1) Death involves suicide or homicide allegations involving the nominee, (2) Criminal proceedings or misrepresentation exists, (3) The member had not completed the lock-in period, (4) The member had not fulfilled contribution obligations, or (5) There is fraud or suppression of facts. The final decision rests solely with the Trustees."
    },
    {
      "q": "Can I cancel my membership?",
      "a": "Yes, participation may be discontinued at any time, subject to terms and conditions. However, membership fees are non-refundable, and no claim or refund shall arise after termination. Voluntary withdrawals may rejoin after fulfilling all outstanding financial obligations."
    },
    {
      "q": "What happens if I don't contribute when required?",
      "a": "Failure to make a contribution or upload proof within the stipulated period will render you ineligible for assistance. Non-cooperation or failure to contribute shall automatically suspend your membership. Membership may be reinstated upon full payment of all outstanding dues."
    },
    {
      "q": "How is the sequence of assistance determined?",
      "a": "In case of multiple deaths, support is extended in order of date of death. If multiple deaths occur on the same date, the member with the highest average contribution ratio receives priority. PWT reserves the right to determine the final order of assistance in exceptional cases."
    },
    {
      "q": "Is membership transferable?",
      "a": "No. Membership is non-transferable and non-assignable. It does not create any legal or contractual right to benefits."
    },
    {
      "q": "What digital platform does PWT operate?",
      "a": "PWT operates a Mobile App, Website, Helpline, and Online communication systems. The platform is used for crisis alerts, information sharing, coordination of voluntary support, and doctor networking. Members shall not misuse the platform — prohibited acts include false information, commercial exploitation, and abusive conduct."
    },
    {
      "q": "Which courts have jurisdiction over PWT matters?",
      "a": "Courts at Hyderabad, Telangana State alone shall have jurisdiction over any matters related to PWT. The Trustees' interpretation of Rules & Bye-Laws shall be final and binding."
    },
  ];

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
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppTheme.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Text(
                r'$',
                style: TextStyle(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Doctors Welfare',
                  style: TextStyle(
                    color: AppTheme.textDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  'An initiative of Professionals Welfare Trust',
                  style: TextStyle(
                    color: AppTheme.textMedium,
                    fontSize: 10,
                  ),
                ),
              ],
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
        centerTitle: false,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // FAQ Hero Banner
            Container(
              width: double.infinity,
              color: AppTheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Frequently Asked Questions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Find answers to common questions about Doctors Welfare membership, mutual support, and processes',
                    style: TextStyle(
                      color: Color(0xFFD0E1FD),
                      fontSize: 14,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // By-Laws Intro Text
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.primary.withOpacity(0.15), width: 1),
                ),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: AppTheme.primaryDark,
                      fontSize: 13,
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(text: 'Can\'t find what you\'re looking for? Contact our support team or read our complete '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: InkWell(
                          onTap: () {
                            // Link placeholder
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Downloading PWT By-Laws PDF...')),
                            );
                          },
                          child: const Text(
                            'By-Laws',
                            style: TextStyle(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
              ),
            ),

            // FAQ Accordion List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _faqs.length,
                itemBuilder: (context, index) {
                  bool isExpanded = _expandedIndex == index;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isExpanded ? AppTheme.primary.withOpacity(0.3) : AppTheme.border,
                        width: 1,
                      ),
                      boxShadow: AppTheme.cardShadow,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            _faqs[index]['q']!,
                            style: TextStyle(
                              color: isExpanded ? AppTheme.primary : AppTheme.textDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          trailing: Icon(
                            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: isExpanded ? AppTheme.primary : AppTheme.textMedium,
                          ),
                          onTap: () {
                            setState(() {
                              _expandedIndex = isExpanded ? -1 : index;
                            });
                          },
                        ),
                        if (isExpanded)
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                _faqs[index]['a']!,
                                style: const TextStyle(
                                  color: AppTheme.textMedium,
                                  fontSize: 13,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // "Still Have Questions?" Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.background,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.border, width: 1),
                ),
                child: Column(
                  children: [
                    Text(
                      'Still Have Questions?',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.textDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Our support team is here to help you with any additional questions or concerns about PWT membership.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.textMedium,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),
                    AdaptiveButton(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      onPressed: () {
                        navProvider.navigateToContactUs();
                      },
                      child: const Text(
                        'Contact Us',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
}
