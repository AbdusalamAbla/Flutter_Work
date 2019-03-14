import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ComputeDemo{

//compute
 static  int loop(int val) {
    int count = 0;
    for (int i = 1; i <= val; i++) {
      count += i;
    }
    return count;
  }

  Future<void> _onPressed() async {
    int result = await compute(loop, 100);
    
  }



  
}
