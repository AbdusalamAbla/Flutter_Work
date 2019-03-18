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

  Future<void> onPressed() async {
     await compute(loop, 100);
    
  }



  
}
