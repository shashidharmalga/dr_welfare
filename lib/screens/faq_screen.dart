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
      'q': 'What is Doctors Welfare?',
      'a': 'Doctors Welfare is a mutual self-support trust initiated by Professionals Welfare Trust (PWT) designed to provide support to the families of deceased doctors through voluntary contributions.'
    },
    {
      'q': 'Who is eligible to join Doctors Welfare?',
      'a': 'Any registered medical practitioner in India (MBBS, MD, MS, BDS, MDS, etc.) holding valid council registration who is under 60 years of age.'
    },
    {
      'q': 'Is there an age limit for membership?',
      'a': 'Yes. Minimum enrollment age is 18 and maximum is 60. Membership automatically terminates at age 65.'
    },
    {
      'q': 'What is the lock-in period?',
      'a': 'A 12-month lock-in period applies post-enrollment. Assistance is restricted to accident-related claims during this duration. Natural death claims are only valid after 12 months.'
    },
    {
      'q': 'What kind of support does PWT provide?',
      'a': 'PWT coordinates mutual support where registered members contribute directly to the nominee of a deceased member. It provides the digital infrastructure for this coordination.'
    },
    {
      'q': 'Does PWT guarantee any specific amount?',
      'a': 'No, PWT does not guarantee a fixed amount as it depends entirely on the voluntary contributions of active members at the time of a member\'s passing.'
    },
    {
      'q': 'How do contributions work?',
      'a': 'When an active member passes away, PWT alerts all members. Each member is required to transfer their contribution directly to the designated nominee\'s bank account.'
    },
    {
      'q': 'What is a nominee and why is it required?',
      'a': 'A nominee is the family member designated by the doctor to receive direct bank contributions from other members in the event of the doctor\'s passing.'
    },
    {
      'q': 'What are the exclusions for assistance?',
      'a': 'Exclusions include deaths by suicide, homicide allegations involving the nominee, and claims submitted with misrepresentation or during the lock-in period.'
    },
    {
      'q': 'Can I cancel my membership?',
      'a': 'Yes, membership can be cancelled at any time by notifying PWT. However, past contributions are voluntary and non-refundable.'
    },
    {
      'q': 'What happens if I don\'t contribute when required?',
      'a': 'Failure to contribute to a verified call for assistance leads to warnings. Continued non-cooperation will suspend or terminate your membership.'
    },
    {
      'q': 'How is the sequence of assistance determined?',
      'a': 'Assistance is processed based on the chronological order of verified claims received by PWT, subject to completion of all required documentation.'
    },
    {
      'q': 'Is membership transferable?',
      'a': 'No, membership is personal and cannot be transferred to any other person or family member.'
    },
    {
      'q': 'What digital platform does PWT operate?',
      'a': 'PWT operates a web-based portal and mobile app coordination system to send alerts, track contributions, and upload receipts.'
    },
    {
      'q': 'Which courts have jurisdiction over PWT matters?',
      'a': 'Any dispute arising out of PWT operations shall be subject to the exclusive jurisdiction of the competent courts in Hyderabad, Telangana.'
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
