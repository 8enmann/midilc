/**
 * CSV2MIDI.java
 * June 11, 2003
 * @author: Stephen Steffes
 * Purpose:  Converts a .csv file to a MIDI file according to ExampleMIDI.csv
 */


import java.io.*;
import javax.sound.midi.*;
import java.lang.*;


public class CSV2MIDI{

	public static void main(String[] args)	throws InvalidMidiDataException {

		//***** Get Inputs *****
		if (args.length != 2)
			printUsageAndExit();
	
		File outputFile = new File(args[1]);
		Sequence sequence = null;

		//Open and save the CSV file
		CSV csvFile=new CSV(args[0]);
		csvFile.fillVector();

		//instrument and timingRes are default.
		int timingRes=16, instrument = 1;

		//***** Initialize Sequencer *****
		try{
			sequence = new Sequence(Sequence.PPQ, timingRes);   //initialize sequencer with timingRes
		}catch (InvalidMidiDataException e){
			e.printStackTrace();
			System.exit(1);
		}

		//***** Create tracks and notes *****
		/* Track objects cannot be created by invoking their constructor
		   directly. Instead, the Sequence object does the job. So we
		   obtain the Track there. This links the Track to the Sequence
		   automatically.
		*/
		Track track = sequence.createTrack();                    //create track
	
		ShortMessage sm = new ShortMessage( );
        sm.setMessage(ShortMessage.PROGRAM_CHANGE, instrument, 0);  //put in instrument in this track
	    track.add(new MidiEvent(sm, 0));

	    // channel/velocity set to default; note/tick/duration will depend on input.
		int channel=0,velocity=90;
		int note=0,tick=0,duration=0;

		//go through each of the following lines and add notes
		for(int currentCSVPos=0;currentCSVPos<csvFile.data.size();){							//loop through rest of CSV file
			try{																																			  //check that the current CSV position is an integer
				tick=Integer.parseInt(csvFile.data.elementAt(currentCSVPos).toString());  //first number is tick
				currentCSVPos+=2;
				duration=Integer.parseInt(csvFile.data.elementAt(currentCSVPos).toString());  //second number is duration
				currentCSVPos+=2;
				note=Integer.parseInt(csvFile.data.elementAt(currentCSVPos).toString());  //next number is note pitch
				currentCSVPos+=2;
				track.add(createNoteOnEvent(note,tick,channel,velocity));				//add note to the track
				track.add(createNoteOffEvent(note,tick+duration,channel));				//add a noteOffEvent to terminate this note
			}catch(NumberFormatException e){																						//current CSV position not an integer
				/*if(csvFile.data.elementAt(currentCSVPos).toString().compareTo("\n")==0){  //if it's a new line
					column=0;																																//go back to 1st column
				}else if(csvFile.data.elementAt(currentCSVPos).toString().compareTo(",")==0){ //if it's just a comma
					column++;
				}*/
				currentCSVPos++;
			}
		}


		// Print track information
		System.out.println( "\nTrack: ");
     	for ( int j = 0; j < track.size(); j++ ) {
			MidiEvent event = track.get( j );
 			System.out.println(" tick "+event.getTick()+", "+MessageInfo.toString(event.getMessage()));
 		} // for



		/* Now we just save the Sequence to the file we specified.
		   The '0' (second parameter) means saving as SMF type 0.
		   (type 1 is for multiple tracks).
		*/
		try{
			MidiSystem.write(sequence, 1, outputFile);
		}catch (IOException e){
			e.printStackTrace();
			System.exit(1);
		}
	}






	// note representation: tick, duration, pitch
  //turns note on
	private static MidiEvent createNoteOnEvent(int nKey, long lTick,int channel,int velocity){
		return createNoteEvent(ShortMessage.NOTE_ON,nKey,velocity,lTick,channel);
	}

	//turns note off
	private static MidiEvent createNoteOffEvent(int nKey, long lTick,int channel){
		return createNoteEvent(ShortMessage.NOTE_OFF,nKey,0,lTick,channel);  //set note to 0 velocity
	}

	//turns note on or off
	private static MidiEvent createNoteEvent(int nCommand,int nKey,int nVelocity,long lTick,int channel){
		ShortMessage message = new ShortMessage();
		try{
			message.setMessage(nCommand,channel,nKey,nVelocity);
		}catch (InvalidMidiDataException e){
			e.printStackTrace();
			System.exit(1);
		}
		MidiEvent event = new MidiEvent(message,lTick);
		return event;
	}

	private static void printUsageAndExit(){
		out("usage:");
		out("java CSV2MIDI <infile.csv> <outfile.midi>");
		System.exit(1);
	}

	private static void out(String strMessage){
		System.out.println(strMessage);
	}
}

