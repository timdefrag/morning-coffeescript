
objType = require('./objtype').objType

( do ->
  console.log "Test '#{testName}': "
  testFn() ) \
for testName, testFn of \
  'objType' : ->
    failed = 0
    ( do ->
      pass = objType(val) == type
      unless pass then failed++
      console.log "- #{type} :: #{ if pass then 'Pass' else 'Fail' }" ) \
    for type, val of \
      'String'     :  '"Hello World"',
      'Number'     :  3.1415,
      'Function'   :  (some, args) -> 'some value',
      'Object'     :  { obj: 'with', some: 'props' },
      'Array'      :  [ 'some', 'array', 'elements' ],
      'Arguments'  :  arguments,
      'Date'       :  new Date(),
      'RegExp'     :  /^(?:[-=]>|[-+*\/%<>&|^!?=]=|>>>=?)/,
      'Null'       :  null,
      'Undefined'  :  this.IDoNotExist
  
