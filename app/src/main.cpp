#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QUrl>

// main é a função de entrada padrão para todas as aplicações C++.
// argc (argument count) e argv (argument vector) são parâmetros da linha de comando,
// que o Qt usa para processar argumentos específicos da plataforma.
int main(int argc, char* argv[])
{
    // 1. Instanciar QGuiApplication.
    //    Este objeto gerencia o loop de eventos principal da aplicação e os recursos globais.
    //    Deve ser o primeiro objeto Qt a ser criado.
    QGuiApplication app(argc, argv);

    // 2. Instanciar o Motor QML.
    //    QQmlApplicationEngine fornece uma maneira fácil de carregar uma aplicação
    //    a partir de um único arquivo QML. Ele lida com a criação da janela
    //    e a renderização da cena QML.
    QQmlApplicationEngine engine;

    // 3. Definir a URL do arquivo QML principal.
    //    Usamos QUrl com o esquema "qrc:" para carregar o arquivo a partir dos recursos
    //    embutidos no executável. O caminho reflete o URI e o nome do arquivo
    //    que definimos no nosso CMakeLists.txt.
    const QUrl url(u"qrc:/OutInPutter.UI/main.qml"_qs);

    // Conectamos um "slot" (uma função lambda, neste caso) ao sinal "objectCreated" do motor.
    // Isso é uma verificação de segurança: se o QML não puder ser carregado (por exemplo, por um erro de sintaxe),
    // o `object` será nulo. Neste caso, saímos da aplicação para evitar uma janela em branco e um erro silencioso.
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject* obj, const QUrl& objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1); // Sai com um código de erro.
        }, Qt::QueuedConnection);

    // 4. Carregar o arquivo QML.
    //    Esta é a chamada que efetivamente lê, interpreta e exibe nossa UI.
    engine.load(url)

    // 5. Iniciar o Loop de Eventos do Qt.
    //    app.exec() entrega o controle ao Qt. A partir deste ponto, o Qt gerencia
    //    todos os eventos (cliques de mouse, pressionamentos de tecla, timers, etc.).
    //    O programa só sairá deste loop quando a aplicação for encerrada (por exemplo, fechando a janela).
    return app.exec();da
}