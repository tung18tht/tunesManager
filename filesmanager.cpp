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
    QString path, size, lastModified;
    string temp;

    while (!tuneStream.eof()) {
        getline(tuneStream, temp);
        path = "file://";
        path += temp.c_str();

        getline(tuneStream, temp);
        size = evaluateSize(temp);

        getline(tuneStream, temp);
        lastModified = temp.c_str();
        tuneList.append(new Tune(path, size, lastModified));
    }

    tuneList.removeLast();

    return tuneList;
}

QString FilesManager::evaluateSize(string size) {
    int sizeInt = atoi(size.c_str());
    sizeInt /= 1000;
    size = to_string(sizeInt);
    for(int i=3; i<size.length(); i+=3) {
        size.insert(size.length()-i, ",");
    }
    size += " KB";
    return size.c_str();
}
