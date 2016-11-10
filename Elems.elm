module Elems exposing (..)

import Array exposing (Array)
import Dom exposing (..)
import Lens exposing (Lens, (>>>))

elems : (Lens m (Maybe a) -> a -> Html m) -> Lens m (Array a) -> Html m
elems elem values =
  values
  |> withState
       (Array.indexedMap (\i -> elem (values >>> Lens.index i))
        >> Array.toList
        >> div [])
