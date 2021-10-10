:- set_prolog_flag(double_quotes, chars).
:- initialization(main).

main :- parse(['if','(',a,')','{',b,';','}','if','(',a,')','{',b,'}'],B),writeln(B).


parse(A,B1) :- parse_(A1),replace_substring(A,A1,[A1],B),(parse(B,B1);B=B1).

parse_([A,';']) :- is_statement(A).
parse_(['if','(',A,')','{',B,'}']) :- is_statement(B);bool_expr(A).
parse_(['function','(',A,')','{',B,'}']).

parse_([A,';']).
parse_(A) :- bool_expr(A);add_expr(A).

bool_expr([A,Symbol,B]) :- member(Symbol,['>','<','>=','<=']),add_expr(A),add_expr(B).
add_expr([A,Symbol,B]) :- member(Symbol,['+','-']).
add_expr(A) :- mul_expr(A).
mul_expr([A,Symbol,B]) :- member(Symbol,['*','/']).

is_statement(A) :- atom(A);number(A).

replace_substring(String, To_Replace, Replace_With, Result) :-
    append([Front, To_Replace, Back], String),
    append([Front, Replace_With, Back], Result).
    
