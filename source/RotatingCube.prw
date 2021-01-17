#include 'totvs.ch'

/*{Protheus.doc} Class RotatingCube
Classe com lógica da rotação do cubo
@author  Lucas Briesemeister
@since   01/2021
@version 12.1.27
*/
Class RotatingCube From BaseGameObject
    
    Data oPanel
    Data oCube

    Method New() Constructor
    Method Update()

EndClass

/*{Protheus.doc} Method New(oWindow) Class RotatingCube
Instância classe do cubo com a lógica de rotação
@author  Lucas Briesemeister
@since   01/2021
@version 12.1.27
*/
Method New(oWindow) Class RotatingCube

    _Super:New(oWindow)

    ::oPanel := TPaintPanel():new(0,0,oWindow:nWidth,oWindow:nHeight,oWindow)

    ::oCube := Cube():New(1, 1, 25, 10);

Return Self

/*{Protheus.doc} Method Update(oGame) Class RotatingCube
Atualiza frame do cubo
@author  Lucas Briesemeister
@since   01/2021
@version 12.1.27
*/
Method Update(oGame) Class RotatingCube

    Local aVertices as array
    Local nIndex as numeric
    Local oPoint1 as object
    Local oPoint2 as object
    Local oPoint3 as object
    Local oV1 as object
    Local oV2 as object
    Local oN1 as object
    Local aFace as array
    Local cId as char

    ::oCube:RotateX(0.01)

    aVertices := Project(::oCube:aVertices, ::oWindow:nWidth, ::oWindow:nHeight)

    For nIndex := Len(::oCube:aFaces) To 1 STEP - 1
        aFace := ::oCube:aFaces[nIndex]

        oPoint1 := ::oCube:aVertices[aFace[1]]
        oPoint2 := ::oCube:aVertices[aFace[2]]
        oPoint3 := ::oCube:aVertices[aFace[3]]

        oV1 := Point3D():New(oPoint2:nX - oPoint1:nX, oPoint2:nY - oPoint1:nY, oPoint2:nZ - oPoint1:nZ)
        oV2 := Point3D():New(oPoint3:nX - oPoint1:nX, oPoint3:nY - oPoint1:nY, oPoint3:nZ - oPoint1:nZ)

        oN1 := Point3D():New(oV1:nY * oV2:nZ - oV1:nZ * oV2:nY, oV1:nZ * oV2:nX - oV1:nX * oV2:nZ, oV1:nX * oV2:nY - oV1:nY * oV2:nX)

        //If (-oPoint1:nX * oN1:nX + (-oPoint1:nY) * oN1:nY + (-oPoint1:nZ) * oN1:nZ) <= 0
            
            cId := cValToChar(nIndex) 

            ::oPanel:DeleteItem(Val(cId))
            ::oPanel:AddShape("id="+cId+";type=9;" + ;
                            "from-left="+cValToChar(aVertices[aFace[1]]:nX) + ";" + ;
                            "from-top="+cValToChar(aVertices[aFace[1]]:nY)+";" + ;
                            "to-left="+cValToChar(aVertices[aFace[2]]:nX) + ";" + ;
                            "to-top="+cValToChar(aVertices[aFace[2]]:nY)+";" + ;
                            "pen-width=1;pen-color=#000000;")

            cId := cValToChar(nIndex) + '1' 
            ::oPanel:DeleteItem(Val(cId))
            ::oPanel:AddShape("id="+cId+";type=9;" + ;
                "from-left="+cValToChar(aVertices[aFace[2]]:nX) + ";" + ;
                "from-top="+cValToChar(aVertices[aFace[2]]:nY)+";" + ;
                "to-left="+cValToChar(aVertices[aFace[3]]:nX) + ";" + ;
                "to-top="+cValToChar(aVertices[aFace[3]]:nY)+";" + ;
                "pen-width=1;pen-color=#000000;")

        //EndIf

    Next

Return

/*{Protheus.doc} Class Point2D
Classse que representa um ponto em duas dimensões no painel
@author  Lucas Briesemeister
@since   01/2021
@version 12.1.27
*/
Class Point2D
    
    Data nX
    Data nY

    Method New() Constructor

EndClass

/*{Protheus.doc} Method New(nX, nY) Class Point2D
Instância a classe de ponto2d
@author  Lucas Briesemeister
@since   01/2021
@version 12.1.27
*/
Method New(nX, nY) Class Point2D

    ::nX := nX
    ::nY := nY

Return Self

/*{Protheus.doc} Class Point3D
Classe que representa um ponto em 3d dimensões no painel
@author  Lucas Briesemeister
@since   01/2021
@version 12.1.27
*/
Class Point3D

    Data nX
    Data nY
    Data nZ

    Method New() Constructor

EndClass

/*{Protheus.doc} Method New(nX, nY, nZ) Class Point3
Instância classe do ponto 3d
@author  Lucas Briesemeister
@since   01/2021
@version 12.1.27
*/
Method New(nX, nY, nZ) Class Point3D

    ::nX := nX
    ::nY := nY
    ::nZ := nZ

