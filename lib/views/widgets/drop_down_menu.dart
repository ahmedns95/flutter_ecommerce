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
    return SizedBox(
      width: 100,
      height: 55,
      child: DropdownButtonFormField<String>(
        value: null,
        icon: const Icon(Icons.arrow_drop_down),
        isExpanded: true,
        elevation: 16,
        //style: Theme.of(context).textTheme.headline5,
        hint: FittedBox(
          child: Text(
            hint,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black, fontSize: 13),
            ),
          );
        }).toList(),
      ),
    );
  }
}
