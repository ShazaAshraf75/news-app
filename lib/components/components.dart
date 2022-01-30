// ignore_for_file: prefer_if_null_operators, constant_identifier_names, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/modules/webview/webview_screen.dart';

String? token = "";

Widget buildArticleItem(articles, context) => InkWell(
      onTap: () {
        navigateTo(context, WebviewScreen(articles['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(children: [
          Stack(
            children: [
              const SizedBox(
                height: 120,
                width: 130,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              Container(
                height: 120,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: articles["urlToImage"] != null
                        ? NetworkImage("${articles["urlToImage"]}")
                        : const NetworkImage(
                            "http://www.keystonetrust.org.uk/wp-content/uploads/2020/06/placeholder-image-1.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${articles["title"]}",
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "${articles["publishedAt"]}",
                    style: GoogleFonts.exo(
                        textStyle: TextStyle(
                      color: Colors.red.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    )),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => Divider(
              endIndent: 15,
              indent: 15,
              color: Colors.grey[300],
            ),
        itemCount: list.length),
    fallback: (context) => isSearch
        ? Container()
        : const Center(child: CircularProgressIndicator()));

Widget defaultTextField({
  required BuildContext context,
  required TextEditingController controller,
  required double radius,
  required double padding,
  required IconData prefixIcon,
  required String label,
  required TextInputType textInputType,
  required String? Function(String?)? validate,
  IconData? suffixIcon,
  Color? unactiveBorderColor,
  Color? suffixIconColor,
  Color? preffixIconColor,
  Color? labelColor,
  Color? textColor = Colors.grey,
  void Function(String?)? onChange,
  void Function()? suffixPressed,
  bool obsecure = false,
}) =>
    Padding(
      padding: EdgeInsets.all(padding),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextFormField(
          style: TextStyle(color: textColor),
          obscureText: obsecure,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: unactiveBorderColor == null
                        ? Colors.grey
                        : unactiveBorderColor,
                    width: 2),
                borderRadius: BorderRadius.all(Radius.circular(radius))),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(radius))),
            prefixIcon: Icon(
              prefixIcon,
              color: preffixIconColor == null ? Colors.grey : preffixIconColor,
            ),
            suffixIcon: IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffixIcon,
                  color:
                      suffixIconColor == null ? Colors.grey : suffixIconColor,
                )),
            labelText: label,
            labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: labelColor == null ? Colors.grey : labelColor,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
          ),
          controller: controller,
          keyboardType: textInputType,
          validator: validate,
          onChanged: onChange,
        )
      ]),
    );
Widget defaultButton({
  required double height,
  required Color backgroundColor,
  required double radius,
  required void Function()? onPressed,
  required String label,
  required TextStyle labelStyle,
}) =>
    Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(radius)),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(label, style: labelStyle),
      ),
    );
void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);
void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;

    case ToastStates.ERROR:
      color = Colors.red;
      break;

    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
