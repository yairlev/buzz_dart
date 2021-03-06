/**
* Represents a single audio source.
*/
class Sound {
  
  SoundOptions options;
  AudioElement sound;
  bool supported;
  num volume;
  num currentTime;
  List<SoundEvent> events;
  num eventOncePid = 0;
   
  /**
  * Creates a new [Sound] object.
  * The [sources] property is a [List] of [String] values which contain the locations of all
  * the available file types of an audio file.
  */
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
  
  /// Load the media of this sound
  Sound load() {
      if (! supported) {
        return this;
      }
      
      sound.load();
      return this;
  }
  
  
  /// Start playing this sound from it's last position
  Sound play() { 
    if (! supported) {
      return this;
    }
    
    this.sound.play();
  }
  
  /// Start or pause the play of the sound
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
  
  /// Pause the play of the sound if not paused
  Sound pause() {
    if ( !supported ) {
      return this;
    }

    this.sound.pause();
    return this;
  }
  
  /// Return whether the sound is paused
  bool isPaused() {
    if ( !supported ) {
      return null;
    }

    return this.sound.paused;
  }
  
  /// Stop playing the sound and reset the current position
  Sound stop() {
    if ( !supported  ) {
      return this;
    }

    this.setTime( this.getDuration() );
    this.sound.pause();
    return this; 
  }
  
  /// Return whether the sound has ended - finished playing.
  bool isEnded() {
    if ( !supported ) {
      return null;
    }

    return this.sound.ended;
  }
  
  /// Enables replay when the sound play has ended
  Sound loop() {
    if ( !supported ) {
      return this;
    }

    this.sound.attributes['loop'] = 'loop';
    bind( const ['ended.buzzloop'], (e) {
        this.currentTime = 0;
        this.play();
    });
    
    return this;
  }
  
  /// Disables replay when the sound play has ended  
  Sound unloop() {
    if ( !supported ) {
      return this;
    }

    this.sound.attributes.remove( 'loop' );
    this.unbind( const ['ended.buzzloop'] );
    return this;
  }
  
  /// Must the the sound
  Sound mute() {
    if ( !supported ) {
      return this;
    }

    this.sound.muted = true;
    return this;
  }
  
  /// Unmute the sound if muted
  Sound unmute() {
    if ( !supported ) {
      return this;
    }

    this.sound.muted = false;
    return this;
  }
  
  /// Toggle if the mute is active or not
  Sound toggleMute() {
    if ( !supported ) {
      return this;
    }

    this.sound.muted = !this.sound.muted;
    return this;
  }
  
  /// Returns whether the must is active
  bool isMuted() {
    if ( !supported ) {
      return null;
    }

    return this.sound.muted;
  }
  
  /// Sets the volume - values can be (0-100)
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
  
  /// Increases the volume by 1
  Sound increaseVolume([num value = 1]) {
    return this.setVolume( this.volume + (value) );
  }
  
  /// Decreases the volume by 1
  Sound decreaseVolume([num value = 1]) {
    return this.setVolume( this.volume - (value) );
  }
  
  Sound setTime(double time) {
    if ( !supported ) {
      return this;
    }

    this.sound.currentTime = time;
    this.whenReady( () {
        this.sound.currentTime = time;
    });
    return this;
  }
  
  double getTime() {
    if ( !supported ) {
      return null;
    }

    double time = ( this.sound.currentTime * 100 ).round() / 100;
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
  
  double getDuration() {
    if ( !supported ) {
      return null;
    }

    double duration = ( this.sound.duration * 100 ).round() / 100;
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
  
  Sound bind(List<String> types, EventListener callback) {
    if ( !supported ) {
      return this;
    }

    types.forEach((t) {
      String idx = t;
      String type = idx.split( '.' )[ 0 ];
      events.add(new SoundEvent(idx, type, callback));
      sound.on[type].add(callback);      
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
        if ( events[i].idx == idx ) {
            sound.on[type].remove(events[i].callback);
            // remove event
            events.removeRange(i, 1);
        }
      }      
    });
    
    return this;
  }
  
  Sound bindOnce(List<String> types, EventListener callback) {
    if ( !supported ) {
      return this;
    }    
    
    types.forEach((t) {
      var funcWrapper = (e) { callback(e); unbind( [t] ); };
      bind([t], funcWrapper);
    });    
    
  }
  
  Sound trigger(List<String> types) {
    
  }
  
  Sound fadeTo(num to, num duration, Function callback) {
    if ( !supported ) {
      return this;
    }

    if ( duration == null ) {
        duration = Buzz.defaults["duration"];
    }

    num from = this.volume;
    int delay = (duration / ( from - to ).abs()).toInt();
    Sound that = this;

    this.play();

    Function doFade() {
        window.setTimeout(
          () {
            if ( from < to && that.volume < to ) {
                that.increaseVolume();
                doFade();
            } else if ( from > to && that.volume > to ) {
                that.decreaseVolume();
                doFade();
            } else if ( callback != null ) {
                callback();
            }
        }, delay );
    }
    
    this.whenReady( () => doFade() );

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
        this.bind( const ['canplay.buzzwhenready'], (e) => func());
    } else {
        func();
    }
  }
  
  //Privates
  
  String _getExt( String filename ) {
    return filename.split('.').last();
  }
  
  _addSource( soundElem, src ) {
    var srcElement = new Element.tag('source');
    srcElement.attributes['src'] = src;
    
    var soundType = Buzz.types[ _getExt( src ) ];
    
    if ( soundType != null && !soundType.isEmpty()) {
      srcElement.attributes['type'] = soundType;
    }
    soundElem.nodes.add( srcElement );  
  }
}


/// This class defines the options to create a sound with
/// * formats can be (OGG MP3 WAV AAC)
class SoundOptions {
  
   final List<String> formats;
   final String preload;
   final bool autoplay;
   final bool loop;
   final num volume;
   
   const SoundOptions([this.formats = const ['mp3', 'ogg', 'wav', 'aac', 'm4a'], 
       this.preload='metadata', this.autoplay=false, this.loop=false, this.volume = 80]);       
   
}

/// Internal class that keeps track of event bindings
class SoundEvent {
  String idx;
  String type;
  EventListener callback;
  
  SoundEvent(this.idx, this.type, this.callback);
  
}



