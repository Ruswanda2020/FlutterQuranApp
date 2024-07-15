import 'dart:convert';

import 'package:alquran_app/global.dart';
import 'package:alquran_app/models/ayat.dart';
import 'package:alquran_app/models/surah.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailSurah extends StatelessWidget {
  final int noSurah;
  const DetailSurah({super.key, required this.noSurah});

  // Fungsi untuk mengambil detail Surah dari API
  Future<Surah> _getDetailSurah() async {
    final dio = Dio();
    try {
      // Mengambil data dari endpoint API
      final dataResponse =
          await dio.get('https://equran.id/api/surat/$noSurah');
      // Mengonversi data JSON ke objek Surah
      return Surah.fromJson(dataResponse.data);
    } catch (e) {
      // Menangani kesalahan dengan melempar pengecualian
      throw Exception('Failed to load Surah');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Surah>(
      future: _getDetailSurah(),
      initialData: null,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Menampilkan indikator loading saat data sedang diambil
          return Scaffold(
            backgroundColor: background,
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          // Menampilkan pesan kesalahan jika terjadi error
          return Scaffold(
            backgroundColor: background,
            body: const Center(child: Text('Failed to load Surah')),
          );
        } else if (!snapshot.hasData) {
          // Menangani kasus jika tidak ada data yang ditemukan
          return Scaffold(
            backgroundColor: background,
            body: const Center(child: Text('No data found')),
          );
        }

        // Menampilkan data Surah jika berhasil diambil
        Surah surah = snapshot.data!;
        return Scaffold(
          backgroundColor: background,
          appBar: _appBar(context: context, surah: surah),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: _detils(surah: surah),
              ),
            ],
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: ListView.separated(
                  itemBuilder: (context, index) => _ayatItem(
                      ayat: surah.ayat!
                          .elementAt(index + (noSurah == 1 ? 1 : 0))),
                  separatorBuilder: (context, index) => Container(),
                  itemCount: surah.jumlahAyat + (noSurah == 1 ? -1 : 0)),
            ),
          ),
        );
      }),
    );
  }

  Widget _ayatItem({required Ayat ayat}) => Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                  color: gray, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(27 / 2)),
                    child: Center(
                      child: Text(
                        '${ayat.nomor}',
                        style: GoogleFonts.amiri(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.share_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Icon(
                    Icons.play_arrow_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Icon(
                    Icons.bookmark_outline,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              ayat.ar,
              style: GoogleFonts.amiri(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              ayat.idn,
              style: GoogleFonts.poppins(color: text, fontSize: 16),
            )
          ],
        ),
      );

  Padding _detils({required Surah surah}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Stack(
          children: [
            Container(
                height: 257,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [
                        0,
                        .6,
                        1
                      ],
                      colors: [
                        Color(0xFFDF98FA),
                        Color(0xFFB070FD),
                        Color(0xFF9055FF)
                      ]),
                )),
            Positioned(
                bottom: 0,
                right: 0,
                child: Opacity(
                    opacity: .2,
                    child: SvgPicture.asset(
                      "assets/svgs/quran.svg",
                      width: 324 - 55,
                    ))),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    surah.namaLatin,
                    style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    surah.arti,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Divider(
                    color: Colors.white.withOpacity(.30),
                    thickness: 2,
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        surah.tempatTurun.name,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
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
                            color: Colors.white),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${surah.jumlahAyat} Ayat",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SvgPicture.asset("assets/svgs/bismillah.svg")
                ],
              ),
            )
          ],
        ),
      );
}

// Fungsi untuk membuat AppBar dengan informasi Surah
AppBar _appBar({required BuildContext context, required Surah surah}) => AppBar(
      backgroundColor: background,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Row(children: [
        // Tombol kembali
        IconButton(
            onPressed: (() => Navigator.of(context).pop()),
            icon: SvgPicture.asset('assets/svgs/back-icon.svg')),
        const SizedBox(
          width: 24,
        ),
        // Nama Latin Surah
        Text(
          surah.namaLatin,
          style: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const Spacer(),
        // Tombol pencarian (belum ada fungsi)
        IconButton(
            onPressed: (() => {}),
            icon: SvgPicture.asset('assets/svgs/search-icon.svg')),
      ]),
    );
