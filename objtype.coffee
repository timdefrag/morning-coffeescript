###
  Playing around with type detection helpers, looking for nice solutions.
  
  
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
        I am not sure what this does other than lower-case the type name. 
      The CS Cookbook guys say it's based on jQuery's implementation, so I am
      probably being stupid. In any case, it's not very aesthetically pleasing.
  
  
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
      as many letters as the string check would. Also, is it just me, or does
      this implementation re-allocate the '[object Type]' bit each time it's
      called? Would a clever interpreter cache that expression?
  
  
  My Implementation
  --------------------------
    
    Thoughts:
        Favors form over speed (no native checks, substring allocates a string),
      but for time-insensitive apps it feels very general and elegant; small
      enough to include inline without distracting from application logic. ###


module.exports.objType =
objType = (obj) -> 
  str = Object.prototype.toString.call(obj)
  str.substring(8, str.length-1)


module.exports.test_objType =
test_objType =  (unused, args) ->
  return "objType: failed on type '#{type}'" unless objType(value) is type \
    for type, val of \
      'String'     :  'Hello World'
      'Number'     :  3.1415
      'Function'   :  (some, args) -> 'some value'
      'Object'     :  { obj: 'with', some: 'props' }
      'Array'      :  [ 'some', 'array', 'elements' ]
      'Arguments'  :  arguments
      'Date'       :  new Date()
      'RegExp'     :  /^(?:[-=]>|[-+*\/%<>&|^!?=]=|>>>=?/
      'Null'       :  null
      'Undefined'  :  IDoNotExist
  true
  
  