#include "tunesmanager.h"

TunesManager::TunesManager(QObject *parent) : QObject(parent) {

}

QList<QObject*> TunesManager::searchTunes(QString directoryPath) {
    string result = runSearchScript(directoryPath.toStdString());
    return dynamicTuneList = fullTuneList = getTuneList(result);
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
    return dynamicTuneList;
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
        for (object=fullTuneList.begin(); object!=fullTuneList.end(); object++) {
            Tune* tune = (Tune*) *object;

            if (tune->name().toStdString() == duplicateName) {
                tune->setDuplicate(true);
            }
        }
    }

    dynamicTuneList = fullTuneList;
}

QList<QObject*> TunesManager::sortTuneList(int role, bool inverse) {
    string roleString = getRoleString(role);
    string sortedRoleString = runSortScript(roleString, inverse);
    return dynamicTuneList = getTuneListFromRole(role, sortedRoleString);
}

string TunesManager::runSortScript(string roleString, bool inverse) {
    string script = "./scripts/sort.sh ";
    script += inverse ? "1 " : "0 ";
    script += "\"" + roleString + "\"";
    return getScriptResult(script.c_str());
}

QList<QObject*> TunesManager::filterTunes(QString name) {
    dynamicTuneList = fullTuneList;
    if (name=="") return fullTuneList;
    string nameList = runFilterScript(name.toStdString());
    return dynamicTuneList = getTuneListFromRole(0, nameList);
}

string TunesManager::runFilterScript(string name) {
    string script = "./scripts/filter.sh ";
    script += "\"" + getRoleString(0) + "\" ";
    script += "\"" + name + "\"";
    return getScriptResult(script.c_str());
}

QList<QObject*> TunesManager::getTuneListFromRole(int role,string roleStringList) {
    QList<QObject*> tuneList;
    string roleString;
    istringstream roleStringStream(roleStringList);
    QList<QObject*>::iterator object;
    bool found = false;

    while (!roleStringStream.eof()) {
        getline(roleStringStream, roleString);
        found = false;
        for (object=dynamicTuneList.begin(); object!=dynamicTuneList.end(); object++) {
            Tune* tune = (Tune*) *object;

            switch(role) {
            case 0:
                if (tune->name().toStdString() == roleString) {
                    tuneList.append(tune);
                    dynamicTuneList.removeOne(*object);
                    found = true;
                }
                break;
            case 1:
                if (tune->size().toStdString() == roleString) {
                    tuneList.append(tune);
                    dynamicTuneList.removeOne(*object);
                    found = true;
                }
                break;
            case 2:
                if (tune->lastModified().toStdString() == roleString) {
                    tuneList.append(tune);
                    dynamicTuneList.removeOne(*object);
                    found = true;
                }
                break;
            }
            if (found) break;
        }
    }

    return tuneList;
}

string TunesManager::getRoleString(int role) {
    QString roleString = "";
    QList<QObject*>::iterator object;
    for (object=fullTuneList.begin(); object!=fullTuneList.end(); object++) {
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
