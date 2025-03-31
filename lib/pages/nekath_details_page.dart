// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:ape_sinhala_aurudu/widgets/compass_widget.dart';
import 'package:flutter/material.dart';

import 'package:ape_sinhala_aurudu/models/nekath_model.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sinhala_unicode_converter/sinhala_unicode_converter.dart';

class NekathDetailsPage extends StatefulWidget {
  final NekathModel nekathModel;
  const NekathDetailsPage({super.key, required this.nekathModel});

  @override
  State<NekathDetailsPage> createState() => _NekathDetailsPageState();
}

class _NekathDetailsPageState extends State<NekathDetailsPage> {
  late Timer _timer;
  Duration _countdownDuration = const Duration();

  String _formatTime(int time) {
    return time.toString().padLeft(2, '0');
  }

  void _startTimer() {
    final currentTime = DateTime.now();
    _countdownDuration = widget.nekathModel.time.difference(currentTime);
    setState(() {}); // Refresh UI with the new countdown
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownDuration.inSeconds > 0) {
          _countdownDuration -= const Duration(seconds: 1);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget _buildTimeCard(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            SinhalaUnicode.sinhalaToUnicode(value),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'FMBindumathi',
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          SinhalaUnicode.sinhalaToUnicode(label),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
            fontFamily: 'FMBindumathi',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          SinhalaUnicode.sinhalaToUnicode("නව අවුරුදු ගණන්"),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'FMEmaneex',
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
            alignment: Alignment(0, -1),
          ),
        ),
        child: Container(
          color: const Color.fromARGB(222, 255, 255, 255),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.nekathModel.fullDate == null
                    ? Container()
                    : Text(
                      SinhalaUnicode.sinhalaToUnicode(
                        widget.nekathModel.fullDate!,
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'FMBindumathi',
                      ),
                    ),
                widget.nekathModel.direction == null
                    ? Container()
                    : Text(
                      SinhalaUnicode.sinhalaToUnicode(
                        widget.nekathModel.direction!,
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'FMBindumathi',
                      ),
                    ),
                SizedBox(height: size.height * .01),
                // Timer Display
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: HexColor('#FADA7A'),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTimeCard(
                        _formatTime(_countdownDuration.inDays),
                        "දින",
                      ),
                      _buildTimeCard(
                        _formatTime(_countdownDuration.inHours.remainder(24)),
                        "පැය",
                      ),
                      _buildTimeCard(
                        _formatTime(_countdownDuration.inMinutes.remainder(60)),
                        "මිනිත්තු",
                      ),
                      _buildTimeCard(
                        _formatTime(_countdownDuration.inSeconds.remainder(60)),
                        "තත්පර",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                widget.nekathModel.direction == null
                    ? Container()
                    : CompassScreen(),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    SinhalaUnicode.sinhalaToUnicode(
                      widget.nekathModel.description,
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'FMBindumathi',
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
