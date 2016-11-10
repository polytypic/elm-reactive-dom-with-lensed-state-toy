module Dom exposing (..)

import Html
import Html.Attributes
import Html.Events as Events
import Lens exposing (Lens)

--

type alias Msg model = model -> model

type alias Html model = model -> Html.Html (Msg model)

type alias Attribute model = model -> Html.Attribute (Msg model)

--

toBeginnerProgram : model
                    -> (Lens model model -> Html model)
                    -> { model: model
                       , view: model -> Html.Html (Msg model)
                       , update: Msg model -> model -> model
                       }
toBeginnerProgram model dom =
  { model = model
  , view = dom Lens.identity
  , update = Basics.identity
  }

--

withState : (a -> m -> r) -> Lens m a -> m -> r
withState a2r maL m = a2r (Lens.get maL m) m

--

liftElem : (List (Html.Attribute (Msg m)) -> List (Html.Html (Msg m)) -> Html.Html (Msg m)) ->
            List (     Attribute      m)  -> List (     Html      m) ->       Html      m
liftElem html attrs htmls m =
  html (attrs |> List.map (\attr -> attr m))
       (htmls |> List.map (\html -> html m))

--

text : String -> Html m
text = Html.text >> always

textL : Lens m String -> Html m
textL msL = Lens.get msL >> Html.text

textAs : (a -> String) -> Lens m a -> Html m
textAs a2s maL = Lens.get maL >> a2s >> Html.text

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
onClick = Events.onClick >> always

onInput : (String -> Msg m) -> Attribute m
onInput = Events.onInput >> always

--

type' : String -> Attribute m
type' = Html.Attributes.type' >> always

valueL : Lens m String -> Attribute m
valueL msL = Lens.get msL >> Html.Attributes.value

disabledAs : (a -> Bool) -> Lens m a -> Attribute m
disabledAs a2b maL = Lens.get maL >> a2b >> Html.Attributes.disabled

min : String -> Attribute m
min = Html.Attributes.min >> always

max : String -> Attribute m
max = Html.Attributes.max >> always
