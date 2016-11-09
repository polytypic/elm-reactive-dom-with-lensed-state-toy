module BMI exposing (..)

import Dom exposing (..)
import Lens exposing (Lens, (>>>))
import Slider

type alias Model = {height: Int, weight: Int}

init : Model
init = {height = 180, weight = 80}

height : Lens {d | height: c} c
height = Lens.lens .height (\v s -> {s | height = v})

weight : Lens {d | weight: c} c
weight = Lens.lens .weight (\v s -> {s | weight = v})

bmi : Lens m Model -> Html m
bmi state =
  div []
    [ Slider.slider {min = 140, max = 210, title = "Height"} (state >>> height)
    , Slider.slider {min = 40,  max = 140, title = "Weight"} (state >>> weight)
    , div []
       [ text "bmi: "
       , state
         |> withState (\s ->
              text (toString (round (toFloat s.weight / (toFloat (s.height * s.height) * 0.0001))))) ]
    ]
