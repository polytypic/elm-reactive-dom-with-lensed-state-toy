module Dom exposing (..)

import Lens exposing (Lens)
import Html
import Html.Attributes
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

textL : Lens m String -> Html m
textL msL = Lens.get msL >> Html.text

textAs : (a -> String) -> Lens m a -> Html m
textAs a2s maL = Lens.get maL >> a2s >> Html.text

--

withState : (a -> m -> r) -> Lens m a -> m -> r
withState a2r maL m = a2r (Lens.get maL m) m

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

onInput : (String -> Msg m) -> Attribute m
onInput s2m = always (Events.onInput s2m)

--

type' : String -> Attribute m
type' = Html.Attributes.type' >> liftAttr

valueL : Lens m String -> Attribute m
valueL msL = Lens.get msL >> Html.Attributes.value

disabledAs : (a -> Bool) -> Lens m a -> Attribute m
disabledAs a2b maL = Lens.get maL >> a2b >> Html.Attributes.disabled

min : String -> Attribute m
min = Html.Attributes.min >> liftAttr

max : String -> Attribute m
max = Html.Attributes.max >> liftAttr