Return Self

/*{Protheus.doc} Class Cube
Classe que contém as infomrações para construção de um cubo
@author  Lucas Briesemeister
@since   01/2021
@version 12.1.27
*/
Class Cube

    Data aVertices
    Data aFaces
    Data nX
    Data nY
    Data nZ

    Method New() Constructor
    Method RotateX()
    Method RotateY()


EndClass

/*{Protheus.doc} Method New(nX, nY, nZ, nSize) Class Cube
Instância o cubo
@author  Lucas Briesemeister
@since   01/2021
@version 12.1.27
*/
Method New(nX, nY, nZ, nSize) Class Cube

    ::nX := nX
    ::nY := nY
    ::nZ := nZ

    nSize *= 0.5

    ::aVertices := {}

    AAdd(::aVertices, Point3D():New(nX - nSize, nY - nSize, nZ - nSize))
    AAdd(::aVertices, Point3D():New(nX + nSize, nY - nSize, nZ - nSize))
    AAdd(::aVertices, Point3D():New(nX + nSize, nY + nSize, nZ - nSize))
    AAdd(::aVertices, Point3D():New(nX - nSize, nY + nSize, nZ - nSize))
    AAdd(::aVertices, Point3D():New(nX - nSize, nY - nSize, nZ + nSize))
    AAdd(::aVertices, Point3D():New(nX + nSize, nY - nSize, nZ + nSize))
    AAdd(::aVertices, Point3D():New(nX + nSize, nY + nSize, nZ + nSize))
    AAdd(::aVertices, Point3D():New(nX - nSize, nY + nSize, nZ + nSize))

    ::aFaces := {}

    Aadd(::aFaces, {1, 2, 3, 4})
    Aadd(::aFaces, {1, 5, 6, 2})
    Aadd(::aFaces, {2, 6, 7, 3})
    Aadd(::aFaces, {4, 3, 7, 8})
    Aadd(::aFaces, {1, 4, 8, 5})
    Aadd(::aFaces, {5, 8, 7, 6})

Return Self

/*{Protheus.doc} Method RotateX(nRadian) Class Cube
Rotaciona o cubo no eixo X
@author  Lucas Briesemeister
@since   01/2021
@version 12.1.27
*/
Method RotateX(nRadian) Class Cube

    Local nCosine as numeric
    Local nSine as numeric
    Local nIndex as numeric
    Local nZ as numeric
    Local nY as numeric
    Local oPoint as object

    nCosine := Cos(nRadian)
    nSine := Sin(nRadian)

    For nIndex := Len(::aVertices) To 1 STEP - 1

        oPoint := ::aVertices[nIndex]

        nY := (oPoint:nY - ::nY) * nCosine - (oPoint:nZ - ::nZ) * nSine
        nZ := (oPoint:nY - ::nY) * nSine + (oPoint:nZ - ::nZ) * nCosine

        oPoint:nY := nY + ::nY
        oPoint:nZ := nZ + ::nZ

    Next

Return

/*{Protheus.doc} Method RotateY(nRadian) Class Cube
Rotaciona o cubo no eixo Y
@author  Lucas Briesemeister
@since   01/2021
@version 12.1.27
*/
Method RotateY(nRadian) Class Cube

    Local nCosine as numeric
    Local nSine as numeric
    Local nIndex as numeric
    Local nX as numeric
    Local nZ as numeric
    Local oPoint as object

    nCosine := Cos(nRadian)
    nSine := Sin(nRadian)

    For nIndex := Len(::aVertices) To 1 STEP - 1
    
        oPoint := ::aVertices[nIndex]

        nX := (oPoint:nZ - ::nZ) * nSine + (oPoint:nX - ::nX) * nCosine
        nZ := (oPoint:nZ - ::nZ) * nCosine - (oPoint:nZ - ::nZ) * nSine

        oPoint:nX := nX + ::nX
        oPoint:nZ := nZ + ::nZ

    Next

Return

/*{Protheus.doc} Static Function Project(aPoints3D, nWidth, nHeight)
Realiza a projeção dos pontos 3D do cubo em um painel de 2 dimensões
@author  Lucas Briesemeister
@since   01/2021
@version 12.1.27
*/
Static Function Project(aPoints3D, nWidth, nHeight)

    Local aPoints2D as array
    LOcal nFocalLength as numeric
    Local nIndex as numeric
    Local nX as numeric
    Local nY as numeric
    Local oPoint as object

    nFocalLength := 200

    aPoints2D := Array(Len(aPoints3D))

    For nIndex := Len(aPoints3D) To 1 STEP - 1
        oPoint := aPoints3D[nIndex]

        nX := oPoint:nX * (nFocalLength / oPoint:nZ) + nWidth * 0.5
        nY := oPoint:nY * (nFocalLength / oPoint:nZ) + nHeight * 0.5

        aPoints2D[nIndex] := Point2D():New(nX, nY)

    Next

Return aPoints2D