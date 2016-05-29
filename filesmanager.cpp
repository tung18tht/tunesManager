#include "filesmanager.h"

FilesManager::FilesManager(QObject *parent) : QObject(parent) {

}

void FilesManager::searchTunes(QUrl directoryPath) {
    cout << runSearchTunesScript(directoryPath.toString().toStdString());
}

string FilesManager::runSearchTunesScript(string directoryPath) {
    const char* script = QUrl("echo 'Hello'").toString().toStdString().c_str();
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
