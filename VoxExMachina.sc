VoxExMachina {

    //var <synth;
    var <params;
    var voxBuf;
    var voxPhrases;
    //var filePhrases;
    var vm;
    var vp;
    
    *initClass {
        StartUp.add {
            
            var s = Server.default;
			
            // we need to make sure the server is running before asking it to do anything
			s.waitForBoot {
            
                this.create_buffers();    

                //mage synth definition
                SynthDef(\vox, {arg out, phrase = 0, pitch = 0, mode = -1, time = 1, shape = 0.55, amp = 0.75, voice = 0;
                                var mage;
                                mage = (SCMage.ar(bufnum: phrase, freqValue: pitch, freqMode: mode, timeScale: time, alpha: shape, voiceNum: voice) ! 2) * amp;
                                Out.ar(out, mage);}, 
                                variants: (vem: [buf: 0], hal: [buf: 1], batty: [buf: 2], maria: [buf: 3], terminator: [buf: 4], lighthouse: [buf: 5], nord: [buf: 6], eur: [buf: 7], joy: [buf: 8], pw: [buf: 9])
                        ).add;
            } //wait for server
        } //startup
    } //init class

    *new { arg context, doneCallback;
        ^super.new(context, doneCallback);
    }

    init {
        params = Dictionary.newFrom([
            \phrase, 0,
            \pitch, 200,
            \mode, -1,
            \time, 1.0,
            \shape, 0.55,
            \voice, 0,
            \gap, 5 
        ]);
    }

    // these methods will populate in SuperCollider when we instantiate the class
	//   'trigger' to play a note with the current 'params' settings:
	trigger { arg delay;
		
		// '++ params.getPairs' iterates through all the 'params' above,
		//   and sends them as [key, value] pairs
        vp = case
        {phrase == 1}{synth = Synth.new('vox.vem', [out: context.out_b.index] ++ params.getPairs, context.xg);}
        {phrase == 2}{synth = Synth.new('vox.hal', [out: context.out_b.index] ++ params.getPairs, context.xg);}
        {phrase == 3}{synth = Synth.new('vox.batty', [out: context.out_b.index] ++ params.getPairs, context.xg);}
        {phrase == 4}{synth = Synth.new('vox.maria', [out: context.out_b.index] ++ params.getPairs, context.xg);}
        {phrase == 5}{synth = Synth.new('vox.terminator', [out: context.out_b.index] ++ params.getPairs, context.xg);}
        {phrase == 6}{synth = Synth.new('vox.lighthouse', [out: context.out_b.index] ++ params.getPairs, context.xg);}
        {phrase == 7}{synth = Synth.new('vox.nord', [out: context.out_b.index] ++ params.getPairs, context.xg);}
        {phrase == 8}{synth = Synth.new('vox.eur', [out: context.out_b.index] ++ params.getPairs, context.xg);}
        {phrase == 9}{synth = Synth.new('vox.joy', [out: context.out_b.index] ++ params.getPairs, context.xg);}
        {phrase == 10}{synth = Synth.new('vox.pw', [out: context.out_b.index] ++ params.getPairs, context.xg);}
        wait(delay);
        synth.free;
	}

	//   'setParam' to set one of our 'params' to a new value:
	setParam { arg paramKey, paramValue;
		params[paramKey] = paramValue;
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
    
}

