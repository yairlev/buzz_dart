#import('dart:html');
#import('dart:core');
#source('Sound.dart');
#source('Buzz.dart');

void main() {
  
  /*
  * Tests for the Buzz class
  */

  print("IsSupported: " + Buzz.Instance.isSupported);
  print("isOGGSupported: " + Buzz.Instance.isOGGSupported);
  print("isWAVSupported: " + Buzz.Instance.isWAVSupported);
  print("isMP3Supported: " + Buzz.Instance.isMP3Supported);
  print("isAACSupported: " + Buzz.Instance.isAACSupported);
  
  print("toTime(3601,true): ${Buzz.Instance.toTimer(3601, true)}");
  print("toTime(61,false): ${Buzz.Instance.toTimer(61, false)}");
  print("toTime(31,false): ${Buzz.Instance.toTimer(31, false)}");
  print("toTime(0,false): ${Buzz.Instance.toTimer(0, false)}");
  
  print("fromTimer(01:00): ${Buzz.Instance.fromTimer("01:00")}");
  print("fromTimer(00:00): ${Buzz.Instance.fromTimer("00:00")}");
  print("fromTimer(01:01:00): ${Buzz.Instance.fromTimer("01:01:00")}");
  print("fromTimer(00:01:00): ${Buzz.Instance.fromTimer("00:01:00")}");
  print("fromTimer(59:59): ${Buzz.Instance.fromTimer("59:59")}");
  
  
  /*
   * Tests for the Sund class
   */
  
  var sound = new Sound(['sounds/ding.wav','sounds/truck.ogg']);
  sound.play();
}
