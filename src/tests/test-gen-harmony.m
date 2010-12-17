/* Test creating a melody and harmony
   Tests by creating a simple melody and then a harmony for it*/

main() {
  Note e;
  Note d;
  Note c;
  Note fc;
  Note fd;
  Sequence b;
  
  e = E4q;
  d = D4q;
  c = C4q;
  fc = C4s;
  fd = D4s;
  
  b = new_sequence();
  b = b + e + d + c + e + d + c;
  b = b + fc + fc + fc + fc;
  b = b + fd + fd + fd + fd;
  b = b + e + d + c;
  
  b = harmony(b, C);
  set_tempo(30);
  play(b);

}

harmony(s, key)
{
	Sequence out;
	Chord c;
	Note root;
	Number len;
	Number i;
	len = s.length;
	out = new_sequence();
	for(i = 0; i < len; i = i+1)
	{
		c = s[i];
		root = c[0];
		out = out + in_major_chord(root, key);
	}
	
	return out;
}

in_major_chord(root, key)
{
	Chord c;
	if(key.pitch - root.pitch == 0 || 
		key.pitch - root.pitch == 12 || key.pitch - root.pitch == (0-12) || 
		key.pitch - root.pitch == 5 || key.pitch - root.pitch == (0-5) || 
		key.pitch - root.pitch == 7 || key.pitch - root.pitch == (0-7))
	{
		c = major(root);
	}
	else
	{
		c = minor(root);
	}
	c = shift(c, (0-12));
	return c;
}

shift(c, n)
{
	Number i;
	Number len;
	len = c.length;
	for(i = 0; i < len; i=i+1)
	{
		c[i] = c[i] .+ n;
	}
	return c;
}

major(root)
{
	Chord c;
	
	c = new_chord(root);
	
	c = c + (root .+ 4);
	c = c + (root .+ 7);
	return c;
}

minor(root)
{
	Chord c;
	
	c = new_chord(root);
	
	c = c + (root .+ 3);
	c = c + (root .+ 7);
	return c;
}
	
