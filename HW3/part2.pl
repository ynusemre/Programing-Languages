% knowledge base
flight(istanbul,ankara,1).
flight(istanbul,izmir,2).
flight(istanbul,rize,4).

flight(izmir,istanbul,2).
flight(izmir,antalya,2).
flight(izmir,ankara,6).


flight(rize,istanbul,4).
flight(rize,ankara,5).

flight(ankara,istanbul,1).
flight(ankara,izmir,6).
flight(ankara,rize,5).
flight(ankara,van,4).
flight(ankara,diyarbakır,8).

flight(van,ankara,4).
flight(van,gaziantep,3).

flight(gaziantep,van,3).

flight(diyarbakır,ankara,8).
flight(diyarbakır,antalya,4).

flight(antalya,izmir,2).
flight(antalya,diyarbakır,4).
flight(antalya,erzincan,3).

flight(erzincan,antalya,3).
flight(erzincan,canakkale,6).

flight(canakkale,erzincan,6).


% rules
route(X,Y,C):- flight(X,Y,A),not(X==Y),(C is A).   
route(X,Y,C):- flight(X,Z,A),flight(Z,Y,B),not(X==Y),not(Z==Y),not(X==Z),(C is A+B).
route(X,Y,C):- flight(X,Z,A),flight(Z,T,B),flight(T,Y,N),not(X==Y),not(Z==T),not(Z==Y),not(T==Y),not(X==T),not(X==Z),(C is A+B+N).
route(X,Y,C):- flight(X,Z,A),flight(Z,T,B),flight(T,K,N),flight(K,Y,P),not(X==Y),not(Z==T),not(Z==Y),not(T==Y),not(X==T),not(X==Z),not(X==K),not(Z==K),not(T==K),not(Y==K),(C is A+B+N+P).
route(X,Y,C):- flight(X,Z,A),flight(Z,T,B),flight(T,K,N),flight(K,E,P),flight(E,Y,S),not(X==Y),not(Z==T),not(Z==Y),not(T==Y),not(X==T),not(X==Z),not(X==K),not(Z==K),not(T==K),not(Y==K),not(X==E),not(Z==E),not(T==E),not(K==E),not(Y==E),(C is A+B+N+P+S).
route(X,Y,C):- flight(X,Z,A),flight(Z,T,B),flight(T,K,N),flight(K,E,P),flight(E,D,S),flight(D,Y,U),not(X==Y),not(Z==T),not(Z==Y),not(T==Y),not(X==T),not(X==Z),not(X==K),not(Z==K),not(T==K),not(Y==K),not(X==E),not(Z==E),not(T==E),not(K==E),not(Y==E),not(X==D),not(Z==D),not(T==D),not(K==D),not(E==D),not(Y==D),(C is A+B+N+P+S+U).
route(X,Y,C):- flight(X,Z,A),flight(Z,T,B),flight(T,K,N),flight(K,E,P),flight(E,D,S),flight(D,M,U),flight(M,Y,Q),not(X==Y),not(Z==T),not(Z==Y),not(T==Y),not(X==T),not(X==Z),not(X==K),not(Z==K),not(T==K),not(Y==K),not(X==E),not(Z==E),not(T==E),not(K==E),not(Y==E),not(X==D),not(Z==D),not(T==D),not(K==D),not(E==D),not(Y==D),not(X==M),not(Z==M),not(T==M),not(K==M),not(E==M),not(Y==M),not(D==M),(C is A+B+N+P+S+U+Q).
route(X,Y,C):- flight(X,Z,A),flight(Z,T,B),flight(T,K,N),flight(K,E,P),flight(E,D,S),flight(D,M,U),flight(M,J,Q),flight(J,Y,W),not(X==Y),not(Z==T),not(Z==Y),not(T==Y),not(X==T),not(X==Z),not(X==K),not(Z==K),not(T==K),not(Y==K),not(X==E),not(Z==E),not(T==E),not(K==E),not(Y==E),not(X==D),not(Z==D),not(T==D),not(K==D),not(E==D),not(Y==D),not(X==M),not(Z==M),not(T==M),not(K==M),not(E==M),not(Y==M),not(D==M),not(X==J),not(Z==J),not(T==J),not(K==J),not(E==J),not(M==J),not(D==J),not(Y==J),(C is A+B+N+P+S+U+Q+W).

