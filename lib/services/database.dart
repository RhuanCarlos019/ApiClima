import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Previsão do Tempo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _databaseService = DatabaseService();
  late Future<List<String>> _favorites;

  @override
  void initState() {
    super.initState();
    _updateFavorites();
  }

  Future<void> _updateFavorites() async {
    setState(() {
      _favorites = _databaseService.getFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previsão do Tempo'),
      ),
      body: Center(
        child: FutureBuilder<List<String>>(
          future: _favorites,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erro: ${snapshot.error}');
            } else {
              List<String> favorites = snapshot.data!;
              return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(favorites[index]),
                    onTap: () {
                      // Implementar a navegação para exibir a previsão do tempo
                    },
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavoritesScreen(databaseService: _databaseService)),
          );
          _updateFavorites();
        },
        child: Icon(Icons.favorite),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  final DatabaseService databaseService;

  FavoritesScreen({required this.databaseService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Locais Favoritos'),
      ),
      body: Center(
        child: Text('Página de locais favoritos'),
      ),
    );
  }
}

class DatabaseService {
  static const String _favoritesKey = 'favorites';

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<String>> getFavorites() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getStringList(_favoritesKey) ?? [];
  }

  Future<void> addFavorite(String location) async {
    final SharedPreferences prefs = await _prefs;
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];
    if (!favorites.contains(location)) {
      favorites.add(location);
      await prefs.setStringList(_favoritesKey, favorites);
    }
  }

  Future<void> removeFavorite(String location) async {
    final SharedPreferences prefs = await _prefs;
    List<String> favorites = prefs.getStringList(_favoritesKey) ?? [];
    favorites.remove(location);
    await prefs.setStringList(_favoritesKey, favorites);
  }
}
