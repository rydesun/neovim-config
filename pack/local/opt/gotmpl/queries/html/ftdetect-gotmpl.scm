[
  ((text) @_
    (#match? @_ "^\\{\\{")
    (#match? @_ "\\}\\}$"))
  (
    (text) @a
    (#match? @a "^\\{\\{")
    (text) @b
    (#match? @b "\\}\\}$")
  )
  ((attribute_value) @_
    (#match? @_ "^\\{\\{"))
]
