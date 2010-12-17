/**
 * InstrumentCheck.java
 * 
 * @author: Fredric
 * Uses a file listing all usable instruments to check an instrument is valid
 */
import java.io.BufferedReader;
import java.io.FileReader;

public class InstrumentCheck {
	public static int checkInstrument(String filename, String instrumentName, int min, int max)
	{
		try
		{
			BufferedReader br = new BufferedReader(new FileReader(filename));
			String input;
			String[] instruments = new String[(max - min) + 1];
			while((input = br.readLine()) != null)
			{
				// separate the instrument number and name
				int divider = input.indexOf(",");
				int instrumentcount = Integer.parseInt(input.substring(0, divider).trim());
				instruments[instrumentcount] = input.substring(divider + 1).trim();
				
				if(instruments[instrumentcount].compareToIgnoreCase(instrumentName) == 0)
					return instrumentcount;
			}
		}
		catch(Exception e)
		{
			;
		}
		return -1;
	}

}
