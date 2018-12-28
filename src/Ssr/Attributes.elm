module Ssr.Attributes exposing
    ( Attribute
    , attribute
    , class
    , content
    , href
    , id
    , name
    , rel
    , src
    , style
    )

import Ssr.VirtualDom as VirtualDom exposing (attribute)


type alias Attribute =
    VirtualDom.Attribute


attribute =
    VirtualDom.attribute


class =
    attribute "class"


id =
    attribute "id"


style =
    attribute "style"


src =
    attribute "src"


name =
    attribute "name"


rel =
    attribute "rel"


href =
    attribute "href"


content =
    attribute "content"
