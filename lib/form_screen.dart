import 'package:flutter/material.dart';
import 'package:read_json_file/display.dart';
import 'package:http/http.dart' as http;

class FormScreen extends StatefulWidget {

  String id="";
  
  String name="";
  FormScreen({required this.id,required this.name});

  @override
  
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  late String _name =widget.name;
  late String _age;
  late String _gender;
  late String _id = widget.id;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

 /* Widget _buildName() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Name'),
      maxLength: 20,
      validator: ( value) {
        if (value!.isEmpty) {
          return 'Name is Required';
        }
        return null;
      },
      onSaved: (value) {
        _name = value!;
      },
    );
  }*/


  Widget _buildage() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Age'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Age is Required';
        }

        return null;
      },
      onSaved: (value) {
        _age = value!;
      },
    );
  }

  Widget _buildgender() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Gender'),
       maxLength: 10,
      validator: ( value) {
        if (value!.isEmpty) {
          return 'Gender is Required';
        }

        return null;
      },
      onSaved: (value) {
        _gender = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Enter Your Details")),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               // _buildName(),
                _buildage(),
                _buildgender(),
                const SizedBox(height: 100),
                RaisedButton(
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 16),
                  ),
                  onPressed: () async {

                    Navigator.of(context).push(MaterialPageRoute(
                                             builder: (context) => WelcomePage(
                                                                  name: _name,
                                                                  age: _age,
                                                                  gender: _gender)
                                                            )
                                             );
                    if (!_formKey.currentState!.validate()) {
                      return;
                      
                    }

                    _formKey.currentState!.save();




                    var map = new Map<String, dynamic>();
                    map['age'] = _age;
                    map['gender'] =_gender;
                    map['id'] =_id;

                    final response = await http.post(
                        Uri.parse('http://ec2-3-215-209-80.compute-1.amazonaws.com/mietjammu/apis/update_user_data.php'),
                        body: map,
                    );

                    print(response.body);


                    

                    print(_name);
                    print(_age);
                    print(_gender);

                    //Send to API
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}