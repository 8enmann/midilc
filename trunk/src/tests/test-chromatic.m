/* Test creating a chromatic scale
   Tests that creating a chromatic scale using a function works.  Library function */

main() {
  Note a;
  Number n;
  Sequence b;
  b = chromatic(C);
  
  play(b);

}

chromatic(root)
{
	Sequence seq;
	Number n;
	seq = new_sequence();
	seq = seq + root;

	for(n = 1; n < 12; n=n+1)
	{
		seq = seq + (root .+ n);
	}
	
	return seq;
}
