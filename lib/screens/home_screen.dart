import 'package:alquran_app/global.dart';
import 'package:alquran_app/tabs/hijb_tab.dart';
import 'package:alquran_app/tabs/page_tab.dart';
import 'package:alquran_app/tabs/para_tab.dart';
import 'package:alquran_app/tabs/surah_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        appBar: _appBar(),
        bottomNavigationBar: _bottomNavigationBar(),
        body: DefaultTabController(
          length: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: _greeting(),
                ),
                SliverAppBar(
                  pinned: true,
                  elevation: 0,
                  backgroundColor: background,
                  automaticallyImplyLeading: false,
                  shape: Border(
                      bottom: BorderSide(
                          width: 3,
                          color: const Color(0xFFAAAAAA).withOpacity(.1))),
                  bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(0), child: _tab()),
                )
              ],
              body: const TabBarView(
                children: [SurahTab(), ParaTab(), PageTab(), HijbTab()],
              ),
            ),
          ),
        ));
  }

  TabBar _tab() {
    return TabBar(
        unselectedLabelColor: text,
        labelColor: Colors.white,
        indicatorColor: primary,
        indicatorWeight: 3,
        tabs: [
          _tabItem(label: "Surah"),
          _tabItem(label: "Para"),
          _tabItem(label: "Page"),
          _tabItem(label: "Hijb"),
        ]);
  }

  Tab _tabItem({required String label}) {
    return Tab(
      child: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Column _greeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Assalamu'alikum",
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w500, color: text),
        ),
        Text(
          "Ruswanda",
          style: GoogleFonts.poppins(
              fontSize: 40, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        const SizedBox(
          height: 24,
        ),
        _lastRead()
      ],
    );
  }

  Stack _lastRead() {
    return Stack(
      children: [
        Container(
            height: 131,
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
            child: SvgPicture.asset("assets/svgs/quran.svg")),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/svgs/book.svg"),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Last Read",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Al-Fatihah",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              Text(
                "Ayat No: 1",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              )
            ],
          ),
        )
      ],
    );
  }

  BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: gray,
        items: [
          _bottomItem(icon: 'assets/svgs/quran-icon.svg', label: 'Quran'),
          _bottomItem(icon: 'assets/svgs/lampu-icon.svg', label: 'Tips'),
          _bottomItem(icon: 'assets/svgs/prey-icon.svg', label: 'Prayer'),
          _bottomItem(icon: 'assets/svgs/doa-icon.svg', label: 'Doa'),
          _bottomItem(icon: 'assets/svgs/bookmerk-icon.svg', label: 'Bookmerk'),
        ],
      );

  BottomNavigationBarItem _bottomItem(
      {required String icon, required String label}) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(text, BlendMode.srcIn),
      ),
      activeIcon: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(primary, BlendMode.srcIn),
      ),
      label: label,
    );
  }

  AppBar _appBar() => AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: background,
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/svgs/menu-icon.svg",
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Text(
              "Quran App",
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                "assets/svgs/search-icon.svg",
              ),
            ),
          ],
        ),
      );
}
