import 'package:flutter/material.dart';

import 'data_model.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    Key? key,
    required this.data,
    required this.edit,
    required this.index,
    required this.delete,
  }) : super(key: key);
  final DataModel data;
  final Function edit;
  final Function delete;

  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: IconButton(
              onPressed: () {
                edit(index);
              },
              icon: const Icon(Icons.edit)),
        ),
        title: Text(data.username),
        subtitle: Text(data.password),
        trailing: CircleAvatar(
            backgroundColor: Colors.red,
            child: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                delete(index);
              },
            )),
      ),
    );
  }
}
