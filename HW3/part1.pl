:- dynamic(room/4).
:- dynamic(course/7).
:- dynamic(instructor/3).
:- dynamic(student/3).

% knowledge base 

%	room(ID,Capacity,hours,Equipment).

room('Z101',80,4,special('projector','smart_board')).
room('Z102',120,5,special('projector')).
room('Z103',100,4,special('projector','handicapped')).
room('Z104',70,2,special('smart_board')).
room('Z105',70,8,special('smart_board')).


%	course(ID,Instructor,Room,Capacity,Hour,Students,Needs).

% oke
course('chemical','ayseKaya','Z101',30,3,student(s25,s30),special('smart_board')).

% No access for the handicapped.
course('math','cemCan','Z102',40,3,student(s26,s27),special('smartBoard','handicapped')).

% capacity not enough
course('physic','aliKoc','Z103',200,2,student(s31),special('projector','handicapped')).

% hours not enough for the room.
course('turkish','mehmetBulut','Z104',30,4,student(s28),special('projector','smartBoard')).

% equipment does not found in the room.
course('english','hasanAla','Z105',30,3,student(s29),special('smart_board')).   


%	instructor(ID,Courses,Equipment).

instructor(i18,course('chemical','math'),special('smart_board')).
instructor(i17,course('math'),special('projector')).
instructor(i16,course('physic'),special('projector')).
instructor(i15,course('turkish','physic'),special('smart_board')).
instructor(i14,course('english'),special('smart_board')).


%	student(ID,Courses,Handicapped).

student(s25,course('chemical'),special()).
student(s26,course('math'),special()).
student(s27,course('math'),special('handicapped')).
student(s28,course('turkish','english'),special()).
student(s29,course('english'),special()).
student(s30,course('chemical','math'),special()).
student(s31,course('physic'),special('handicapped')).

%rules.

% hours check
conflict(Courseid1,Courseid2) :- room(Roomid,_,X,special(A,B)), course(Courseid,_,_,_,Y,student(C,D),special(K,L)), X<Y.

% capacity check.
capacityCheck(Roomid,Courseid) :- room(Roomid,X,_,special(A,B)), course(Courseid,_,_,Y,_,student(C,D),special(K,L)), X<Y.



