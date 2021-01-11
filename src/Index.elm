module Index exposing (view)

import Data.Author
import Date
import Element exposing (Element)
import Element.Border
import Element.Font
import Metadata
import Pages
import Pages.PagePath as PagePath exposing (PagePath)
import TemplateType exposing (TemplateType)


type alias PostEntry =
    ( PagePath Pages.PathKey, Metadata.Article )


view :
    List ( PagePath Pages.PathKey, TemplateType )
    -> Element msg
view posts =
    Element.column [ Element.spacing 20 ]
        (posts
            |> List.filterMap
                (\( path, metadata ) ->
                    case metadata of
                        TemplateType.Page meta ->
                            Nothing

                        TemplateType.Article meta ->
                            if meta.draft then
                                Nothing

                            else
                                Just ( path, meta )

                        TemplateType.BlogIndex _ ->
                            Nothing
                )
            |> List.sortWith postPublishDateDescending
            |> List.map postSummary
        )


postPublishDateDescending : PostEntry -> PostEntry -> Order
postPublishDateDescending ( _, metadata1 ) ( _, metadata2 ) =
    Date.compare metadata2.published metadata1.published


postSummary : PostEntry -> Element msg
postSummary ( postPath, post ) =
    articleIndex post
        |> linkToPost postPath


linkToPost : PagePath Pages.PathKey -> Element msg -> Element msg
linkToPost postPath content =
    Element.link [ Element.width Element.fill ]
        { url = PagePath.toString postPath, label = content }


title : String -> Element msg
title text =
    [ Element.text text ]
        |> Element.paragraph
            [ Element.Font.size 36
            , Element.Font.center
            , Element.Font.family [ Element.Font.typeface "Raleway" ]
            , Element.Font.semiBold
            , Element.padding 16
            ]


articleIndex : Metadata.Article -> Element msg
articleIndex metadata =
    Element.el
        [ Element.centerX
        , Element.width (Element.maximum 800 Element.fill)
        , Element.padding 40
        , Element.spacing 10
        , Element.Border.width 1
        , Element.Border.color (Element.rgba255 0 0 0 0.1)
        , Element.mouseOver
            [ Element.Border.color (Element.rgba255 0 0 0 1)
            ]
        ]
        (postPreview metadata)


readMoreLink : Element msg
readMoreLink =
    Element.text "Continue reading >>"
        |> Element.el
            [ Element.centerX
            , Element.Font.size 18
            , Element.alpha 0.6
            , Element.mouseOver [ Element.alpha 1 ]
            , Element.Font.underline
            , Element.Font.center
            ]


postPreview : Metadata.Article -> Element msg
postPreview post =
    Element.textColumn
        [ Element.centerX
        , Element.width Element.fill
        , Element.spacing 30
        , Element.Font.size 18
        ]
        [ title post.title
        , Element.row [ Element.spacing 10, Element.centerX ]
            [ Data.Author.view [ Element.width (Element.px 40) ] post.author
            , Element.text post.author.name
            , Element.text "•"
            , Element.text (post.published |> Date.format "MMMM ddd, yyyy")
            ]
        , post.description
            |> Element.text
            |> List.singleton
            |> Element.paragraph
                [ Element.Font.size 22
                , Element.Font.center
                , Element.Font.family [ Element.Font.typeface "Raleway" ]
                ]
        , readMoreLink
        ]
