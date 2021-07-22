
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  List<double> value = [0, 0, 0, 0, 0, 0];
  int questionNumber = 0;
  double color = 100;
  List<String> questions = [
    "How did you Like our service?",
    "How was the sanitation?",
    "How was the Sound quality",
    "How was the Lighting",
    "How likely are you to recommend us to your contacts",
    "How likely are you to come back here"
  ];
  int arrSum(List<double> list, int listlen) {
    int i = 0;
    int result = 0;
    while (i < listlen) {
      result = result + list[i].toInt();
      i=i+1;
    }
    return result;
  }

  int netScore = 0;
  List<String> resultList = [
    "Sorry for the inconvinience",
    " Hope we serve you better next time",
    "We hope you come back next time."
  ];
  MaterialColor resultcolor = Colors.red;
  String result = "";
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FeedBack Please"),
          centerTitle: true,
        ),
        body: Center(
            child: questionNumber < 6
                ? Container(
                    width: 400,
                    child: Column(children: [
                      Text(
                        "${questionNumber + 1}) ${questions[questionNumber]}",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Karla'),
                      ),
                      Slider(
                          value: value[questionNumber],
                          onChanged: (double newVal) {

                              setState(() {
                                color = (newVal) * 100+100 ;
                              });

                            setState(() {
                              value[questionNumber] = newVal;
                            });
                          },
                          activeColor: Colors.red[color.toInt()],
                          min: 0,
                          max: 5,
                          divisions: 5),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (questionNumber >= 0 && questionNumber < 6)
                                questionNumber = questionNumber + 1;
                              if (questionNumber == 6) {
                                netScore = arrSum(value, 6);
                                if (netScore < 10) {
                                  resultcolor = Colors.red;
                                  result = resultList[0];
                                } else if (netScore > 10 && netScore < 20) {
                                  resultcolor = Colors.yellow;
                                  result = resultList[1];
                                } else {
                                  resultcolor = Colors.green;
                                  result = resultList[2];
                                }
                              }
                            });
                          },
                          child: Text("next"))
                    ], mainAxisAlignment: MainAxisAlignment.center))
                : Container(
                    width: 400,
                    child: Column(children: [
                      Text(
                        "$result",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Karla',
                            color: resultcolor[600]),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              questionNumber = 0;
                              value=value.map((e)=>e=0).toList();
                            });
                          },
                          child: Text("Return"))
                    ], mainAxisAlignment: MainAxisAlignment.center))));
  }
}
