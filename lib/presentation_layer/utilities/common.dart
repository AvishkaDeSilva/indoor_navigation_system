import 'package:flutter/material.dart';

List<DropdownMenuItem> dropDownList() {
  return const [
    DropdownMenuItem(
      value: 0,
      child: Text("Staff"),
    ),
    DropdownMenuItem(
      value: 1,
      child: Text("HOD Office"),
    ),
    DropdownMenuItem(
      value: 3,
      child: Text("Room1"),
    ),
    DropdownMenuItem(
      value: 4,
      child: Text("Room2"),
    ),
    DropdownMenuItem(
      value: 5,
      child: Text("FYP Lab"),
    ),
    DropdownMenuItem(
      value: 7,
      child: Text("Washroom"),
    ),
    DropdownMenuItem(
      value: 9,
      child: Text("Room3"),
    ),
    DropdownMenuItem(
      value: 10,
      child: Text("Room4"),
    ),
    DropdownMenuItem(
      value: 11,
      child: Text("Room5"),
    ),
  ];
}
