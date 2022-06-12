import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Box<String> friendsBox;

  TextEditingController _idController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _editController = TextEditingController();

  @override
  void initState() {
    friendsBox = Hive.box<String>('friends');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // + button
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return Dialog(
                        child: SizedBox(
                          height: 200,
                          child: Column(
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  label: Text('key'),
                                ),
                                controller: _idController,
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  label: Text('Note'),
                                ),
                                controller: _nameController,
                              ),
                              SizedBox(height: 15),
                              ElevatedButton(
                                onPressed: () {
                                  final key = _idController.text;
                                  final note = _nameController.text;

                                  friendsBox.put(key, note);
                                  _idController.clear();
                                  _nameController.clear();

                                  Navigator.pop(context);
                                },
                                child: Text('Submit'),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(Icons.add)),
        ],
        backgroundColor: Colors.green,
        title: Text('ToDo Hive'),
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: friendsBox.listenable(),
          builder: (context, Box<String> friends, _) {
            return ListView.separated(
                itemCount: friends.keys.length,
                itemBuilder: (ctx, i) {
                  final key = friends.keys.toList()[i];
                  final note = friends.get(key);

                  return ListTile(
                      leading: Text(
                        key.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      title: Text(
                        note.toString(),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return Dialog(
                                      child: SizedBox(
                                        height: 200,
                                        child: Column(
                                          children: [
                                            // TextField(
                                            //   decoration: InputDecoration(
                                            //     label: Text('key'),
                                            //   ),
                                            //   controller: _idController,
                                            // ),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                label: Text('note'),
                                              ),
                                              controller: _nameController =
                                                  TextEditingController(
                                                      text: note.toString()),
                                            ),
                                            SizedBox(height: 15),
                                            ElevatedButton(
                                              onPressed: () {
                                                final note =
                                                    _nameController.text;
                                                friendsBox.put(key, note);

                                                Navigator.pop(context);
                                              },
                                              child: Text('Submit'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              final note = friends.keys.toList()[i];
                              friendsBox.delete(note);
                            },
                          ),
                        ],
                      )
                      //Icon(Icons.delete, color: Colors.red,),
                      );
                },
                separatorBuilder: (_, i) => Divider());
          },
        ),
      ),
    );
  }
}
