#include "filesmanager.h"

FilesManager::FilesManager(QObject *parent) : QObject(parent) {

}

void FilesManager::searchTunes(QUrl directoryPath) {
    cout << directoryPath.toString().toStdString() << endl;
}
