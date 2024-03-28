import 'package:flutter/material.dart';

import '../../atoms/containers/containers_atoms.dart';
import '../../atoms/texts/texts_atoms.dart';

Widget buildBodyBack({required Color color1, required Color color2}) {
  return ContainerDegradee(
      color1: color1, color2: color2);
}

Widget sliverAppBar(){
  return SliverAppBar(
    floating: true,
    snap: true,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    flexibleSpace: FlexibleSpaceBar(
      title: text(label: "", color: const Color(0xfff1f1f1)),
      centerTitle: true,
    ),
  );
}


