import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculater extends StatefulWidget {
  const Calculater({Key? key}) : super(key: key);

  @override
  State<Calculater> createState() => _CalculaterState();
}

class _CalculaterState extends State<Calculater> {
  String userInput='';
  String output='';
  List<String> buttons = [
    'Ac',
    '(',
    ')',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '0',
    "/",
    "x",
    "+",
    '-',
    'Ans'
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator',),
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(userInput,style: TextStyle(color: Colors.white),),
                  Divider(
                   color: Colors.white,
                  ),
                  Text(output,style:TextStyle(color: Colors.white,fontSize: 25,),
                  ),
                  Divider(
                    color:Colors.white,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height:double.infinity,
              padding: EdgeInsets.only(top:10,left: 10,right: 10),
              child: GridView.builder(

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5),
                    itemCount: buttons.length,
                    itemBuilder: (ctx, int index) {
                      return Button(buttons[index]);
                    },
                  ),
            )
          )
        ],
      ),
    );
  }
  Widget Button(String text  ) {
    return InkWell(


      splashColor: Color(0xFF1d2630),
      onTap: ()=>onClick(text),

      child: Ink(

        decoration:BoxDecoration(

            borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey,
          boxShadow: [

                BoxShadow(
                  color: Colors.white.withOpacity(1),
                  blurRadius: 4,
                  spreadRadius: 0.5,
                  offset: Offset(4,5),
                )
          ]

        ),
            child: Center(
        child: Text(
        text,

        style: TextStyle(
          color: isOperater(text)?Colors.green:Colors.blue,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),


      ),

    );

  }

  bool isOperater(String x){
    if (x=='X'||x=='/'|| x=='+'|| x=='-'||x=='Ac'||x=='Ans'){
      return true;
    }
    return false;

  }
  onClick(String text){

    setState(() {

      if (text=='Ac'){
        userInput='';
        output='';
        return;
      }

      if(text =='Ans'){
        output= equation();
       // userInput=output;

           return;
      }


      userInput= userInput + text;
      output='0';

    });
  }
  equation(){

    String finalInput =userInput;
    finalInput = userInput.replaceAll('x', '*');

    Parser P = Parser();
    Expression exp =P.parse(finalInput);
    ContextModel cm =ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    return eval.toString();


  }

  }














