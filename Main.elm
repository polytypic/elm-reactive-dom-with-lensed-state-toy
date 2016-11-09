import Array exposing (Array)
import Html.App as Html
import Dom exposing (..)
import Lens exposing (Lens, (>>>))

import Counter
import Elems
import Removable
import BMI

type alias Model =
  { bmi: BMI.Model
  , counters: Array Int
  }

bmi : Lens { d | bmi : c } c
bmi = Lens.lens .bmi (\v s -> {s | bmi = v})

counters : Lens { d | counters : c } c
counters = Lens.lens .counters (\v s -> {s | counters = v})

init : Model
init =
  { bmi = BMI.init
  , counters = Array.fromList [0, 1, 2, 3]
  }

app : Lens s Model -> Html s
app state =
  div []
    [ BMI.bmi (state >>> bmi)
    , button [onClick (Lens.modify (state >>> counters) (Array.push 0))] [text "New"]
    , Elems.elems
        (state >>> counters)
        (Removable.removable Counter.counter)
    ]

main : Program Never
main =
  Dom.toBeginnerProgram init app
  |> Html.beginnerProgram
