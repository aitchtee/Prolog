%%%%%%%%%%%%%% �������������� ������� � 1. ������ %%%%%%%%%%%%%%
% ��� ���������� ������ ��������� ��� ������ L1 � L2,
% ��� �������� L1 ��� ��������������� �������� ��������� ������,% � ������� ������ L2 � ������� i ����������,
% ������� ��� ������� ������
% L1 � ����� ������� ����������� � ��������.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ������� �������� ������� �� ������
%
delElem(_,[],[]).
delElem(X,[X|Y],Z):- delElem(X,Y,Z).
delElem(X,[Y|L],[Y|L1]):- X \= Y, delElem(X,L,L1).

%��������� �������� ���� �������
%
delete_list([],[]).
delete_list([X|Y],[X|Z]):-delElem(X,Y,Z1),delete_list(Z1,Z).


% ����� ��������� ���� ��������� ������
count([],_,0).
count([X|T],X,Y):- count(T,X,Z), Y is Z+1.
count([X1|T],X,Z):- X1 \= X,count(T,X,Z).


delall([],_,[]).
delall([X|T],X,R) :- delall(T,X,R).
delall([Y|T],X,[Y|R]) :- X \= Y, delall(T,X,R).

getKol([],_).
getKol([[_,L2|_]|T],[L2|X]):-getKol(T,X).

lcount([],[]).
lcount([H|T],[[H,Z]|R]) :- count([H|T],H,Z), delall(T,H,Q),
      lcount(Q,R),!.

listLen([], 0):-!.
listLen([_|Y],Z):-listLen(Y,Z1), Z is Z1+1.

% �������� ���������
result(List,L1,L2):-delete_list(List,L1),
      lcount(List,L3), getKol(L3,L2),listLen(L2,_),!.


%%%%%%%%% �������������� ������� � 2. ���������� ������ %%%%%%%%
% � ����� ����� ����� �� �������, ����������, ��������,
% ���������, ����������� � ������������ ����� ���� ��� ������� �
% �������, �������� � �������.
% ������ �� ��� ���������� ��� ��������.
% ������� � ������� ������������ ����� � ������ �� ����. �������
% �������� ������ ������� ����������. ������� � ����� �������.
% � ����������� ������ ���� �� ���������� � ��������,
% � ������� � � ������� ������������ �����.
% � ����������� �������, ��������� � ������� ����������� ����a
% ���� �� �������. ����� �������� ��������� ������ �������?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
% morozov, tokarev, vasilev
% bio, geo, eng, fra, his, mat
%

unique([]):-!.
unique([H|T]):- member(H,T),!,fail.
unique([_|T]):- unique(T).

lesson(bio).
lesson(fra).
lesson(eng).
lesson(his).
lesson(math).
lesson(geo).

teachers(Res):-
Res = [(morozov,XL1,XL2),
       (vasilev,YL1,YL2),
       (tokarev,ZL1,ZL2)],

      lesson(XL1),lesson(XL2),
      lesson(YL1),lesson(YL2),
      lesson(ZL1),lesson(ZL2),
      unique([XL1,XL2,YL1,YL2,ZL1,ZL2]),

      not(member((_,geo,fra),Res)),
      not(member((_,fra,geo),Res)),
      not(member((tokarev,bio;_,fra;_),Res)),
      not(member((tokarev,fra;_,bio;_),Res)),
      not(member((_,bio,fra),Res)),
      not(member((_,fra,bio),Res)),
      not(member((morozov,bio,_),Res)),
      not(member((morozov,_,bio),Res)),
      not(member((_,bio,math),Res)),
      not(member((_,math,bio),Res)),
      not(member((_,eng,math),Res)),
      not(member((_,math,eng),Res)),
      not(member((morozov,_,eng),Res)),
      not(member((morozov,eng,_),Res)),
      not(member((morozov,_,math),Res)),
      not(member((morozov,math,_),Res)),!.



