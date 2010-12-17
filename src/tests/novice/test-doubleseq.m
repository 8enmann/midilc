/* play two sequences at once, based on twinkle twinkle little star with accompaniment */

main() {
	/* FIRST PART - TWINKLE TWINKLE */
	/* declare all the variables: Notes c through a, Sequences firstpart, and Number n */
	Note c;
	Note d;
	Note e;
	Note f;
	Note g;
	Note a;
	Sequence firstpart;
	Number n;
	Sequence accomp;
	
	/* set each of the notes to a quarter note in the 4th octave, note name as indicated by the capital letters */
	c = C4q;
	d = D4q;
	e = E4q;
	f = F4q;
	g = G4q;
	a = A4q;
	
	/* initialize sequences */
	firstpart = new_sequence();
	
	/* add the first two stanzas of the song to the Sequence firstpart */
	firstpart = firstpart + c;
	firstpart = firstpart + c;
	firstpart = firstpart + g;
	firstpart = firstpart + g;
	firstpart = firstpart + a;
	firstpart = firstpart + a;
	/* make the last note's duration two quarternotes long (4 beats longer, 16th note per beat) */
	firstpart = firstpart + (g + 4);
	
	firstpart = firstpart + f;
	firstpart = firstpart + f;
	firstpart = firstpart + e;
	firstpart = firstpart + e;
	firstpart = firstpart + d;
	firstpart = firstpart + d;
	firstpart = firstpart + (c + 4);

	
	/* SECOND PART - ACCOMPANIMENT */
	accomp = new_sequence();
	
	/* add a dotted whole-note rest: 4 beats per quarter note, so 12 is 3 quarter notes long*/
	accomp = accomp + (R + 12);
	
	accomp = accomp + c;
	/* adding eigth notes*/
	accomp = accomp + (C4e);
	accomp = accomp + (D4e);
	accomp = accomp + e;
	accomp = accomp + c;
	accomp = accomp + d;
	/* adding eigth notes*/
	accomp = accomp + (E4e);
	accomp = accomp + (F4e);
	accomp = accomp + g;
	accomp = accomp + g;
	accomp = accomp + f;
	accomp = accomp + f;
	/* adding half note by incrementing a quarter note's duration*/
	accomp = accomp + (e + 4);
	
	/* set tempo from default 120 to 100 to slow it down */
	set_tempo(100);
	
	/* call on play() to create the csv file. this will create two tracks, one per Sequence */
	play(firstpart);
	play(accomp);
}