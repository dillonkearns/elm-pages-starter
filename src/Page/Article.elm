module Page.Article exposing (view)

import Data.Author as Author
import Date exposing (Date)
import Element exposing (Element)
import Element.Font as Font
import Metadata exposing (ArticleMetadata)
import Pages
import Pages.ImagePath as ImagePath exposing (ImagePath)
import Palette


view : ArticleMetadata -> Element msg -> { title : String, body : List (Element msg) }
view metadata viewForPage =
    { title = metadata.title
    , body =
        [ Element.column [ Element.spacing 10 ]
            [ Element.row [ Element.spacing 10 ]
                [ Author.view [] metadata.author
                , Element.column [ Element.spacing 10, Element.width Element.fill ]
                    [ Element.paragraph [ Font.bold, Font.size 24 ]
                        [ Element.text metadata.author.name
                        ]
                    , Element.paragraph [ Font.size 16 ]
                        [ Element.text metadata.author.bio ]
                    ]
                ]
            ]
        , publishedDateView metadata |> Element.el [ Font.size 16, Font.color (Element.rgba255 0 0 0 0.6) ]
        , Palette.blogHeading metadata.title
        , articleImageView metadata.image
        , viewForPage
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
