#import('dart:html');
#import('dart:core');
#source('Sound.dart');
#source('Buzz.dart');

void main() {
  
  var sounds = ['ding.wav', 'song.ogg', 'truck.ogg'];
  
  String base_selected;
  
  Sound soundLeft, soundRight;
  
  void toggle(String side) {
    switch(side) {
      case 'left':
        if (soundLeft != null) {
          soundLeft.togglePlay();
        }
        break;
      case 'right':
        if (soundRight != null) {
          soundRight.togglePlay();
        }
        break;
    }
  }
  
  sounds.forEach((s) {
    var element = new Element.html('<div class="sound_item">$s</div>');    
    element.on.click.add((e) {
      
      if (base_selected == 'left') {  
        soundLeft = new Sound(['sounds/${e.target.text}']);
        soundLeft.play();
      }
      else if (base_selected == 'right') {  
        soundRight = new Sound(['sounds/${e.target.text}']);
      } 
      
    });
    document.query("#sound_list").nodes.add(element);
  });
  
  document.query("#left_base").on.click.add((e) { base_selected = 'left'; } );
  document.query("#right_base").on.click.add((e) { base_selected = 'right'; } );
  
  document.query("#left_toggle").on.click.add((e) { toggle('left'); } );
  document.query("#right_toggle").on.click.add((e) { toggle('right'); } );
  
  
  
  
  
  
  
}