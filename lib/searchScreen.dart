import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codersstatus/components/colorscheme.dart';
import 'package:codersstatus/components/myTextFormField.dart';
import 'package:codersstatus/components/myUserTile.dart';
import 'package:codersstatus/firebase_layer/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var queryResultSet = [];
  var tempSearchStore = [];
  List<Widget> listOfUserTiles = [];

  void initateSearch(String value) async {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
      return;
    }

    var capitalizedValue = value.toUpperCase();

    if (queryResultSet.length == 0 && value.length == 1) {
      QuerySnapshot querySnapshot =
          await SearchDatabase().searchByName(capitalizedValue);
      querySnapshot.docs.forEach((element) {
        queryResultSet.add(element.data());
      });
      print(queryResultSet.length);
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['name']
                .toString()
                .toUpperCase()
                .startsWith(capitalizedValue) ||
            element['codername']
                .toString()
                .toUpperCase()
                .startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Expanded(
        child: Column(
          children: [
            myTextEormField(Icon(CupertinoIcons.search), 'Search', false,
                (val) {
              initateSearch(val);
            }, TextInputType.name, (val) {}),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            tempSearchStore.length == 0
                ? Expanded(
                    child: Center(
                      child: Text(
                        'Enter the Username to search',
                        style: TextStyle(
                            color: colorschemeclass.lightgrey,
                            fontFamily: 'young',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : Column(
                    children: tempSearchStore.map((element) {
                      return MyUserTile(element['avatarurl'], element['name'],
                          element['codername']);
                    }).toList(),
                  )
          ],
        ),
      )),
    );
  }
}