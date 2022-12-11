// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:qeed_remake_2/mediaQ.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var lna_array = [0];
  var lhm_array = [0];
  double containerHeight = 255;

  Color bgColor = const Color(0xff674C6D),
      RButtomColor = const Color(0xffFAFE73),
      UButtomColor = const Color(0xffFFE1EC),
      Row1Color = const Color(0xffE8CDF6),
      Row2Color = const Color(0xffE8CDF6);

  late TextEditingController lna, lhm;

  int lnaSum = 0;
  int lhmSum = 0;

  var arrow = [
    Icons.arrow_circle_up,
    Icons.arrow_circle_left,
    Icons.arrow_circle_down,
    Icons.arrow_circle_right,
  ];

  int arrow_index = 3;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SizeConfig().init(context);

    return KeyboardDismissOnTap(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: buildMayColumn(),
          ),
        ),
        backgroundColor: bgColor,
      ),
    );
  }

  buildMayColumn() {
    return Column(
      children: [
        inputRow(),
        recordRow(),
        buttomRow(),
      ],
    );
  }

  inputRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Row1Color,
          borderRadius: BorderRadius.circular(25),
        ),
        height: SizeConfig.screenHeight / 5.77,
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    "لهم",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  //arrowIndecator(),
                  SizedBox(width: 25),
                  Text(
                    "لنا",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: myTextField(lna)),
                  const SizedBox(width: 25),
                  Expanded(child: myTextField(lhm))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  recordRow() {
    return KeyboardVisibilityBuilder(builder: (context, visible) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn,
          height: visible
              ? (SizeConfig.screenHeight / 1.59) - SizeConfig.keyboradHeight
              : SizeConfig.screenHeight / 1.59,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Row2Color,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      lnaSum.toString(),
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      lhmSum.toString(),
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const Divider(),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => buildRowOfResult(index),
                      itemCount: lna_array.length),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  buttomRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: recordButtom()),
          const SizedBox(width: 12.5),
          undowButtom(),
        ],
      ),
    );
  }

  myTextField(TextEditingController ctrl) {
    return TextField(
      onEditingComplete: recordFunc,
      cursorColor: bgColor,
      textAlign: TextAlign.center,
      controller: ctrl,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 30),
      decoration: InputDecoration(
        hintText: "0",
        contentPadding: const EdgeInsets.all(15),
        hintStyle: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: bgColor),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: bgColor,
            width: 2,
          ),
        ),
      ),
    );
  }

  recordButtom() {
    return Container(
      decoration: BoxDecoration(
        color: RButtomColor,
        borderRadius: BorderRadius.circular(20),
      ),
      height: SizeConfig.screenHeight / 9.75,
      width: 10,
      child: MaterialButton(
        onPressed: () {
          recordFunc();
        },
        child: const Text("سجل",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
    );
  }

  undowButtom() {
    return Container(
      height: SizeConfig.screenHeight / 9.75,
      width: 90,
      decoration: BoxDecoration(
          color: UButtomColor, borderRadius: BorderRadius.circular(20)),
      child: MaterialButton(
        onPressed: displayUndoDialog,
        child: const Icon(Icons.settings_backup_restore_rounded),
      ),
    );
  }

  // dont need it for now
  arrowIndecator() {
    return MaterialButton(
      onPressed: () {},
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.yellow,
        ),
        child: Icon(arrow[arrow_index]),
      ),
    );
  }

  buildRowOfResult(int index) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              lna_array[index].toString(),
              textScaleFactor: 1.75,
              textAlign: TextAlign.center,
            ),
            Text(
              lhm_array[index].toString(),
              textScaleFactor: 1.75,
              textAlign: TextAlign.center,
            )
          ],
        ),
        const SizedBox(height: 10)
      ],
    );
  }

  undoFunc() {
    setState(() {
      if (lna_array.length > 1) {
        lhmSum -= lhm_array[lhm_array.length - 1];
        lnaSum -= lna_array[lna_array.length - 1];
        lna_array.removeLast();
        lhm_array.removeLast();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    lna = TextEditingController();
    lhm = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    lna.dispose();
    lhm.dispose();
  }

  displayGameOverDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text(
              "!انتهت السكة ",
              style: TextStyle(color: bgColor, fontWeight: FontWeight.bold),
            ),
            actions: [
              //
              MaterialButton(
                  onPressed: () {
                    restartGameFunc();
                  },
                  child: Text(
                    "سكة جديدة  ",
                    style: TextStyle(color: bgColor),
                  )),
              //
              MaterialButton(
                  child: Text(
                    "تراجع",
                    style: TextStyle(color: bgColor),
                  ),
                  onPressed: () {
                    undoFunc();
                    Navigator.pop(context);
                  })
            ],
          ),
        );
      },
    );
  }

  displayUndoDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            title: Text(
              "تراجع ؟ ",
              style: TextStyle(color: bgColor, fontWeight: FontWeight.bold),
            ),
            actions: [
              //
              MaterialButton(
                  onPressed: () {
                    undoFunc();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "نعم",
                    style: TextStyle(color: bgColor, fontSize: 20),
                  )),
              //
              MaterialButton(
                  child: Text(
                    "الغاء",
                    style: TextStyle(color: bgColor, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        );
      },
    );
  }

  restartGameFunc() {
    setState(() {
      lna_array = [0];
      lhm_array = [0];
      Navigator.pop(context);
      lnaSum = lhmSum = 0;
    });
  }

  recordFunc() {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      if (lna.text == "" && lhm.text == "") {
        // dont add anything if both 0
        return;
      } else {
        if (lna.text == "") {
          lna_array.add(0);
        } else {
          lna_array.add(int.parse(lna.text));
          lnaSum += int.parse(lna.text);
        }
        //
        if ((lhm.text) == "") {
          lhm_array.add(0);
        } else {
          lhm_array.add(int.parse(lhm.text));
          lhmSum += int.parse(lhm.text);
        }
      }
      if (lhmSum >= 152 || lnaSum >= 152) {
        displayGameOverDialog();
      }
      lna = TextEditingController();
      lhm = TextEditingController();
    });
  }
}
