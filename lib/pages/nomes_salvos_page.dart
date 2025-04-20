import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NomesSalvosPage extends StatefulWidget {
  final List<String> nomesSalvos;

  const NomesSalvosPage({Key? key, required this.nomesSalvos}) : super(key: key);

  @override
  _NomesSalvosPageState createState() => _NomesSalvosPageState();
}

class _NomesSalvosPageState extends State<NomesSalvosPage> {
  late List<String> nomesSalvos;

  @override
  void initState() {
    super.initState();
    nomesSalvos = List.from(widget.nomesSalvos);
  }

  Future<void> removerNome(String nome) async {
    setState(() {
      nomesSalvos.remove(nome);
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('nomesSalvos', nomesSalvos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nomes Salvos'),
      ),
      body: nomesSalvos.isEmpty
          ? Center(child: Text('Nenhum nome salvo.'))
          : ListView.builder(
              itemCount: nomesSalvos.length,
              itemBuilder: (context, index) {
                final nome = nomesSalvos[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: Icon(Icons.person, color: Colors.indigo),
                    title: Text(nome),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => removerNome(nome),
                      tooltip: 'Remover nome',
                    ),
                  ),
                );
              },
            ),
    );
  }
}