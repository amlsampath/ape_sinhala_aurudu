import 'dart:async';
import 'dart:math';
import 'package:ape_sinhala_aurudu/models/nekath_model.dart';
import 'package:ape_sinhala_aurudu/pages/nekath_details_page.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sinhala_unicode_converter/sinhala_unicode_converter.dart';
import 'package:upgrader/upgrader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _timer;
  Duration _countdownDuration = const Duration(
    days: 20,
    hours: 2,
    minutes: 26,
    seconds: 15,
  );
  final List<NekathModel> availableNekath = [];

  final List<NekathModel> events = [
    NekathModel(
      title: 'නව සඳ බලීම',
      time: DateTime(2025, 03, 30),
      description:
          '''අභිනව චන්ද්‍ර වර්ෂය සදහා මාර්තු මස 30 වැනි ඉරිදා දින ද අභිනව සූර්ය වර්ෂය සදහා මැයි මස 01 වැනි බ්‍රහස්පතින්දා  දින ද නව සද බැලීම මැනවි.''',
      shortDate: 'මාර්තු 30',
      fullDate: 'මාර්තු 30 වන ඉරිදා',
    ),

    NekathModel(
      title: 'පරණ අවුරුද්ද සදහා ස්නානය',
      time: DateTime(2025, 04, 13),
      description:
          '''අප්‍රේල් මස 13 වැනි ඉරිදා දින දිඹුල්පත් යුෂ මිශ්‍ර නානු ගා ස්නානය කොට ඉෂ්ට දේවතා අනුස්මරණයෙහි යෙදී වාසය මැනවි.''',
      shortDate: 'අප්‍රේල් 13',
      fullDate: 'අප්‍රේල් 13 වැනි ඉරිදා',
    ),
    NekathModel(
      title: 'පුණ්‍ය කාලය',
      time: DateTime(2025, 04, 13, 20, 57),
      description:
          '''අප්‍රේල් මස 13 වැනි ඉරිදා අපරභාග 08.57 සිට පසුදින එනම් 14 වැනි සදුදා පූර්වභාග 09.45 දක්වා පුණ්‍ය කාලය බැවින් අප්‍රේල් මස 13 වැනි ඉරිදා අපරභාග 08.57 ට පළමුව ආහාර පාන ගෙන සියලු වැඩ අත්හැර ආගමික වතාවත්වල යෙදීම ද, පුණ්‍ය කාලයේ අපර කොටස එනම් අප්‍රේල් මස 14 වැනි සදුදා පූර්වභාග 03.21 සිට 14 වැනි සදුදා පූර්වභාග 09.45 දක්වා පහත දැක්වෙන අයුරින් අහාර පිසීම,වැඩ ඇල්ලීම,ගනුදෙනු  කිරීම හා ආහාර අනුභවය ආදි නැකත් චාරිත්‍ර විධි ඉටු කිරීම මැනවි.''',
      shortDate: 'අප්‍රේල් 13',
      fullDate: 'අප්‍රේල් 13 වැනි ඉරිදා',
    ),
    NekathModel(
      title: 'අලුත් අවුරුදු උදාව',
      time: DateTime(2025, 04, 14, 03, 21, 00),
      description:
          '''අප්‍රේල් මස 14 වැනි සදුදා දින පූර්වභාග 03.21 ට සිංහල අලුත් අවුරුද්ද උදා වෙයි.''',
      shortDate: 'අප්‍රේල් 14',
      fullDate: 'අප්‍රේල් 14 වැනි සදුදා',
    ),
    NekathModel(
      title: 'ආහාර පිසීම',
      time: DateTime(2025, 04, 14, 04, 04),
      description:
          '''අප්‍රේල් මස 14 වැනි සදුදා පූර්වභාග 04.04 ට තඹ වර්ණ වස්ත්‍රාභරණයෙන් සැරසී දකුණු දිශාව බලා ළිප් බැද ගිනි මොලවා කිරිබතක් ද කැවිලි වර්ගයක් ද දී කිරි සහ විලද ද පිළියෙල කර ගැනීම මැනවි.''',
      shortDate: 'අප්‍රේල් 14',
      fullDate: 'අප්‍රේල් 14 වැනි සදුදා',
      direction: 'දකුණු දිශාව',
    ),
    NekathModel(
      title: 'ආහාර අනුභවය',
      time: DateTime(2025, 04, 14, 06, 44),
      description:
          '''අප්‍රේල් මස 14 වැනි සදුදා පූර්වභාග 06.44ට මුතු හා ශ්වේත වර්ණ වස්ත්‍රාභරණයෙන් සැරසී දකුණු දිශාව බලා සියලු වැඩ අල්ලා ගනුදෙනු කොට ආහාර අනුභව කිරීම මැනවි.''',
      shortDate: 'අප්‍රේල් 14',
      fullDate: 'අප්‍රේල් 14 වැනි සදුදා',
      direction: 'දකුණු දිශාව',
      directionNo: 2,
    ),
    NekathModel(
      title: 'හිසතෙල් ගෑම',
      time: DateTime(2025, 04, 16, 09, 04),
      description:
          '''අප්‍රේල් මස 16 වැනි බදාදා පූර්වභාග 09.04ට පච්ච වර්ණ හෙවත් කොළ පැහැති වස්ත්‍රාභරණයෙන් සැරසී උතුරු දිශාව බලා හිසට කොහොඹ පත් ද, පයට කොළොන් පත් ද තබා කොහොඹ පත් යුෂ මිශ්‍ර නානු හා තෙල් ගා ස්නානය කිරීම මැනවි.''',
      shortDate: 'අප්‍රේල් 16',
      fullDate: 'අප්‍රේල් 16 වැනි බදාදා',
      direction: 'උතුරු දිශාව',
      directionNo: 1,
    ),
    NekathModel(
      title: 'රැකීරක්ෂා සදහා පිටත්ව යෑම',
      time: DateTime(2025, 04, 17, 09, 03),
      description:
          '''අප්‍රේල් මස 17 වැනි බ්‍රහස්පතින්දා පූර්වභාග 09.03ට රන්වන් පැහැති වස්ත්‍රාභරණයෙන් සැරසී කිරිබතක් හා එළකිරි මිශ්‍ර කැවිලි වර්ගයක් අනුභව කර උතුරු දිශාව බලා පිටත්ව යෑම මැනවි.''',
      shortDate: 'අප්‍රේල් 17',
      fullDate: 'අප්‍රේල් 17 වැනි බ්‍රහස්පතින්දා',
      direction: 'උතුරු දිශාව',
      directionNo: 1,
    ),
  ];
  String convertToUnicode(String text) {
    return text;
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
    setCountDown();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownDuration.inSeconds > 0) {
          _countdownDuration -= const Duration(seconds: 1);
        }
      });
    });
  }

  void setCountDown() {
    final currentTime = DateTime.now();
    availableNekath.clear(); // Clear the list before adding new items

    for (var event in events) {
      if (currentTime.isBefore(event.time)) {
        availableNekath.add(event);
      }
    }

    if (availableNekath.isEmpty) {
      // If no upcoming events, show message
      return;
    }

    // Sort events by date
    availableNekath.sort((a, b) => a.time.compareTo(b.time));
    _countdownDuration = availableNekath[0].time.difference(currentTime);
    setState(() {}); // Refresh UI with the new countdown
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int time) {
    return time.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: UpgradeAlert(
        child: Stack(
          children: [
            Container(),
            Positioned(top: -200, child: Image.asset('assets/bg.png')),
            Positioned.fill(
              child: Container(color: const Color.fromARGB(222, 255, 255, 255)),
            ),
            Positioned.fill(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * .05),
                      Text(
                        SinhalaUnicode.sinhalaToUnicode(
                          "සුභ අලුත් අවුරුද්දක් වේවාæ",
                        ),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'FMEmaneex',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        SinhalaUnicode.sinhalaToUnicode(
                          "අලුත් අවුරුද්දේ  නැකැත් හා වේලාවන්",
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontFamily: 'FMEmaneex',
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Countdown Timer Box
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade200,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child:
                            availableNekath.isEmpty
                                ? Center(
                                  child: Text(
                                    SinhalaUnicode.sinhalaToUnicode(
                                      "මෙම වසරේ සියලුම නැකැත් අවසන්",
                                    ),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'FMEmaneex',
                                    ),
                                  ),
                                )
                                : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          SinhalaUnicode.sinhalaToUnicode(
                                            availableNekath[0].title,
                                          ),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'FMEmaneex',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      SinhalaUnicode.sinhalaToUnicode(
                                        availableNekath[0].fullDate!,
                                      ),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'FMBindumathi',
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      SinhalaUnicode.sinhalaToUnicode(
                                        availableNekath[0].description,
                                      ),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'FMBindumathi',
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    // Timer Display
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildTimeCard(
                                          _formatTime(
                                            _countdownDuration.inDays,
                                          ),
                                          "දින",
                                        ),
                                        _buildTimeCard(
                                          _formatTime(
                                            _countdownDuration.inHours
                                                .remainder(24),
                                          ),
                                          "පැය",
                                        ),
                                        _buildTimeCard(
                                          _formatTime(
                                            _countdownDuration.inMinutes
                                                .remainder(60),
                                          ),
                                          "මිනිත්තු",
                                        ),
                                        _buildTimeCard(
                                          _formatTime(
                                            _countdownDuration.inSeconds
                                                .remainder(60),
                                          ),
                                          "තත්පර",
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    // Button
                                    if (availableNekath.isNotEmpty)
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return NekathDetailsPage(
                                                    nekathModel:
                                                        availableNekath[0],
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.brown,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text(
                                            SinhalaUnicode.sinhalaToUnicode(
                                              "විස්තර බලන්න",
                                            ),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'FMEmaneex',
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                      ),
                      const SizedBox(height: 20),
                      // Upcoming Events List
                      Text(
                        SinhalaUnicode.sinhalaToUnicode("ඉදිරි කාලසටහන්"),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'FMBindumathi',
                        ),
                      ),
                      SizedBox(height: size.height * .02),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: availableNekath.length,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return const SizedBox.shrink();
                          }
                          return _buildEventCard(availableNekath[index]);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

  Widget _buildEventCard(NekathModel nekathModel) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return NekathDetailsPage(nekathModel: nekathModel);
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: size.height * .1,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: HexColor('#FADA7A'),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    SinhalaUnicode.sinhalaToUnicode(nekathModel.shortDate!),
                    style: TextStyle(fontSize: 20, fontFamily: 'FMGanganeex'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 7,
              child: Container(
                height: size.height * .1,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: HexColor('#FADA7A'),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nekathModel.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'FMGanganee',
                      ),
                    ),
                    Text(
                      SinhalaUnicode.sinhalaToUnicode(nekathModel.description),
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'FMBindumathi',
                      ),
                      maxLines: 2,
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
