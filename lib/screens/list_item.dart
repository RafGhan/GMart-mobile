import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gmart/models/item.dart';
import 'package:gmart/screens/detail_item.dart';
import 'package:gmart/widgets/left_drawer.dart';

class ListItemPage extends StatefulWidget {
    const ListItemPage({Key? key}) : super(key: key);

    @override
    _ListItemPageState createState() => _ListItemPageState();
} 

class _ListItemPageState extends State<ListItemPage> {
  Future<List<Item>> fetchProduct() async {
    var url = Uri.parse(
      'https://rafi-ghani-tugas.pbp.cs.ui.ac.id/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Item> list_product = [];
    for (var d in data) {
      if (d != null) {
          list_product.add(Item.fromJson(d));
      }
    }
    return list_product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Center(
          child: Text(
            'List Item',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProduct(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                Text(
                  "Tidak ada data item.",
                  style:
                    TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                ),
                SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                        "${index + 1}. ${snapshot.data![index].fields.name}",
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                        ),
                        ),
                        const SizedBox(height: 10),
                        Text("Amount: ${snapshot.data![index].fields.amount}"),
                        const SizedBox(height: 10),
                        Text("Description: ${snapshot.data![index].fields.description}"),
                        const SizedBox(height: 10),
                        Text("Tipe: ${snapshot.data![index].fields.type}"),
                        ElevatedButton(
                          onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailItemPage(item: snapshot.data![index]),
                            ),
                          );
                        },
                        child: const Text('Detail Item'),
                      ),
                    ],
                    ),
                  )
                )
              );
            }
          }
        }
      )
    );
  }
}