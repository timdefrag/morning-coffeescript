# objType -- Helper, returns the type name part of a toString call
objType = (obj) -> 
  str = {}.toString.call(obj)
  str.substring(8, str.length-1)

# Verify that objType returns the proper value for each JS object type.
test_objType = () ->
  return "objType: failed on type '#{type}'" unless objType(value) is type \
    for type, val of \
      'String'     :  'Hello World'
      'Number'     :  3.14
      'Function'   :  (some, args) -> 'some value'
      'Object'     :  { obj: 'with', some: 'props' }
      'Array'      :  [ 'some', 'array', 'elements' ]
      'Null'       :  null
      'Undefined'  :  IDoNotExist.___Hopefully
  true