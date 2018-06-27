let Actions = constructors < Clean : List Text | Execute : List Text | Link : List { dest : Text, src : Text }>
in
[ Actions.Clean ["~/"]
, Actions.Execute ["/bin/false"]
, Actions.Link
  [{ dest = "~/.spacemacs"
   , src = "spacemacs"
   }]
, Actions.Execute ["/bin/true"]
]
