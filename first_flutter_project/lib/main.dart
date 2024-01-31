import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.green,
        backgroundColor: Colors.grey[200],
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '203172'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> clothes = [];
  TextEditingController clothesController = TextEditingController();
  TextEditingController editController = TextEditingController();
  int? editingIndex;

  void _addClothes() {
    setState(() {
      String newClothes = clothesController.text;
      if (newClothes.isNotEmpty) {
        if (editingIndex != null) {
          // If we are editing, update the existing clothes
          clothes[editingIndex!] = newClothes;
          editingIndex = null;
        } else {
          // If not editing, add new clothes
          clothes.add(newClothes);
        }
        clothesController.clear();
      }
    });
  }

  void _deleteClothes(int index) {
    setState(() {
      clothes.removeAt(index);
      if (editingIndex == index) {
        // If we are deleting the currently edited item, reset editingIndex
        editingIndex = null;
        editController.clear();
      }
    });
  }

  void _startEditing(int index) {
    setState(() {
      editingIndex = index;
      editController.text = clothes[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 54, 145, 95),
        title: Text(widget.title),
      ),
      backgroundColor: Color.fromARGB(
          255, 54, 145, 95), // Set the background color of the entire app
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < clothes.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 218, 149, 22),
                      width: 2.0), // Add a border
                  borderRadius: BorderRadius.circular(8.0),
                  color: Color.fromARGB(255, 218, 149, 22),
                ),
                child: ListTile(
                  title: editingIndex == i
                      ? TextField(
                          controller: editController,
                          decoration:
                              const InputDecoration(labelText: 'Edit Clothes'),
                        )
                      : Text(
                          clothes[i],
                          style: TextStyle(color: Color.fromARGB(255, 9, 103, 211)), // Set the text color to blue
                        ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (editingIndex == i)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Color.fromARGB(255, 6, 240, 84), // Set the background color of the border
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.check,
                                  color: Color.fromARGB(255, 97, 10, 10)),
                              onPressed: () => _addClothes(),
                            ),
                          ),
                        ),
                      if (editingIndex != i)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Color.fromARGB(255, 6, 240, 84), // Set the background color of the border
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.edit,
                                  color: Color.fromARGB(255, 97, 10, 10)),
                              onPressed: () => _startEditing(i),
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Color.fromARGB(255, 6, 240, 84), // Set the background color of the border
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.delete,
                                color: Color.fromARGB(255, 97, 10, 10)),
                            onPressed: () => _deleteClothes(i),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: clothesController,
              decoration: const InputDecoration(labelText: 'Add Clothes'),
            ),
          ),
          ElevatedButton(
            onPressed: _addClothes,
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // background color
            ),
            child: Text(
              editingIndex != null ? 'Update Clothes' : 'Add Clothes',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
