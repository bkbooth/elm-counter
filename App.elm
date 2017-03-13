module App exposing (main)

import Html exposing (Html, div, button, text, input, label, p)
import Html.Attributes exposing (id, class, value, for)
import Html.Events exposing (onClick, onInput)


main : Program Never Model Msg
main =
    Html.program
        { init = initialModel
        , update = update
        , subscriptions = subscriptions
        , view = rootView
        }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment amount ->
            ( { model | counter = model.counter + amount }
            , Cmd.none
            )

        Decrement amount ->
            ( { model | counter = model.counter - amount }
            , Cmd.none
            )

        UpdateAmount newAmount ->
            let
                parsed =
                    String.toInt newAmount
            in
                case parsed of
                    Ok value ->
                        ( { model | amount = value }
                        , Cmd.none
                        )

                    Err _ ->
                        ( model, Cmd.none )



-- VIEW


rootView : Model -> Html Msg
rootView model =
    div [ id "app-root" ]
        [ p []
            [ text ("Counter is... " ++ (toString model.counter)) ]
        , p []
            [ label [ for "amount" ] [ text "Amount " ]
            , input [ onInput UpdateAmount, value (toString model.amount), id "amount" ] []
            ]
        , p []
            [ button [ onClick (Increment model.amount) ] [ text "Increment" ]
            , button [ onClick (Decrement model.amount) ] [ text "Decrement" ]
            ]
        ]



-- MODEL


type alias Model =
    { counter : Int
    , amount : Int
    }


initialModel : ( Model, Cmd Msg )
initialModel =
    ( Model 0 1
    , Cmd.none
    )


type Msg
    = Increment Int
    | Decrement Int
    | UpdateAmount String



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
