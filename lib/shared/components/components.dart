

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app_firebase/shared/styles/icon_broken.dart';

void navigateTo(context,Widget){
  Navigator.push(context, MaterialPageRoute(builder:(context)=>Widget));
}


void navigateAndFinish(context,Widget){
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder:(context)=>Widget),
          (route){
        return false;
      }
  );
}


///TextFormField///
Widget defaultTextForm(


    {
      ontap,
      onSubmitd,
      oncnged,
      bool isPasswrd = false,
      IconData? suffix,
      required TextEditingController contrl,
      required TextInputType typ,
      required validte,
      required String labell,
      required IconData prefix,
      suffixPressed,
    }) =>
    TextFormField(
      onTap: ontap,
      onFieldSubmitted: onSubmitd,
      onChanged: oncnged,
      controller: contrl,
      keyboardType: typ,
      obscureText: isPasswrd ? true : false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labell,
        prefixIcon: Icon(prefix),
        suffixIcon: (suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null),
      ),
      validator: validte,
    );



///button///
Widget defalultButton({
  double raidos = 0.0,
  double height = 40.0,
  double width = double.infinity,
  Color background = Colors.blue,
  required function,
  required String text,
  bool toUpperCase = true,
}) =>
    Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(raidos),
      ),
      height: height,
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          toUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );


Widget defaultTextButton({
  required  function,
  required String text,
})=>TextButton(onPressed:function, child: Text(text.toUpperCase()));

void showToast({
  required String text,
  required ToastState state,
}) =>   Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastState{SUCCESS,ERROR,WARRNING}

Color? chooseToastColor(ToastState state){
  Color? color;
  switch(state){
    case (ToastState.SUCCESS):
      color=Colors.green;
      break;
    case (ToastState.ERROR):
      color=Colors.red;
      break;
    case (ToastState.WARRNING):
      color=Colors.amberAccent;
      break;
  }
  return color;
}

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  required String title,
  List<Widget>? actions,
})=>AppBar(
  title: Text(title),
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: Icon(IconBroken.Arrow___Left_2),
  ),
  actions: actions,
);





