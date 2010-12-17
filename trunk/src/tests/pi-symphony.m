main(){
    Sequence s1;
    Sequence s2;
    Sequence s3;
    Sequence s4;
    Sequence s5;
    Sequence scale;
    Number i;
    Number j;
    Number turn;
    Chord c;
    Number k;
    Number pi1;
    Number pi2;
    Number pi;
    Note n;
    turn = 0;
    s1 = new_sequence();
    s2 = new_sequence();
    s3 = new_sequence();
    s5 = new_sequence();
    scale = major_scale(Cq);
    pi1 = 562951413;
    pi2 = 323979853;
    pi = pi1;
    for(i = 0; i < 24; i=i+1){
        if(pi == 0){ 
            if(turn){
                pi = pi1;
                turn = 1-turn;
            }
            else{
                pi = pi2;
                turn = 1-turn;
            }
        }
        n = scale[pi%10];
        n.duration = pi%10;
        s1 = s1+n;
        s3= s3 + (n[0].+3);
        pi = pi/10;
    }
    s4 = s1;
    play(divide(s4) + divide(divide(transpose(s4,G3,C5)))+E5);
    play(divide(s3) + repeat(D3s,Rs,s3.length)+repeat(G4s,Rs,s3.length/2));  
    play(s5+repeat(s5+Ch+Rh+Gh,s5+R6h+R6h+G6h,3));
    
}

transpose(s, n1, n2){
    Number diff;
    Number i;
    Note k;
    Sequence newseq;

    diff = n1.pitch-n2.pitch;
    newseq = new_sequence();

    for(i = 0; i < s.length; i=i+1){
        k = s[i];
        newseq = newseq + (k[0] .+ diff);
    }

    return newseq;
}

repeat(n1,n2,times){
    return do_repeat(n1,n2,times,new_sequence());
}

do_repeat(n1, n2, times, so_far){
    if(times == 0)
    {
        return so_far;
    }
    return do_repeat(n1,n2, times-1, so_far+n1+n2);
}

major_scale(n1){
    Sequence p;
    Number i;
    p  = new_sequence();
    for(i = 0; i <= 16; i=i+1){
        if(i==0 || i==2 || i==4 || i==5 || i==7 || i==9 || i== 11 || i==12 || i==14 || i==16){
            p = p + (n1 .+ i);
        }
    }
    return p;
}

Sequence divide(Sequence s) {
  Sequence result;
  Number dur;
  Number i;
  Chord temp;
  
  result = new_sequence();
  for(i = 0; i < s.length; i=i+1) {
    temp = s[i];
    dur = temp.duration;
    dur = dur/2;
    temp.duration = dur;
    result = result + temp;
  }
  result = result + result;
  return result;
}
    
