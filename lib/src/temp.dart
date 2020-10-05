import 'package:flutter/material.dart';

class SendScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
              height: 200,
              width: 300,
              child: Material(
                color: Colors.black,
                clipBehavior: Clip.antiAlias,
                shape: BeveledRectangleBorder(
                  side: BorderSide(
                    color: Color.fromRGBO(255, 255, 255, .90),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      15,
                    ),
                  ),
                ),
                child: new Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, .10),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    border: Border.all(
                      color: Color.fromRGBO(255, 255, 255, .10),
                      width: 2,
                    ),
                  ),
                  child: new Container(
                    height: 50,
                    width: 100,
                  ),
                ),
              )),
        ));
  }
}
