module Ssr.Attributes exposing
    ( Attribute
    , class
    , content
    , href
    , id
    , name
    , rel
    , style
    )

import Ssr.VirtualDom as VirtualDom exposing (attribute)


type alias Attribute =
    VirtualDom.Attribute


class =
    attribute "class"


id =
    attribute "id"


style =
    attribute "style"


name =
    attribute "name"


rel =
    attribute "rel"


href =
    attribute "href"


content =
    attribute "content"
