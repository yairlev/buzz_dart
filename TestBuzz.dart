#import("dart:html");
#import("Buzz.dart");

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
  timeslider.disabled = true;
  
  ysound.whenReady(() {
    document.query("#endTime").text = Buzz.Instance.toTimer(ysound.getDuration(), false);
    timeslider.max = ysound.getDuration().toString();
    timeslider.disabled = false;
  });
  
  
  timeslider.on.change.add((Event e) {
    print('slaider change vlaue to: ${timeslider.value}');
    ysound.setTime(Math.parseDouble(timeslider.value));
  }, true);
  

  
  ysound.bind(const ["volumechange.slider"], (e) {slider.value = ysound.getVolume().toString();});
  ysound.bind(const ["timeupdate.slider"], (e) {
    labelTime.text = "${Buzz.Instance.toTimer(ysound.getTime(), false)} (${ysound.getPercent()}%)";
    timeslider.value = ysound.getTime().toString();
    });
  ysound.bind(const ["timeupdate.ranges"], (e) {
      document.query("#logArea").nodes.clear();
      TimeRanges ranges = ysound.getPlayed();
      int rangesCount = ranges.length;
      for (int idx = 0; idx < rangesCount; idx++) {
        document.query("#logArea").nodes.add(new Element.html("<li>$idx- ${ranges.start(idx)} - ${ranges.end(idx)}</li>"));
      }
      labelMsg.text = "${ysound.getPlayed().length}";
    });
  
  
  
  
  
  
  
  
  
  /*
   * Yoad's Tests for the Sund class
   */
   LabelElement labelMsg2 = document.query("#statusMsg2");
   LabelElement labelTime2 = document.query("#currTime2");
   
   Sound ysound2 = new Sound('sounds/a-party.ogg', new SoundOptions(
     const ['mp3', 'ogg', 'wav', 'aac', 'm4a'],
     'metadata', false, false, 80
   ));
   
   ButtonElement test1b2 = document.query("#playSong2");
   test1b2.on.click.add((Event e) { 
       ysound2.play();
     }
   );
   
   test1b2 = document.query("#pauseSong2");
   test1b2.on.click.add((Event e) { 
       ysound2.pause();
     }
   ); 
   
   test1b2 = document.query("#stopSong2");
   test1b2.on.click.add((Event e) { 
       ysound2.stop();
     }
   );
   
   test1b2 = document.query("#fadeOut2");
   test1b2.on.click.add((Event e) { 
       ysound2.fadeOut(2500, () {labelMsg2.text = "Fadeout Done";});
     }
   );
   
   test1b2 = document.query("#fadeIn2");
   test1b2.on.click.add((Event e) { 
       ysound2.fadeIn(2500, () {labelMsg2.text = "Fadein Done";});
     }
   );
   
   
   
   InputElement slider2 = document.query("#volumeSlider2");
   slider2.on.change.add((Event e) {
     ysound2.setVolume(Math.parseInt(slider2.value));
   }, true);
   
   
  
   InputElement timeslider2 = document.query("#timeSlider2");
   timeslider2.disabled = true;
   
   ysound2.whenReady(() {
     document.query("#endTime2").text = Buzz.Instance.toTimer(ysound2.getDuration(), false);
     timeslider2.max = ysound2.getDuration().toString();
     timeslider2.disabled = false;
   });
   
  
   timeslider2.on.change.add((Event e) {
     print('slaider change vlaue to: ${timeslider2.value}');
     ysound2.setTime(Math.parseDouble(timeslider2.value));
   }, true);
   

   
   ysound2.bind(const ["volumechange.slider"], (e) {slider2.value = ysound2.getVolume().toString();});
   ysound2.bind(const ["timeupdate.slider"], (e) {
     labelTime2.text = "${Buzz.Instance.toTimer(ysound2.getTime(), false)} (${ysound2.getPercent()}%)";
     timeslider2.value = ysound2.getTime().toString();
     });
   ysound2.bind(const ["timeupdate.ranges"], (e) {
       document.query("#logArea2").nodes.clear();
       TimeRanges ranges = ysound2.getPlayed();
       int rangesCount = ranges.length;
       for (int idx = 0; idx < rangesCount; idx++) {
         document.query("#logArea2").nodes.add(new Element.html("<li>$idx- ${ranges.start(idx)} - ${ranges.end(idx)}</li>"));
       }
       labelMsg2.text = "${ysound2.getPlayed().length}";
     });


}
