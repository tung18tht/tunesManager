#include "tunesmanager.h"

TunesManager::TunesManager(QObject *parent) : QObject(parent) {

}

QList<QObject*> TunesManager::searchTunes(QString directoryPath) {
    string result = runSearchScript(directoryPath.toStdString());
    return tuneList = getTuneList(result);
}

string TunesManager::runSearchScript(string directoryPath) {
    string script = "./scripts/search.sh \"" + directoryPath + "\" mp3";
    return getScriptResult(script.c_str());
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

QList<QObject*> TunesManager::checkDuplicate() {
    string duplicateNameList = runCheckDuplicateScript();
    setDuplicate(duplicateNameList);
    return tuneList;
}

string TunesManager::runCheckDuplicateScript() {
    string nameString = getRoleString(0);
    string script = "./scripts/checkDuplicate.sh ";
    script += "\"" + nameString + "\"";
    return getScriptResult(script.c_str());
}

void TunesManager::setDuplicate(string duplicateNameList) {
    string duplicateName;
    istringstream duplicateNameStream(duplicateNameList);
    QList<QObject*>::iterator object;

    while (!duplicateNameStream.eof()) {
        getline(duplicateNameStream, duplicateName);
        for (object=tuneList.begin(); object!=tuneList.end(); object++) {
            Tune* tune = (Tune*) *object;

            if (tune->lastModified().toStdString() == roleString) {
                sortedTuneList.append(tune);
                tuneList.removeOne(*object);
                found = true;
            }
        }
    }
}

QList<QObject*> TunesManager::sortTuneList(int role, bool inverse) {
    string roleString = getRoleString(role);
    string sortedRoleString = runSortScript(roleString, inverse);
    return tuneList = getSortedTuneList(role, sortedRoleString);
}

string TunesManager::runSortScript(string roleString, bool inverse) {
    string script = "./scripts/sort.sh ";
    script += inverse ? "1 " : "0 ";
    script += "\"" + roleString + "\"";
    return getScriptResult(script.c_str());
}

QList<QObject*> TunesManager::getSortedTuneList(int role,string sortedRoleString) {
    QList<QObject*> sortedTuneList;
    string roleString;
    istringstream roleStringStream(sortedRoleString);
    QList<QObject*>::iterator object;
    bool found = false;

    while (!roleStringStream.eof()) {
        getline(roleStringStream, roleString);
        found = false;
        for (object=tuneList.begin(); object!=tuneList.end(); object++) {
            Tune* tune = (Tune*) *object;

            switch(role) {
            case 0:
                if (tune->name().toStdString() == roleString) {
                    sortedTuneList.append(tune);
                    tuneList.removeOne(*object);
                    found = true;
                }
                break;
            case 1:
                if (tune->size().toStdString() == roleString) {
                    sortedTuneList.append(tune);
                    tuneList.removeOne(*object);
                    found = true;
                }
                break;
            case 2:
                if (tune->lastModified().toStdString() == roleString) {
                    sortedTuneList.append(tune);
                    tuneList.removeOne(*object);
                    found = true;
                }
                break;
            }
            if (found) break;
        }
    }

    return sortedTuneList;
}

string TunesManager::getRoleString(int role) {
    QString roleString = "";
    QList<QObject*>::iterator object;
    for (object=tuneList.begin(); object!=tuneList.end(); object++) {
        Tune* tune = (Tune*) *object;

        switch(role) {
        case 0:
            roleString += tune->name() + "\n";
            break;
        case 1:
            roleString += tune->size() + "\n";
            break;
        case 2:
            roleString += tune->lastModified() + "\n";
            break;
        }
    }
    roleString.chop(1);
    return roleString.toStdString();
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
