#include "filesmanager.h"

FilesManager::FilesManager(QObject *parent) : QObject(parent) {

}

void FilesManager::searchTunes(QUrl directoryPath) {
    cout << runSearchTunesScript(directoryPath.toString().toStdString()) << endl;
}

string FilesManager::runSearchTunesScript(string directoryPath) {
    string script = getScriptCommand(":/scripts/searchTunes.sh");
    return getScriptResult(script.c_str());
}

string FilesManager::getScriptCommand(QString scriptFilePath) {
    QFile scriptFile(scriptFilePath);
    scriptFile.open(QFile::ReadOnly | QFile::Text);
    QTextStream scriptStream(&scriptFile);
    return scriptStream.readAll().toStdString();
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
