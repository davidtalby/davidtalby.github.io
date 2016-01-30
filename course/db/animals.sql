% Databases Course, Fall Semester 1998/9
% Sample database creation file
% -----------------------------

% The 'create table' creates tables and defines their fields. The type of every field has
% to be defined as well: Here we use 'number' for integers and 'varchar2' for strings.
% You can delete a table using the 'drop table table_name' command, and change a table's
% fields or other definitions using the 'alter table' command (see Oracle's help files).

create table animals
  (aid varchar2(5),
   species varchar2(15),
   weight number,
   birthyear number);

create table children
  (parent varchar2(5),
   child varchar2(5));

create table sites
  (sid varchar2(5),
   name varchar2(15),
   country varchar2(15),
   climate varchar2(15));

create table research
  (rid varchar2(5),
   name varchar2(15),
   subject varchar2(15));

create table events
  (aid varchar2(5),
   sid varchar2(5),
   rid varchar2(5),
   year number);

% The 'insert' command inserts tuples into a table.
% Note: These are demo values. I have no backgroup in biology, so some of the attributes
% and behavior of animals may be well out of the natural order...

insert into animal values ('a1', 'Eagle', 30, 1982);
insert into animal values ('a2', 'Eagle', 42, 1979);
insert into animal values ('a3', 'Eagle', 34, 1987);
insert into animal values ('a4', 'Eagle', 51, 1988);
insert into animal values ('a5', 'Whale', 301, 1957);
insert into animal values ('a6', 'Whale', 209, 1967);
insert into animal values ('a7', 'Whale', 720, 1970);
insert into animal values ('a8', 'Whale', 687, 1965);
insert into animal values ('a9', 'Whale', 997, 1984);
insert into animal values ('a10', 'Whale', 901, 1984);
insert into animal values ('a11', 'Whale', 273, 1986);
insert into animal values ('a12', 'Whale', 445, 1990);
insert into animal values ('a13', 'White Bear', 200, 1955);
insert into animal values ('a14', 'White Bear', 220, 1990);
insert into animal values ('a15', 'Octupus', 40, 1998);
insert into animal values ('a16', 'Tarantula', 5, 1992);
insert into animal values ('a17,, 'Tarantula', 8, 1992);
insert into animal values ('a18,, 'Aligator', 60, 1944);
insert into animal values ('a19', 'Aligator', 66, 1955);
insert into animal values ('a20', 'Aligator', 77, 1966);
insert into animal values ('a21', 'Aligator', 88, 1977);
insert into animal values ('a22', 'Aligator', 43, 1989);

insert into children values ('a1','a3');
insert into children values ('a2','a3');
insert into children values ('a1','a4');
insert into children values ('a2','a4');
insert into children values ('a5','a6');
insert into children values ('a5','a7');
insert into children values ('a7','a9');
insert into children values ('a8','a9');
insert into children values ('a7','a12');
insert into children values ('a13','a14');
insert into children values ('a18','a19');
insert into children values ('a19','a20');
insert into children values ('a20','a21');
insert into children values ('a21','a22');

insert into sites values ('s1', 'Eastern Coral Reef', 'Canada', 'Arctic');
insert into sites values ('s2', 'Western Coral Reef', 'Canada', 'Arctic');
insert into sites values ('s3', 'Lapland', 'Norway', 'Arctic');
insert into sites values ('s4', 'Qua Chu', 'China', 'Humid');
insert into sites values ('s5', 'Chu Qua', 'China', 'Jungle');
insert into sites values ('s6', 'Negev', 'Israel', 'Desert');
insert into sites values ('s7', 'New Mexico', 'USA', 'Desert');

insert into research values ('r1','Rainforest Insects', 'Extinction');
insert into research values ('r2','White Bear', 'Global Warming');
insert into research values ('r3','White Bear', 'Extinction');
insert into research values ('r4','Spider Migration', 'Deforestation');
insert into research values ('r5','Whale Communication', 'Animal Language');
insert into research values ('r6','Eagle Migration', 'Deforestation');
insert into research values ('r7','Reptile Communication', 'Animal Language');

insert into events values ('a1', 's1', 'r6', 1988);
insert into events values ('a2', 's1', 'r6', 1988);
insert into events values ('a3', 's1', 'r6', 1988);
insert into events values ('a4', 's1', 'r6', 1988);
insert into events values ('a1', 's2', 'r6', 1989);
insert into events values ('a2', 's2', 'r6', 1989);
insert into events values ('a3', 's2', 'r6', 1989);
insert into events values ('a4', 's2', 'r6', 1989);
insert into events values ('a2', 's1', 'r6', 1990);
insert into events values ('a3', 's1', 'r6', 1990);
insert into events values ('a4', 's1', 'r6', 1990);
insert into events values ('a3', 's7', 'r1', 1995);
insert into events values ('a4', 's7', 'r1', 1995);
insert into events values ('a9', 's1', 'r5', 1983);
insert into events values ('a9', 's1', 'r5', 1986);
insert into events values ('a10', 's1', 'r5', 1983);
insert into events values ('a10', 's1', 'r5', 1986);
insert into events values ('a11', 's1', 'r5', 1983);
insert into events values ('a11', 's1', 'r5', 1986);
insert into events values ('a12', 's3', 'r5', 1993);
insert into events values ('a12', 's4', 'r5', 1996);
insert into events values ('a12', 's5', 'r7', 1991);
insert into events values ('a12', 's3', 'r7', 1992);
insert into events values ('a10', 's4', 'r7', 1991);
insert into events values ('a10', 's5', 'r7', 1992);
insert into events values ('a11', 's3', 'r7', 1991);
insert into events values ('a11', 's4', 'r7', 1992);
insert into events values ('a15', 's4', 'r7', 1991);
insert into events values ('a15', 's3', 'r7', 1992);
insert into events values ('a14', 's3', 'r3', 1991);
insert into events values ('a14', 's2', 'r3', 1992);
insert into events values ('a14', 's1', 'r3', 1993);
insert into events values ('a14', 's3', 'r3', 1994);
insert into events values ('a14', 's2', 'r3', 1995);
insert into events values ('a14', 's1', 'r3', 1996);
insert into events values ('a14', 's3', 'r3', 1997);
insert into events values ('a13', 's4', 'r2', 1955);
insert into events values ('a13', 's4', 'r2', 1960);
insert into events values ('a13', 's4', 'r2', 1965);
insert into events values ('a13', 's4', 'r2', 1970);
insert into events values ('a16', 's7', 'r4', 1998);
insert into events values ('a16', 's6', 'r4', 1998);
insert into events values ('a16', 's5', 'r4', 1998);
insert into events values ('a17', 's7', 'r4', 1998);
insert into events values ('a17', 's6', 'r4', 1998);
insert into events values ('a17', 's5', 'r4', 1998);
insert into events values ('a18', 's4', 'r7', 1996);
insert into events values ('a19', 's5', 'r7', 1996);
insert into events values ('a20', 's4', 'r7', 1996);
insert into events values ('a21', 's5', 'r7', 1996);
insert into events values ('a22', 's4', 'r7', 1996);
insert into events values ('a18', 's5', 'r7', 1997);
insert into events values ('a19', 's4', 'r7', 1997);
insert into events values ('a20', 's5', 'r7', 1997);
insert into events values ('a21', 's4', 'r7', 1997);
insert into events values ('a22', 's5', 'r7', 1997);
insert into events values ('a10', 's4', 'r7', 1996);
insert into events values ('a11', 's5', 'r7', 1996);
insert into events values ('a12', 's4', 'r7', 1996);

% The 'delete' command deletes records from tables.
% All tuples that answer to the 'where' condition are deleted.

delete from events where aid = 'a12' and year = 1996;

% The 'update' command changes existing records:

update animals set (size = 400) where species = 'White Bear';

% You can change the above tables as you wish. Your changes will not affect other students.

