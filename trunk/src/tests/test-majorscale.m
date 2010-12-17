/* Test majorscale
   Testing major scale creation.  Library function 
   @author Ye
   */

main() {
  Note a;
  Number n;
  Sequence b;
  b = majorscale(C);
  
  play(b);

}

majorscale(root)
{
	Sequence seq;
	Number n;
	seq = new_sequence();
	seq = seq + root;

	for(n = 1; n < 3; n=n+1)
	{
		root = root .+ 2;
		seq = seq + root;
	}
	
	root = root .+ 1;
	seq = seq + root;
	
	for(n = 1; n < 4; n=n+1)
	{
		root = root .+ 2;
		seq = seq + root;
	}
	
	root = root .+ 1;
	seq = seq + root;
	
	return seq;
}
