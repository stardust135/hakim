import 'package:flutter/material.dart';
import '../models/blood_pressure_model.dart';
import '../services/database_helper.dart';
import 'package:intl/intl.dart' as intl;

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<BloodPressure>> _bloodPressuresFuture;

  @override
  void initState() {
    super.initState();
    _bloodPressuresFuture = DatabaseHelper.instance.getAllBloodPressures();
  }

  String _formatTime(DateTime dateTime) {
    return intl.DateFormat('HH:mm').format(dateTime);
  }

  String _formatDate(DateTime dateTime) {
    return intl.DateFormat('yyyy-MM-dd').format(dateTime);
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value),
      ],
    );
  }

  Widget _buildBloodPressureCard(BloodPressure bp) {
    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 7,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatTime(bp.dateTime)),
              Text(_formatDate(bp.dateTime)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildRow('سیستولیک', bp.systolic.toString()),
                _buildRow('دیاستولیک', bp.diastolic.toString()),
                _buildRow('ضربان قلب', bp.pulse.toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تاریخچه فشار خون'),
          backgroundColor: Colors.blueGrey.shade800,
        ),
        body: FutureBuilder<List<BloodPressure>>(
          future: _bloodPressuresFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('خطا در بارگذاری اطلاعات'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('هیچ داده‌ای موجود نیست'));
            }

            final bloodPressures = snapshot.data!;
            return ListView.builder(
              itemCount: bloodPressures.length,
              itemBuilder: (context, index) {
                return _buildBloodPressureCard(bloodPressures[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
