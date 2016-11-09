import Array exposing (Array)
import Html.App as Html
import Dom exposing (..)
import Lens exposing (Lens)

import Counter
import Elems
import Removable

type alias Model = Array Int

app : Lens s Model -> Html s
app state =
  div []
    [ button [onClick (Lens.modify state (Array.push 0))] [text "New"]
    , Elems.elems
        state
        (Removable.removable Counter.counter)
    ]

main : Program Never
main =
  Dom.toBeginnerProgram
    (Array.fromList [0, 1, 2, 3])
    app
  |> Html.beginnerProgram
