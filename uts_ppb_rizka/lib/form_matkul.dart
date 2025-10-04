import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Mata Kuliah',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 156, 17, 7),
        ),
      ),
      home: const Formmatkul(),
    );
  }
}

class Formmatkul extends StatefulWidget {
  const Formmatkul({super.key});

  @override
  State<Formmatkul> createState() => _FormmatkulState();
}

class _FormmatkulState extends State<Formmatkul> {
  final _formKey = GlobalKey<FormState>();
  final int _currentStep = 0;

  final cNamaMatkul = TextEditingController();
  final cKodeMatkul = TextEditingController();
  final cSksMatkul = TextEditingController();
  

  @override
  void dispose() {
    cNamaMatkul.dispose();
    cKodeMatkul.dispose();
    cSksMatkul.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Periksa kembali isian Anda.')),
      );
      return;
    }

    

    final data = {
      'Nama Mata Kuliah': cNamaMatkul.text.trim(),
      'Kode Mata Kuliah': cKodeMatkul.text.trim(),
      'Jumlah SKS': cSksMatkul.text.trim(),
    
    };

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Data Mata Kuliah"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.entries
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text('${e.key}: ${e.value}'),
                    ),
                  )
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Widget _sectionTitle(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8, top: 8),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final steps = <Step>[
      Step(
        title: const Text('Mata Kuliah'),
        isActive: true,
        state: StepState.indexed,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Data Mata Kuliah'),
            TextFormField(
              controller: cNamaMatkul,
              decoration: const InputDecoration(
                labelText: 'Nama Mata Kuliah',
                hintText: 'cth: Pemrograman Perangkat Bergerak',
                prefixIcon: Icon(Icons.book),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nama Mata Kuliah Wajib Diisi' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cKodeMatkul,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Kode Mata Kuliah',
                hintText: 'cth: SIS61521',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.code),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'NPM wajib diisi' : null,
            ),

            const SizedBox(height: 10),
            TextFormField(
              controller: cSksMatkul,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'SKS',
                hintText: 'cth: 3',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.access_time),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'SKS wajib diisi' : null,
            ),
            
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Data Mata Kuliah')),
      body: Form(
        key: _formKey,
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          steps: steps,
          onStepContinue: _simpan,
          onStepCancel: null,
          controlsBuilder: (context, details) {
            return Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text('Simpan'),
                  onPressed: details.onStepContinue,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}
