#!/bin/sh
###########################################################################
##                                                                       ##
##                     Carnegie Mellon University                        ##
##                         Copyright (c) 2014                            ##
##                        All Rights Reserved.                           ##
##                                                                       ##
##  Permission is hereby granted, free of charge, to use and distribute  ##
##  this software and its documentation without restriction, including   ##
##  without limitation the rights to use, copy, modify, merge, publish,  ##
##  distribute, sublicense, and/or sell copies of this work, and to      ##
##  permit persons to whom this work is furnished to do so, subject to   ##
##  the following conditions:                                            ##
##   1. The code must retain the above copyright notice, this list of    ##
##      conditions and the following disclaimer.                         ##
##   2. Any modifications must be clearly marked as such.                ##
##   3. Original authors' names are not deleted.                         ##
##   4. The authors' names are not used to endorse or promote products   ##
##      derived from this software without specific prior written        ##
##      permission.                                                      ##
##                                                                       ##
##  CARNEGIE MELLON UNIVERSITY AND THE CONTRIBUTORS TO THIS WORK         ##
##  DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING      ##
##  ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT   ##
##  SHALL CARNEGIE MELLON UNIVERSITY NOR THE CONTRIBUTORS BE LIABLE      ##
##  FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES    ##
##  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN   ##
##  AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,          ##
##  ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF       ##
##  THIS SOFTWARE.                                                       ##
##                                                                       ##
###########################################################################
##                                                                       ##
##  A bare-minimum installation script for Festival.                     ##
##                                                                       ##
##  Forked from the Festival build script.                               ##
##                                                                       ##
###########################################################################

mkdir -p festival
cd festival

if [ ! -d packed ]
then

    mkdir packed
    cd packed
    wget http://festvox.org/packed/festival/2.4/festival-2.4-release.tar.gz
    wget http://festvox.org/packed/festival/2.4/speech_tools-2.4-release.tar.gz
    wget http://festvox.org/packed/festival/2.4/festlex_CMU.tar.gz
    wget http://festvox.org/packed/festival/2.4/festlex_OALD.tar.gz
    wget http://festvox.org/packed/festival/2.4/festlex_POSLEX.tar.gz
    wget http://festvox.org/packed/festival/2.4/voices/festvox_kallpc16k.tar.gz
    wget http://festvox.org/packed/festival/2.4/voices/festvox_rabpc16k.tar.gz

    cd ..

fi

# Unpack the code and voices
mkdir programs
cd programs

for i in ../packed/*.gz
do
   tar zxvf $i
done

for i in ../packed/*.bz2
do
   tar jxvf $i
done

#cd speech_tools
#./configure
#make
#cd ..

#cd festival
#./configure
#make

