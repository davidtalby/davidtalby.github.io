/* Database Course, 1996/7
   Practical Exercise 1 - Queries

   by David Talby, 03426435-16, davidt
*/


/* Answer 1 */
select distinct sh1.p#, sh2.p#
  from shipments sh1, shipments sh2
  where sh1.p# <> sh2.p#
    and sh1.s# =  sh2.s#;

 
/* Answer 2 */
select p.p#
  from  parts p, parts p4
  where p4.p# = 'p4'
    and p.weight > p4.weight;


/* Answer 3 */
select j.j#
  from  projects j
  where not exists
        (select *
           from  shipments sh, parts p 
           where sh.j# = j.j#
             and sh.p# = p.p#
             and (not (p.color = 'red')) );


/* Answer 4 */
select distinct p.color
  from  parts p
  where p.color not in
        (select p2.color
           from  parts p2, shipments sh
           where sh.p# =  p2.p#
             and sh.s# <> 's5' );


/* Answer 5 */
select j.jname
  from  projects j
  where not exists
        (select *
           from  suppliers sp
           where sp.city = j.city);


/* Answer 6 */
select sp.s# 
  from  suppliers sp
  where exists
        (select *
           from  parts p
           where not exists
                 (select *
                    from  projects j
                    where not exists
                          (select *
                             from  shipments sh
                             where (sh.s# = sp.s#)
                               and (sh.p# = p.p#)
                               and (sh.j# = j.j#)
                          )
                 )
        );

/* Answer 7 */
select avg(status), max(status), min(status)
  from suppliers;

/* Answer 8 */
select count(distinct p#) / count(distinct j#) p_per_j
  from projects, parts;