%%%%%%%%%%%%%%% �������������� ������� � 3. ������ %%%%%%%%%%%%%
% ������� ����� ������, ������������ � ��������������� ����� �
% ��� �� ������; ������� �������� ����� ��� ����� �k�.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
% ��������� ������� � ���������� ��������� � �����
%
firstElem(X,R) :- sub_string(X, 0, 1, _ ,R).
lastElem(X,R) :- string_length(X,L), L1 is L-1,
                 sub_string(X, L1, 1, _ ,R).
firstEqualLast(X):- firstElem(X,Y),
                    lastElem(X,Z),
                    Y = Z.

%
% ������� ���������
%
countK("",_,0).
countK(S,C,N):- atom_chars(S,MidStr), MidStr = [X|S1],
                X = C, !,atomics_to_string(S1,S2),
                countK(S2,C,N1), N is N1+1, !.
countK(S,C,N):- atom_chars(S,MidStr), MidStr =[_|S1],
                atomics_to_string(S1,S2),
                countK(S2,C,N),!.
findWord(S,C):- countK(S,C,N), N = 3, !, write(S), write(" ").
findWord(_,_).

%
% �������� ���������
%
preRes([H|T]):- firstEqualLast(H), !,
                findWord(H, k), preRes(T).
preRes([_|T]):- preRes(T).
preRes([]).

res(S):- split_string(S," ","./,/;/!/?",L),
         preRes(L).


%%%%%%%%%%%%%%% �������������� ������� � 4. ����� %%%%%%%%%%%%%%
% � ����� �������� �������������� ��������� �� ���������
% ������� (�������� a+b , a�b , a*b � a/b � �� ������������).
% � ��������� ���� ������� ��������� ����������
% ������� ���������.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ������� �������� � ������, ������� � 1
indexOf([Znak|_], Znak, 1):-!.
indexOf([_|T], Znak, Pos):-
  indexOf(T, Znak, Ind), !,
  Pos is Ind+1.

% ������ N ��������� ������
get_first_n(List, N, FirstN):-
  append(FirstN, _Tail, List),
  length(FirstN, N),!.

% ������ ��� ������ N ���������
rem_first_n(List, N, Last):-
  append(_FirstN, Last, List),
  length(_FirstN, N),!.

% �������� ���������� �������� ������
dellast([_],[]):-!.
dellast([X|T],[X|Y]):-dellast(T,Y).

% ���� ��� �������
preDiv(X,U):- H = /, indexOf(X,H,A), !, A1 is A-1,
    get_first_n(X,A1,L1),
    last(L1,Last),
    %A2 is A+1,
    rem_first_n(X,A,[First|L2]),
    R is Last/First,
    dellast(L1,L3),
    append(L3,[R],L4),
    append(L4,L2,PreR), preDiv(PreR, U).
preDiv(X,X):- !.

% ���� ��� ���������
preMul(X,U):-H = *, indexOf(X,H,A), !, A1 is A-1,
    get_first_n(X,A1,L1),
    last(L1,Last),
    %A2 is A+1,
    rem_first_n(X,A,[First|L2]),
    R is Last * First,
    dellast(L1,L3),
    append(L3,[R],L4),
    append(L4,L2,PreR), preMul(PreR, U).
preMul(X,X):- !.

% ���� ��� ��������
prePl(X,U):-H = +, indexOf(X,H,A), !, A1 is A-1,
    get_first_n(X,A1,L1),
    last(L1,Last),
    %A2 is A+1,
    rem_first_n(X,A,[First|L2]),
    R is Last + First,
    dellast(L1,L3),
    append(L3,[R],L4),
    append(L4,L2,PreR), prePl(PreR, U).
prePl(X,X):- !.

% ���� ��� ������
preMin(X,U):-H = -, indexOf(X,H,A), !, A1 is A-1,
    get_first_n(X,A1,L1),
    last(L1,Last),
    %A2 is A+1,
    rem_first_n(X,A,[First|L2]),
    R is Last - First,
    dellast(L1,L3),
    append(L3,[R],L4),
    append(L4,L2,PreR), preMin(PreR, U).
