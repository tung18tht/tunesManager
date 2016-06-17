#ifndef TUNESMANAGER_H
#define TUNESMANAGER_H

#include <QObject>
#include <QUrl>

#include <iostream>
#include <sstream>

#include "tune.h"

using namespace std;

class TunesManager : public QObject {
    Q_OBJECT
public:
    explicit TunesManager(QObject *parent = 0);
    Q_INVOKABLE QList<QObject*> searchTunes(QString directoryPath);
    Q_INVOKABLE QList<QObject*> sortTuneList(QString role, bool inverse);

private:
    QList<QObject*> tuneList;

    string runSearchTunesScript(string directoryPath);
    string getScriptResult(const char* script);
    QList<QObject*> getTuneList(string tuneString);
    QString evaluateSize(string size);
};

#endif // TUNESMANAGER_H
