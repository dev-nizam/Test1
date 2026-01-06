import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: LoginPage()));

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final user = TextEditingController();
  final pass = TextEditingController();
  List<String> dataList = ["Initial Name"];

  void login() {
    if (user.text == "admin" && pass.text == "123") {
      // അഡ്മിൻ ലോഗിൻ
      Navigator.push(context, MaterialPageRoute(builder: (context) => AdminScreen(list: dataList)));
    } else if (user.text == "user" && pass.text == "123") {
      // കസ്റ്റമർ ലോഗിൻ
      Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerScreen(list: dataList)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Failed!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: user, decoration: const InputDecoration(labelText: "Username")),
            TextField(controller: pass, decoration: const InputDecoration(labelText: "Password"), obscureText: true),
            ElevatedButton(onPressed: login, child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}

class AdminScreen extends StatefulWidget {
  final List<String> list;
  const AdminScreen({super.key, required this.list});
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final nameInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin - Create Names")),
      body: Column(
        children: [
          TextField(controller: nameInput, decoration: const InputDecoration(labelText: "Enter Name")),
          ElevatedButton(onPressed: () {
            setState(() { widget.list.add(nameInput.text); });
            nameInput.clear();
          }, child: const Text("Create")),
          Expanded(child: ListView.builder(itemCount: widget.list.length, itemBuilder: (ctx, i) => ListTile(title: Text(widget.list[i]))))
        ],
      ),
    );
  }
}

class CustomerScreen extends StatelessWidget {
  final List<String> list;
  const CustomerScreen({super.key, required this.list});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customer - View Names")),
      body: ListView.builder(itemCount: list.length, itemBuilder: (ctx, i) => ListTile(title: Text(list[i]))),
    );
  }
}
