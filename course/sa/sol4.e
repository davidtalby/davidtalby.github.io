-- System Analysis and Design Course, 1998/9
-- Exercise 4 suggested solution
-- by David Talby
--
-- The following classes are defined:
--   RECORD, TABLE, UNFILTERED_TABLE, FILTERED_TABLE
--   CONDITION, COMPARE_TO_CONSTANT_CONDITION, COMPOSITE_CONDITION, AND_CONDITION
--   STATISTIC, MEAN
-- The last class is a demonstration of all of these, named EXAMPLE_APPLICATION.

-- One record of a table. The values in every record must be comparable.
class RECORD inherit
  ARRAY[COMPARABLE]
end

-- A table is a list of records. All records must have the same number of fields.
-- Access the records through the start, item, forth, after, put and remove features.
deferred class TABLE inherit
  LIST[RECORD]
    redefine put end
feature
  put(new: RECORD) is
    require
      valid_field_count: new.count = fields_count
    deferred
    end
  fields_count: INTEGER
invariant
  same_number_of_fields: -- for all items in list, item.count = fields_count
end

-- A table implemented as a linked list of records. Note how TABLE defines many deferred
-- features (start, item, put...) and LINKED_LIST provides an implementation to all of them.
-- Dynamically set fields using put_field (which adds 0 to existing records) and remove_field.
class UNFILTERED_TABLE inherit
  TABLE
  LINKED_LIST[RECORD]
feature
  put_field is
    do
      from start until after loop
        item.put(0)
      end
      fields_count := fields_count + 1
    end
  remove_field(n: INTEGER) is
    require
      existing_field: n <= fields_count
    do
      from start until after loop
        item.remove(n)
      end
      fields_count := fields_count - 1
    end
end

-- A filtered table is a table, that contains the same fields of another table (the base table),
-- but only has part of its records - the ones that satisfy a given condition.
-- All actions on the list of records, except moving the cursor, are passed to the base table.
class FILTERED_TABLE create
  make
inherit
  TABLE redefine start, item, forth, after, put, remove end
feature
  base: TABLE
  filter: CONDITION
  put(t: RECORD)    is do base.put(t) end
  remove(t: RECORD) is do base.remove(t) end
  item: RECORD      is do Result := base.item  end
  after: BOOLEAN    is do Result := base.after end
  make(b: TABLE; f: CONDITION) is
    require
      base_valid:   b /= Void
      filter_valid: f /= Void
    do
      base := b
      filter := f
    end
  start is
    do
      base.start
      find_next_good_record
    end
  forth is
    do
      base.forth
      find_next_good_record
    end
feature {NONE}
  find_next_good_record is
    do    
      from until
        base.after or else filter.evaluate(base.item)
      loop
        base.forth
      end
    end
invariant
  item_satisfies_condition: item = Void or else evaluate(item)
end      

-- An abstract definition of any condition on a single table record.
deferred class CONDITION feature
  evaluate(r: RECORD): BOOLEAN is
    -- result of condition
    require
      record_valid: r /= Void
    deferred
    end
end

-- A condition that requires that one of the fields of the tested table record will satisfy
-- some relation with a given constant. For example, if we create c.make(2, infix ">", 100)
-- then this condition accepts only records whose 2nd field is greater than 100.
-- This class assumes that we can send routines as arguments (not yet standard Eiffel).
class COMPARE_TO_CONSTANT_CONDITION create
  make
inherit
  CONDITION redefine evaluate end
feature
  make(fld: INTEGER; comp: ROUTINE; const: COMPARABLE) is
    require
      field_valid: fld >= 1
      comp_valid:  comp /= Void
      const_valid: const /= Void
    do
      field := fld
      comparator := comp
      constant := const
    end
  evaluate(r: RECORD): BOOLEAN is
    do
      Result := comparator.call(r.item(field), constant)
    end
  field: INTEGER
  comparator: ROUTINE
  constant: COMPARABLE
end

-- Represents a condition that is a combination of other conditions. Redefine evalute_init
-- and evalute_item in descendant classes to define how to combine the boolean results from
-- each condition the class is composed of.
-- Add and remove conditions from the list by calling the put, remove, item, and so forth.
deferred class COMPOSITE_CONDITION inherit
  CONDITION redefine evaluate end
  LINKED_LIST[CONDITION]
feature
  evaluate(r: RECORD): BOOLEAN is
    do
      Result := evaluate_init
      from start until after loop
        Result := evaluate_item(Result, item, r)
      end
    end
feature {NONE}
  evaluate_init: BOOLEAN is
    do end
  evalute_item(before: CONDITION; now: CONDITION; r: RECORD): BOOLEAN is
    deferred
    end

-- A condition that is the boolean 'and' of other conditions. This is a composite condition.
class AND_CONDITION inherit
  COMPOSITE_CONDITION redefine evalute_init, evaluate_next end
feature
  evaluate_init: BOOLEAN is
    do
      Result := True
    end
  evalute_item(before: CONDITION; now: CONDITION; r: RECORD): BOOLEAN is
    do
      Result := before and now.evaluate(what)
    end
end

-- Represents any statistic that may be computed from a table. Redefine compute_init and
-- compute_item in descendant classes to define what to do with each record in the given
-- table when the statistic has to be computed.
-- 'answer' holds the last result. Its type varies for different descendant classes.
deferred class STATISTIC[G] feature
  compute(t: TABLE) is
    do
      compute_init
      from t.start until t.after loop
        compute_item(t.item)
        t.forth
      end
    end
  answer: G is
    deferred
  end
feature {NONE}
  compute_init is
    do end
  compute_item(r: RECORD) is
    deferred
  end
end

-- The mean (simple average) statistic for fields of type G. 'answer' is redefined as a variable.
class MEAN[G -> NUMERIC] create
  make
inherit
  STATISTIC redefine answer, compute_init, compute_item end
feature
  make(fld: INTEGER) is
    do
      field := fld
    end
  answer: G
  field:  INTEGER
feature {NONE}
  count:  INTEGER
  compute_init is
    do
      answer := 0
      count  := 0
    end
  compute_item(r: RECORD) is
    local
      x: G
    do
      x ?= r.item(field)
      if x /= Void then
        answer := (answer * count + x) / (count + 1)
        count  := count + 1
      end
    end
end

class EXAMPLE_APPLICATION create
  make
feature
  make is
    local
      t:  UNFILTERED_TABLE
      r:  RECORD
      c1, c2: COMPARE_TO_CONSTANT_CONDITION
      ac: AND_CONDITION
      ft: FILTERED_TABLE
      m:  MEAN[INTEGER]
    do
      -- create a table t with two fields
      create t
      t.put_field; t.put_field; t.put_field
      -- add records to it
      create r.make(3)
      r.item(1) := 2.10; r.item(2) := 100; r.item(3) := "Single";  t.put(r)
      r.item(1) := 1.70; r.item(2) := 65;  r.item(3) := "Married"; t.put(r)
      -- create a composite filter
      create c1.make(1, infix ">",  2.00)
      create c2.make(3, infix "=", "Single")
      create ac
      ac.put(c1); ac.put(c2)
      -- create a filetered table
      create ft.make(t, ac)
      -- create and calculate mean age
      create m.make(2)
      m.compute(ft)
      print(m.answer)
    end
end

