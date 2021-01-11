module Template.Article exposing (Model, Msg, template)

import Data.Author as Author
import Date exposing (Date)
import Element exposing (Element)
import Element.Font as Font
import Head
import Head.Seo as Seo
import Metadata exposing (Article)
import Pages
import Pages.ImagePath as ImagePath exposing (ImagePath)
import Pages.PagePath exposing (PagePath)
import Palette
import Shared
import Template exposing (StaticPayload, Template)
import TemplateType exposing (TemplateType)


type alias Model =
    ()


type alias Msg =
    Never


type alias StaticData =
    ()


template : Template Article StaticData
template =
    Template.noStaticData { head = head }
        |> Template.buildNoState { view = view }


head :
    StaticPayload Article StaticData
    -> List (Head.Tag Pages.PathKey)
head { metadata } =
    Seo.summaryLarge
        { canonicalUrlOverride = Nothing
        , siteName = "elm-pages starter"
        , image =
            { url = metadata.image
            , alt = metadata.description
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = metadata.description
        , locale = Nothing
        , title = metadata.title
        }
        |> Seo.article
            { tags = []
            , section = Nothing
            , publishedTime = Just (Date.toIsoString metadata.published)
            , modifiedTime = Nothing
            , expirationTime = Nothing
            }


view :
    List ( PagePath Pages.PathKey, TemplateType )
    -> StaticPayload Article StaticData
    -> Shared.RenderedBody
    -> Shared.PageView Never
view allMetadata static rendered =
    { title = static.metadata.title
    , body =
        [ Element.column [ Element.spacing 10 ]
            [ Element.row [ Element.spacing 10 ]
                [ Author.view [] static.metadata.author
                , Element.column [ Element.spacing 10, Element.width Element.fill ]
                    [ Element.paragraph [ Font.bold, Font.size 24 ]
                        [ Element.text static.metadata.author.name
                        ]
                    , Element.paragraph [ Font.size 16 ]
                        [ Element.text static.metadata.author.bio ]
                    ]
                ]
            ]
        , publishedDateView static.metadata |> Element.el [ Font.size 16, Font.color (Element.rgba255 0 0 0 0.6) ]
        , Palette.blogHeading static.metadata.title
        , articleImageView static.metadata.image
        , rendered
        ]
    }


publishedDateView : { a | published : Date } -> Element msg
publishedDateView metadata =
    Element.text
        (metadata.published
            |> Date.format "MMMM ddd, yyyy"
        )


articleImageView : ImagePath Pages.PathKey -> Element msg
articleImageView articleImage =
    Element.image [ Element.width Element.fill ]
        { src = ImagePath.toString articleImage
        , description = "Article cover photo"
        }
