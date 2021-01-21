import 'package:covid19_app/components/text_field_container.dart';
import 'package:covid19_app/core/consts.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoundedDatetimeInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueSetter<DateTime> onSaved;
  const RoundedDatetimeInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: DateTimeField(
        format: DateFormat("dd-MM-yyyy HH:mm"),
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2030),
            builder: (BuildContext context, Widget child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: mainColor,
                  accentColor: mainColor,
                  colorScheme: ColorScheme.light(primary: mainColor),
                  buttonTheme:
                      ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child,
              );
            },
          );

          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              builder: (BuildContext context, Widget child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: mainColor,
                    accentColor: mainColor,
                    colorScheme: ColorScheme.light(primary: mainColor),
                    buttonTheme:
                        ButtonThemeData(textTheme: ButtonTextTheme.primary),
                  ),
                  child: child,
                );
              },
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
        onSaved: onSaved,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: backgroundColor,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
