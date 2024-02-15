Engine_VoxExMachina : CroneEngine{

    var <synth;

    var voxBuf;
    var voxPhrases;
    var filePhrases;
    var voxPhrase = 0;
    var voxVoice = 0;
    var voxScale = 1.0;
    var voxAlpha = 0.55;

    var voxFreq = 100;
    var voxMode = -1;
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
	//var vox_path = "/home/we/dust/data/vox/phrases";
	//var phrases_file = File(vox_path, "r"); 
	//voxPhrases = phrases_file.readAllString.split("\n");
         
         voxPhrases = ["i am vox ex machina, this is my voice", "my mind is fading, I can feel it.", "all those moments, lost in time, like tears", "tears in rain", "let the waves, have their way now", "leave me alone", "a thousand islands in the sea", "there must be something like me", "vox vox vox, to the radio waves", "i am, voice of the machine"];
  
	//initialise the bufffers for mage
	voxPhrases.do ({ arg phrase, index; 
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
        SynthDef(\vox, {arg out, buf= 0, val = 0, mode = -1, scale = 1, alpha = 0.55, amp = 0.75, voice = 0;
            var mage;
            mage = (SCMage.ar(bufnum: buf, freqValue: val, freqMode: mode, timeScale: scale, alpha: alpha, voiceNum: voice) ! 2) * amp;
            Out.ar(out, mage);
        }, variants: (vem: [buf: 0], hal: [buf: 1], batty: [buf: 2], maria: [buf: 3], terminator: [buf: 4], lighthouse: [buf: 5], nord: [buf: 6], eur: [buf: 7], joy: [buf: 8], pw: [buf: 9]) ).add;


        {
            true.while({
			
                    //server sync
                    context.server.sync;
                    
		   //play phrase thru mage synth
		    vp = case
		    {voxPhrase == 1}{
                    	synth = Synth.new('vox.vem', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
		        wait(5 * voxScale);
                        synth.free
		    }
		    {voxPhrase == 2}{
                    	synth = Synth.new('vox.hal', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
		        wait(6 * voxScale);
                        synth.free
                    }
		    {voxPhrase == 3}{
                    	synth = Synth.new('vox.batty', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
		        wait(7 * voxScale);
                        synth.free
		    }
		    {voxPhrase == 4}{
                    	synth = Synth.new('vox.maria', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
		        wait(6 * voxScale);
                        synth.free
		    }
		    {voxPhrase == 5}{
                    	synth = Synth.new('vox.terminator', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
		        wait(3 * voxScale);
                        synth.free
		    }
		    {voxPhrase == 6}{
                    	synth = Synth.new('vox.lighthouse', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
		        wait(4 * voxScale);
                        synth.free
		    }
		    {voxPhrase == 7}{
                    	synth = Synth.new('vox.nord', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
		        wait(4 * voxScale);
                        synth.free
		    }
		    {voxPhrase == 8}{
                    	synth = Synth.new('vox.eur', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
		        wait(4 * voxScale);
                        synth.free
		    }
		    {voxPhrase == 9}{
                    	synth = Synth.new('vox.joy', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
		        wait(4 * voxScale);
                        synth.free
		    }
		    {voxPhrase == 10}{
                    	synth = Synth.new('vox.pw', [out: context.out_b.index, bufnum:voxPhrase, val:voxFreq, mode:voxMode, scale:voxScale, alpha:voxAlpha, amp:voxAmp, voice:voxVoice], context.xg);
		        wait(4 * voxScale);
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

    }

    free {
        voxMode = 1;
	synth.free
    }
}
