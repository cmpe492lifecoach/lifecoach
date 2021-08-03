import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifecoach_app/app/nutrition_page_extra/generated/l10n.dart';
import 'package:lifecoach_app/app/nutrition_page_extra/model/ResultModel.dart';
import 'package:lifecoach_app/app/nutrition_page_extra/model/RowItem.dart';
import 'package:lifecoach_app/app/nutrition_page_extra/page/BodyMassResultPage.dart';
import 'package:lifecoach_app/app/nutrition_page_extra/page/ChartPage.dart';
import 'package:lifecoach_app/app/nutrition_page_extra/utils/ConstantData.dart';
import 'package:lifecoach_app/app/nutrition_page_extra/utils/ConstantWidget.dart';
import 'package:lifecoach_app/app/nutrition_page_extra/utils/PrefData.dart';
import 'package:lifecoach_app/app/nutrition_page_extra/utils/SizeConfig.dart';

class BodyMassPage extends StatefulWidget {
  @override
  _BodyMassPage createState() {
    return _BodyMassPage();
  }
}

class _BodyMassPage extends State<BodyMassPage> {
  Color themeColor = ConstantData.primaryColor;
  TextEditingController ageController = new TextEditingController();
  TextEditingController weightController = new TextEditingController();
  bool centimeter;
  bool kg;
  TextEditingController ftController = new TextEditingController();
  TextEditingController inchController = new TextEditingController();
  RowItem rowItem;
  List<DropdownMenuItem<String>> genderList;
  List<DropdownMenuItem<String>> typeList;
  List<DropdownMenuItem<String>> currencyList;
  String selectGender;
  String selectCurrency;
  String selectType;
  String string = "";

  ResultModel resultModel;

  @override
  void dispose() {
    super.dispose();
  }



  @override
  void initState() {
    super.initState();
 passData();
    


    Future.delayed(Duration.zero, () {
      setState(() {
        genderList = buildAndGetDropDownMenuItems(
            [S.of(context).male, S.of(context).female]);
        typeList = buildAndGetDropDownMenuItems(
            [S.of(context).foot, S.of(context).centimeter]);

        currencyList = buildAndGetDropDownMenuItems(
            [S.of(context).kilogram, S.of(context).pounds]);
        selectGender = genderList[0].value;
        selectType = typeList[0].value;

        string = S.of(context).ft;

        setDefaultData();
      });
    });
  }

  setDefaultData() async {
    int age = await PrefData.getAge();
    int gender = await PrefData.getGender();
    double height = await PrefData.getHeight();
    double weight = await PrefData.getWeight();
    centimeter = await PrefData.getCM();
    kg = await PrefData.getKG();
    ageController.text = age.toString();

    if (gender == null) {
      gender = 0;
    }

    selectGender = genderList[gender].value;

    if (centimeter) {
      selectType = typeList[1].value;
      string = S.of(context).cm;
      ftController.text = ConstantData.meterToCm(height).round().toString();
    } else {
      print("age---${ageController.text.toString()}");

      selectType = typeList[0].value;
      string = S.of(context).ft;
      setState(() {
        ConstantData.meterToInchAndFeet(height, ftController, inchController);
      });
    }

    if (kg) {
      selectCurrency = currencyList[0].value;
      weightController.text = weight.round().toString();
    } else {
      selectCurrency = currencyList[1].value;
      weightController.text = ConstantData.kgToPound(weight).round().toString();
    }
    checkData(centimeter);
    setState(() {});
  }

  void checkData(bool val) {
    if (centimeter != val) {
      if (centimeter) {
        if (ConstantData.check(ftController.text) &&
            ConstantData.check(inchController.text)) {
          int i1 = 0;

          try {
            i1 = int.parse(ftController.text);
          } on Exception catch (_) {
            print('never reached');
          }

          int i2 = 0;

          try {
            i2 = int.parse(inchController.text);
          } on Exception catch (_) {
            print('never reached');
          }

          String s =
              ConstantData.meterToCm(ConstantData.feetAndInchToMeter(i1, i2))
                  .round()
                  .toString();

          setState(() {
            ftController.text = s;
          });
        }
      } else {
        if (ConstantData.check(ftController.text)) {
          setState(() {
            ConstantData.meterToInchAndFeet(
                ConstantData.cmToMeter(double.parse(ftController.text)),
                ftController,
                inchController);
          });
        }
      }
    }
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List fruits) {
    List<DropdownMenuItem<String>> items = [];
    for (String fruit in fruits) {
      items.add(new DropdownMenuItem(value: fruit, child: new Text(fruit)));
    }
    return items;
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


    return ConstantWidget.getMainDefaultWidget(context, getWidget(), rowItem, _requestPop);


  }


