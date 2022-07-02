import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mopasborsacebimde/data/static/global/mycolors.dart';
import 'package:mopasborsacebimde/models/usdtprofit.dart';

usdtProfitListFunc(
  List<UsdtProfit> usdtProfitList,
  BuildContext context,
  TextEditingController textFieldController,
  Color usdtProfitColor,
) {
  return StaggeredGridView.count(
    scrollDirection: Axis.vertical,
    crossAxisCount: 3,
    mainAxisSpacing: 6,
    children: <Widget>[
      getTitle(),
      getForeksKur(usdtProfitList, usdtProfitColor),
      getTextField(textFieldController),
      getUsdtList(
          context, usdtProfitList, textFieldController, usdtProfitColor),
    ],
    staggeredTiles: [
      StaggeredTile.extent(3, MediaQuery.of(context).size.height * 0.10),
      StaggeredTile.extent(1, MediaQuery.of(context).size.height * 0.10),
      StaggeredTile.extent(2, MediaQuery.of(context).size.height * 0.10),
      StaggeredTile.extent(3, MediaQuery.of(context).size.width),
    ],
  );
}

getUsdtList(
  BuildContext context,
  List<UsdtProfit> usdtProfitList,
  TextEditingController textFieldController,
  Color usdtProfitColor,
) {
  List<String> cacheValue = ["", "", "", ""];
  var sayi;

  print(MediaQuery.of(context).size.height.toString());
  print(MediaQuery.of(context).size.width.toString());

  for (int k = 0; k < cacheValue.length; k++) {
    try {
      cacheValue[k] = ((usdtProfitList[k + 1].profit *
                  int.parse(textFieldController.text)) /
              usdtProfitList[0].price)
          .toStringAsFixed(3);
    } catch (error) {
      print(error);
    }
  }
  if (MediaQuery.of(context).size.height > 550)
    sayi = (MediaQuery.of(context).size.width /
            MediaQuery.of(context).size.height) -
        0.11;
  if (MediaQuery.of(context).size.height > 650)
    sayi = (MediaQuery.of(context).size.width /
            MediaQuery.of(context).size.height) -
        0.04;
  if (MediaQuery.of(context).size.height > 800)
    sayi = (MediaQuery.of(context).size.width /
        MediaQuery.of(context).size.height);

  return Container(
    color: MyColors.kapaliMatSiyah,
    padding: EdgeInsets.symmetric(horizontal: 6.0),
    child: GridView.count(
      primary: false,
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      crossAxisCount: 4,
      childAspectRatio: sayi,
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        for (int i = 1; i < usdtProfitList.length; i++)
          Container(
            color: MyColors.acikMatSiyah,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  usdtProfitList[i].price.toString(),
                  style: TextStyle(
                    color: usdtProfitColor,
                    fontSize: 19,
                    fontFamily: "SourceSansPro",
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  usdtProfitList[i].name,
                  style: TextStyle(
                    color: MyColors.matSari,
                    fontSize: 19,
                    fontFamily: "SourceSansPro",
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        for (int i = 1; i < usdtProfitList.length; i++)
          Container(
            color: MyColors.acikMatSiyah,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  usdtProfitList[i].parite.toStringAsFixed(3) + "%",
                  style: TextStyle(
                    color: usdtProfitColor,
                    fontSize: 19,
                    fontFamily: "SourceSansPro",
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  usdtProfitList[i].name.split(" ")[0] + " Parite",
                  style: TextStyle(
                    color: MyColors.matSari,
                    fontSize: 19,
                    fontFamily: "SourceSansPro",
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        for (int i = 1; i < usdtProfitList.length; i++)
          Container(
            color: MyColors.acikMatSiyah,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  cacheValue[i - 1] + " ₺",
                  style: TextStyle(
                    color: usdtProfitColor,
                    fontSize: 19,
                    fontFamily: "SourceSansPro",
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Profit",
                  style: TextStyle(
                    color: MyColors.matSari,
                    fontSize: 19,
                    fontFamily: "SourceSansPro",
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

getTextField(TextEditingController textFieldController) {
  return Container(
    margin: EdgeInsets.only(right: 6),
    padding: EdgeInsets.all(4),
    alignment: Alignment.center,
    color: MyColors.acikMatSiyah,
    child: Theme(
      data: ThemeData(
        primaryColor: MyColors.matSari,
        primaryColorDark: MyColors.matSari,
      ),
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(11),
        ],
        controller: textFieldController,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: MyColors.matSari,
          fontSize: 22,
          fontFamily: "SourceSansPro",
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hoverColor: MyColors.matSari,
          hintText: 'Cache ',
          hintStyle: TextStyle(
            color: MyColors.matSari,
            fontFamily: "SourceSansPro",
            fontSize: 20,
          ),
        ),
        cursorColor: MyColors.matSari,
      ),
    ),
  );
}

getForeksKur(List<UsdtProfit> usdtProfitList, Color usdtProfitColor) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: 5.0,
      vertical: 8.0,
    ),
    margin: EdgeInsets.only(right: 6, left: 6),
    alignment: Alignment.center,
    color: MyColors.acikMatSiyah,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          usdtProfitList[0].name,
          style: TextStyle(
            color: MyColors.matSari,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontFamily: "SourceSansPro",
          ),
        ),
        Text(
          usdtProfitList[0].price.toString(),
          style: TextStyle(
            color: usdtProfitColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "SourceSansPro",
          ),
        ),
      ],
    ),
  );
}

getTitle() {
  return Container(
    margin: EdgeInsets.only(right: 6, left: 6, top: 6),
    color: MyColors.acikMatSiyah,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "USD to TRY",
          style: TextStyle(
            color: MyColors.matSari,
            fontSize: 20,
            fontFamily: "SourceSansPro",
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    ),
  );
}
