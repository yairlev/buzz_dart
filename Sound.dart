//#source('Buzz.dart');

class Sound {
  
  SoundOptions options;
  AudioElement sound;
  bool supported;
  num volume;
  num currentTime;
  List<SoundEvent> events;
   
  Sound (var sources, [SoundOptions options = const SoundOptions()]): events = new List<SoundEvent>()
  {
    
    List<String> sourceList;
    
    sound = new Element.tag('audio');
    supported = Buzz.Instance.isSupported;        

    if (sources is String) {
      sourceList = new List<String>();
      sourceList.add(sources);
    }
    else {
      sourceList = sources;
    }
    
    sourceList.forEach((s){
      
      _addSource(sound, s);
      
      if (options.loop) {
        sound.attributes['loop'] = 'loop';
      }
      
      if (options.autoplay) {
        sound.attributes['autoplay'] = 'autoplay';
      }
      
      if (options.preload == 'true') {
        sound.attributes['preload'] = 'auto';
      }
      else if ( options.preload == 'false' ) {
        sound.attributes['preload'] = 'none';
      } 
      else {
        sound.attributes['preload'] = options.preload;
      }       
      
      document.body.nodes.add(sound);
      
      this.setVolume( options.volume );
      
      Buzz.sounds.add(this);
      
    });    
    
  }
  
  Sound load() {
      if (! supported) {
        return this;
      }
      
      sound.load();
      return this;
  }
  
  Sound play() { 
    if (! supported) {
      return this;
    }
    
    this.sound.play();
  }
  
  Sound togglePlay() {
    if ( !supported ) {
      return this;
    }

    if ( this.sound.paused ) {
        this.sound.play();
    } else {
        this.sound.pause();
    }
    return this;
  }
  
  Sound pause() {
    if ( !supported ) {
      return this;
    }

    this.sound.pause();
    return this;
  }
  
  bool isPaused() {
    if ( !supported ) {
      return null;
    }

    return this.sound.paused;
  }
  
  Sound stop() {
    if ( !supported  ) {
      return this;
    }

    //this.setTime( this.getDuration() );
    this.sound.pause();
    this.setTime( 0 );
    return this; 
  }
  
  bool isEnded() {
    if ( !supported ) {
      return null;
    }

    return this.sound.ended;
  }
  
  Sound loop() {
    if ( !supported ) {
      return this;
    }

    this.sound.attributes['loop'] = 'loop';
    this.bind( const ['ended.buzzloop'], function() {
        this.currentTime = 0;
        this.play();
    });
    return this;
  }
  
  Sound unloop() {
    if ( !supported ) {
      return this;
    }

    this.sound.attributes.remove( 'loop' );
    this.unbind( const ['ended.buzzloop'] );
    return this;
  }
  
  Sound mute() {
    if ( !supported ) {
      return this;
    }

    this.sound.muted = true;
    return this;
  }
  
  Sound unmute() {
    if ( !supported ) {
      return this;
    }

    this.sound.muted = false;
    return this;
  }
  
  Sound toggleMute() {
    if ( !supported ) {
      return this;
    }

    this.sound.muted = !this.sound.muted;
    return this;
  }
  
  bool isMuted() {
    if ( !supported ) {
      return null;
    }

    return this.sound.muted;
  }
  
  Sound setVolume(num newVolume) {
    if ( !supported ) {
      return this;
    }

    if ( newVolume < 0 ) {
      newVolume = 0;
    }
    if ( newVolume > 100 ) {
      newVolume = 100;
    }
  
    this.volume = newVolume;
    this.sound.volume = newVolume / 100;
    return this;
  }
  
  num getVolume() {
    if ( !supported ) {
      return 0;
    }

    return this.volume;
  }
  
  Sound increaseVolume([num value = 1]) {
    return this.setVolume( this.volume + (value) );
  }
  
  Sound decreaseVolume([num value = 1]) {
    return this.setVolume( this.volume - (value) );
  }
  
  Sound setTime(num time) {
    if ( !supported ) {
      return this;
    }

    this.sound.currentTime = time;
    this.whenReady( () {
        this.sound.currentTime = time;
        print('kaka $time  ${this.sound.currentTime}');
    });
    return this;
  }
  
  num getTime() {
    if ( !supported ) {
      return null;
    }

    num time = ( this.sound.currentTime * 100 ).round() / 100;
    return ( time ).isNaN() ? Buzz.defaults['placeholder'] : time;
  }
  
  Sound setPercent(num percent) {
    if ( !supported ) {
      return this;
    }

    return this.setTime( Buzz.Instance.fromPercent( percent, this.sound.duration ) );
  }
  
  num getPercent() {
    if ( !supported ) {
      return null;
    }

    num percent = ( Buzz.Instance.toPercent( this.sound.currentTime, this.sound.duration ) ).round();
    return ( percent ).isNaN() ? Buzz.defaults['placeholder'] : percent;
  }
  
  Sound setSpeed(num duration) {
    if ( !supported ) {
      return this;
    }

    this.sound.playbackRate = duration;
  }
  
  num getSpeed() {
    if ( !supported ) {
      return null;
    }

    return this.sound.playbackRate;
  }
  
  num getDuration() {
    if ( !supported ) {
      return null;
    }

    num duration = ( this.sound.duration * 100 ).round() / 100;
    return ( duration ).isNaN() ? Buzz.defaults['placeholder'] : duration;
    
  }
  
  
  TimeRanges getPlayed() {
    if ( !supported ) {
      return null;
    }

    return this.sound.played;
  }
  
  TimeRanges getBuffered() {
    if ( !supported ) {
      return null;
    }

    return this.sound.buffered;
  }
  
