
import 'package:charity/shared/styles/colors.dart';
import 'package:flutter/material.dart';

import '../../shared/components/constants.dart';


class RefCodeScreen extends StatelessWidget {
  const RefCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text(
          'Charity',
          style:
          TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 35,

          ),
        ),
        leading: IconButton( onPressed: () {Navigator.pop(context);  }, icon: Icon(Icons.arrow_back_ios),),
        backgroundColor: Color.fromRGBO(37, 90, 123,1),
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You Should go to any market to pay',style: TextStyle(fontSize: 35),),
          SizedBox(height: 10,),
          Text('Your Reference Code Code is',style: TextStyle(fontSize: 22),),
          SizedBox(height: 10,),
          TextFormField(
            style: TextStyle(color: defaultColor,fontSize: 70,fontWeight: FontWeight.bold,),

            readOnly: true,
            textAlign: TextAlign.center,

            controller:   TextEditingController(text:'$kioskReferenceCode' ),
            decoration: InputDecoration(

              border: InputBorder.none,

            ),

          ),
          // Text('$kioskReferenceCode',style: TextStyle(fontSize: 70,color: Colors.green,fontWeight: FontWeight.bold,)),


        ],
      )),
    );
  }
}
