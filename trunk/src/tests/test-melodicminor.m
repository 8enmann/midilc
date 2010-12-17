/* Test harmonicminor
   Testing melodic minor scale creation.  Library function 
   @author Ye
   */

main() {
  Note a;
  Number n;
  Sequence b;
  b = melodicminor(C);
  
  play(b);

}

melodicminor(root)
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
	
	root = root .+ 2;
	seq = seq + root;
	
	root = root .+ 2;
	seq = seq + root;
	
	root = root .+ 1;
	seq = seq + root;
	
	return seq;
}