  getWidget(){
    double cellHeight = ConstantWidget.getScreenPercentSize(context, 7);
    double allMargin = ConstantWidget.getScreenPercentSize(context, 1);
    double width = ConstantWidget.getWidthPercentSize(context, 2);
    return  ListView(
      children: [
        Container(
          height: cellHeight,
          margin: EdgeInsets.only(top: allMargin),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstantWidget.getImage(
                  themeColor, context, "gender.png"),
              Expanded(
                child: ConstantWidget.getTextFiled(
                    context,
                    themeColor,
                    S.of(context).enterAge,
                    cellHeight,
                    ageController),
                flex: 1,
              ),
              SizedBox(
                width: width,
              ),
              Container(
                width: ConstantWidget.getWidthPercentSize(
                    context, 30),
                child: ConstantWidget.getDropDown(
                    context, selectGender, genderList,
                        (value) {
                      setState(() {
                        selectGender = value;
                      });
                    }),
              )
            ],
          ),
        ),
        Container(
          height: cellHeight,
          margin: EdgeInsets.only(top: allMargin),
          child: Row(
            children: [
              ConstantWidget.getImage(
                  themeColor, context, "height.png"),
              Expanded(
                child: ConstantWidget.getDropDown(
                    context, selectType, typeList, (value) {
                  bool oldVal = centimeter;

                  setState(() {
                    selectType = value;

                    centimeter = (selectType ==
                        S.of(context).centimeter);

                    checkData(oldVal);

                    if (selectType ==
                        S.of(context).centimeter) {
                      string = S.of(context).cm;
                    } else {
                      string = S.of(context).ft;
                    }
                  });
                }),
                flex: 1,
              ),
              Expanded(
                child: Container(),
                flex: 1,
              )
            ],
          ),
        ),
        Container(
          height: cellHeight,
          margin: EdgeInsets.only(top: allMargin),
          child: Row(
            children: [
              ConstantWidget.getImage(
                  themeColor, context, "centimeter.png"),
              Expanded(
                child: ConstantWidget.getTextFiled(
                    context,
                    themeColor,
                    S.of(context).enterHeight,
                    cellHeight,
                    ftController),
                flex: 1,
              ),
              SizedBox(
                width: width,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ConstantWidget.getDefaultTextWidget(
                      string,
                      TextAlign.start,
                      FontWeight.w400,
                      ConstantWidget.getPercentSize(
                          cellHeight, 30),
                      ConstantData.textColor),
                ),
                flex: 1,
              )
            ],
          ),
        ),
        Visibility(
          child: Container(
            height: cellHeight,
            margin: EdgeInsets.only(top: (allMargin)),
            child: Row(
              children: [
                ConstantWidget.getImage(
                    themeColor, context, "inch.png"),
                Expanded(
                  child: ConstantWidget.getTextFiled(
                      context,
                      themeColor,
                      S.of(context).enterHeight,
                      cellHeight,
                      inchController),
                  flex: 1,
                ),
                SizedBox(
                  width: width,
                ),
                Expanded(
                  child: ConstantWidget.getDefaultTextWidget(
                      S.of(context).inch,
                      TextAlign.start,
                      FontWeight.w400,
                      ConstantWidget.getPercentSize(
                          cellHeight, 30),
                      ConstantData.textColor),
                  flex: 1,
                )
              ],
            ),
          ),
          visible: (selectType == S.of(context).foot),
        ),
        Container(
          height: cellHeight,
          margin: EdgeInsets.only(top: allMargin),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstantWidget.getImage(
                  themeColor, context, "weight.png"),
              Expanded(
                child: ConstantWidget.getTextFiled(
                    context,
                    themeColor,
                    S.of(context).enterWeight,
                    cellHeight,
                    weightController),
                flex: 1,
              ),
              SizedBox(
                width: width,
              ),
              Container(
                width: ConstantWidget.getWidthPercentSize(
                    context, 30),
                child: ConstantWidget.getDropDown(
                    context, selectCurrency, currencyList,
                        (value) {
                      setState(() {
                        selectCurrency = value;

                        kg = (selectCurrency ==
                            S.of(context).kilogram);
                      });
                    }),
              )
            ],
          ),
        ),
        ConstantWidget.getButtonWidget(
            context, themeColor, S.of(context).bmiChart,
                (type) {
              if (type == ConstantData.calculate) {
                calculate();
              } else if (type == ConstantData.reset) {
                reset();
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChartPage(rowItem),
                    ));
              }
            })
      ],
    );
  }
  calculate() {
    double height;
    double height2;
    double weight;
    double age;
    bool check = false;

    if (ConstantData.check(ftController.text)) {
      height = double.parse(ftController.text);
    } else {
      check = true;
    }

    if (ConstantData.check(weightController.text)) {
      weight = double.parse(weightController.text);
    } else {
      check = true;
    }

    if (ConstantData.check(ageController.text)) {
      age = double.parse(ageController.text);
    } else {
      check = true;
    }

    if (!centimeter) {
      if (ConstantData.check(inchController.text)) {
        height2 = double.parse(inchController.text);
      } else {
        check = true;
      }
    }

    if (check) {
      ConstantData.showToast(S.of(context).pleaseEnterValidValues, context);
      check = false;
    } else {
      if (centimeter) {
        height /= 100.0;
      } else {
        height *= 12.0;
        height += height2;
        height *= 0.0254;
      }
      if (!kg) {
        weight *= 0.453592;
      }

      PrefData.setAge(age.toInt());
      print("bmi----$weight=====$height");

      double bmi = (weight / (height * height));

       resultModel = new ResultModel();
      resultModel.value1 = ConstantData.formatData(bmi);


      // print("bmi----$bmi");
 passData();
     
    }


  }

  void reset() {
    ageController.text = "";
    ftController.text = "";
    inchController.text = "";
    weightController.text = "";
    checkData(centimeter);
    setState(() {});
  }

  void passData() {
    ConstantWidget.sendData(
        context, resultModel, BodyMassResultPage(resultModel, rowItem));
  }
}
