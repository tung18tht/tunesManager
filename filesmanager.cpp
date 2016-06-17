#include "filesmanager.h"

FilesManager::FilesManager(QObject *parent) : QObject(parent) {

}

QList<QObject*> FilesManager::searchTunes(QString directoryPath) {
    string result = runSearchTunesScript(directoryPath.toStdString());
    return getTuneList(result);
}

string FilesManager::runSearchTunesScript(string directoryPath) {
    string script = "./scripts/searchTunes.sh \"" + directoryPath + "\" mp3";
    return getScriptResult(script.c_str());
}

string FilesManager::getScriptResult(const char* script) {
    char buffer[128];
    string result = "";
    shared_ptr<FILE> pipe(popen(script, "r"), pclose);
    while (!feof(pipe.get())) {
        if (fgets(buffer, 128, pipe.get()) != NULL) {
            result += buffer;
        }
    }
    return result;
}

QList<QObject*> FilesManager::getTuneList(string tuneString) {
    QList<QObject*> tuneList;
    istringstream tuneStream(tuneString);
    QString path = "file://", lastModified;
    string temp;
    int size;

    while (!tuneStream.eof()) {
        getline(tuneStream, temp);
        path += temp.c_str();
        getline(tuneStream, temp);
        size = atoi(temp.c_str());
        getline(tuneStream, temp);
        lastModified = temp.c_str();
        tuneList.append(new Tune(path, size, lastModified));
    }

    tuneList.removeLast();

    return tuneList;
}
