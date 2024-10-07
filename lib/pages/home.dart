import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktop_clone/models/item.dart';
import 'package:tiktop_clone/provider/apiProvider.dart';

import 'package:tiktop_clone/provider/counter_notifier.dart';
class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // int count = ref.watch(counterPovider);

    final AsyncValue itemsAsyncValue = ref.watch(itemProvider);
    // CounterNotifier counterNotifier = ref.read(counterPovider.notifier);
    return Scaffold(
      
      appBar: AppBar(
        title:const Text("Riverpod"),
      ),
      body: itemsAsyncValue.when(data: (items)=> Expanded(
        child: SizedBox(
         
          child:ListView.builder(
            itemCount: items.length,
            itemBuilder: (context,index){
              final item = items[index];
              return Card(
                child: ListTile(
                  title: Text(item.name,style: TextStyle(fontSize: 20,color: Colors.blue),),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(onPressed: (){
                         _editItemDialog(context, ref, item);
                        }, 
                        icon:const Icon(Icons.edit)
                        ),
                        IconButton(onPressed:(){
                          ref.read(itemProvider.notifier).deleteItem(item.id);
                        }, 
                        icon:const Icon(Icons.delete)
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            ),
        ),
      ), 
      error: (e,stack)=> Center (child: Text("Error: $e show"),), 
      loading: ()=>const Center(child: CircularProgressIndicator(),)
      ),
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.add),
        onPressed: ()=> _addItemDialog(context,ref),
      ),
    );
  }


  void _addItemDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Item'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Enter item name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(itemProvider.notifier).createItem(controller.text);
              Navigator.of(context).pop();
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

   void _editItemDialog(BuildContext context, WidgetRef ref, Item item) {
    final TextEditingController controller = TextEditingController(text: item.name);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Item'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Enter new name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(itemProvider.notifier).updateItem(item.id, controller.text);
              Navigator.of(context).pop();
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
}

final  counterPovider = NotifierProvider<CounterNotifier,int> (() {
  return CounterNotifier();
},);



 




