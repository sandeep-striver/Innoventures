import 'package:flutter/material.dart';

// This widget represents the Donor registration screen.
class DonorScreen extends StatefulWidget {
  const DonorScreen({super.key});

  @override
  State<DonorScreen> createState() => _DonorScreenState();
}

class _DonorScreenState extends State<DonorScreen> {
  String? _selectedBloodGroup;
  final TextEditingController _locationController = TextEditingController();
  DateTime? _lastDonationDate;
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  // New state variables for disease checks.
  bool _hasHadMalaria = false;
  bool _hasHadTyphoid = false;
  bool _hasHadJaundice = false;

  final List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  @override
  void dispose() {
    _locationController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  // Method to show the date picker dialog.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _lastDonationDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFE55B5B), // Header background color
              onPrimary: Colors.white, // Header text color
              surface: Colors.white, // Calendar background color
              onSurface: Color(0xFF2C3E50), // Calendar text color
            ),
            dialogTheme: DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _lastDonationDate) {
      setState(() {
        _lastDonationDate = pickedDate;
      });
    }
  }

  void _checkEligibility() {
    // Check for basic required fields
    if (_selectedBloodGroup == null || _locationController.text.isEmpty) {
      _showAttractiveMessage(
        context,
        'Please fill in all the required fields.',
        Icons.warning_amber,
        Colors.orange,
      );
      return;
    }

    // Check age and weight criteria
    final int? age = int.tryParse(_ageController.text);
    final int? weight = int.tryParse(_weightController.text);

    if (age == null || age < 18 || age > 65) {
      _showAttractiveMessage(
        context,
        'You must be between 18 and 65 years old to donate blood.',
        Icons.info,
        const Color(0xFFE55B5B),
      );
      return;
    }

    if (weight == null || weight < 50) {
      _showAttractiveMessage(
        context,
        'You must weigh at least 50 kg to donate blood.',
        Icons.info,
        const Color(0xFFE55B5B),
      );
      return;
    }

    // Check last donation date
    if (_lastDonationDate != null) {
      final DateTime threeMonthsAgo = DateTime.now().subtract(
        const Duration(days: 90),
      );
      if (_lastDonationDate!.isAfter(threeMonthsAgo)) {
        _showAttractiveMessage(
          context,
          'You are not eligible to donate. Your last donation was within the last 3 months.',
          Icons.block,
          Colors.red,
        );
        return;
      }
    }

    // New: Check for specific diseases in the past year.
    final DateTime oneYearAgo = DateTime.now().subtract(
      const Duration(days: 365),
    );
    if (_hasHadMalaria || _hasHadTyphoid || _hasHadJaundice) {
      _showAttractiveMessage(
        context,
        'You are not eligible to donate due to recent health issues. Please consult with a doctor or blood bank representative.',
        Icons.sick_outlined,
        Colors.red,
      );
      return;
    }

    // If all checks pass, show a success message.
    _showAttractiveMessage(
      context,
      'You are eligible to donate! Thank you for your interest.',
      Icons.favorite,
      Colors.green,
    );
  }

  // Method to show attractive dialog messages.
  void _showAttractiveMessage(
    BuildContext context,
    String message,
    IconData icon,
    Color color,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 60),
                const SizedBox(height: 20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFEE8E8), Color(0xFFFFFFFF)],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              expandedHeight: 120.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: EdgeInsets.only(bottom: 20.0),
                title: Text(
                  'Donate Blood',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(24.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildBloodGroupDropdown(),
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: _locationController,
                    label: 'Location',
                    hint: 'Enter your location',
                    icon: Icons.location_on_outlined,
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: _ageController,
                    label: 'Age',
                    hint: 'Enter your age',
                    keyboardType: TextInputType.number,
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: _weightController,
                    label: 'Weight (in kg)',
                    hint: 'Enter your weight',
                    keyboardType: TextInputType.number,
                    icon: Icons.monitor_weight_outlined,
                  ),
                  const SizedBox(height: 20),
                  _buildLastDonationDateField(),
                  const SizedBox(height: 20),
                  // New health criteria checkboxes
                  _buildHealthCheckboxes(),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _checkEligibility,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 8,
                        shadowColor: const Color(0xFF4CAF50).withOpacity(0.4),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                            size: 28,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'CHECK ELIGIBILITY',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // New widget to build the health criteria checkboxes.
  Widget _buildHealthCheckboxes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Health Questionnaire',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 10),
        _buildCheckboxTile(
          'Have you had malaria in the last year?',
          _hasHadMalaria,
          (bool? newValue) {
            setState(() {
              _hasHadMalaria = newValue ?? false;
            });
          },
        ),
        _buildCheckboxTile(
          'Have you had typhoid in the last year?',
          _hasHadTyphoid,
          (bool? newValue) {
            setState(() {
              _hasHadTyphoid = newValue ?? false;
            });
          },
        ),
        _buildCheckboxTile(
          'Have you had jaundice in the last year?',
          _hasHadJaundice,
          (bool? newValue) {
            setState(() {
              _hasHadJaundice = newValue ?? false;
            });
          },
        ),
      ],
    );
  }

  // Reusable widget for a single checkbox tile.
  Widget _buildCheckboxTile(
    String title,
    bool value,
    ValueChanged<bool?> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: CheckboxListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Color(0xFF2C3E50)),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFFE55B5B),
      ),
    );
  }

  // Existing helper methods...

  Widget _buildLastDonationDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Last Donation Date',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: InkWell(
            onTap: () => _selectDate(context),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: Color(0xFFE55B5B),
                  size: 24,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    _lastDonationDate != null
                        ? "${_lastDonationDate!.toLocal().day}/${_lastDonationDate!.toLocal().month}/${_lastDonationDate!.toLocal().year}"
                        : 'Select date (optional)',
                    style: TextStyle(
                      fontSize: 18,
                      color:
                          _lastDonationDate != null
                              ? const Color(0xFF2C3E50)
                              : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
              prefixIcon:
                  icon != null
                      ? Icon(icon, color: const Color(0xFFE55B5B))
                      : null,
              prefixIconConstraints:
                  icon != null ? const BoxConstraints(minWidth: 40) : null,
            ),
            style: const TextStyle(fontSize: 18, color: Color(0xFF2C3E50)),
          ),
        ),
      ],
    );
  }

  Widget _buildBloodGroupDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Blood Group',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedBloodGroup,
              hint: const Text(
                'Select Blood Group',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              icon: const Icon(Icons.arrow_drop_down, color: Color(0xFFE55B5B)),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedBloodGroup = newValue;
                });
              },
              items:
                  _bloodGroups.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
