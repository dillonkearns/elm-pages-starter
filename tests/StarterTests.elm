module StarterTests exposing (suite)

{-| Smoke tests for the elm-pages-starter routes.

Run: `npx elm-pages test`
View in browser: `npm start`, then visit `/_tests`

-}

import Json.Encode as Encode
import Test.BackendTask as BackendTaskTest
import Test.Html.Selector as Selector
import Test.PagesProgram as PagesProgram
import TestApp


suite : PagesProgram.Test
suite =
    PagesProgram.describe "elm-pages-starter"
        [ PagesProgram.describe "Landing page"
            [ PagesProgram.test "renders the running headline"
                (TestApp.start "/" BackendTaskTest.init)
                [ PagesProgram.ensureViewHas
                    [ Selector.tag "h1"
                    , Selector.containing [ Selector.text "elm-pages is up and running!" ]
                    ]
                ]
            , PagesProgram.test "links to the hello blog post"
                (TestApp.start "/" BackendTaskTest.init)
                [ PagesProgram.ensureViewHas
                    [ Selector.tag "a", Selector.containing [ Selector.text "My blog post" ] ]
                ]
            ]
        , PagesProgram.describe "Hello (server-rendered)"
            [ PagesProgram.test "renders the GitHub star count from the API"
                (TestApp.start "/hello" BackendTaskTest.init)
                [ PagesProgram.simulateHttpGet
                    "https://api.github.com/repos/dillonkearns/elm-pages"
                    (Encode.object [ ( "stargazers_count", Encode.int 1234 ) ])
                , PagesProgram.ensureViewHas [ Selector.text "1234" ]
                ]
            ]
        ]
