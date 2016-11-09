module Dom exposing (..)

import Lens exposing (Lens)
import Html
import Html.Events as Events

--

type alias Msg m = m -> m

type alias Html m = m -> Html.Html (Msg m)

type alias Attribute m = m -> Html.Attribute (Msg m)

--

liftElem : (List (Html.Attribute (Msg m)) -> List (Html.Html (Msg m)) -> Html.Html (Msg m)) ->
            List (     Attribute      m)  -> List (     Html      m) ->       Html      m
liftElem html attrs htmls m =
  html (attrs |> List.map (\attr -> attr m))
       (htmls |> List.map (\html -> html m))

liftAttr : Html.Attribute (Msg m) ->
                Attribute      m
liftAttr attr = always attr

--

toBeginnerProgram : m -> (Lens m m -> Html m) -> { model: m, view: m -> Html.Html (Msg m), update: Msg m -> m -> m }
toBeginnerProgram m html =
  { model = m
  , view = html Lens.identity
  , update = \u m -> u m
  }

--

text : String -> Html m
text s = always (Html.text s)

view : Lens m String -> Html m
view msL = Lens.get msL >> Html.text

viewAs : (a -> String) -> Lens m a -> Html m
viewAs a2s maL = Lens.get maL >> a2s >> Html.text

--

withState : (a -> Html m) -> Lens m a -> Html m
withState a2mH maL m = a2mH (Lens.get maL m) m

--

button : List (Attribute m) -> List (Html m) -> Html m
button = liftElem Html.button

div : List (Attribute m) -> List (Html m) -> Html m
div = liftElem Html.div

input : List (Attribute m) -> List (Html m) -> Html m
input = liftElem Html.input

span : List (Attribute m) -> List (Html m) -> Html m
span = liftElem Html.span

--

onClick : Msg m -> Attribute m
onClick msg = always (Events.onClick msg)
