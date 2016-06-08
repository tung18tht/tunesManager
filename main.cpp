#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

#include"filesmanager.h"

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);

    qmlRegisterType<FilesManager>("FilesManager", 1, 0, "FilesManager");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/HomeWindow.qml")));

    return app.exec();
}
