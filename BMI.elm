module BMI exposing (..)

import Dom exposing (..)
import Lens exposing (Lens, (>>>))
import Slider exposing (slider)

type alias Model = {height: Int, weight: Int}

init : Model
init = {height = 180, weight = 80}

bmi : Lens m Model -> Html m
bmi state =
  div []
    [ slider {min = 140, max = 210, title = "Height"} (state >>> heightL)
    , slider {min = 40,  max = 140, title = "Weight"} (state >>> weightL)
    , div []
       [ text "bmi: "
       , state
         |> withState (\{height, weight} ->
              text (toString (round (toFloat weight / (toFloat (height * height) * 0.0001)))))
       ]
    ]

-- The following code could easily be compiler generated
-- See: https://groups.google.com/d/msg/elm-dev/gFyQtgMlqrs/Ws6Ih8mFAwAJ

heightL : Lens {d | height: c} c
heightL = Lens.lens .height (\v s -> {s | height = v})

weightL : Lens {d | weight: c} c
weightL = Lens.lens .weight (\v s -> {s | weight = v})
