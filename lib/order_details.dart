import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  List orders;
  String name;
  String email;
  String phone;
  String city;
  String garak;
  String street;
  OrderDetails({
    Key? key,
    required this.street,
    required this.orders,
    required this.city,
    required this.email,
    required this.garak,
    required this.name,
    required this.phone,
  }) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  double total = 0;
  double getSum() {
    for (int i = 0; i < widget.orders.length; i++) {
      total += widget.orders[i]['subtotal'];
    }
    return total;
  }

  List items = [];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    num all = 1;
    widget.orders.forEach((element) {
      all += element['subtotal'];
    });
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: screenHeight * 0.09,
                  width: screenWidth * 0.22,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.person,
                        size: 30,
                        color: Color.fromRGBO(246, 121, 82, 1),
                      ),
                      Column(
                        children: [
                          const Text(
                            'Customer',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(widget.name),
                          SizedBox(
                            height: 5,
                          ),
                          Text(widget.email),
                          SizedBox(
                            height: 5,
                          ),
                          Text('+964${widget.phone}'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 260,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(
                        Icons.delivery_dining,
                        size: 30,
                        color: Color.fromRGBO(246, 121, 82, 1),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          const Text(
                            'Deliver to',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('City: ${widget.city}'),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('Garak: ${widget.garak}'),
                          Text('Street: ${widget.street}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: screenHeight * 0.2,
                  width: screenWidth * 0.7,
                  margin: const EdgeInsets.all(20),
                  child: DataTable(
                    dataRowHeight: 60,
                    border: TableBorder.all(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white10,
                      width: 1,
                    ),
                    columns: const [
                      DataColumn(label: Text('Product')),
                      DataColumn(label: Text('Quantity')),
                      DataColumn(label: Text('Price')),
                      DataColumn(label: Text('Total')),
                    ],
                    rows: widget.orders
                        .map((e) => DataRow(cells: [
                              DataCell(Row(
                                children: [
                                  Image.network(e['imageUrl'],
                                      fit: BoxFit.contain),
                                  Text(e['name'])
                                ],
                              )),
                              DataCell(Text(e['quantity'].toString())),
                              DataCell(Text(e['price'] + '\$')),
                              DataCell(Text('${e['subtotal']}\$')),
                            ]))
                        .toList(),
                  ),
                ),
                Container(
                  height: screenHeight * 0.04,
                  width: screenWidth * 0.7,
                  margin: const EdgeInsets.fromLTRB(25, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Price:'),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Text(getSum().toString() + '\$'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.2,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color.fromRGBO(246, 121, 82, 1),
                  minimumSize: Size(screenWidth * 0.4, screenHeight * 0.05)),
              onPressed: () {
                List list = [];
                widget.orders.forEach((element) {
                  list.add({
                    'name': element['name'],
                    'quantity': element['quantity']
                  });
                });
                for (var element in widget.orders) {
                  final FirebaseFirestore firestore =
                      FirebaseFirestore.instance;
                  final DocumentReference documentReference =
                      firestore.collection('report').doc(element['name']);
                  documentReference.get().then((documentSnapshot) {
                    if (documentSnapshot.exists) {
                      print('');
                      documentReference.update({
                        'quantity': FieldValue.increment(element['quantity'])
                      }).then((value) {
                        print('Document updated successfully.');
                      }).catchError((error) {
                        print('Failed to update document: $error');
                      });
                    } else {
                      FirebaseFirestore.instance
                          .collection('report')
                          .doc(element['name'])
                          .set({
                        'date': DateTime.now().toString().substring(0, 10),
                        'name': element['name'],
                        'quantity': element['quantity']
                      });
                    }
                    print('Item added successfully');
                  }).catchError((error) {
                    print('Failed to get document: $error');
                  });
                }
              },
              child: const Text('Save Order'),
            ),
          ],
        ),
      ),
    );
  }
}
