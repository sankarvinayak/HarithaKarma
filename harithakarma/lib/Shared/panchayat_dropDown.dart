import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:harithakarma/service/database.dart';

class PanchayatDropDownList extends StatefulWidget {
  final Function(Object) Panchayat;

  const PanchayatDropDownList({Key? key, required this.Panchayat})
      : super(key: key);

  @override
  State<PanchayatDropDownList> createState() => _PanchayatDropDownListState();
}

class _PanchayatDropDownListState extends State<PanchayatDropDownList> {
  var _Panchayath;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<QuerySnapshot>(
      stream: DatabaseService().getpanchayath(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Container();

        return DropdownButton(
          hint: Container(
            alignment: Alignment.center,
            child: _Panchayath == null
                ? const Text('Panchayath/Muncipality/Corperation name')
                : Text(
                    _Panchayath,
                  ),
          ),
          isExpanded: true,
          value: _Panchayath,
          items: snapshot.data!.docs.map((value) {
            return DropdownMenuItem(
              value: value.get('panchayath'),
              child: Text('${value.get('panchayath')}'),
            );
          }).toList(),
          onChanged: (value) {
            setState(
              () {
                _Panchayath = value;
                widget.Panchayat(value!);
              },
            );
          },
        );
      },
    ));
  }
}