  TimeRanges getSeekable() {
    if ( !supported ) {
      return null;
    }

    return this.sound.seekable;
  }
  
  num getErrorCode() {
    if ( supported && this.sound.error != null ) {
      return this.sound.error.code;
    }
    return 0;
  }
  
  String getErrorMessage() {
    if ( !supported ) {
      return null;
    }

    switch( this.getErrorCode() ) {
        case 1:
            return 'MEDIA_ERR_ABORTED';
        case 2:
            return 'MEDIA_ERR_NETWORK';
        case 3:
            return 'MEDIA_ERR_DECODE';
        case 4:
            return 'MEDIA_ERR_SRC_NOT_SUPPORTED';
        default:
            return null;
    }
  }
  
  getStateCode() {
    if ( !supported ) {
      return null;
    }

    return this.sound.readyState;
  }
  
  String getStateMessage() {
    if ( !supported ) {
      return null;
    }

    switch( this.getStateCode() ) {
        case 0:
            return 'HAVE_NOTHING';
        case 1:
            return 'HAVE_METADATA';
        case 2:
            return 'HAVE_CURRENT_DATA';
        case 3:
            return 'HAVE_FUTURE_DATA';
        case 4:
            return 'HAVE_ENOUGH_DATA';
        default:
            return null;
    }
  }
  
  getNetworkStateCode() {
    if ( !supported ) {
      return null;
    }

    return this.sound.networkState;
  }
  
  String getNetworkStateMessage() {
    if ( !supported ) {
      return null;
    }

    switch( this.getNetworkStateCode() ) {
        case 0:
            return 'NETWORK_EMPTY';
        case 1:
            return 'NETWORK_IDLE';
        case 2:
            return 'NETWORK_LOADING';
        case 3:
            return 'NETWORK_NO_SOURCE';
        default:
            return null;
    }
  }
  
  Sound setElementAttr(String key, var value) {
    if ( !supported ) {
      return this;
    }

    this.sound.attributes[ key ] = value;
    return this;
  }
  
  getElementAttr(String key) {
    if ( !supported ) {
      return null;
    }

    return !key.isEmpty() && key != null ? this.sound.attributes[ key ] : this.sound;
  }
  
  Sound bind(List<String> types, Function func) {
    if ( !supported ) {
      return this;
    }

    types.forEach((t) {
      String idx = t;
      String type = idx.split( '.' )[ 0 ];
      events.add(new SoundEvent(idx, type, func));
      sound.on[type].add(func);      
    });    
    
    return this;
  }
  
  Sound unbind(List<String> types) {
    if ( !supported ) {
      return this;
    }
    
    types.forEach((t) {
      String idx = t;
      String type = idx.split( '.' )[ 0 ];
    
      for(int i=0; i<events.length; i++) {
        var namespace = events[i].idx.split( '.' );
        if ( events[i].idx == idx || ( namespace[ 1 ] == idx.replaceAll( '.', '' ) ) ) {
            sound.on[type].remove(events[i].func);
            // remove event
            events.removeRange(i, 1);
        }
      }      
    });
    
    return this;
  }
  
  Sound bindOnce(List<String> types) {
    
  }
  
  Sound trigger(List<String> types) {
    
  }
  
  Sound fadeTo(num to, num duration, Function callback) {
    if ( !supported ) {
      return this;
    }

    //TODO: support for null duration parameter
    /*
    if ( duration instanceof Function ) {
        callback = duration;
        duration = buzz.defaults.duration;
    } else {
        duration = duration || buzz.defaults.duration;
    }
    */

    var from = this.volume,
    delay = duration / ( from - to ).abs(),
        that = this;
    this.play();

    Function doFade() {
        window.setTimeout(
          () {
            if ( from < to && that.volume < to ) {
                that.setVolume( that.volume += 1 );
                doFade();
            } else if ( from > to && that.volume > to ) {
                that.setVolume( that.volume -= 1 );
                doFade();
            } else if ( callback != null ) {
                //callback.apply( that );
            }
        }, delay );
    }
    this.whenReady( () {
        doFade();
    });

    return this;
  }
  
  Sound fadeIn(num duration, Function callback) {
    if ( !supported ) {
      return this;
    }

    return this.setVolume(0).fadeTo( 100, duration, callback );
  }
  
  Sound fadeOut(num duration, Function callback) {
    if ( !supported ) {
      return this;
    }

    return this.fadeTo( 0, duration, callback );
  }
  
  void whenReady(Function func) {
    if ( !supported ) {
      return null;
    }

    var that = this;
    if (this.sound.readyState != null && this.sound.readyState == 0 ) {
        this.bind( const ['canplay.buzzwhenready'], func);
    } else {
        func();
    }
  }
  
  //Privates
  
  String _getExt( String filename ) {
    return filename.split('.').last();
  }
  
  _addSource( sound, src ) {
    var srcElement = new Element.tag('source');
    srcElement.attributes['src'] = src;
    
    var soundType = Buzz.types[ _getExt( src ) ];
    
    if ( soundType != null && !soundType.isEmpty()) {
      srcElement.attributes['type'] = soundType;
    }
    sound.nodes.add( srcElement );  
  }
}


class SoundOptions {
  
   final List<String> formats;
   final String preload;
   final bool autoplay;
   final bool loop;
   final num volume;
   
   const SoundOptions([this.formats = const ['mp3', 'ogg', 'wav', 'aac', 'm4a'], 
       this.preload='metadata', this.autoplay=false, this.loop=false, this.volume = 80]);       
   
}

class SoundEvent {
  String idx;
  String type;
  Function func;
  
  SoundEvent(this.idx, this.type, this.func);
  
}