preMin(X,X):- !.

% ���������������� ���������� + � -

addition(H1,H3,Res):- Res is H1 + H3. % ���� ��������
subtraction(H1,H3,Res):-Res is H1 - H3. % ���� ��������

posled([H1,H2,H3|T],U):- H2 = +, !, addition(H1,H3,Res),
    append([Res],T,L1),
    posled(L1,U).
posled([H1,H2,H3|T],U):- H2 = -, !, subtraction(H1,H3,Res),
    append([Res],T,L1),
    posled(L1,U).
posled(X,X):-!.

% result
result4:-
    see('C:/Users/hieut/OneDrive/���������/Prolog/ind4.txt'),
    readln(X), X \= [], !,
    preDiv(X,R), preMul(R,R1),
    /*prePl(R1,R2), preMin(R2,R3),*/
    posled(R1,R3),
    tell('C:/Users/hieut/OneDrive/���������/Prolog/ans.txt'),
    writeln(R3), result4.
result4:-seen, told.


%%%%%%%%%%%%%%% �������������� ������� � 6. ����� %%%%%%%%%%%%%
% ���� ��� ����� � ����� ������� ��� ���������� �����.
% ���������, �������� �� ��� �����������.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

children1(1,[5,6,7]).
children1(2,[4,5,6]).
children1(3,[4,5,6]).
children1(4,[2,3,7]).
children1(5,[1,2,3]).
children1(6,[1,2,3]).
children1(7,[1,4]).

children2(1,[4,7]).
children2(2,[4,5,6]).
children2(3,[4,5,6]).
children2(4,[1,2,3]).
children2(5,[7,2,3]).
children2(6,[2,3,7]).
children2(7,[1,5,6]).

%children1(1,[2,3]).
%children1(2,[1,3,4]).
%children1(3,[1,2]).
%children1(4,[2]).

%children2(1,[3]).
%children2(2,[3,4]).
%children2(3,[1,2,4]).
%children2(4,[2,3]).


find_edge1(R1):-findall(A/B,(children1(A,L), member(B,L)),X), %������� ��� �����
           clear(X,R1).
find_edge2(R1):-findall(A/B,(children2(A,L), member(B,L)),X), %������� ��� �����
           clear(X,R1).

clear([],[]):-!.
clear([X/Y|T],R):-clear(T,R1),
    ((member(X/Y,R1);member(Y/X,R1)),
      R=R1;
    R=[X/Y|R1]),!.

position(L, X, [X|L]).
position([H|T1], X, [H|T2]) :-
         position(T1,X,T2).
%������������
transposition([],[]).
transposition([H|T],L) :-
         transposition(T,T1),
         position(T1,H,L).

%���� ������ ��������
indexOf([Znak|_], Znak, 1):-!.
indexOf([_|T], Znak, Pos):-
indexOf(T, Znak, Ind), !,
Pos is Ind+1.

%���� ������� �� �������
find(1,[Result|_],Result):-!.
find(Number,[_|Tail],Result):-N is Number-1,find(N,Tail,Result).

%��������� ��� ����� ������ �� ���������� � �������������
prov(_,_,[],_).
prov(L,L1,[A/B|R],R1):-indexOf(L,A,X),indexOf(L,B,Y),
   find(X,L1,V1),find(Y,L1,V2), hasr(V1/V2,R1), prov(L,L1,R,R1).

%��������� ���� �� �����
hasr(A/B,L):-member(A/B,L);member(B/A,L).

result6:- findall(V,children1(V,_),L),findall(V,children2(V,_),L1), length(L,K),length(L1,K1), K=K1,find_edge1(R),find_edge2(R1),length(R,P),length(R1,P1), P=P1,
    transposition(L1,V),prov(L,V,R,R1),!.
