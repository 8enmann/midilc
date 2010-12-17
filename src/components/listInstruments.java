/**
 * listInstruments.java
 * 
 * @author: Stephen Steffes http://www.penguinpeepshow.com/CSV2MIDI.php
 * 
 * Creates list of instruments and their numbers. Taken from Stephen Steffes at http://www.penguinpeepshow.com/CSV2MIDI.php
 */

import java.io.*;
import javax.sound.midi.*;

public class listInstruments{
  public static Synthesizer synth;

  public static void listAvailableInstruments(){
    Instrument[] instrument = synth.getAvailableInstruments();
    for (int i=0; i<instrument.length; i++){
      System.out.println(i + "   " + instrument[i].getName());
    }
  }

  public static void main(String[] args)	throws InvalidMidiDataException {
    try {
      synth = MidiSystem.getSynthesizer();
      synth.open();
    } catch (MidiUnavailableException e) {
      e.printStackTrace();
    }
    listAvailableInstruments();
    System.exit(0);
  }
}
