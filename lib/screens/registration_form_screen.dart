import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../navigation_provider.dart';
import '../theme.dart';
import '../widgets/adaptive_widgets.dart';

class RegistrationFormScreen extends StatefulWidget {
  const RegistrationFormScreen({super.key});

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _mobileController = TextEditingController();
  final _altMobileController = TextEditingController();
  final _aadharController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _homeAddressController = TextEditingController();
  final _officeAddressController = TextEditingController();

  final _nomineeNameController = TextEditingController();
  final _nomineeAgeController = TextEditingController();
  final _nomineeEmailController = TextEditingController();
  final _nomineePhoneController = TextEditingController();
  final _bankHolderController = TextEditingController();
  final _bankAccountController = TextEditingController();
  final _confirmAccountController = TextEditingController();
  final _ifscController = TextEditingController();
  final _shareController = TextEditingController(text: '100');

  // Form selections
  String? _selectedSex;
  String? _selectedQualification;
  String? _nomineeSex;
  String _numNominees = '1';

  // Document status
  String? _photoFileName;
  String? _certFileName;
  String? _aadharFileName;

  // Declarations
  bool _acceptRules = false;
  bool _receiveUpdates = true;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _mobileController.dispose();
    _altMobileController.dispose();
    _aadharController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _homeAddressController.dispose();
    _officeAddressController.dispose();
    _nomineeNameController.dispose();
    _nomineeAgeController.dispose();
    _nomineeEmailController.dispose();
    _nomineePhoneController.dispose();
    _bankHolderController.dispose();
    _bankAccountController.dispose();
    _confirmAccountController.dispose();
    _ifscController.dispose();
    _shareController.dispose();
    super.dispose();
  }

  void _submitForm(NavigationProvider navProvider) {
    if (_formKey.currentState!.validate()) {
      if (!_acceptRules) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'You must accept the Rules & Bye-Laws of PWT to proceed.',
            ),
            backgroundColor: AppTheme.danger,
          ),
        );
        return;
      }

      // Successful Registration
      navProvider.registerUser(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        qualification: _selectedQualification ?? 'MBBS',
      );

      // Show success dialog
      final isIOSVal = isIOS(context);
      
      if (isIOSVal) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Application Received'),
            content: const Text(
              'Your membership application has been submitted successfully for verification. You will receive an update once the documents are reviewed.',
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                  navProvider.closeRegistration();
                  navProvider.setTab(0); // return to home
                },
                child: const Text('Go to Home'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: const [
                Icon(Icons.verified, color: AppTheme.success, size: 28),
                SizedBox(width: 8),
                Text('Application Received'),
              ],
            ),
            content: const Text(
              'Your membership application has been submitted successfully for verification. You will receive an update once the documents are reviewed.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  navProvider.closeRegistration();
                  navProvider.setTab(0); // return to home
                },
                child: const Text(
                  'Go to Home',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    final isIOSVal = isIOS(context);

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        leading: IconButton(
          icon: Icon(
            isIOSVal ? CupertinoIcons.clear : Icons.close,
            color: AppTheme.primary,
          ),
          onPressed: () {
            navProvider.closeRegistration();
          },
        ),
        title: const Text('Join Doctors Welfare'),
        centerTitle: true,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section 1: Personal Info
                _buildCardSection(
                  title: 'Personal Information',
                  icon: Icons.person_outline,
                  children: [
                    _buildLabel('Full Name'),
                    _buildTextFormField(
                      controller: _nameController,
                      hintText: 'Dr. Jane Doe',
                      icon: Icons.person,
                      validator: (val) =>
                          val!.isEmpty ? 'Enter full name' : null,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Age'),
                              _buildTextFormField(
                                controller: _ageController,
                                hintText: '35',
                                icon: Icons.cake_outlined,
                                keyboardType: TextInputType.number,
                                validator: (val) {
                                  if (val!.isEmpty) return 'Required';
                                  int? age = int.tryParse(val);
                                  if (age == null) return 'Invalid';
                                  if (age < 18 || age > 60)
                                    return 'Must be 18-60';
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Sex'),
                              DropdownButtonFormField<String>(
                                value: _selectedSex,
                                decoration: _inputDecoration(icon: Icons.wc),
                                items: ['Male', 'Female', 'Other']
                                    .map(
                                      (sex) => DropdownMenuItem(
                                        value: sex,
                                        child: Text(
                                          sex,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) =>
                                    setState(() => _selectedSex = val),
                                validator: (val) =>
                                    val == null ? 'Required' : null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildLabel('Qualification'),
                    DropdownButtonFormField<String>(
                      value: _selectedQualification,
                      decoration: _inputDecoration(icon: Icons.school_outlined),
                      items:
                          [
                                'MBBS',
                                'MD',
                                'MS',
                                'BDS',
                                'MDS',
                                'Dermatologist',
                                'Surgeon',
                                'Physician',
                                'Pediatrician',
                                'Ophthalmologist',
                                'Orthopedic',
                              ]
                              .map(
                                (q) => DropdownMenuItem(
                                  value: q,
                                  child: Text(
                                    q,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (val) =>
                          setState(() => _selectedQualification = val),
                      validator: (val) => val == null ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildLabel('Mobile Number'),
                    _buildTextFormField(
                      controller: _mobileController,
                      hintText: '9876543210',
                      icon: Icons.phone_android,
                      keyboardType: TextInputType.phone,
                      validator: (val) =>
                          val!.length < 10 ? 'Enter valid mobile number' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildLabel('Alternate Mobile Number'),
                    _buildTextFormField(
                      controller: _altMobileController,
                      hintText: '8765432109',
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    _buildLabel('Aadhar Number'),
                    _buildTextFormField(
                      controller: _aadharController,
                      hintText: '1234 5678 9012',
                      icon: Icons.credit_card,
                      keyboardType: TextInputType.number,
                      validator: (val) =>
                          val!.length < 12 ? 'Enter 12 digit Aadhar' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildLabel('Email Address'),
                    _buildTextFormField(
                      controller: _emailController,
                      hintText: 'jane.doe@hospital.org',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) =>
                          !val!.contains('@') ? 'Enter valid email' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildLabel('Password'),
                    _buildTextFormField(
                      controller: _passwordController,
                      hintText: '••••••••',
                      icon: Icons.lock_outline,
                      obscureText: true,
                      validator: (val) =>
                          val!.length < 6 ? 'Password min 6 chars' : null,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Section 2: Document Upload
                _buildCardSection(
                  title: 'Document Upload',
                  icon: Icons.cloud_upload_outlined,
                  children: [
                    _buildFileUploadBox(
                      label: 'Passport Photo (JPEG/PNG)',
                      fileName: _photoFileName,
                      onTap: () =>
                          setState(() => _photoFileName = 'passport_photo.png'),
                    ),
                    const SizedBox(height: 16),
                    _buildFileUploadBox(
                      label: 'Medical Registration Certificate (PDF/JPEG)',
                      fileName: _certFileName,
                      onTap: () => setState(
                        () => _certFileName = 'registration_cert.pdf',
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildFileUploadBox(
                      label: 'Aadhar Card (Both Sides PDF/JPEG)',
                      fileName: _aadharFileName,
                      onTap: () =>
                          setState(() => _aadharFileName = 'aadhar_card.pdf'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Section 3: Address Info
                _buildCardSection(
                  title: 'Address Information',
                  icon: Icons.map_outlined,
                  children: [
                    _buildLabel('House Address'),
                    _buildTextFormField(
                      controller: _homeAddressController,
                      hintText: 'Enter your residential address...',
                      maxLines: 3,
                      validator: (val) =>
                          val!.isEmpty ? 'Enter residential address' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildLabel('Professional / Office Address'),
                    _buildTextFormField(
                      controller: _officeAddressController,
                      hintText: 'Enter your clinic or hospital address...',
                      maxLines: 3,
                      validator: (val) =>
                          val!.isEmpty ? 'Enter clinic/hospital address' : null,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Section 4: Nominee Details
                _buildCardSection(
                  title: 'Nominee Details',
                  icon: Icons.group_outlined,
                  children: [
                    _buildLabel('Number of Nominees'),
                    DropdownButtonFormField<String>(
                      value: _numNominees,
                      decoration: _inputDecoration(icon: Icons.numbers),
                      items: ['1', '2', '3']
                          .map(
                            (count) => DropdownMenuItem(
                              value: count,
                              child: Text(
                                '$count Nominee(s)',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) =>
                          setState(() => _numNominees = val ?? '1'),
                    ),
                    const SizedBox(height: 20),

                    // Nominee 1 form fields
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppTheme.background,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppTheme.border, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nominee 1 Details',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryDark,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildLabel('Nominee Name'),
                          _buildTextFormField(
                            controller: _nomineeNameController,
                            hintText: 'Full name of nominee',
                            validator: (val) =>
                                val!.isEmpty ? 'Enter nominee name' : null,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel('Age'),
                                    _buildTextFormField(
                                      controller: _nomineeAgeController,
                                      hintText: '30',
                                      keyboardType: TextInputType.number,
                                      validator: (val) =>
                                          val!.isEmpty ? 'Required' : null,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLabel('Sex'),
                                    DropdownButtonFormField<String>(
                                      value: _nomineeSex,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 10,
                                        ),
                                      ),
                                      items: ['Male', 'Female', 'Other']
                                          .map(
                                            (sex) => DropdownMenuItem(
                                              value: sex,
                                              child: Text(
                                                sex,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (val) =>
                                          setState(() => _nomineeSex = val),
                                      validator: (val) =>
                                          val == null ? 'Required' : null,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildLabel('Nominee Email'),
                          _buildTextFormField(
                            controller: _nomineeEmailController,
                            hintText: 'nominee@example.com',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 12),
                          _buildLabel('Nominee Phone'),
                          _buildTextFormField(
                            controller: _nomineePhoneController,
                            hintText: 'Mobile number',
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 12),
                          _buildLabel('Bank Account Holder Name'),
                          _buildTextFormField(
                            controller: _bankHolderController,
                            hintText: 'Nominee bank account name',
                            validator: (val) =>
                                val!.isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 12),
                          _buildLabel('Bank Account Number'),
                          _buildTextFormField(
                            controller: _bankAccountController,
                            hintText: 'Account number',
                            keyboardType: TextInputType.number,
                            validator: (val) =>
                                val!.isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 12),
                          _buildLabel('Confirm Account Number'),
                          _buildTextFormField(
                            controller: _confirmAccountController,
                            hintText: 'Re-enter account number',
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val!.isEmpty) return 'Required';
                              if (val != _bankAccountController.text)
                                return 'Accounts mismatch';
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          _buildLabel('IFSC Code'),
                          _buildTextFormField(
                            controller: _ifscController,
                            hintText: 'IFSC1234567',
                            validator: (val) =>
                                val!.isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 12),
                          _buildLabel('Percentage Share %'),
                          _buildTextFormField(
                            controller: _shareController,
                            hintText: '100',
                            keyboardType: TextInputType.number,
                            validator: (val) =>
                                val!.isEmpty ? 'Required' : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Declarations & Checkboxes
                _buildCardSection(
                  title: 'Declaration & Submission',
                  icon: Icons.gavel_outlined,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isIOSVal)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0, top: 4.0),
                            child: Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                value: _acceptRules,
                                onChanged: (val) =>
                                    setState(() => _acceptRules = val),
                              ),
                            ),
                          )
                        else
                          Checkbox(
                            value: _acceptRules,
                            activeColor: AppTheme.primary,
                            onChanged: (val) =>
                                setState(() => _acceptRules = val ?? false),
                          ),
                        const Expanded(
                          child: Text(
                            'I declare that I have read and agree to follow all Rules, Regulations, and Bye-Laws of PWT mutual support. I understand that assistance claims depend strictly on voluntary member contributions and are not legally enforceable debts.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.textDark,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        if (isIOSVal)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                value: _receiveUpdates,
                                onChanged: (val) =>
                                    setState(() => _receiveUpdates = val),
                              ),
                            ),
                          )
                        else
                          Checkbox(
                            value: _receiveUpdates,
                            activeColor: AppTheme.primary,
                            onChanged: (val) =>
                                setState(() => _receiveUpdates = val ?? false),
                          ),
                        const Expanded(
                          child: Text(
                            'I agree to receive welfare alerts, updates, and messaging notifications.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.textMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: AdaptiveButton(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        onPressed: () => _submitForm(navProvider),
                        child: const Text(
                          'Submit Application',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppTheme.textDark,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    IconData? icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 14),
      decoration: _inputDecoration(hintText: hintText, icon: icon),
      validator: validator,
    );
  }

  InputDecoration _inputDecoration({String? hintText, IconData? icon}) {
    return InputDecoration(
      prefixIcon: icon != null ? Icon(icon, size: 20) : null,
      hintText: hintText,
      hintStyle: const TextStyle(color: AppTheme.textLight, fontSize: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  Widget _buildCardSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
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
              Icon(icon, color: AppTheme.primary, size: 22),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppTheme.textDark,
                ),
              ),
            ],
          ),
          const Divider(height: 24, color: AppTheme.border),
          ...children,
        ],
      ),
    );
  }

  Widget _buildFileUploadBox({
    required String label,
    required String? fileName,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        CustomPaint(
          painter: DashedBorderPainter(
            color: AppTheme.primary.withOpacity(0.5),
          ),
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                children: [
                  Icon(
                    fileName != null
                        ? Icons.check_circle
                        : Icons.cloud_upload_outlined,
                    color: fileName != null
                        ? AppTheme.success
                        : AppTheme.primary,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    fileName ?? 'Choose file to upload',
                    style: TextStyle(
                      color: fileName != null
                          ? AppTheme.successText
                          : AppTheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Supported: PDF, JPG, PNG (Max 5MB)',
                    style: TextStyle(color: AppTheme.textLight, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Dashed border custom painter
class DashedBorderPainter extends CustomPainter {
  final Color color;

  DashedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(8),
        ),
      );

    // Dash pattern: 6px dash, 4px gap
    double dashWidth = 6.0;
    double dashSpace = 4.0;
    double distance = 0.0;

    for (final pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        final length = dashWidth;
        canvas.drawPath(
          pathMetric.extractPath(distance, distance + length),
          paint,
        );
        distance += length + dashSpace;
      }
      distance = 0.0;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
