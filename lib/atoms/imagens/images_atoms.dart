import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

Widget imageDefault({required BuildContext context, required String image,required double opacity}){
  var size = MediaQuery.of(context).size;

  return  Center(
    child: Container(
      width: size.width * 0.9,
      height: size.height * 0.8,
      decoration: BoxDecoration(
        image: DecorationImage(
          opacity: opacity,
          scale: 1,
          image: AssetImage(image, bundle: rootBundle),
        ),
      ),
    ),
  );
}

Widget imageCard({required BuildContext context, required String image,required double opacity}){
  var size = MediaQuery.of(context).size;

  return  Center(
    child: Container(
      padding: EdgeInsets.all(16),
      width: size.height * 0.08,
      height: size.height * 0.08,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          opacity: opacity,
          scale: 2,
          image: AssetImage(image, bundle: rootBundle),
        ),
      ),
    ),
  );
}

Widget imageCardSale({required BuildContext context, required String image,required double opacity}){
  var size = MediaQuery.of(context).size;

  return  Center(
    child: Container(
      width: size.width * 0.4,
      height: size.height * 0.2,
      decoration: BoxDecoration(
        image: DecorationImage(
          opacity: opacity,
          scale: 1,
          image: AssetImage(image, bundle: rootBundle),
        ),
      ),
    ),
  );
}

Widget viewImageCardSale({required BuildContext context, required String image,required double opacity}){
  var size = MediaQuery.of(context).size;

  return  Center(
    child: Container(
      width: size.width * 0.4,
      height: size.height * 0.10,
      decoration: BoxDecoration(
        image: DecorationImage(
          opacity: opacity,
          scale: 1,
          image: AssetImage(image, bundle: rootBundle),
        ),
      ),
    ),
  );
}

Widget imageLogin({required BuildContext context, required String image}){
  var size = MediaQuery.of(context).size;
  return Container(
    height: 150,
    width: size.width,
    decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
        )),
  );
}