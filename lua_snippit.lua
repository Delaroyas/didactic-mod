-- Snippets in lua programming
-- This file is not called it it just here as a learning/reminder tool

--1
-- A useful Lua idiom is x = x or v, which is equivalent to
  if not x then x = v end
  
--2 
--Lua allows multiple assignment, where a list of values is assigned to
--a list of variables in one step. Both lists have their elements
--separated by commas. For instance, in the assignment
  a, b = 10, 2*x
--the variable a gets the value 10 and b gets 2*x.
--In a multiple assignment, Lua first evaluates all values and only then
--executes the assignments. Therefore, we can use a multiple assignment
--to swap two values, as in
  x, y = y, x                -- swap `x' for `y'
  a[i], a[j] = a[j], a[i]    -- swap `a[i]' for `a[j]'
  
  
