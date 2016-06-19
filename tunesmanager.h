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
    // QML methods
    Q_INVOKABLE QList<QObject*> searchTunes(QString directoryPath);
    Q_INVOKABLE QList<QObject*> checkDuplicate();
    Q_INVOKABLE QList<QObject*> sortTuneList(int role, bool inverse);
    Q_INVOKABLE QList<QObject*> filterTunes(QString name);

private:
    // fullList always store all tunes in search directories
    // dynamicList store tunes after filterd and sorted, works as a model for QML
    QList<QObject*> fullTuneList;
    QList<QObject*> dynamicTuneList;

    // seachTunes() helper methods
    string runSearchScript(string directoryPath);
    QList<QObject*> getTuneList(string tuneString);

    // checkDuplicate() helper methods
    string runCheckDuplicateScript();
    void setDuplicate(string duplicateNameList);

    // sortTuneList() helper methods
    string runSortScript(string roleString, bool inverse);

    // filterTunes() helper methods
    string runFilterScript(string name);

    string getRoleString(int role);
    QList<QObject*> getTuneListFromRole(int role, string roleStringList);
    string getScriptResult(const char* script);
};

#endif // TUNESMANAGER_H
