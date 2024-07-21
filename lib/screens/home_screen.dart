

import 'dart:ffi';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  bool isEditing = false;
   List<String> _tasks = [];
   TextEditingController _textConroller = TextEditingController();

// lets write addTask Method;

void _addTask(){
  if(_textConroller.text.isNotEmpty){
    setState(() {
      _tasks.add(_textConroller.text);
 
 
      _textConroller.clear();
    
    });
  }

}

void _removeTask(int index){

    setState(() {
      _tasks.removeAt(index);
 
 
      _textConroller.clear();
    
    });
  
}
void _editTask(index){
   setState(() {
      _index = index;
    isEditing = true;
     _textConroller.text = _tasks[index];

   });
}

void _saveTodo(){
  setState(() {
  
    _tasks[_index] = _textConroller.text;
    isEditing = false;
    _textConroller.clear();
  });
}


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:const Text("TODO List"),
        
        backgroundColor:const Color.fromARGB(255, 255, 176, 7),
        titleTextStyle: const TextStyle(color: Colors.white,
        fontSize: 23,
        fontWeight: FontWeight.w500,
        letterSpacing: 2),
        
      ),
      body: Column(
        
        children: [
               Row(
                children: [
                  Expanded(child: TextField(controller: _textConroller,)),
                 
                 (){
             if(isEditing){
              return IconButton(onPressed: ()=>_saveTodo(), icon: Icon(Icons.save));
             }
               return IconButton(onPressed: _addTask, icon: Icon(Icons.add));  }(),
                ],
                
                ),
               Expanded(child:  ListView.builder(itemCount: _tasks.length,
                itemBuilder: (context, index) =>  Row(children: [Expanded(child: ListTile(title:Text(_tasks[index]),)
                ),
                Expanded(child: IconButton(onPressed: ()=>_removeTask(index), icon: const Icon(Icons.delete))),
                Expanded(child: IconButton(onPressed: ()=>_editTask(index), icon: const Icon(Icons.edit)))
                ]),
                )
                )
        ],),
    );
  }
}