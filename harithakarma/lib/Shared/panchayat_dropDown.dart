import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:harithakarma/service/database.dart';

class PanchayatDropDownList extends StatefulWidget {
  final Function(Object) panchayat;

  const PanchayatDropDownList({Key? key, required this.panchayat})
      : super(key: key);

  @override
  State<PanchayatDropDownList> createState() => _PanchayatDropDownListState();
}

class _PanchayatDropDownListState extends State<PanchayatDropDownList> {
  String? _panchayath;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseService().getpanchayath(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Container();

        return DropdownButton(
          hint: Container(
            alignment: Alignment.center,
            child: _panchayath == null
                ? const Text('Panchayath/Muncipality/Corperation name')
                : Text(
                    _panchayath!,
                  ),
          ),
          isExpanded: true,
          value: _panchayath,
          items: snapshot.data!.docs.map((value) {
            return DropdownMenuItem(
              value: value.get('panchayath'),
              child: Text('${value.get('panchayath')}'),
            );
          }).toList(),
          onChanged: (value) {
            setState(
              () {
                _panchayath = value.toString();
                widget.panchayat(value!);
              },
            );
          },
        );
      },
    );
  }
}
