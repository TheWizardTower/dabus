{ defaults = [] : Optional (List Bool)

, conf =
let Actions = constructors < Clean : { _1: List Text } | Execute : { _1: List Text } | Link : { _1: List { dest : Text, src : Text } } >
in
[ Actions.Clean { _1 = ["~/"]}
, Actions.Execute { _1 = ["/bin/false"] }
, Actions.Link { _1 =
  [{ dest = "~/.spacemacs"
   , src = "spacemacs"
   }]}
, Actions.Execute { _1 = ["/bin/true"] }
]
}