module Lens exposing (..)

import Array exposing (Array)
import String

type alias Lens a b =
  { get: a -> b
  , modify: (b -> b) -> a -> a
  }

get : Lens s a -> s -> a
get l = l.get

modify : Lens s a -> (a -> a) -> s -> s
modify l = l.modify

set : Lens s a -> a -> s -> s
set saL a = modify saL (always a)

lens : (a -> b) -> (b -> a -> a) -> Lens a b
lens get set =
  { get = get
  , modify = \b2b a -> set (b2b (get a)) a
  }

iso : (a -> b) -> (b -> a) -> Lens a b
iso a2b b2a = lens a2b (b2a >> always)

(>>>) : Lens a b -> Lens b c -> Lens a c
(>>>) abL bcL =
  { get = abL.get >> bcL.get
  , modify = bcL.modify >> abL.modify
  }

identity : Lens a a
identity = { get = Basics.identity, modify = \a2a a -> a2a a }

index : Int -> Lens (Array a) (Maybe a)
index i =
  { get = Array.get i
  , modify = \x2x xs ->
     case Array.get i xs of
       Nothing -> xs
       x       -> Array.append
                    (Array.slice 0 i xs
                     |> case x2x x of
                          Just x  -> Array.push x
                          Nothing -> Basics.identity)
                    (Array.slice (i+1) (Array.length xs) xs)
  }

withDefault : b -> Lens a (Maybe b) -> Lens a b
withDefault b abML =
  { get = abML.get >> Maybe.withDefault b
  , modify = \b2b -> abML.modify (\bM -> Just (b2b (Maybe.withDefault b bM)))
  }

intAsString : Lens Int String
intAsString =
  iso toString
      (\s -> case String.toInt s of
               Ok i -> i
               Err _ -> 0)
