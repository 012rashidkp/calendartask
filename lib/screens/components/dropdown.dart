
import 'package:calendartask/utility/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/atributes.dart';

class Mydropdown extends StatefulWidget {
  final List<Attributes>? items;
  final String? hintText;
  final Function(String?) onChanged;

  const Mydropdown({
    required this.items,
    required this.hintText,
    required this.onChanged,
  });

  @override
  State<Mydropdown> createState() => _MydropdownState();
}

class _MydropdownState extends State<Mydropdown> {

  final _focusNode = FocusNode();
  @override
  void initState() {
    _focusNode.unfocus();
    super.initState();



  }


  @override
  Widget build(BuildContext context) {
    Attributes? _selectedItem;
    return DropdownButtonFormField<Attributes>(
        focusNode: _focusNode,
      items: widget.items?.map((attribute) => DropdownMenuItem<Attributes>(
        value: attribute,
        child: SizedBox(

          width:MediaQuery.of(context).size.width*0.55,
          child: Text(attribute.attribute?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,

          ),
        ),
      )).toList(),
      value: _selectedItem,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: tealcolor, width: 1.2),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: tealcolor),
        ),
        hintText: widget.hintText,
        hintMaxLines: 1,

        filled: true,
        fillColor:bodycolor,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: tealcolor, width: 1.2),
          borderRadius: BorderRadius.circular(8.0),
        ),

        hintStyle: const TextStyle(color: Colors.black, fontSize: 15),
        focusColor: tealcolor,
        contentPadding:
        const EdgeInsets.symmetric(vertical:10.0,horizontal: 5.0),

      ),
      onChanged: (Attributes? attribute) {
        setState(() {
          _selectedItem = attribute;
          widget.onChanged(_selectedItem?.attribute);
        });
      },
    );

  }
}