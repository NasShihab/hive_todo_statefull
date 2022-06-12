
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);

  late Box<String> friendsBox;

  final _idController = TextEditingController();
  final _nameController = TextEditingController();

  // @override
  // void initState() {
  //   friendsBox = Hive.box<String>('friends');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive CRUD'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Buttons CRUD
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('Create'),
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
                                      label: Text('value'),
                                    ),
                                    controller: _nameController,
                                  ),
                                  SizedBox(height: 15),
                                  ElevatedButton(
                                    onPressed: () {
                                      final key = _idController.text;
                                      final value = _nameController.text;

                                      friendsBox.put(key, value);
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
                ),
                ElevatedButton(
                  child: Text('Update'),
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
                                      label: Text('value'),
                                    ),
                                    controller: _nameController,
                                  ),
                                  SizedBox(height: 15),
                                  ElevatedButton(
                                    onPressed: () {
                                      final key = _idController.text;
                                      final value = _nameController.text;

                                      friendsBox.put(key, value);
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
                ),
                ElevatedButton(
                  child: Text('Delete'),
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
                                  SizedBox(height: 15),
                                  ElevatedButton(
                                    onPressed: () {
                                      final key = _idController.text;

                                      friendsBox.delete(key);
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
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  child: ValueListenableBuilder(
                    valueListenable: friendsBox.listenable(),
                    builder: (context, Box<String> friends, _) {
                      return ListView.separated(
                          itemCount: friends.keys.length,
                          itemBuilder: (ctx, i) {
                            final key = friends.keys.toList()[i];
                            final value = friends.get(key);

                            return ListTile(

                                title: Text('ID: $key',style: TextStyle(
                                    fontSize: 20
                                ),),
                                subtitle: Text('Name: ${value.toString()}', style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black
                                ),),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red,),
                                  onPressed: (){
                                    final key = friends.keys.toList()[i];
                                    friendsBox.delete(key);
                                  },
                                )
                              //Icon(Icons.delete, color: Colors.red,),
                            );
                          },
                          separatorBuilder: (_, i) => Divider());
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
