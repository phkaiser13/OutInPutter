# Encontra os pacotes (módulos) do Qt6 que nossa aplicação precisa.
# A chamada find_package usa a variável CMAKE_PREFIX_PATH que definimos
# no CMakeLists.txt pai para localizar a instalação do Qt.
# - REQUIRED: O processo de build falhará se o Qt não for encontrado.
# - COMPONENTS: A lista específica dos módulos que vamos usar.
#   - Core: Funcionalidades base do Qt (strings, containers, event loop).
#   - Gui: Gerenciamento de janelas, eventos de mouse/teclado, OpenGL.
#   - Qml: O motor que interpreta e executa a linguagem QML.
#   - Quick: Os blocos de construção visuais para QML (Rectangle, Text, Item, etc.).
find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick)

# qt_add_qml_module é uma função moderna do Qt6/CMake que simplifica TUDO.
# Ela agrupa nossos arquivos QML em um módulo coeso que a aplicação pode carregar.
#
# - appoutinputter: É o nome interno do nosso alvo do módulo. O CMake cuida disso.
# - URI (Uniform Resource Identifier): Um "endereço" único para nossos componentes QML.
#   Dentro do código QML, usaremos 'import OutInPutter.UI 1.0' para acessar nossos arquivos.
# - VERSION: A versão do nosso módulo QML.
# - QML_FILES: Lista de todos os arquivos .qml que fazem parte deste módulo.
#   Por enquanto, só temos o main.qml, mas depois adicionaremos os outros aqui.
qt_add_qml_module(appoutinputter
    URI OutInPutter.UI
    VERSION 1.0
    QML_FILES
        resources/qml/main.qml
        # Quando criarmos as outras telas, elas serão adicionadas aqui.
        # resources/qml/WelcomeScreen.qml
        # resources/qml/ProcessingScreen.qml
)


# Define o nosso alvo executável.
#
# - OutInPutter: O nome do nosso executável final (será OutInPutter.exe no Windows).
# - WIN32: Uma flag importante para aplicações de GUI no Windows.
#   Ela cria uma aplicação de janela em vez de uma aplicação de console.
#   Sem isso, uma janela de terminal preta apareceria junto com nossa interface.
# - Fontes: Lista de todos os arquivos de código-fonte C++ que compõem o executável.
add_executable(OutInPutter WIN32
    src/main.cpp
    # Quando criarmos a ponte com o backend, adicionaremos os arquivos aqui.
    # src/BackendBridge.h
    # src/BackendBridge.cpp
)

# Define qual padrão da linguagem C++ queremos usar.
# Usar C++20 nos dá acesso a recursos modernos e torna o código mais limpo.
# Isso adiciona a flag correta ao compilador (ex: -std=c++20).
target_compile_features(OutInPutter PRIVATE cxx_std_20)

# "Linka" nosso executável com as bibliotecas do Qt que encontramos antes.
# Este é um passo crucial. Ele diz ao compilador para conectar nosso código
# com o código das bibliotecas do Qt, para que possamos usar suas funcionalidades.
# A sintaxe "Qt6::Core" é a forma moderna e preferida, pois também configura
# automaticamente os diretórios de include e outras definições necessárias.
target_link_libraries(OutInPutter PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)