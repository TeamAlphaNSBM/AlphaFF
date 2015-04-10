/* Declaration of 'and','or' and 'not' as infix operators */
:- op(1000,xfy,'and').
:- op(1000,xfy,'or').
:- op(900,fy,'not').

/* Finding boolean constants in the expression */
variable_find(N,V,V) :- member(N,[0,1]),!.    
variable_find(X,Vin,Vout) :- atom(X), 
                         (member(X,Vin) ->Vout = Vin ; 
	          Vout = [X|Vin]).   
variable_find(X and Y,Vin,Vout) :- variable_find(X,Vin,Vtemp),
variable_find(Y,Vtemp,Vout).
variable_find(X or Y,Vin,Vout) :-  variable_find(X,Vin,Vtemp),
variable_find(Y,Vtemp,Vout).
variable_find(not X,Vin,Vout) :-   variable_find(X,Vin,Vout).


/* Initial truth assignment */
truth_initial([],[]).
truth_initial([X|R],[0|S]) :- truth_initial(R,S).

/* Successor truth assignment */
successor(A,S) :- reverse(A,R),
next(R,N),
reverse(N,S).

next([0|R],[1|R]).
next([1|R],[0|S]) :- next(R,S).

/* truth table for the three infix operations */
val_and(0,0,0). 
val_and(0,1,0).     
val_and(1,0,0).
val_and(1,1,1).
val_or(0,0,0).      
val_or(0,1,1).
val_or(1,0,1).      
val_or(1,1,1).
val_not(0,1).
val_not(1,0).

/* Definition for the truth value */
truth_val(N,_,_,N) :- member(N,[0,1]).
truth_val(X,Vars,A,Val) :- atom(X),
lookup(X,Vars,A,Val).
truth_val(X and Y,Vars,A,Val) :- truth_val(X,Vars,A,VX),
truth_val(Y,Vars,A,VY),
val_and(VX,VY,Val).
truth_val(X or Y,Vars,A,Val) :-  truth_val(X,Vars,A,VX),
truth_val(Y,Vars,A,VY),
val_or(VX,VY,Val).
truth_val(not X,Vars,A,Val) :-   truth_val(X,Vars,A,VX),
val_not(VX,Val).

lookup(X,[X|_],[V|_],V).
lookup(X,[_|Vars],[_|A],V) :- lookup(X,Vars,A,V).