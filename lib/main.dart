import 'dart:math';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/nomes_salvos_page.dart';

void main() {
  runApp(SorteioNomesApp());
}

class SorteioNomesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sorteio de Nomes',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: SorteioHomePage(),
    );
  }
}

class SorteioHomePage extends StatefulWidget {
  @override
  _SorteioHomePageState createState() => _SorteioHomePageState();
}

class _SorteioHomePageState extends State<SorteioHomePage> {
  final Random random = Random();
  final faker = Faker();

  List<String> nomes = [];
  List<String> nomesSalvos = [];
  String? nomeSorteado;
  bool mostrarLista = false;

  @override
  void initState() {
    super.initState();
    gerarNomesAleatorios();
    carregarNomesSalvos();
  }

  void gerarNomesAleatorios() {
    setState(() {
      nomes = List.generate(10, (_) => faker.person.name());
      nomeSorteado = null;
    });
  }

  void sortearNome() {
    if (nomes.isNotEmpty) {
      final index = random.nextInt(nomes.length);
      setState(() {
        nomeSorteado = nomes[index];
      });
    }
  }

  void limparLista() {
    setState(() {
      nomes.clear();
      nomeSorteado = null;
    });
  }

  void alternarLista() {
    setState(() {
      mostrarLista = !mostrarLista;
    });
  }

  Future<void> salvarNome(String nome) async {
    if (!nomesSalvos.contains(nome)) {
      setState(() {
        nomesSalvos.add(nome);
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList('nomesSalvos', nomesSalvos);
    }
  }

  Future<void> carregarNomesSalvos() async {
    final prefs = await SharedPreferences.getInstance();
    final lista = prefs.getStringList('nomesSalvos') ?? [];
    setState(() {
      nomesSalvos = lista;
    });
  }

  void exibirNomesSalvos() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NomesSalvosPage(nomesSalvos: nomesSalvos),
      ),
    );

    // Recarrega os nomes salvos ao voltar da tela
    await carregarNomesSalvos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sorteio de Nomes'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (nomeSorteado != null)
                Column(
                  children: [
                    Text(
                      '🎉 Nome sorteado:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8),
                    Text(
                      nomeSorteado!,
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.indigo),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: gerarNomesAleatorios,
                    icon: Icon(Icons.refresh),
                    label: Text('Gerar Nomes'),
                  ),

                  ElevatedButton.icon(
                    onPressed: sortearNome,
                    icon: Icon(Icons.casino),
                    label: Text('Sortear'),
                  ),

                  ElevatedButton.icon(
                    onPressed: limparLista,
                    icon: Icon(Icons.delete_forever),
                    label: Text('Limpar Lista'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),

                  ElevatedButton.icon(
                    onPressed: alternarLista,
                    icon: Icon(
                      mostrarLista ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white,
                    ),
                    label: Text(
                      mostrarLista ? 'Ocultar Lista' : 'Mostrar Lista',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                    ),
                  ),

                  ElevatedButton.icon(
                    onPressed: exibirNomesSalvos,
                    icon: Icon(Icons.star),
                    label: Text('Ver nomes salvos'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  ),
                ],
              ),
              SizedBox(height: 30),
              if (mostrarLista)
                nomes.isEmpty
                    ? Text('Lista vazia')
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: nomes.length,
                        itemBuilder: (context, index) {
                          final nome = nomes[index];
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 6),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              leading: Icon(Icons.person, color: Colors.indigo),
                              title: Text(nome),
                              trailing: IconButton(
                                icon: Icon(Icons.star_border),
                                tooltip: 'Salvar nome',
                                onPressed: () => salvarNome(nome),
                              ),
                            ),
                          );
                        },
                      ),
            ],
          ),
        ),
      ),
    );
  }
}