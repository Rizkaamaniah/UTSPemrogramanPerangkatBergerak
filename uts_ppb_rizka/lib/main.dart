import 'package:flutter/material.dart';
import 'package:uts_ppb_rizka/form_dosen.dart';
import 'package:uts_ppb_rizka/form_matkul.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu Drawer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 156, 17, 7)),
      ),
      home: const MainWithDrawer(),
      routes: {
        '/form_dosen': (_) => const FormDosen(),
        '/form_matkul': (_) => const Formmatkul(), 
       
       
       
      },
    );
  }
}

class MainWithDrawer extends StatelessWidget {
  const MainWithDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Utama')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('RIZKA AMANIAH'),
              accountEmail: const Text('2310631250076'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: const Icon(Icons.school),
              ),
            
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Dosen'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/form_dosen');
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Mata Kuliah'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/form_matkul');
              },
            ),
           
          ],
        ),
      ),
      body: const _HomeContent(),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.school),
                    title: const Text('Dosen'),
                    onTap: () {
                      Navigator.pushNamed(context, '/form_dosen');
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: const Text('Mata Kuliah'),
                    onTap: () {
                      Navigator.pushNamed(context, '/form_matkul');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

