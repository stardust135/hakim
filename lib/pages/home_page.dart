import 'package:flutter/material.dart';
import 'package:hakim/pages/connect_bluetooth.dart';
import 'package:hakim/pages/history_page.dart';
import 'package:hakim/pages/manual_entry_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      ManualEntryPage(),
      const ConnectBluetooth(),
      HistoryPage(),
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _buildMenu(context, pages),
      ),
    );
  }

  Widget _buildMenu(BuildContext context, List<Widget> pages) {
    List<String> titles = [
      'وارد کردن دستی',
      'اتصال به بلوتوث',
      'مشاهده تاریخچه',
      'وارد کردن با عکس',
    ];
    List<IconData> icons = [
      Icons.edit_note_rounded,
      Icons.bluetooth_audio_rounded,
      Icons.history_rounded,
      Icons.add_a_photo_rounded,
    ];
    return Column(
      children: [
        const SizedBox(height: 25),
        ...List.generate(
          titles.length,
          (index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                // if index == 3 should take picture without navigating
                if(index != 3) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pages[index],
                      ));
                } else {
                  // image picker
                  // todo
                }
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 13),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 7,
                      // spreadRadius: -1,
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 21),
                  child: Row(
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Icon(
                              icons[index],
                              color: const Color(0xff707070),
                              size: 20,
                            ),
                            const SizedBox(width: 20),
                            Flexible(
                              child: Text(
                                titles[index],
                                style: TextStyle(
                                  color: const Color(0xff515151),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  shadows: [
                                    Shadow(
                                      offset: const Offset(0.0, 1.0),
                                      blurRadius: 5,
                                      color: Colors.grey.shade100,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color(0xff707070),
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
