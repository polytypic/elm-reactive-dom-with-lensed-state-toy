import Array exposing (Array)
import Html.App as Html

import Dom exposing (..)
import Lens exposing (Lens, (>>>))

import BMI exposing (bmi)
import Counter exposing (counter)
import ElemsWithAdd exposing (elemsWithAdd)
import Removable exposing (removable)

type alias Model =
  { bmis: Array BMI.Model
  , counters: Array Int
  }

init : Model
init =
  { bmis = Array.fromList [BMI.init]
  , counters = Array.fromList [0, 1, 2, 3]
  }

app : Lens s Model -> Html s
app state =
  div []
    [ elemsWithAdd (removable bmi)     BMI.init (state >>> bmisL)
    , elemsWithAdd (removable counter) 0        (state >>> countersL)
    ]

main : Program Never
main =
  Dom.toBeginnerProgram init app
  |> Html.beginnerProgram

-- The following code could easily be compiler generated
-- See: https://groups.google.com/d/msg/elm-dev/gFyQtgMlqrs/Ws6Ih8mFAwAJ

bmisL : Lens {d | bmis: c} c
bmisL = Lens.lens .bmis (\v s -> {s | bmis = v})

countersL : Lens {d | counters: c} c
countersL = Lens.lens .counters (\v s -> {s | counters = v})
