import 'package:admin_web_panel/item_daily_summary.dart';
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
          // const Text('Most selled items'),
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

                // int sum = 0;
                // snapshot.data?.docs.forEach((doc) {
                //   Map<String, dynamic> data = doc.data();
                //   data.forEach((key, value) {
                //     if (value is int) {
                //       sum += value;
                //     }
                //   });
                // });

                List<DataRow> orderRows = [];

                for (DocumentSnapshot document in snapshot.data!.docs) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  int sum = 0;
                  data.forEach((key, value) {
                    if (value is int) {
                      sum += value;
                    }
                  });

                  orderRows.add(DataRow(
                      cells: [
                        DataCell(Text(document.id)),
                        DataCell(Text(sum.toString())),
                      ],
                      onSelectChanged: (w) {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (builder) {
                          return ItemSummary(date: data['date']);
                        }));
                      }));
                }

                return SizedBox(
                  // color: Colors.red,
                  width: double.infinity,
                  height: 500,
                  child: DataTable(
                      border: TableBorder.all(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(10),
                          style: BorderStyle.solid),
                      columns: const [
                        DataColumn(label: Text('Date')),
                        DataColumn(label: Text('Total items')),
                      ],
                      rows: orderRows.toList(),
                      onSelectAll: (val) {}),
                );
              },
              stream: FirebaseFirestore.instance
                  .collection('DailyData')
                  .snapshots(),
            ),
          )
        ],
      ),
    );
  }
}
