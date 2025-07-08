# Versão mínima do CMake necessária para este projeto.
# Garante compatibilidade e acesso a recursos modernos do CMake.
cmake_minimum_required(VERSION 3.16)

# Define o nome do projeto e as linguagens que usaremos (C++).
# O nome do projeto será usado para variáveis como ${PROJECT_NAME}.
project(OutInPutter LANGUAGES CXX)

# --- Configuração Essencial para Integração com Qt ---
# Estas três linhas automatizam a maior parte do trabalho pesado do Qt.
# Elas dizem ao CMake para executar automaticamente as ferramentas do Qt (moc, rcc, uic)
# sempre que encontrarem arquivos que precisam delas. Isso economiza muita configuração manual.

# Ativa o Meta-Object Compiler (essencial para Sinais & Slots e propriedades QML)
set(CMAKE_AUTOMOC ON)

# Ativa o Resource Compiler (essencial para embutir qml/imagens no .exe)
set(CMAKE_AUTORCC ON)

# Ativa o User Interface Compiler (para arquivos .ui, bom ter por padrão)
set(CMAKE_AUTOUIC ON)

# Para garantir que o Qt encontre os módulos corretos, mesmo que não estejam no PATH
# padrão do sistema, definimos um prefixo. Isso aponta para a pasta de instalação do Qt.
# NOTA: Você precisará ajustar este caminho para onde o Qt está instalado no SEU computador.
# Exemplo para Windows com MSVC 2019:
set(CMAKE_PREFIX_PATH "C:/Qt/6.5.2/msvc2019_64") # <--- AJUSTE ESTE CAMINHO!

# --- Subdiretórios do Projeto ---
# Aqui, dizemos ao CMake para entrar nos subdiretórios e procurar por mais
# arquivos CMakeLists.txt para construir as diferentes partes da nossa aplicação.

# Primeiro, adicionamos nosso frontend.
add_subdirectory(app)

# Futuramente, quando formos integrar o backend, adicionaremos aqui:
# add_subdirectory(python_backend)