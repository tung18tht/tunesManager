#include "filesmanager.h"

FilesManager::FilesManager(QObject *parent) : QObject(parent) {

}

QList<QObject*> FilesManager::searchTunes(QUrl directoryPath) {
//    runSearchTunesScript(directoryPath.toString().toStdString());
    return null;
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
