
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utility/colors.dart';

class Inputfield extends StatelessWidget {
  final String? hintvalue;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final bool? isprefix;
  final bool? readonly;
  final Function(String?)?onchange;
  final Function(String?)?oneditchange;
  final bool? isdark;
  const Inputfield({
    super.key,
    this.hintvalue,
    this.textInputType,
    this.controller,
    this.isprefix,
    this.readonly,
    this.onchange,
    this.oneditchange,
    this.isdark
  });

  @override
  Widget build(BuildContext context) {

    final FocusNode _focusNode=FocusNode();
    TextEditingController? editingcontroller=TextEditingController();
    editingcontroller=controller;


    return  Material(
      color: bodycolor,
      textStyle: TextStyle(color: bodycolor),
      child: TextFormField(
        textAlign: TextAlign.justify,
        controller: editingcontroller,
        readOnly: readonly ?? false,
        style:  const TextStyle(
            color: Colors.black,
            fontSize: 17
        ),

        keyboardType:textInputType,
        autofocus: false,
        focusNode: _focusNode,
        onChanged: (value){
          onchange!(value);
        },
        decoration:  InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(
                color:tealcolor,
                width: 2.0
            ),
            borderRadius: BorderRadius.circular(12.0),


          ),
          enabledBorder:    OutlineInputBorder(
            borderSide: const BorderSide(
                color:tealcolor,
                width: 2.0
            ),
            borderRadius: BorderRadius.circular(12.0),

          ),

          filled: true,
          fillColor:bodycolor,
          hintText:hintvalue,

          focusedBorder:OutlineInputBorder(
            borderSide: const BorderSide(
                color:tealcolor,
                width: 2.0
            ),
            borderRadius: BorderRadius.circular(10.0),

          ),
          hintStyle:  const TextStyle(
            color:  Colors.black,
            fontSize: 17,

          ),
          focusColor: bodycolor,

          contentPadding: const EdgeInsets.only(left:12.0),



        ),
      ),


    );
  }

}