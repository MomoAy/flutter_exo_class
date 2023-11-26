import 'package:calculator/models/ligne_calcul.dart';
import 'package:calculator/pages/history_page.dart';
import 'package:calculator/repository/ligne_calcul_repository.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? nb1 = 0;
  int? nb2 = 0;
  int? sum = 0;
  int? rest = 0;
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController nb1Controller = TextEditingController();
  TextEditingController nb2Controller = TextEditingController();
  TextEditingController sumController = TextEditingController();
  TextEditingController restController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Calculator APP"),
            centerTitle: true,
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Form(
                    key: keyForm,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: nb1Controller,
                          decoration: const InputDecoration(
                              hintText: "Entrez le premier nombre",
                              labelText: "Premier nombre",
                              border: OutlineInputBorder()),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Le champ ne peut être vide";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            nb1 = int.parse(value);
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: nb2Controller,
                          decoration: const InputDecoration(
                            hintText: "Entrez votre deuxième nombre",
                            labelText: "Deuxième nombre",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Le champ ne peut être vide";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            nb2 = int.parse(value);
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              foregroundColor: Colors.white,
                              
                            ),
                            onPressed: () {
                              if (keyForm.currentState!.validate()) {
                                sum = nb1! + nb2!;
                                rest = nb1! - nb2!;
                                LigneCalcul lc = LigneCalcul(nb1, nb2, sum, rest);
                                LigneCalculRepository.calculList.add(lc);
                              }
                              setState(() {
                                nb1Controller.clear();
                                nb2Controller.clear();
                              });
                            },
                            child: const Text("Calcul"))
                      ],
                    )),
                    SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Somme : "),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.70,
                      height: 55,
                      child: Text(
                          LigneCalculRepository.calculList.isNotEmpty ? LigneCalculRepository.calculList.last.result1.toString() : '0'),
              
                    )
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Reste : "),
                    const SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8)),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.70,
                      height: 55,
                      child: Text(
                          LigneCalculRepository.calculList.isNotEmpty ? LigneCalculRepository.calculList.last.result2.toString() : '0'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HistoryPage()));
        },
        tooltip: 'History',
        child: Icon(Icons.add_link_outlined),
        ),
      );
  }
}
