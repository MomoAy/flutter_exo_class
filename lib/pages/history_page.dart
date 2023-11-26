import 'package:calculator/repository/ligne_calcul_repository.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: LigneCalculRepository.calculList.length,
        itemBuilder: (BuildContext context, int index) {
          final ligne = LigneCalculRepository.calculList[index];
          return ListTile(
            title: Text(
              '${ligne.nb1} + ${ligne.nb2} = ${ligne.result1}, ${ligne.result2}',
              style: TextStyle(fontSize: 18),
            ),
          );
        },
      );
  }
}
