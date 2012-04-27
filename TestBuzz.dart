#import('dart:html');
#source('Sound.dart');
#source('Buzz.dart');

void main() {
  
  /*
  * Tests for the Buzz class
  */
  //print("IsSupported: " + Buzz.isSupported);
  
  
  /*
   * Tests for the Sund class
   */
  
  var sound = new Sound(['sounds/ding.wav','sounds/truck.ogg']);
  sound.play();
}
