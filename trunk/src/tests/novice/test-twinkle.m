/* twinkle twinkle little star*/

main() {
	/* declare all the variables: Notes c through a, Sequences firstpart and overall, and Number n */
	Note c;
	Note d;
	Note e;
	Note f;
	Note g;
	Note a;
	Sequence firstpart;
	Sequence overall;
	Number n;
	
	/* set each of the notes to a quarter note in the 4th octave, note name as indicated by the capital letters */
	c = C4q;
	d = D4q;
	e = E4q;
	f = F4q;
	g = G4q;
	a = A4q;
	
	/* initialize sequences */
	firstpart = new_sequence();
	overall = new_sequence();
	
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
	
	/* add the first part to the overall Sequence */
	overall = overall + firstpart;
	
	/* add the middle section of the song to overall twice, by using a for-loop */
	for (n = 0; n < 2; n = n+1) {
		overall = overall + g;
		overall = overall + g;
		overall = overall + f;
		overall = overall + f;
		overall = overall + e;
		overall = overall + e;
		overall = overall + (d + 4);
	}
	
	/* add firstpart to overall again, since the song ends how it begins */
	overall = overall + firstpart;
	
	/* set tempo from default 120 to 90, since it is a slow song */
	set_tempo(90);
	
	/* call on play() to create the csv file */
	play(overall);
}
	