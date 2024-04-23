
import 'package:flutter/material.dart';

class TextFormCont extends StatelessWidget {

  TextFormCont({required this.labeltitle,
    required this.iconName,
    required this.obsecureBool,
    required this.feildController,
    required this.onchangeFunc,
    required this.paddingBorders,});

  final String labeltitle;
  final IconData iconName;
  final Function() onchangeFunc;
  final double paddingBorders;
  final bool obsecureBool;
  final TextEditingController feildController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.all(paddingBorders),
        child: Container(
          decoration:  BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Color(0xff3E4684)),
              borderRadius:const BorderRadius.all(Radius.circular(14))
          ),
          padding:const  EdgeInsets.only(left: 10,top: 10),
          height: 70,
          width: double.infinity,
          child: TextField(
            obscureText:obsecureBool ,
            controller: feildController,
            onChanged: (e){

            },
            decoration: InputDecoration(
              icon: Icon(iconName,size: 40,color: const Color(0xff3E4684),),
              labelText: labeltitle,
              labelStyle: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 15,
                 // fontWeight: FontWeight.bold
              ),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,

            ),
          ),
        ),
      ),
    );
  }
}