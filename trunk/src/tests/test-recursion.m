/** Test recursion
  *
  * This test shows the power of recursion in MIDILC.
  *
  * Sequences are created using the get_new_seq method, which calls itself
  * recursively to create ever more elaborate musical pieces.
  *
  * @author Akiva
  */
main(){
    Number i;
    Sequence seq;
    i = 5;
    seq = get_new_seq(i, new_sequence());
    play(seq);
}

Sequence get_new_seq(Number i, Sequence seq){
    seq = seq + (G.+(mult(i,5))) + seq + (C.+(mult(i,5))) + seq + (E.+(mult(i,5)));

    if(i == 0){
        return seq;
    }
    i = i-1;
    
    return get_new_seq(i, seq);
}

mult(original, times){
    return do_mult(original, times-1, original);
}

do_mult(original, times, toreturn){
    if(times <= 0){
        return toreturn;
    }
    return do_mult(original, times-1, toreturn+original);
}
