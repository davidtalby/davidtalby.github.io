create table suppliers 
     (s#          varchar2(5),
      sname       varchar2(15),
      status      number,
      city        varchar2(15) ) ;

create table parts
     (p#          varchar2(5),
      pname       varchar2(15),
      color       varchar2(15),
      weight      number,
      city        varchar2(15)  ) ;

create table projects
     (j#          varchar2(5),
      jname       varchar2(15),
      city        varchar2(15)   )  ;

create table shipments
     (s#          varchar2(5),
      p#          varchar2(5),
      j#          varchar2(5)   )  ;

insert into suppliers values ('s1', 'Smith', 20, 'London') ;
insert into suppliers values ('s2', 'Jones', 30, 'Paris') ;
insert into suppliers values ('s3', 'Blake', 30, 'Paris') ;
insert into suppliers values ('s4', 'Clark', 20, 'London') ;
insert into suppliers values ('s5', 'Adams', 30, 'Athens') ;

insert into parts values ('p1', 'nut',    'red',   12, 'London') ;
insert into parts values ('p2', 'bolt',   'green', 17, 'Paris') ;
insert into parts values ('p3', 'screw',  'blue',  17, 'Rome') ;
insert into parts values ('p4', 'screw',  'red',   14, 'London') ;
insert into parts values ('p5', 'cord',   'blue',  12, 'Paris') ;
insert into parts values ('p6', 'button', 'red',   19, 'London') ;

insert into projects values ('j1', 'xterminal', 'Paris' ) ;
insert into projects values ('j2', 'mouse',     'Rome' ) ;
insert into projects values ('j3', 'keyboard',  'Athens' ) ;
insert into projects values ('j4', 'modem',     'Oslo' ) ;

insert into shipments values ('s1', 'p1', 'j1' ) ;
insert into shipments values ('s1', 'p1', 'j4' ) ;
insert into shipments values ('s2', 'p3', 'j1' ) ;
insert into shipments values ('s2', 'p3', 'j2' ) ;
insert into shipments values ('s3', 'p5', 'j1' ) ;
insert into shipments values ('s4', 'p1', 'j2' ) ;
insert into shipments values ('s4', 'p6', 'j3' ) ;
insert into shipments values ('s4', 'p6', 'j4' ) ;
insert into shipments values ('s5', 'p2', 'j1' ) ;



