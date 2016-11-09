module Slider exposing (..)

import Dom exposing (..)
import Lens exposing (Lens, (>>>))

slider : {min: Int, max: Int, title: String} -> Lens m Int -> Html m
slider {min, max, title} value =
  div []
    [ div []
        [ text title
        , text ": "
        , textAs toString value
        ]
    , button [ onClick (Lens.modify value ((+) -1))
             , disabledAs ((==) min) value
             ]
        [text "-"]
    , input [ type' "range"
            , Dom.min (toString min)
            , Dom.max (toString max)
            , valueL (value >>> Lens.intAsString)
            , onInput (Lens.set (value >>> Lens.intAsString))
            ]
        []
    , button [ onClick (Lens.modify value ((+) 1))
             , disabledAs ((==) max) value
             ]
        [text "+"]
    ]
