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
  
  print("toTimer(3601,true): ${Buzz.Instance.toTimer(3601, true)}");
  print("toTimer(61,false): ${Buzz.Instance.toTimer(61, false)}");
  print("toTimer(31,false): ${Buzz.Instance.toTimer(31, false)}");
  print("toTimer(0,false): ${Buzz.Instance.toTimer(0, false)}");
  
  print("fromTimer(01:00): ${Buzz.Instance.fromTimer("01:00")}");
  print("fromTimer(00:00): ${Buzz.Instance.fromTimer("00:00")}");
  print("fromTimer(01:01:00): ${Buzz.Instance.fromTimer("01:01:00")}");
  print("fromTimer(00:01:00): ${Buzz.Instance.fromTimer("00:01:00")}");
  print("fromTimer(59:59): ${Buzz.Instance.fromTimer("59:59")}");
  
  print("toPercent(20, 40, 2): ${Buzz.Instance.toPercent(20, 40, 2)}");
  print("toPercent(3, 7, 0): ${Buzz.Instance.toPercent(3, 7, 0)}");
  print("toPercent(3, 7, 1): ${Buzz.Instance.toPercent(3, 7, 1)}");
  print("toPercent(3, 7, 5): ${Buzz.Instance.toPercent(3, 7, 5)}");
  print("toPercent(10, 10, 2): ${Buzz.Instance.toPercent(10, 10, 2)}");
  print("toPercent(0, 10, 2): ${Buzz.Instance.toPercent(0, 10, 2)}");
  
  print("fromPercent(20, 100, 2): ${Buzz.Instance.fromPercent(20, 100, 2)}");
  print("fromPercent(100, 20, 2): ${Buzz.Instance.fromPercent(100, 20, 2)}");
  print("fromPercent(50, 21, 4): ${Buzz.Instance.fromPercent(50, 21, 4)}");
  print("fromPercent(0, 10, 2): ${Buzz.Instance.fromPercent(0, 10, 2)}");
  print("fromPercent(0, 0, 2): ${Buzz.Instance.fromPercent(0, 0, 2)}");
  print("fromPercent(100, 0, 2): ${Buzz.Instance.fromPercent(100, 0, 2)}");
 
  /*
   * Yair's Tests for the Sund class
   */
  
  var yair_sound = new Sound(['sounds/ding.wav','sounds/truck.ogg']);
  yair_sound.bind(['ended'], (e) => window.alert('') );
  //sound.play();
  
  ButtonElement yair_b = document.query("#yair_play");
  yair_b.on.click.add((Event e) { 
    yair_sound.play();
    }
  );  
  
  
  
  /*
  * Yoad's Tests for the Sund class
  */
  LabelElement labelMsg = document.query("#statusMsg");
  LabelElement labelTime = document.query("#currTime");
  
  Sound ysound = new Sound('sounds/song.ogg', new SoundOptions(
    const ['mp3', 'ogg', 'wav', 'aac', 'm4a'],
    'metadata', false, false, 80
  ));
  
  ButtonElement test1b = document.query("#playSong");
  test1b.on.click.add((Event e) { 
      ysound.play();
    }
  );
  
  test1b = document.query("#pauseSong");
  test1b.on.click.add((Event e) { 
      ysound.pause();
    }
  ); 
  
  test1b = document.query("#stopSong");
  test1b.on.click.add((Event e) { 
      ysound.stop();
    }
  );
  
  test1b = document.query("#fadeOut");
  test1b.on.click.add((Event e) { 
      ysound.fadeOut(2500, () {labelMsg.text = "Fadeout Done";});
    }
  );
  
  test1b = document.query("#fadeIn");
  test1b.on.click.add((Event e) { 
      ysound.fadeIn(2500, () {labelMsg.text = "Fadein Done";});
    }
  );
  
  
  InputElement slider = document.query("#volumeSlider");
  slider.on.change.add((Event e) {
    ysound.setVolume(Math.parseInt(slider.value));
  }, true);
  
  
  
  InputElement timeslider = document.query("#timeSlider");
  
  ysound.whenReady(() {
    document.query("#endTime").text = Buzz.Instance.toTimer(ysound.getDuration(), false);  
  });
  
  timeslider.max = ysound.getDuration().toString();
  timeslider.on.change.add((Event e) {
    ysound.setTime(Math.parseDouble(timeslider.value));
  }, true);
  
  window.setInterval(() {
      labelTime.text = "${Buzz.Instance.toTimer(ysound.getTime(), false)} (${ysound.getPercent()}%)";
      slider.value = ysound.getVolume().toString();
    }
    , 500);
}
