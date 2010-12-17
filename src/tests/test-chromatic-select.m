/* Test selecting from a chromatic scale
   Tests that selecting from the chromatic scale using a function works */

main() {
  Note a;
  Number n;
  Sequence b;
  b = new_sequence();
  b = b + chromatic_select(C, 0) + chromatic_select(C, 5) + chromatic_select(C, 8);
  
  play(b);

}

chromatic_select(root, index)
{
	Sequence seq;
	Chord c;
	seq = chromatic(root);
	
	c = seq[index];
	return c[0];
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
