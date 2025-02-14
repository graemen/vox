Engine_VoxExMachina : CroneEngine{

    var <synth;

    var voxBuf;
    var voxPhrases;
    var filePhrases;
    var voxPhrase = 0;
    var voxVoice = 0;
    var voxScale = 1.0;
    var voxAlpha = 0.55;
    var voxGap = 2.0;
    var voxFreq = 200;
    var voxMode = 1;
    var voxAmp = 1.0;

    var vm;
    var vp;

    var <isRunning = true;

    // this is your constructor. the 'context' arg is a CroneAudioContext.
    // it provides input and output busses and groups.
    // see its implementation for details.
    *new { arg context, doneCallback;
        ^super.new(context, doneCallback);
    }


    synth_label { arg phrase, index; 
        SCMage.labelBuf(phrase, { |buf|
            voxBuf[index] = buf;
	        voxBuf[index].postln;
        });
    }

    create_buffers {
	
        voxPhrases = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "aay", "bee", "see", "dee", "eee", "eff"];
  
        //initialise the bufffers for mage
        voxPhrases.do ({ arg phrase, index; 
                // Send progress update before buffer creation
                // oscClient.sendMsg("/buffer_progress", index, voxPhrases.size);
                "creating buffer for: ".postln;
                phrase.postln;
                SCMage.labelBuf(phrase, { |buf|
                    voxBuf = buf;
                });
                //labelling is asynchronous so we need to wait for the new buffer
                
                wait(5);
        });
    }

    // this is called when the engine is actually loaded by a script.
    // you can assume it will be called in a Routine,
    // and you can use .sync and .wait methods.
    alloc {
	
	    this.create_buffers();    

        //mage synth definition
        SynthDef(\vox, {arg out, buf = 0, val = 0, mode = -1, scale = 1, alpha = 0.55, amp = 0.75, voice = 0;
            var mage;
            mage = (SCMage.ar(bufnum: buf, freqValue: val, freqMode: mode, timeScale: scale, alpha: alpha, voiceNum: voice) ! 2) * amp;
            Out.ar(out, mage);
        }, variants: ( zero: [buf: 0], one: [buf: 1], two: [buf: 2], three: [buf: 3], four: [buf: 4], five: [buf: 5], six: [buf: 6], seven: [buf: 7], eight: [buf: 8], nine: [buf: 9], aay: [buf: 10], bee: [buf: 11], see: [buf: 12], dee: [buf: 13], eee: [buf: 14], eff: [buf: 15] )).add;


        {
            true.while({
			            
                 //server sync
                context.server.sync;
                  
                  //play phrase thru mage synth
                  vp = case
                  {voxPhrase == 0}{
                              synth = Synth.new('vox.zero', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
                      wait(voxGap * voxScale);
                              synth.free
                  }
                  {voxPhrase == 1}{
                              synth = Synth.new('vox.one', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
                      wait(voxGap * voxScale);
                              synth.free
                  }
                  {voxPhrase == 2}{
                              synth = Synth.new('vox.two', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
                      wait(voxGap * voxScale);
                              synth.free
                          }
                  {voxPhrase == 3}{
                              synth = Synth.new('vox.three', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
                      wait(voxGap * voxScale);
                              synth.free
                  }
                  {voxPhrase == 4}{
                              synth = Synth.new('vox.four', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
                      wait(voxGap * voxScale);
                              synth.free
                  }
                  {voxPhrase == 5}{
                              synth = Synth.new('vox.five', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
                      wait(voxGap * voxScale);
                              synth.free
                  }
                  {voxPhrase == 6}{
                              synth = Synth.new('vox.six', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
                      wait(voxGap * voxScale);
                              synth.free
                  }
                  {voxPhrase == 7}{
                              synth = Synth.new('vox.seven', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
                      wait(voxGap * voxScale);
                              synth.free
                  }
                  {voxPhrase == 8}{
                              synth = Synth.new('vox.eight', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
                      wait(voxGap * voxScale);
                              synth.free
                  }
                  {voxPhrase == 9}{
                              synth = Synth.new('vox.nine', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
                      wait(voxGap * voxScale);
                              synth.free
                  }
                  {voxPhrase == 10}{
                              synth = Synth.new('vox.aay', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
                      wait(voxGap * voxScale);
                              synth.free
                  }
                  {voxPhrase == 11}{
                              synth = Synth.new('vox.bee', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
                      wait(voxGap * voxScale);
                              synth.free
                  }
                  {voxPhrase == 12}{
                              synth = Synth.new('vox.see', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
                      wait(voxGap * voxScale);
                              synth.free
                  }
                  {voxPhrase == 13}{
                              synth = Synth.new('vox.dee', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
                      wait(voxGap * voxScale);
                              synth.free
                  }
                  {voxPhrase == 14}{
                              synth = Synth.new('vox.eee', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
                      wait(voxGap * voxScale);
                              synth.free
                  }
                  {voxPhrase == 15}{
                              synth = Synth.new('vox.eff', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
                      wait(voxGap * voxScale);
                              synth.free
                  }
             
            });
        }.fork;

        // synth commands
        // the format string is analogous to an OSC message format string,
        // and the 'msg' argument contains data.
        this.addCommand("mode", "i", {|msg|
             voxMode = msg[1]-1;
        });

        this.addCommand("freq", "i", {|msg|
	          voxFreq = msg[1];
        });

        this.addCommand("phrase", "i", {|msg|
	          voxPhrase = msg[1];
        });

        this.addCommand("voice", "i", {|msg|
            voxVoice = msg[1];
        });

        this.addCommand("scale", "f", {|msg|
            voxScale = msg[1];
        });

        this.addCommand("alpha", "f", {|msg|
            voxAlpha = msg[1];
        });

        this.addCommand("gap", "f", {|msg|
            voxGap = msg[1];
        });

        this.addCommand("toggle", "", {
            isRunning = isRunning.not;
        });
    }

    free {
	    synth.free
    }
}
