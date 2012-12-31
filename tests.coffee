# Run tests for the random crap in this workspace.

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