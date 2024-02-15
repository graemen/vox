SCMage : UGen {
    classvar <>scMagePath;

    *initClass {
        scMagePath = PathName.new("/home/we/vox/SCMage");
    }

    *ar { |bufnum, freqValue = 0.0, freqMode = -1, timeScale = 1.0, alpha = 0.55, voiceNum = 0|
        ^this.multiNew('audio', bufnum, freqValue, freqMode, timeScale, alpha, voiceNum);
    }

    *labelize { |text, action|
        var festivalPath, text2uttPath, dumpfeatsPath, text2labPath;
        var text2utt, dumpfeats, convertFeaturesToLabels, removeDurationsFromLabels;
        var prefix;
        var labelFileString;

        festivalPath = "/home/we/vox/SCMage/festival/programs/festival/";
        text2labPath = "/home/we/dust/code/vox/tools/text2lab/";
        
	text2uttPath = "/home/we/dust/code/vox/tools/text2utt";
        dumpfeatsPath = "/home/we/dust/code/vox/tools/dumpfeats";

        prefix = "/home/we/dust/data/vox/mage-" ++ 8.collect({ "0123456789abcdef".choose }).join("");
        File.use(prefix ++ ".txt", "w", { |textFile|
            textFile.write(text);
        });

        // Step 1: Convert the text into a Festival utterance file.
        text2utt = { |action|
            [
                text2uttPath,
                prefix ++ ".txt",
                ">", prefix ++ ".utt"
            ].join(" ").unixCmd(action, false);
        };

        // Step 2: Convert the utterance file into a text file of space-separated values.
        dumpfeats = { |action|
            [
                dumpfeatsPath,
                "-eval", text2labPath +/+ "extra_feats.scm",
                "-relation", "Segment",
                "-feats", text2labPath +/+ "label.feats",
                "-output", prefix ++ ".extracted_features.txt",
                prefix ++ ".utt"
            ].join(" ").unixCmd(action, false);
        };

        // Step 3: Convert the space-separated values into a label file with durations.
        convertFeaturesToLabels = { |action|
            [
                "gawk",
                "-f", text2labPath +/+ "label-full.awk",
                prefix ++ ".extracted_features.txt",
                ">",
                prefix ++ ".with_durations.lab"
            ].join(" ").unixCmd(action, false);
        };

        // Step 4: Remove the excess durations from the label files.
        removeDurationsFromLabels = { |action|
            [
                "gawk",
                "-F\" \"",
                "'{print $3}'",
                prefix ++ ".with_durations.lab",
                ">",
                prefix ++ ".lab"
            ].join(" ").unixCmd(action, false);
        };

        // sorry, SC doesn't have promises
        text2utt.({
            dumpfeats.({
                convertFeaturesToLabels.({
                    removeDurationsFromLabels.({
                        File.use(prefix ++ ".lab", "r", { |labelFile|
                            labelFileString = labelFile.readAllString;
                        });
                        action.value(labelFileString);
                    });
                });
            });
        });
    }

    *labelBuf { |text, action|
        this.labelize(text, { |labelString|
            var buf;
            buf = Buffer.loadCollection(Server.default, labelString.ascii);
            action.value(buf);
        });
    }
}
