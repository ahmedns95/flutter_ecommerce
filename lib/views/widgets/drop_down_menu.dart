import 'package:flutter/material.dart';

class DropDownMenuComponent extends StatelessWidget {
  final void Function(String? value) onChanged;
  final List<String> items;
  final String hint;
  const DropDownMenuComponent({
    Key? key,
    required this.onChanged,
    required this.items,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border.all(style: BorderStyle.none, color: Colors.deepOrangeAccent),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: DropdownButtonFormField<String>(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        value: null,
        dropdownColor: Colors.white,
        icon: const Icon(Icons.arrow_drop_down),
        isExpanded: true,
        elevation: 10,
        hint: Text(
          hint,
          style: const TextStyle(fontSize: 16),
        ),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
          );
        }).toList(),
      ),
    );
  }
}
