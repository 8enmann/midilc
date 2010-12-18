/* Test naturalminorscale.m
   Testing natural minor scale creation.  Library function 
   @author Ye
   */

main() {
  Note a;
  Number n;
  Sequence b;
  b = naturalminorscale(C);
  
  play(b);

}

naturalminorscale(root) {
	Sequence seq;
	Number n;
	seq = new_sequence();
	
	/* natural minor starts on the 6th note of the major scale in the octave below */
	root = root .+ (0 - 3);
	seq = seq + root;

	root = root .+ 2;
	seq = seq + root;
		
	root = root .+ 1;
	seq = seq + root;
	
	for(n = 1; n < 3; n=n+1)
	{
		root = root .+ 2;
		seq = seq + root;
	}
	
	root = root .+ 1;
	seq = seq + root;
	
	for(n = 1; n < 3; n=n+1)
	{
		root = root .+ 2;
		seq = seq + root;
	}

	
	return seq;
}
