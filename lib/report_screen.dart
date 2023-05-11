import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<Map<String, dynamic>> myDataList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Most selled items'),
          Expanded(
            child: StreamBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading...");
                }
                myDataList.clear();
                snapshot.data!.docs.forEach((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  myDataList.add(data);
                });
                return Container(
                  // color: Colors.red,
                  width: double.infinity,
                  height: 500,
                  child: DataTable(
                      border: TableBorder.all(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(10),
                          style: BorderStyle.solid),
                      columns: const [
                        DataColumn(label: Text('Item name')),
                        DataColumn(label: Text('Item Count')),
                      ],
                      rows: myDataList.map((e) {
                        return DataRow(
                          onSelectChanged: (o) {},
                          cells: [
                            DataCell(Text(e['name'])),
                            DataCell(Text(e['quantity'].toString())),
                          ],
                        );
                      }).toList()),
                );
              },
              stream: FirebaseFirestore.instance
                  .collection('report')
                  .orderBy('quantity', descending: true)
                  .snapshots(),
            ),
          )
        ],
      ),
    );
  }
}
