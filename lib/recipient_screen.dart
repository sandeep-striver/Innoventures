import 'package:flutter/material.dart';

class RecipientScreen extends StatefulWidget {
  const RecipientScreen({super.key});

  @override
  State<RecipientScreen> createState() => _RecipientScreenState();
}

class _RecipientScreenState extends State<RecipientScreen> {
  final TextEditingController _patientNameController = TextEditingController();
  String? _selectedBloodGroup;
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _medicalReasonController =
      TextEditingController();

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

  bool _isPatientNameEmpty = false;
  bool _isBloodGroupEmpty = false;
  bool _isQuantityEmpty = false;
  bool _isHospitalEmpty = false;
  bool _isMedicalReasonEmpty = false;

  @override
  void dispose() {
    _patientNameController.dispose();
    _quantityController.dispose();
    _hospitalController.dispose();
    _medicalReasonController.dispose();
    super.dispose();
  }

  void _sendNotification() {
    setState(() {
      _isPatientNameEmpty = _patientNameController.text.isEmpty;
      _isBloodGroupEmpty = _selectedBloodGroup == null;
      _isQuantityEmpty = _quantityController.text.isEmpty;
      _isHospitalEmpty = _hospitalController.text.isEmpty;
      _isMedicalReasonEmpty = _medicalReasonController.text.isEmpty;
    });

    List<String> missingFields = [];
    if (_isPatientNameEmpty) missingFields.add('Patient Name');
    if (_isBloodGroupEmpty) missingFields.add('Blood Group');
    if (_isQuantityEmpty) missingFields.add('Quantity');
    if (_isHospitalEmpty) missingFields.add('Hospital');
    if (_isMedicalReasonEmpty) missingFields.add('Medical Reason');

    if (missingFields.isNotEmpty) {
      String message =
          'Please fill in the following details:\n${missingFields.join(', ')}.';
      _showAttractiveMessage(
        context,
        message,
        Icons.warning_amber,
        Colors.orange,
      );
      return;
    }

    print('Sending notification with the following details:');
    print('Patient Name: ${_patientNameController.text}');
    print('Required Blood Group: $_selectedBloodGroup');
    print('Quantity Needed: ${_quantityController.text}');
    print('Hospital/Location: ${_hospitalController.text}');
    print('Medical Reason: ${_medicalReasonController.text}');

    _showAttractiveMessage(
      context,
      'Notification sent to nearby donors!',
      Icons.check_circle_outline,
      Colors.green,
    );
  }

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
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
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
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              expandedHeight: 120.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: const EdgeInsets.only(bottom: 20.0),
                title: const Text(
                  'Recipient',
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
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: _patientNameController,
                    label: 'Patient Name',
                    hint: 'Aakash',
                    icon: Icons.person_outline,
                    isError: _isPatientNameEmpty,
                  ),
                  const SizedBox(height: 20),
                  _buildBloodGroupDropdown(isError: _isBloodGroupEmpty),
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: _quantityController,
                    label: 'Quantity',
                    hint: '1 units',
                    keyboardType: TextInputType.number,
                    icon: Icons.format_list_numbered,
                    isError: _isQuantityEmpty,
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: _hospitalController,
                    label: 'Hospital',
                    hint: 'Park Hospital,Gurugram',
                    icon: Icons.local_hospital_outlined,
                    isError: _isHospitalEmpty,
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    controller: _medicalReasonController,
                    label: 'Medical Reason',
                    hint: 'Surgery due to injury',
                    maxLines: 3,
                    icon: Icons.medical_services_outlined,
                    isError: _isMedicalReasonEmpty,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _sendNotification,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3F51B5),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        'SEND NOTIFICATION',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    IconData? icon,
    bool isError = false,
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isError ? Colors.red.shade400 : Colors.grey.shade200,
              width: isError ? 2.0 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    isError
                        ? Colors.red.withOpacity(0.2)
                        : Colors.grey.withOpacity(0.1),
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
              contentPadding: EdgeInsets.zero,
              prefixIcon:
                  icon != null
                      ? Icon(icon, color: const Color(0xFFE55B5B), size: 24)
                      : null,
              prefixIconConstraints:
                  icon != null ? const BoxConstraints(minWidth: 40) : null,
            ),
            style: const TextStyle(fontSize: 18, color: Color(0xFF2C3E50)),
            onChanged: (text) {
              if (isError && text.isNotEmpty) {
                setState(() {
                  // Clear error state when user starts typing
                  if (controller == _patientNameController)
                    _isPatientNameEmpty = false;
                  if (controller == _quantityController)
                    _isQuantityEmpty = false;
                  if (controller == _hospitalController)
                    _isHospitalEmpty = false;
                  if (controller == _medicalReasonController)
                    _isMedicalReasonEmpty = false;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBloodGroupDropdown({bool isError = false}) {
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
            border: Border.all(
              color: isError ? Colors.red.shade400 : Colors.grey.shade200,
              width: isError ? 2.0 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    isError
                        ? Colors.red.withOpacity(0.2)
                        : Colors.grey.withOpacity(0.1),
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
                  if (isError && newValue != null) {
                    _isBloodGroupEmpty = false;
                  }
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
