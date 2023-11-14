import 'package:flutter/material.dart';
import 'package:gmart/widgets/left_drawer.dart';
import 'package:gmart/widgets/shop_card.dart';

class ListItemPage extends StatefulWidget{
  const ListItemPage({Key? key});

  @override
  State<ListItemPage> createState() => _ListItemPageState();
}

class _ListItemPageState extends State<ListItemPage>{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'List Item'
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: listitem.length,
                itemBuilder: (BuildContext context, int i){
                  return ListTile(
                    title: Text(
                      "${i + 1}. ${listitem[i].name}",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Container(
                      child: Text(
                        'Jumlah: ${listitem[i].amount}\nDeskripsi: ${listitem[i].description}\nTipe: ${listitem[i].type}',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}