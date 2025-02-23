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


        // synth commands
        // the format string is analogous to an OSC message format string,
        // and the 'msg' argument contains data.
        this.addCommand("voice", "i", {|msg|
            voxVoice = msg[1];
        });

        // message per buffer - basically fixed samples
        this.addCommand("zero", "i", {|msg|
	    voxPhrase = msg[1];
            Synth.new('vox.zero', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
        });
        this.addCommand("one", "i", {|msg|
	    voxPhrase = msg[1];
                Synth.new('vox.one', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
        });        
        this.addCommand("two", "i", {|msg|
	    voxPhrase = msg[1];
                Synth.new('vox.two', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
        });
        this.addCommand("three", "i", {|msg|
	    voxPhrase = msg[1];
                Synth.new('vox.three', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
        });
        this.addCommand("four", "i", {|msg|
	    voxPhrase = msg[1];
                Synth.new('vox.four', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
        });
        this.addCommand("five", "i", {|msg|
	    voxPhrase = msg[1];
                Synth.new('vox.five', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
        });
        this.addCommand("six", "i", {|msg|
	    voxPhrase = msg[1];
                Synth.new('vox.six', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
        });
        this.addCommand("seven", "i", {|msg|
	    voxPhrase = msg[1];
                Synth.new('vox.seven', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);          
        });
        this.addCommand("eight", "i", {|msg|
	    voxPhrase = msg[1];
                Synth.new('vox.eight', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
        });
        this.addCommand("nine", "i", {|msg|
	    voxPhrase = msg[1];
                Synth.new('vox.nine', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
        });
        this.addCommand("aay", "i", {|msg|
	    voxPhrase = msg[1];
                Synth.new('vox.aay', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
        });
        this.addCommand("bee", "i", {|msg|
	    voxPhrase = msg[1];
                Synth.new('vox.bee', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
        });
        this.addCommand("see", "i", {|msg|
	    voxPhrase = msg[1];
                Synth.new('vox.see', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
        });
        this.addCommand("dee", "i", {|msg|
	    voxPhrase = msg[1];
                Synth.new('vox.dee', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
        });
        this.addCommand("eee", "i", {|msg|
	    voxPhrase = msg[1];
                Synth.new('vox.eee', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
        });
        this.addCommand("eff", "i", {|msg|
	    voxPhrase = msg[1];
                Synth.new('vox.eff', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
        });
        
        this.addCommand("mode", "i", {|msg|
             voxMode = msg[1]-1;
        });

        this.addCommand("freq", "i", {|msg|
	          voxFreq = msg[1];
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

        this.addCommand("mute", "i", {|msg|
            voxAmp = msg[1];
        });
    }

    free {
	    synth.free
    }
}
