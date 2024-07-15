import 'dart:convert';

import 'package:alquran_app/global.dart';
import 'package:alquran_app/models/surah.dart';
import 'package:alquran_app/screens/detail_surah.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SurahTab extends StatelessWidget {
  const SurahTab({super.key});

  Future<List<Surah>> _getSurahList() async {
    String data = await rootBundle.loadString("assets/datas/list-surah.json");
    List<dynamic> jsonData = json.decode(data);
    return jsonData.map((item) => Surah.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Surah>>(
        future: _getSurahList(),
        initialData: const [],
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return ListView.separated(
              itemBuilder: (context, index) => _surahItem(
                  context: context, surah: snapshot.data!.elementAt(index)),
              separatorBuilder: (context, index) => Divider(
                    color: const Color(0xFFAAAAAA).withOpacity(.35),
                  ),
              itemCount: snapshot.data!.length);
        });
  }

  Widget _surahItem({required Surah surah, required BuildContext context}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailSurah(
              noSurah: surah.nomor,
            ),
          ));
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Row(
              children: [
                Stack(
                  children: [
                    SvgPicture.asset("assets/svgs/no-surah.svg"),
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: Center(
                        child: Text(
                          "${surah.nomor}",
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      surah.namaLatin,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          surah.tempatTurun.name,
                          style: GoogleFonts.poppins(
                              color: text,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: text),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${surah.jumlahAyat} Ayat",
                          style: GoogleFonts.poppins(
                              color: text,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                )),
                Text(
                  surah.nama,
                  style: GoogleFonts.amiri(
                      color: primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )),
      );
}
