% main file

run:- consult('C:/Users/hieut/OneDrive/���������/Prolog/db.pl'),
    retractall(crew/2),retractall(style/2),
    retractall(dancer/3).

% �������� ��������
showDancers:- run, nl, style(A,B), crew(C,D), dancer(A, C, X),
    write("���: "), writeln(X),
    write("�����: "), writeln(B),
    write("�������: "), writeln(D), nl, fail.

% �������� �����
showStyle:-run, nl, style(_,X),
    write("�����: "), writeln(X),nl,fail.

% �������� ������
showCrew:-run, nl, crew(_,X),
    write("�������� �������: "), writeln(X), nl, fail.

% �������� �����
addStyle:-writeln("���������� �����"),
    write("ID: "), read(X),
    write("��������: "), read(Y),
    assertz(style(X,Y)).

% �������� �������
addCrew:-writeln("���������� �������"),
    write("ID: "), read(X),
    write("��������: "), read(Y),
    assertz(crew(X,Y)).

% �������� �������
addDancer:-writeln("���������� �������"),
   write("ID �������:"), read(X),
   write("ID �������: "), read(Y),
   write("���: "), read(Z),
   assertz(dancer(X,Y,Z)).

% ������� �����
delStyle:-writeln("������� �����"),
    write("ID �����: "),read(X),
    retract(style(X,_)),
    retract(dancer(_,X,_)),
    writeln("����� ������"),
    tell('C:/Users/hieut/OneDrive/���������/Prolog/db.pl'),
    listing(crew), listing(style), listing(dancer),
    told, write('������� ���������'),nl.


% ���������� ����
save:- tell('C:/Users/hieut/OneDrive/���������/Prolog/db.pl'),
    listing(crew),listing(style),listing(dancer),
    told, write('���� ���������'),nl,fail.

