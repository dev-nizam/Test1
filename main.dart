import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin-Customer App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
    );
  }
}

// --- ലോഗിൻ പേജ് ---
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void _login() {
    String username = _userController.text;
    String password = _passController.text;

    if (username == 'admin' && password == 'admin123') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminPage()));
    } else if (username == 'user' && password == 'user123') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CustomerPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ലോഗിൻ പരാജയപ്പെട്ടു!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ലോഗിൻ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _userController, decoration: const InputDecoration(labelText: 'യൂസർ നെയിം')),
            TextField(controller: _passController, decoration: const InputDecoration(labelText: 'പാസ്‌വേഡ്'), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: const Text('ലോഗിൻ'))
          ],
        ),
      ),
    );
  }
}

// ഡാറ്റ സ്റ്റോർ ചെയ്യാൻ ഒരു ഗ്ലോബൽ ലിസ്റ്റ് (താല്കാലികം)
List<String> itemsList = ["Item 1", "Item 2"];

// --- അഡ്മിൻ പേജ് (ലിസ്റ്റ് ക്രിയേറ്റ് ചെയ്യാൻ) ---
class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _itemController = TextEditingController();

  void _addItem() {
    if (_itemController.text.isNotEmpty) {
      setState(() {
        itemsList.add(_itemController.text);
      });
      _itemController.clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('പേര് ആഡ് ചെയ്തു!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('അഡ്മിൻ പാനൽ'), actions: [
        IconButton(icon: const Icon(Icons.logout), onPressed: () => Navigator.pop(context))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _itemController, decoration: const InputDecoration(labelText: 'പുതിയ പേര് നൽകുക')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _addItem, child: const Text('ക്രിയേറ്റ് ചെയ്യുക')),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: itemsList.length,
                itemBuilder: (context, index) => ListTile(title: Text(itemsList[index])),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// --- കസ്റ്റമർ പേജ് (ലിസ്റ്റ് കാണാൻ മാത്രം) ---
class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('കസ്റ്റമർ പേജ്'), actions: [
        IconButton(icon: const Icon(Icons.logout), onPressed: () => Navigator.pop(context))
      ]),
      body: itemsList.isEmpty
          ? const Center(child: Text('ലിസ്റ്റ് ശൂന്യമാണ്'))
          : ListView.builder(
              itemCount: itemsList.length,
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.person),
                title: Text(itemsList[index]),
              ),
            ),
    );
  }
}
