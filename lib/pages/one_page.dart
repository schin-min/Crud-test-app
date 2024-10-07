import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktop_clone/pages/home.dart';

class One extends ConsumerWidget {
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    int count = ref.watch(counterPovider);
    return Scaffold(
      appBar:  AppBar(
        title:  Text("Count is $count"),
      ),
    );
  }

  
}