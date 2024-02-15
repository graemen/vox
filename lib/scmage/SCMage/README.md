## SCMage - EARLY STAGE OF DEVELOPMENT - USE AT YOUR OWN RISK! ##

A SuperCollider plugin wrapping the MAGE/pHTS speech synthesizer. It is Linux only.

### Building and installing ###

    $ mkdir build && cd build
    $ cmake -DSC_PATH=/path/to/supercollider/ -DMAGE_PATH=/path/to/mage/ ..
    $ make

Here, `/path/to/supercollider/` is the location of a copy of the SuperCollider *source code*. It must match the version of SuperCollider you have running. If set correctly, there should be a file in that directory at `include/plugin_interface/SC_PlugIn.h`.

`/path/to/mage/`, similarly, is a copy of the MAGE source. MAGE should be built first, and there should be a `libmage.so` in `builds/Release/`.

After building, install the SCMage directory as you would a quark. I prefer to add a symbolic link in my extensions directory, but you can also use `Quarks.gui` and click on "Install a folder."

### Festival ###

SCMage requires a frontend to be able to synthesize text. The provided frontend uses Festival TTS. It's optional, but creating alternative frontends could take a lot of work.

You can get Festival via Linux repositories, but I haven't figured out how to get the `text2utts` and `dumpfeats` scripts working correctly out of such installations. Unfortunately, you will have to download and build Festival yourself. If you figure out a way around this, I'm all ears.

I've provided a script called `download-and-build-festival.sh` that does this for you (forked from the script Festival uses for testing). Run it with the root of this repository as your working directory. The total download size is 15 MB, a lot of which is excess because Festival is not very good at modularity. I can assure you that it doesn't require root access and won't interfere with any installed versions of Festival.

The script is not very smart, so if it has problems like a failed download, you may have to fix them manually. It's very simple though, so troubleshooting should be straightforward.

