import 'package:flutter/material.dart';
import 'package:googlesheetsapi/gapi.dart';
import 'package:googlesheetsapi/user.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Gapi.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget{

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TextEditingController Name;

  late TextEditingController Number;

  void initUser(){
    Name = TextEditingController();
    Number = TextEditingController();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUser();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
          title: Text("Google Sheet using API"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Container(
                  width: 180,
                  height: 80,
                  child: TextField(
                      controller: Name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Name"
                      )
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: 180,
                  height: 80,
                  child: TextField(
                      controller: Number,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Number",

                      )
                  ),
                ),

                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("Submit"),
                  onPressed: ()async{
                    final user = User(

                      name: Name.text,
                      number: Number.text,

                    );
                    await Gapi.insert([user.toJson()]);

                    print("Name: ${Name.text}\nNumber: ${Number.text}");
                  },
                )
              ]
          ),
        ),
      ),

    );

  }
}