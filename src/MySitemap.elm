module MySitemap exposing (build)

import Pages
import Pages.PagePath as PagePath exposing (PagePath)
import Sitemap
import TemplateType exposing (TemplateType(..))


build :
    { siteUrl : String
    }
    ->
        List
            { path : PagePath Pages.PathKey
            , frontmatter : TemplateType
            , body : String
            }
    ->
        { path : List String
        , content : String
        }
build config siteMetadata =
    { path = [ "sitemap.xml" ]
    , content =
        Sitemap.build config
            (siteMetadata
                |> List.filter
                    (\page ->
                        case page.frontmatter of
                            Article articleData ->
                                not articleData.draft

                            _ ->
                                True
                    )
                |> List.map
                    (\page ->
                        { path = PagePath.toString page.path, lastMod = Nothing }
                    )
            )
    }
