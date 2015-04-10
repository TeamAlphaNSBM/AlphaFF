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




