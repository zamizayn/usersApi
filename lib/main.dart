import 'dart:convert';

import 'package:fetchusers/constants.dart';
import 'package:fetchusers/model/users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Users'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Users> users = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final response = await http.get(Uri.parse(BASEURL));
    final body = jsonDecode(response.body);
    body.forEach((e) {
      setState(() {
        users.add(Users.fromJson(e));
      });
    });
    print('data' + users.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(5),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                users.length > 0
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: users.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Card(
                                elevation: 15,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name : ' + users[index].name.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          'Username : ' +
                                              users[index].username.toString(),
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          'Email : ' +
                                              users[index].email.toString(),
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          'Address : ' +
                                              users[index]
                                                  .address
                                                  .street
                                                  .toString() +
                                              users[index]
                                                  .address
                                                  .suite
                                                  .toString() +
                                              users[index]
                                                  .address
                                                  .city
                                                  .toString() +
                                              "\n" +
                                              users[index]
                                                  .address
                                                  .zipcode
                                                  .toString(),
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.business),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(users[index].company.name),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.public),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(users[index].website),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.call),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(users[index].phone),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          );
                        })
                    : Center(child: CircularProgressIndicator())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
