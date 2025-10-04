import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Dosen',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 156, 17, 7),
        ),
      ),
      home: const FormDosen(),
    );
  }
}

class FormDosen extends StatefulWidget {
  const FormDosen({super.key});

  @override
  State<FormDosen> createState() => _FormDosenState();
}

class _FormDosenState extends State<FormDosen> {
  final _formKey = GlobalKey<FormState>();
  final int _currentStep = 0;

  final cNama = TextEditingController();
  final cNIDN = TextEditingController();
  final cHomebase = TextEditingController();
  final cEmail = TextEditingController();
  final cNotlp = TextEditingController();
  

  

  @override
  void dispose() {
    cNama.dispose();
    cNIDN.dispose();
    cHomebase.dispose();
    cEmail.dispose();
    cNotlp.dispose();
    super.dispose();
  }

  

  void _simpan() {
  if (!_formKey.currentState!.validate()) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Periksa kembali isian Anda.')),
    );
    return;
  }

  if (cHomebase.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Homebase belum diisi')),
    );
    return;
  }

 
  final data = {
    'Nama': cNama.text.trim(),
    'NIDN': cNIDN.text.trim(),
    'Homebase': cHomebase.text.trim(),
    'Email': cEmail.text.trim(),
    'No.Tlp': cNotlp.text.trim(),
  };

  
  showDialog(
  context: context,
  builder: (context) {
    return AlertDialog(
      title: const Text("Data Dosen"),
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
        title: const Text('Identitas Dosen'),
        isActive: true,
        state: StepState.indexed,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Data Dosen'),
            TextFormField(
              controller: cNama,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                hintText: 'cth: Rizka Amaniah,S.kom',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cNIDN,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'NIDN',
                hintText: 'cth: 2310631250076',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'NPM wajib diisi' : null,
                
            ),
          
            const SizedBox(height: 10),
            TextFormField(
              controller: cHomebase,
              decoration: const InputDecoration(
                labelText: 'Homebase',
                hintText: 'cth: Sistem Informasi',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.home),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'cth: nama@kampus.ac.id',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Email wajib diisi';
                }
                final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v.trim());
                return ok ? null : 'Format email tidak valid';
              },
            
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cNotlp,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'No. Telepon',
                hintText: 'cth: 08456543276',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'No.Tlp wajib diisi' : null,
            ),
          
            
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Data Dosen')),
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
