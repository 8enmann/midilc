/* Test harmonicminor
   Testing harmonic minor scale creation.  Library function 
   @author Ye
   */

main() {
  Note a;
  Number n;
  Sequence b;
  b = harmonicminor(C);
  
  play(b);

}

harmonicminor(root)
{
	Sequence seq;
	Number n;
	seq = new_sequence();
	seq = seq + root;

	root = root .+ 2;
	seq = seq + root;
	
	root = root .+ 1;
	seq = seq + root;
	
	root = root .+ 2;
	seq = seq + root;
	
	root = root .+ 2;
	seq = seq + root;
	
	root = root .+ 1;
	seq = seq + root;
	
	root = root .+ 3;
	seq = seq + root;
	
	root = root .+ 1;
	seq = seq + root;
	
	return seq;
}
