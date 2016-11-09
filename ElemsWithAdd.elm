module ElemsWithAdd exposing (..)

import Array exposing (Array)
import Dom exposing (..)
import Lens exposing (..)
import Elems

elemsWithAdd : (Lens m (Maybe a) -> a -> Html m) -> a -> Lens m (Array a) -> Html m
elemsWithAdd elem new values =
  div []
   [ button [onClick (Lens.modify values (Array.push new))] [text "New"]
   , Elems.elems elem values
   ]
