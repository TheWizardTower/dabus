# dabus

This is hopefully going to become a dotfiles manager, ala dotbot, but in Haskell, using Dhall for a configuration language.

Right now, it compiles, but does not run.

Steps to reproduce:

```
stack build
stack exec dabus -- --file ./dabus.dhall
```

observe the errors. For reference, this is what I get on my machine:

```
stack exec dabus -- --file ./dabus.dhall
Starting Greet function.
dabus: 
Error: Expression doesn't match annotation

./dabus.dhall : { foo : Natural, bar : List Double }

(input):1:1
```
