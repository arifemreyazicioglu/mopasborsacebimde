import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';

class BorsaAppBttmNvg {
  static BottomNavigationBar getBtmNvgBar(
    BuildContext context,
    int currentPageIndex,
  ) {
    return BottomNavigationBar(
      selectedItemColor: MyColors.matSari,
      unselectedItemColor: Colors.black,
      selectedFontSize: 13,
      unselectedFontSize: 13,
      elevation: 0,
      backgroundColor: MyColors.acikMatSiyah,
      onTap: (index) {
        print(index);
        switch (index) {
          case 0: // portföy
            Navigator.pushNamedAndRemoveUntil(
                context, "/portfoy", (route) => false);
            break;
          case 1: // piyasalar
            Navigator.pushNamedAndRemoveUntil(
                context, "/piyasalar", (route) => false);
            break;
          case 2: //cüzadan
            Navigator.pushNamedAndRemoveUntil(
                context, "/wallet", (route) => false);
        }
      },
      currentIndex: currentPageIndex,
      items: [
        BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.briefcase,
            size: 20,
          ),
          label: ('Portföy'),
        ),
        BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.exchangeAlt,
            size: 20,
          ),
          label: ('Piyasalar'),
        ),
        BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.wallet,
            size: 20,
          ),
          label: ('Cüzdan'),
        ),
      ],
    );
  }
}
