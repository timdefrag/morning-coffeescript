### Playing around with type detection helpers, looking for nice solutions.
  
  
The CoffeeScript CookBook Way
-----------------------------

  Code (CoffeeScript):
    typeIsArray = Array.isArray || ( value ) -> return {}.toString.call( value ) is '[object Array]'
    type = (obj) ->
      if obj == undefined or obj == null
        return String obj
      classToType = new Object
      for name in "Boolean Number String Function Array Date RegExp".split(" ")
        classToType["[object " + name + "]"] = name.toLowerCase()
      myClass = Object.prototype.toString.call obj
      if myClass of classToType
        return classToType[myClass]
      return "object"
  
  Thoughts:
        In 'typeIsArray', Doesn't '{}' allocate a new object? They use
    'Object.prototype' in the general 'type' func. Also, it looks like 'type'
    uses a lot of special cases (null check, undefined check) and
    wasted effort:
      - Split the types string;
      - Allocate/populate 'classToType';
      - Key look-up on 'classToType' ('of');
      - Value look-up on 'classToType' ('...[myClass]')
    to essentially '.toLowerCase' the class name; is this a Microsoft hack-job?
    The CS Cookbook guys say it's based on jQuery's implementation, so I may be
    missing something. In any case, it's not very aesthetically pleasing.


The Underscore.JS Way
---------------------
  
  Code (JS):
    _.isArray = nativeIsArray || function(obj) {
      return toString.call(obj) == '[object Array]';
    };
    _.isObject = function(obj) {
      return obj === Object(obj);
    };
    each(['Arguments', 'Function', 'String', 'Number', 'Date', 'RegExp'], function(name) {
      _['is' + name] = function(obj) {
        return toString.call(obj) == '[object ' + name + ']';
      };
    });
  
  Thoughts:
        Creating individual checkers feels hefty, as the function name uses
    as many letters as the string check would. Does this implementation
    re-concatenate the '[object Type]' bit each time it's called? Would a
    clever interpreter cache that expression? I think, being a closure, it
    has to assume 'name' could be a pointer, and re-build the string each run.


My Implementation
--------------------------
  
  Thoughts:
        Favors form over speed (no native checks, substring allocates a
    string), but feels very general and elegant; small enough to include inline
    without distracting from application logic.
        Additionally, I think if you're at the point where you need to
    switch to native type-checks for efficiency, you should either re-imagine
    your algorithm, or explicitly call the native funcs to obviate it's
    performance-critical nature.  ###


module.exports.objType =
  
objType = (obj) -> 
  str = Object.prototype.toString.call(obj)
  str.substring(8, str.length-1)

  
  