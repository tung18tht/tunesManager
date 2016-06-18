#include "tunesmanager.h"

TunesManager::TunesManager(QObject *parent) : QObject(parent) {

}

QList<QObject*> TunesManager::searchTunes(QString directoryPath) {
    string result = runSearchScript(directoryPath.toStdString());
    return tuneList = getTuneList(result);
}

QList<QObject*> TunesManager::sortTuneList(int role, bool inverse) {
    string roleString = "";
    QList<QObject*>::iterator object;
    for (object=tuneList.begin(); object!=tuneList.end(); object++) {
        Tune* tune = (Tune*) *object;

        switch(role) {
        case 0:
            roleString += tune->name().toStdString() + "\n";
            break;
        case 1:
            roleString += tune->size().toStdString() + "\n";
            break;
        case 2:
            roleString += tune->lastModified().toStdString() + "\n";
            break;
        }
    }
    string result = runSortScript(roleString, inverse);
    cout << result << endl;
    return tuneList;
}

string TunesManager::runSearchScript(string directoryPath) {
    string script = "./scripts/search.sh \"" + directoryPath + "\" mp3";
    return getScriptResult(script.c_str());
}

string TunesManager::runSortScript(string roleString, bool inverse) {
    string script = "./scripts/sort.sh ";
    script += inverse ? "1 " : "0 ";
    script += "\"" + roleString + "\"";
    return getScriptResult(script.c_str());
}

string TunesManager::getScriptResult(const char* script) {
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

QList<QObject*> TunesManager::getTuneList(string tuneString) {
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

QString TunesManager::evaluateSize(string size) {
    int sizeInt = atoi(size.c_str());
    sizeInt /= 1000;
    size = to_string(sizeInt);
    for(int i=3; i<size.length(); i+=3) {
        size.insert(size.length()-i++, ",");
    }
    size += " KB";
    return size.c_str();
}
