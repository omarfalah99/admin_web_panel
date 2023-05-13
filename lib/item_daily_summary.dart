import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemSummary extends StatefulWidget {
  String date;
  ItemSummary({Key? key, required this.date}) : super(key: key);

  @override
  State<ItemSummary> createState() => _ItemSummaryState();
}

class _ItemSummaryState extends State<ItemSummary> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('DailyData')
          .doc(widget.date)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Attributes'),
          ),
          body: ListView(
            children: data.keys.where((key) => key != 'date').map((key) {
              return ListTile(
                title: Text(key),
                trailing: Text(data[key].toString()),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
