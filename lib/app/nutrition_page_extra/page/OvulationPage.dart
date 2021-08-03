import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:lifecoach_app/app/nutrition_page_extra/page/OvulationResultPage.dart';

import 'package:flutter/material.dart';
import 'package:lifecoach_app/app/nutrition_page_extra/generated/l10n.dart';
import 'package:lifecoach_app/app/nutrition_page_extra/model/ResultModel.dart';
import 'package:lifecoach_app/app/nutrition_page_extra/model/RowItem.dart';
import 'package:lifecoach_app/app/nutrition_page_extra/page/ChartPage.dart';
import 'package:lifecoach_app/app/nutrition_page_extra/utils/ConstantData.dart';
import 'package:lifecoach_app/app/nutrition_page_extra/utils/ConstantWidget.dart';
import 'package:lifecoach_app/app/nutrition_page_extra/utils/SizeConfig.dart';


class OvulationPage extends StatefulWidget {
  @override
  _OvulationPage createState() {
    return _OvulationPage();
  }
}

class _OvulationPage extends State<OvulationPage> {
  Color themeColor = ConstantData.primaryColor;

  DateTime currentDate = DateTime.now();

  RowItem rowItem;
  String stringDate = "";

  ResultModel resultModel;

  @override
  void dispose() {
   
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
 passData();
    

    setState(() {
      stringDate = ConstantData.getFormattedDate(new DateTime.now());
    });
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop();
    return new Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    rowItem = ConstantData.getThemeColor(context);
    themeColor = rowItem.color;
    SizeConfig().init(context);

    return ConstantWidget.getMainDefaultWidget(
        context, getWidget(), rowItem, _requestPop);
  }

  getWidget() {
    double sliderHeight = SizeConfig.safeBlockVertical * 18;
    double margin = ConstantWidget.getPercentSize(sliderHeight, 13);

    return ListView(
      children: [
        SizedBox(
          height: (margin),
        ),
        ConstantWidget.getDefaultTextWidget(
            S.of(context).chooseThe1stDayOfYourLastMenstrualPeriod,
            TextAlign.center,
            FontWeight.w500,
            ConstantWidget.getWidthPercentSize(context, 5),
            ConstantData.textColor),
        SizedBox(
          height: (margin),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstantWidget.getDefaultTextWidget(
                S.of(context).dateChosen,
                TextAlign.center,
                FontWeight.w500,
                ConstantWidget.getWidthPercentSize(context, 3.5),
                ConstantData.textColor),
            SizedBox(
              width: (margin * 2),
            ),
            ConstantWidget.getDefaultTextWidget(
                stringDate,
                TextAlign.center,
                FontWeight.w500,
                ConstantWidget.getWidthPercentSize(context, 3.5),
                themeColor),
          ],
        ),
        SizedBox(
          height: (margin),
        ),
        Wrap(
          children: [
            getButton(
                Icons.calendar_today, S.of(context).chooseDate, _selectDate),
            getButton(null, S.of(context).calculate, calculate)
          ],
        ),
        ConstantWidget.getButton(
            context, S.of(context).menstrualCycleCalendar, themeColor, () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChartPage(rowItem),
              ));
        })
      ],
    );
  }

  calculate() {
    if (stringDate.isNotEmpty && stringDate != null) {
      resultModel = new ResultModel();

        var thirtyDaysFromNow = currentDate.add(new Duration(days: 12));
      var thirtyDaysFromNow1 = thirtyDaysFromNow.add(new Duration(days: 4));

      resultModel.value1 = ConstantData.getFormattedDate(thirtyDaysFromNow);
      resultModel.value2 = ConstantData.getFormattedDate(thirtyDaysFromNow1);
 passData();
      
    }
  }

  Future<void> _selectDate() async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: themeColor,
              accentColor: themeColor,
              colorScheme: ColorScheme.light(primary: themeColor),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        },
        initialDate: DateTime.now(),
        firstDate: DateTime(2005),
        lastDate: DateTime(2050));

    if (pickedDate != null)
      setState(() {
        currentDate = pickedDate;

        setState(() {
          stringDate = ConstantData.getFormattedDate(currentDate);
        });
      });
  }

  void passData() {
    ConstantWidget.sendData(
        context, resultModel, OvulationResultPage(resultModel, rowItem));
  }

  getButton(var icon, String s, Function function) {
    double buttonHeight = ConstantWidget.getScreenPercentSize(context, 6);
    double buttonWidth = ConstantWidget.getScreenPercentSize(context, 25);

    double subRadius = ConstantWidget.getWidthPercentSize(context, 1.5);
    double fontSize = ConstantWidget.getPercentSize(buttonHeight, 32);
    double iconSize = ConstantWidget.getPercentSize(buttonHeight, 50);
    double sliderHeight = SizeConfig.safeBlockVertical * 18;

    double margin = ConstantWidget.getPercentSize(sliderHeight, 13);

    return Center(
      child: InkWell(
        child: Container(
          margin: EdgeInsets.only(top: margin),
          width: buttonWidth,
          padding:
              EdgeInsets.all(ConstantWidget.getPercentSize(buttonWidth, 1.5)),
          height: buttonHeight,
          decoration: BoxDecoration(
              color: themeColor,
              borderRadius: BorderRadius.all(Radius.circular(subRadius))),
          child: Stack(
            children: [
              Visibility(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                    size: iconSize,
                  ),
                ),
                visible: (icon != null),
              ),
              Center(
                child: ConstantWidget.getDefaultTextWidget(s, TextAlign.center,
                    FontWeight.w500, fontSize, Colors.white),
              )
            ],
          ),
        ),
        onTap: function,
      ),
    );
  }
}
