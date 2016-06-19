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

// Create a Tune list from a string with following format:
//  Line 1: File path
//  Line 2: File size
//  Line 3: Last modified
QList<QObject*> TunesManager::getTuneList(string tuneString) {
    QList<QObject*> tuneList;
    istringstream tuneStream(tuneString);
    QString path;
    int size, lastModified;
    string temp;

    while (!tuneStream.eof()) {
        getline(tuneStream, temp);
        path = "file://";
        path += temp.c_str();

        getline(tuneStream, temp);
        size = atoi(temp.c_str());

        getline(tuneStream, temp);
        lastModified = atoi(temp.c_str());
        tuneList.append(new Tune(path, size, lastModified));
    }
    tuneList.removeLast();

    return tuneList;
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

// role: determine sort by name (0) or size (1), or lastModified (2)
// inverse: determine sort alphabetically (0) or not (1)
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
    if (name=="") return dynamicTuneList;
    string nameList = runFilterScript(name.toStdString());
    return dynamicTuneList = getTuneListFromRole(0, nameList);
}

string TunesManager::runFilterScript(string name) {
    string script = "./scripts/filter.sh ";
    script += "\"" + getRoleString(0) + "\" ";
    script += "\"" + name + "\"";
    return getScriptResult(script.c_str());
}

// Get string list of all tunes by role only (all names, all size,...)
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
            roleString += tune->iSizeString() + "\n";
            break;
        case 2:
            roleString += tune->iLastModifiedString() + "\n";
            break;
        }
    }
    roleString.chop(1);
    return roleString.toStdString();
}

// roleStringList is from output of getRoleString(int role)
// this function return a list of Tunes that their roles are in the roleStringList
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
                if (tune->iSizeString().toStdString() == roleString) {
                    tuneList.append(tune);
                    dynamicTuneList.removeOne(*object);
                    found = true;
                }
                break;
            case 2:
                if (tune->iLastModifiedString().toStdString() == roleString) {
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

// convert executed script result to std::string
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
