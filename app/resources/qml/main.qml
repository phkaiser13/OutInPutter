// Importamos os módulos necessários.
// 'QtQuick' nos dá os componentes básicos de UI como Window, Rectangle, Text, etc.
// 'QtQuick.Controls' nos dá componentes mais complexos como Button, Slider, etc. (que usaremos depois).
import QtQuick
import QtQuick.Window

// O elemento raiz do nosso arquivo QML. Neste caso, é a janela principal.
// O nome do arquivo (main.qml) corresponde ao que carregamos no main.cpp.
Window {
    // 'id' é um identificador único para este elemento. Podemos usá-lo para referenciar
    // esta janela a partir de outros elementos QML.
    id: rootWindow

    // Propriedades iniciais da janela.
    title: qsTr("OutInPutter") // qsTr() é para internacionalização (tradução)
    width: 1024
    height: 720
    visible: true // Importante! A janela não aparece se isso não for true.

    // --- Estilo Avançado para um Visual Limpo ---
    // Para criar a janela "flutuante" sem bordas, usamos flags.
    // Qt.FramelessWindowHint remove a barra de título e as bordas padrão do SO.
    flags: Qt.FramelessWindowHint

    // Definimos a cor da janela como transparente.
    // Isso fará com que apenas os elementos que desenharmos dentro dela (como nosso retângulo)
    // sejam visíveis. O resto será um "buraco" mostrando o que estiver por trás (o desktop).
    color: "transparent"

    // --- Conteúdo da Janela ---
    // Por enquanto, apenas um retângulo para representar a área do nosso app,
    // exatamente como na sua imagem de exemplo.

    Rectangle {
        id: appContainer

        // A cor do nosso contêiner principal.
        color: "#ffffff" // Branco

        // Define um raio para os cantos, dando uma aparência mais suave e moderna.
        radius: 12

        // 'anchors' é o poderoso sistema de layout do QML.
        // Em vez de posições fixas (x, y), nós "ancoramos" elementos uns aos outros.
        // Aqui, estamos dizendo para este retângulo ter 80% da largura e altura da janela
        // e para se centralizar perfeitamente nela. Se a janela for redimensionada,
        // o retângulo se ajustará automaticamente.
        width: parent.width * 0.8
        height: parent.height * 0.8
        anchors.centerIn: parent // 'parent' aqui se refere a 'rootWindow'
        
        // Colocamos o texto "(TELA)" dentro do retângulo para replicar sua imagem.
        Text {
            text: qsTr("(TELA)")
            font.pixelSize: 72 // Tamanho da fonte grande
            font.bold: true
            color: "#333333" // Cinza escuro, não preto puro
            anchors.centerIn: parent // Centraliza o texto dentro do retângulo.
        }
    }

    // Permitir que a janela seja arrastada, já que removemos a barra de título.
    // Adicionamos uma área de mouse que cobre toda a janela.
    MouseArea {
        anchors.fill: parent
        property var previousPosition: Qt.point(0, 0)
        
        onPressed: (mouse) => {
            // Capturamos a posição inicial do mouse quando clicamos.
            previousPosition = mouse.globalPosition
        }

        onPositionChanged: (mouse) => {
            // Quando o mouse é arrastado (com o botão pressionado), calculamos
            // a diferença de posição e movemos a janela de acordo.
            const delta = mouse.globalPosition.minus(previousPosition)
            rootWindow.setX(rootWindow.x + delta.x)
            rootWindow.setY(rootWindow.y + delta.y)
            previousPosition = mouse.globalPosition
        }
    }
}