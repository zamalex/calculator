import 'package:flutter/material.dart';

import 'colors.dart';

class BasicTextField extends StatelessWidget {
  TextEditingController? controller;
  bool isEmail;
  bool isPrice;
  Color color;
  String hint;

  BasicTextField({Key? key,this.controller,this.isEmail=false,this.isPrice=false,this.color=kLightGrey,this.hint=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      height: 56,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [


          SizedBox(
            width: 5,
          ),
          Expanded(
              child: TextField(
                keyboardType: isEmail?TextInputType.emailAddress:isPrice?TextInputType.number:TextInputType.text,
                controller: controller,
                decoration: InputDecoration(
                  isCollapsed: true,
                  isDense: true,
                  contentPadding:
                  EdgeInsets.only(bottom: 15, top: 15, left: 10, right: 10),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kLightGrey)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kLightGrey),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: kLightGrey),
                  ),
                  hintStyle: TextStyle(
                    color: kDarkGrey,
                  ),
                  focusColor: kLightGrey,
                  hintText: hint

                ),
              ))
        ],
      ),
    );
  }


}

