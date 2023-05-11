import 'package:admin_web_panel/order_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Map<String, dynamic>> myDataList = [];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: [
        Container(
          width: width * 0.7,
          height: height * 0.4,
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('admin_cart').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                width: 500,
                height: 500,
                child: DataTable(
                    border: TableBorder.all(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(10),
                        style: BorderStyle.solid),
                    columns: const [
                      DataColumn(label: Text('Order ID')),
                      DataColumn(label: Text('Order Date')),
                      DataColumn(label: Text('User Name')),
                      DataColumn(label: Text('City')),
                    ],
                    rows: myDataList.map((e) {
                      return DataRow(
                          cells: [
                            DataCell(Text("#${e['orderNo']}")),
                            DataCell(
                                Text(e['date'].toString().substring(0, 10))),
                            DataCell(Text(e['nameOfUser'].toString())),
                            DataCell(Text(e['city'].toString())),
                          ],
                          onSelectChanged: (val) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return OrderDetails(
                                  street: e['street'],
                                  orders: e['items'],
                                  city: e['city'],
                                  email: e['email'],
                                  garak: e['garak'],
                                  name: e['nameOfUser'],
                                  phone: e['phone']);
                            }));
                          });
                    }).toList()),
              );
            },
          ),
        ),
      ],
    ));
  }
}
