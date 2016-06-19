#include "tune.h"

Tune::Tune(QObject *parent) : QObject(parent) {

}

Tune::Tune(QString path, int size, int lastModified) {
    qPath = path;
    iSize = size;
    qSize = evaluateSize(size);
    iLastModified = lastModified;
    qLastModified = evaluateLastModified(lastModified);
    qDuplicate = false;
    setNameFromPath();
}

QString Tune::name() {
    return qName;
}

QString Tune::path() {
    return qPath;
}

QString Tune::size() {
    return qSize;
}

QString Tune::lastModified() {
    return qLastModified;
}

bool Tune::duplicate() {
    return qDuplicate;
}

QString Tune::iSizeString() {
    return to_string(iSize).c_str();
}

QString Tune::iLastModifiedString() {
    return to_string(iLastModified).c_str();
}

void Tune::setDuplicate(bool duplicate) {
    qDuplicate = duplicate;
}

QString Tune::evaluateSize(int size) {
    size /= 1000;
    string sizeString = to_string(size);
    for(int i=3; i<sizeString.length(); i+=3) {
        sizeString.insert(sizeString.length()-i++, ",");
    }
    sizeString += " KB";
    return sizeString.c_str();
}

QString Tune::evaluateLastModified(int lastModified) {
    time_t epochTime = lastModified;
    struct tm* timeInfo;
    char buffer [20];

    timeInfo = localtime (&epochTime);
    strftime (buffer, 20, "%d/%m/%y %R", timeInfo);

    return buffer;
}

void Tune::setNameFromPath() {
    qName = qPath.right(qPath.length() - qPath.lastIndexOf("/") - 1);
}
