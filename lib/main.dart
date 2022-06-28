import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:read_json_file/ProductDataModel.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:http/http.dart' as http;
import 'package:read_json_file/display.dart';


import 'form_screen.dart';

void main() {
  runApp(MyApp(name: '',));
}

class MyApp extends StatelessWidget {

  String name="";
  MyApp({required this.name});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
    );
  }
}

class User {
  final String id;
  final String name;
  final String age;
  final String gender;
  
  User({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
  });
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context,data){
          if(data.hasError){
            return Center(child: Text("${data.error}"));
          }else if(data.hasData){
            var items =data.data as List<User>;
            return ListView.builder(
              itemCount: items == null? 0: items.length,
                itemBuilder: (context,index){
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                          ),
                          Expanded(child: Container(
                            padding: EdgeInsets.only(bottom: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.only(left: 8,right: 8),child: Text(items[index].name.toString(),style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),),),
                            Container(
                            margin: EdgeInsets.only(top:0),
                            padding: EdgeInsets.only(left: 1000),
                            child: FlatButton(
                              child: Text("SignIn"),
                              color: Colors.blueGrey,
                              textColor: Colors.white,
                              onPressed: () async{
                                final response = await http.get(
                        Uri.parse('http://ec2-3-215-209-80.compute-1.amazonaws.com/mietjammu/apis/check_user_data.php?id='+items[index].id));
                        
                        final decoded = jsonDecode(response.body) as Map;

                        print(decoded['exists']);

                        if(decoded['exists']==1){
                          Navigator.of(context).push(MaterialPageRoute(
                                             builder: (context) =>WelcomePage (
                                                                  name: items[index].name,
                                                                  age: decoded['age'],
                                                                  gender: decoded['gender'])
                                                            )
                                             );
                        }else{
                          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => FormScreen(id: items[index].id,name:items[index].name)),
  );
                        }

                              
                              },
                            ),
                          ),

                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  );
                }
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      )
    );
  }

  Future<List<User>>ReadJsonData() async{
     //final jsondata = await rootBundle.rootBundle.loadString('jsonfile/productlist.json');
     String url = "http://ec2-3-215-209-80.compute-1.amazonaws.com/mietjammu/apis/read_user_data.php?userdata=1";
    final jsondata = await http.get(Uri.parse(url));
     final list = json.decode(jsondata.body) as List<dynamic>;

     List<User> users = [];
    for (var singleUser in list) {
      User user = User(
          id: singleUser["id"],
          name: singleUser["name"],
          age: singleUser["age"],
          gender: singleUser["gender"]);
  
      //Adding user to the list.
      users.add(user);
    }
    return users;

  }
  }


