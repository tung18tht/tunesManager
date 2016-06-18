#ifndef TUNESMANAGER_H
#define TUNESMANAGER_H

#include <QObject>

#include <iostream>
#include <sstream>

#include "tune.h"

using namespace std;

class TunesManager : public QObject {
    Q_OBJECT
public:
    explicit TunesManager(QObject *parent = 0);
    Q_INVOKABLE QList<QObject*> searchTunes(QString directoryPath);
    Q_INVOKABLE QList<QObject*> checkDuplicate();
    Q_INVOKABLE QList<QObject*> sortTuneList(int role, bool inverse);
    Q_INVOKABLE QList<QObject*> filterTunes(QString name);

private:
    QList<QObject*> fullTuneList;
    QList<QObject*> dynamicTuneList;

    string runSearchScript(string directoryPath);
    QList<QObject*> getTuneList(string tuneString);
    QString evaluateSize(string size);

    string runCheckDuplicateScript();
    void setDuplicate(string duplicateNameList);

    string runSortScript(string roleString, bool inverse);

    string runFilterScript(string name);

    QList<QObject*> getTuneListFromRole(int role, string roleStringList);
    string getRoleString(int role);
    string getScriptResult(const char* script);
};

#endif // TUNESMANAGER_H
