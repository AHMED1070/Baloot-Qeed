import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var lna_array = [0];
  var lhm_array = [0];

  Color bgColor = const Color(0xff674C6D),
      RButtomColor = Color(0xffFAFE73),
      UButtomColor = Color(0xffFFE1EC),
      Row1Color = Color(0xffE8CDF6),
      Row2Color = Color(0xffE8CDF6);

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: buildMayColumn(),
        ),
      ),
      backgroundColor: bgColor,
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
    return Container(
      decoration: BoxDecoration(
        color: Row1Color,
        borderRadius: BorderRadius.circular(25),
      ),
      height: 150,
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
                  "لنا",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                //arrowIndecator(),
                SizedBox(width: 25),
                Text(
                  "لهم",
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
    );
  }

  recordRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 17.0),
      child: Expanded(
        child: Container(
          height: 515,
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
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      lhmSum.toString(),
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Divider(),
                SizedBox(height: 10),
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
      ),
    );
  }

  buttomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: recordButtom()),
        SizedBox(width: 12.5),
        undowButtom(),
      ],
    );
  }

  myTextField(TextEditingController ctrl) {
    return TextField(
      cursorColor: bgColor,
      textAlign: TextAlign.center,
      controller: ctrl,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: "0",
          hintStyle: const TextStyle(
            fontSize: 20,
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
              ))),
    );
  }

  recordButtom() {
    return Container(
      decoration: BoxDecoration(
        color: RButtomColor,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 90,
      width: 10,
      child: MaterialButton(
        onPressed: () {
          recordFunc();
        },
        child:
            const Text("Record", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  undowButtom() {
    return Container(
      height: 90,
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
    // TODO: implement initState
    super.initState();
    lna = TextEditingController();
    lhm = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
              "Game Over !",
              style: TextStyle(color: bgColor, fontWeight: FontWeight.bold),
            ),
            actions: [
              //
              MaterialButton(
                  onPressed: () {
                    restartGameFunc();
                  },
                  child: Text(
                    "Start New Game ",
                    style: TextStyle(color: bgColor),
                  )),
              //
              MaterialButton(
                  child: Text(
                    "Undo",
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
              "Undo the Last record ?",
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
                    "Yes, Undo",
                    style: TextStyle(color: bgColor),
                  )),
              //
              MaterialButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: bgColor),
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
      lna_array = [];
      lhm_array = [];
      Navigator.pop(context);
      lnaSum = lhmSum = 0;
    });
  }

  recordFunc() {
    setState(() {
      if (lna.text == "" && lhm.text == "") {
        // dont add anything if both 0
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
