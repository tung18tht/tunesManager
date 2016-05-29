#ifndef FILESMANAGER_H
#define FILESMANAGER_H

#include <QObject>
#include <QUrl>
#include <QFile>
#include <QTextStream>
#include <QFileInfo>

#include <iostream>

using namespace std;

class FilesManager : public QObject {
    Q_OBJECT
public:
    explicit FilesManager(QObject *parent = 0);
    Q_INVOKABLE void searchTunes(QUrl directoryPath);

private:
    string runSearchTunesScript(string directoryPath);
    string getScriptResult(const char* script);
};

#endif // FILESMANAGER_H
