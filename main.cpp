#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "calculator.h"
#include "notemanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<Calculator>("MiniApps", 1, 0, "Calculator");
    qmlRegisterType<NoteManager>("MiniApps", 1, 0, "NoteManager");

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("MiniApps", "Main");

    return app.exec();
}
