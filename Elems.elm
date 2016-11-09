module Elems exposing (..)

import Array exposing (Array)
import Dom exposing (..)
import Lens exposing (..)

elems : Lens m (Array a) -> (Lens m (Maybe a) -> a -> Html m) -> Html m
elems values elem =
  values
  |> withState
       (Array.indexedMap (\i -> elem (values >>> Lens.index i))
        >> Array.toList
        >> div [])
