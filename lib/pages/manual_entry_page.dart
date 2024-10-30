import 'package:flutter/material.dart';
import '../models/blood_pressure_model.dart';
import '../services/database_helper.dart';

class ManualEntryPage extends StatefulWidget {
  @override
  _ManualEntryPageState createState() => _ManualEntryPageState();
}

class _ManualEntryPageState extends State<ManualEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _systolicController = TextEditingController();
  final TextEditingController _diastolicController = TextEditingController();
  final TextEditingController _pulseController = TextEditingController();

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      final bp = BloodPressure(
        systolic: int.parse(_systolicController.text),
        diastolic: int.parse(_diastolicController.text),
        pulse: int.parse(_pulseController.text),
        dateTime: DateTime.now(),
      );
      await DatabaseHelper.instance.insertBloodPressure(bp);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ثبت شد!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('وارد کردن دستی'),
          backgroundColor: Colors.blueGrey.shade800,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField('فشار سیستولیک', _systolicController),
                _buildTextField('فشار دیاستولیک', _diastolicController),
                _buildTextField('ضربان قلب', _pulseController),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveData,
                  style: ButtonStyle(
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.blueGrey.shade700,
                    ),
                  ),
                  child: const Text('ثبت'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'لطفا مقدار را وارد کنید';
        }
        return null;
      },
    );
  }
}
