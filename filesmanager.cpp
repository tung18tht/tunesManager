#include "filesmanager.h"

FilesManager::FilesManager(QObject *parent) : QObject(parent) {

}

QString FilesManager::searchTunes(QUrl directoryPath) {
    QString qString(runSearchTunesScript(directoryPath.toString().toStdString()).c_str());
    return qString;
}

string FilesManager::runSearchTunesScript(string directoryPath) {
    string script = "./scripts/searchTunes.sh " + directoryPath;
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
