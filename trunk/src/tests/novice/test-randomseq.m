/* random sequence */

main() {
	/* declare all the Note, Sequence and Numbers that are used */
	Note a;
	Sequence seq;
	Number n;
	Number r1;
	Number r2;
	
	/* initialize seq */
	seq = new_sequence();
	
	/* loop through and put in 20 notes of random duration and pitch */
	for (n = 0; n < 20; n = n + 1) {
		/* set a as middle C, sixteenth note, and then change its pitch and duration randomly */
		a = C4s;
		
		/* randomly generated numbers */
		r1 = rand(15);
		r2 = rand(4);
		
		/* change a's pitch */
		a = a .+ r1;
		/* change a's duration */
		a = a + r2;
		
		/* add a to the sequence */
		seq = seq + a;
	}
	
	/* play the sequence */
	play(seq);
}