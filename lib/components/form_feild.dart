
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormFeild extends StatelessWidget {
  const FormFeild({
    Key? key,
    required double width,
    required this.hint,
    this.enable= true,
    required this.obsecureBool,
    required this.lenghtMax,
    required this.type,
    required this.controller
  }) : _width = width, super(key: key);

  final double _width;

  final String hint;
  final TextInputType type;
  final bool obsecureBool;
  final int lenghtMax;
  final bool enable;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: _width*0.03),
        child: TextFormField(
          maxLines: lenghtMax,
          keyboardType: type,
          controller: controller,
          obscureText: obsecureBool,
          style: const TextStyle(
            fontSize: 17,
            letterSpacing: 0.1,
            fontWeight: FontWeight.w300,
          ),
          // controller: passwordController,
          decoration: InputDecoration(
            filled: true, //<-- SEE HERE
            fillColor: Colors.white,
            contentPadding:
            const EdgeInsets.fromLTRB(
                20, 10, 10, 10),
            hintText: hint,
            hintStyle: const TextStyle(
                color: Color(0xff3E4684),
                fontSize: 15),
            border: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(20.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color(0xff3E4684)

              ),
              borderRadius:
              BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color(0xff3E4684)),
              borderRadius:
              BorderRadius.circular(8.0),
            ),
          ),
          enabled: enable,
        )
    );
  }
}
