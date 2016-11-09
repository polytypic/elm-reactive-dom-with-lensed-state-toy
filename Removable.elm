module Removable exposing (..)

import Dom exposing (..)
import Lens exposing (Lens)

removable : (Lens m a -> Html m) -> Lens m (Maybe a) -> a -> Html m
removable elem state default =
  div []
    [ elem (Lens.withDefault default state)
    , button [onClick (Lens.set state Nothing)] [text "x"]
    ]
