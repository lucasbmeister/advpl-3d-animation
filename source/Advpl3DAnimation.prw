#include 'totvs.ch'
#include 'gameadvpl.ch'

/*{Protheus.doc} Main Function Animation3D()
Realiza a rotação de um cubo 3d
@author  Lucas Briesemeister
@since   01/2021
@version 12.1.27
*/
Main Function Animation3D()
    Local oGame as object
    Local oMenu as object
    Local oLevels as object
    Local oInteraction as object
    Local oWindow as object
    Local aDimensions as array

    // instância gerenciador do jogo
    oGame := GameManager():New("Animação 3D", 50, 50, 650, 1330)

    // obtém janela princial onde as cenas serão adicionadas
    oWindow := oGame:GetMainWindow()

    // retorna dimensões de tela do jogo
    aDimensions := oGame:GetDimensions()

    oCubeScene := Scene():New(oWindow, "cube", aDimensions[TOP], aDimensions[LEFT], aDimensions[HEIGHT], aDimensions[WIDTH])
    oCubeScene:SetInitCodeBlock({|oLevel| LoadCube(oLevel, oGame)})

    // adiciona cena ao jogo
    oGame:AddScene(oCubeScene)

    oGame:Start(oCubeScene:GetSceneID())

Return
/*{Protheus.doc} Static FUnction LoadCube(oLevel, oGame)
Carrega cena do cubo
@author  Lucas Briesemeister
@since   01/2021
@version 12.1.27
*/
Static FUnction LoadCube(oLevel, oGame)

    Local oWindow as object
    Local oRotatingCube as object

    oWindow := oLevel:GetSceneWindow()

    oRotatingCube := RotatingCube():New(oWindow)

    oLevel:AddObject(oRotatingCube)

Return
