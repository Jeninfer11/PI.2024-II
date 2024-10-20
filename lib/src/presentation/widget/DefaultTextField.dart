import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  String label;
  String? errorText;
  final Color? iconColor;
  TextInputType? textInputType;
  IconData icon;
  Color? color;
  final TextStyle? labelStyle;
  bool obscureText;
  Function(String text) onChange;
  String? Function(String?)? validator;

  DefaultTextField(
      {Key? key,
      required this.label,
      required this.icon,
      this.iconColor,
      required this.onChange,
      this.errorText,
      this.validator,
      this.obscureText = false,
      this.color = Colors.white,
      this.labelStyle = const TextStyle(color: Colors.black),
      textInputType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: obscureText,
        onChanged: (text) {
          onChange(text);
        },
        keyboardType: textInputType,
        validator: validator,
        decoration: InputDecoration(
          label: Text(
            label,
            style: TextStyle(color: color),
          ),
          errorText: errorText,
          prefixIcon: Icon(icon, color: color),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: color!)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: color!)),
        ),
        style: TextStyle(color: color));
  }
}

class DefaultDropdownField extends StatelessWidget {
  final String label;
  final IconData icon;
  final List<String> items;
  final Function(String?) onChange;
  final String? value;
  final String? errorText;
  final String? Function(String?)? validator;
  final Color iconColor; // Color para personalizar el ícono

  const DefaultDropdownField({
    Key? key,
    required this.label,
    required this.icon,
    required this.items,
    required this.onChange,
    this.value,
    this.errorText,
    this.validator,
    this.iconColor = Colors.black, // Valor predeterminado
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: iconColor ?? Colors.black),
          border: OutlineInputBorder(),
          errorText: errorText,
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChange,
        validator: validator,
      ),
    );
  }
}
