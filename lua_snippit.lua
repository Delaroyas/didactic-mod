-- Snippets in lua programming
-- This file is not called it it just here as a learning/reminder tool

--1
-- A useful Lua idiom is 
x = x or v  
--which is equivalent to
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

--3  
  -- Repeat statememt. 
  -- Like a while, 
  --   but condition is checked at the end
  --   stops when condition is TRUE (not false)
  --   Always executed at least once.
  repeat
    stuff
  until test == true'


--4
-- unpack
-- A special function with multiple returns is unpack. 
--It receives an array and returns as results all elements from the array, starting from index 1:
    print(unpack{10,20,30})    --> 10   20   30
    a,b = unpack{10,20,30}     -- a=10, b=20, 30 is discarded
--An important use for unpack is in a generic call mechanism. 
--A generic call mechanism allows you to call any function, with any arguments, dynamically.

--5
-- Variable number of inputs
--We can write this new function in Lua as follows:
    function myfun (...)
      -- All inputs are stored in a hidden variable named "arg"
      for i,v in ipairs(arg) do 
        wathever
      end
  end
  -- A function may have regular parameters before the dots.
   function g (a, b, ...) 
      -- a = a
      -- b = b 
      -- additionnal input variables are 
      -- stored in a hidden variable named "arg"
  end
  
  
--6 Max
  table.maxn ({1, 3, 2}) --> 3
--Returns the largest positive numerical index of the given table,
