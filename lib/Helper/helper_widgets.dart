import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HelperWidgets extends State {
  var date_hint = '25/7/2020';
  var date_day = 'الخميس';

  Widget reserve_spinner(String hint) {
    String _value;
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
      child: new Container(
        alignment: Alignment.center,
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5.0),
          side: BorderSide(
            width: 1.0,
            color: Color(0xFFDEDEDE),
          ),
        )),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
              value: _value,
              isExpanded: true,
              iconSize: 40,
              icon: (null),
              hint: Text(
                hint,
                style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
              ),
              onChanged: (String newValue) {
                setState(() {
                  _value = newValue;
                });
              },

              /*
              // use with api
              items: pharmacyList?.map((item) {
                return new DropdownMenuItem(
                  child: new Text(item['name']),
                  value: item['id'].toString(),
                );
              })?.toList() ??
                  [],

               */
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        date_hint = "${selectedDate.toLocal()}".split(' ')[0];
        date_day = DateFormat('EEEE').format(selectedDate);
        print('date_hint : $date_hint');
        print('date_day : $date_day');
      });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
