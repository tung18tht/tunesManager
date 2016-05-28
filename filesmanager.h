#ifndef FILESMANAGER_H
#define FILESMANAGER_H

#include <QObject>
#include <QUrl>

#include "scriptsmanager.h"

#include <iostream>

using namespace std;

class FilesManager : public QObject {
    Q_OBJECT
public:
    explicit FilesManager(QObject *parent = 0);
    Q_INVOKABLE void searchTunes(QUrl directoryPath);

private:
};

#endif // FILESMANAGER_H
