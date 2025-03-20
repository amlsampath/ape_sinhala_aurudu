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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(),
            Positioned(top: -200, child: Image.asset('assets/bg.png')),
            Positioned.fill(
              child: Container(color: const Color.fromARGB(222, 255, 255, 255)),
            ),
            Positioned(
              top: 10,
              left: 20,
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: const Offset(4, 4),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      SinhalaUnicode.sinhalaToUnicode("නව අවුරුදු ගණන්"),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'FMEmaneex',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.15,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                    const SizedBox(height: 10),
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
                            _formatTime(
                              _countdownDuration.inHours.remainder(24),
                            ),
                            "පැය",
                          ),
                          _buildTimeCard(
                            _formatTime(
                              _countdownDuration.inMinutes.remainder(60),
                            ),
                            "මිනිත්තු",
                          ),
                          _buildTimeCard(
                            _formatTime(
                              _countdownDuration.inSeconds.remainder(60),
                            ),
                            "තත්පර",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const CompassScreen(),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            SinhalaUnicode.sinhalaToUnicode(
                              widget.nekathModel.description,
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'FMBindumathi',
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
