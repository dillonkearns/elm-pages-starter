module Palette exposing (blogHeading, color, focusStyleShadow, heading, link, newTabLink)

import Color exposing (Color)
import Element exposing (Element)
import Element.Border
import Element.Font as Font
import Element.Region


color =
    { primary = Element.rgb255 5 117 230
    , secondary = Element.rgb255 0 242 96
    }


{-| A box-shadow record, compatible both with `Element.layoutWith` Option and `Element.focusStyle`.

For buttons, links and other interactables, we set focus styles
We use a box-shadow instead of an outline, because it follows borders.

Blue works well in this particular case.
You might want to customise this for your application.

Bear in mind that focus outlines should not be removed altogether,
because they are used by people who rely on keyboard and/or screen reader navigation.
They should also have a good color contrast with the background.

-}
focusStyleShadow =
    { color = color.primary
    , offset = ( 0, 0 )
    , blur = 0
    , size = 2
    }


{-| A composable `Element.link` that bakes in focus styles.

We need this for consistent / good-by-default styles and accessibility.
This might change in the future, if elm-ui supports setting focus globally via layoutWith.

See the notes in focusStyleShadow for more on accessibility and styling.

-}
link :
    List (Element.Attribute msg)
    ->
        { url : String
        , label : Element msg
        }
    -> Element msg
link attrs content =
    Element.link
        (Element.focused
            [ Element.Border.shadow focusStyleShadow
            ]
            :: attrs
        )
        content


{-| A composable `Element.newTabLink` that bakes in focus styles.
-}
newTabLink :
    List (Element.Attribute msg)
    ->
        { url : String
        , label : Element msg
        }
    -> Element msg
newTabLink attrs content =
    Element.newTabLink
        (Element.focused
            [ Element.Border.shadow focusStyleShadow
            ]
            :: attrs
        )
        content


heading : Int -> List (Element msg) -> Element msg
heading level content =
    Element.paragraph
        ([ Font.bold
         , Font.family [ Font.typeface "Raleway" ]
         , Element.Region.heading level
         ]
            ++ (case level of
                    1 ->
                        [ Font.size 36 ]

                    2 ->
                        [ Font.size 24 ]

                    _ ->
                        [ Font.size 20 ]
               )
        )
        content


blogHeading : String -> Element msg
blogHeading title =
    Element.paragraph
        [ Font.bold
        , Font.family [ Font.typeface "Raleway" ]
        , Element.Region.heading 1
        , Font.size 36
        , Font.center
        ]
        [ Element.text title ]
