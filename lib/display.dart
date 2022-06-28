import 'package:flutter/material.dart';

import 'main.dart';

class WelcomePage extends StatelessWidget {
   String name,age,gender;
   WelcomePage({Key? key,required this.name,required this.age,required this.gender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
      child: Card(
          elevation: 50,
          shadowColor: Colors.blueGrey,
          color: Color.fromARGB(209, 61, 66, 62),
          child: SizedBox(
            width: 300,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              

          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                    'Your Info',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ), //Textstyle
                  ), //Text
                  const SizedBox(
                    height: 10,
                  ), //SizedBox

                   Text(
                    'Name:$name',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ), //Textstyle
                  ), //Text
                  const SizedBox(
                    height: 10,
                  ), 
                  
                  Text(
                    'Age:$age',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ), //Textstyle
                  ), //Text
                  const SizedBox(
                    height: 10,
                  ),
                  
                  
                  Text(
                    'Gender:$gender',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ), //Textstyle
                  ), //Text
                  const SizedBox(
                    height: 10,
                  ),//SizedBox
                                        Container(
                            margin: EdgeInsets.only(top:10),
                            padding: EdgeInsets.only(left: 8),
                            child: FlatButton(
                              child: Text("Sign Out"),
                              color: Colors.blueGrey,
                              textColor: Colors.white,
                              onPressed: (){
                                                              Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => MyHomePage()),
  );
                              },
                            ),
                          ),
          ],
        ),





                  ),
          ), 

      ),
    ),
    );
  }
}