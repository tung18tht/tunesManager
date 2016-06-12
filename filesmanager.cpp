#include "filesmanager.h"

FilesManager::FilesManager(QObject *parent) : QObject(parent) {

}

QList<QObject*> FilesManager::searchTunes(QUrl directoryPath) {
    string result = runSearchTunesScript(directoryPath.toString().toStdString());

    QList<QObject*> tuneList;
    istringstream resultStream(result);
    QString name, lastModified;
    string temp;
    int size;

    while (!resultStream.eof()) {
        getline(resultStream, temp);
        name = temp.c_str();
        getline(resultStream, temp);
        size = atoi(temp.c_str());
        getline(resultStream, temp);
        lastModified = temp.c_str();
        tuneList.append(new Tune(name, size, lastModified));
    }

    tuneList.removeLast();

    return tuneList;
}

string FilesManager::runSearchTunesScript(string directoryPath) {
    string script = "./scripts/searchTunes.sh " + directoryPath + " mp3";
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
