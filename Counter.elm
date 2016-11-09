module Counter exposing (..)

import Dom exposing (..)
import Lens exposing (Lens)

counter : Lens m Int -> Html m
counter value =
  div []
    [ button [onClick (Lens.modify value ((+) -1))] [text "-"]
    , textAs toString value
    , button [onClick (Lens.modify value ((+)  1))] [text "+"]
    ]
