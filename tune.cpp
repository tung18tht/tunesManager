#include "tune.h"

Tune::Tune(QObject *parent) : QObject(parent) {

}

Tune::Tune(QString path, QString size, QString lastModified) {
    qPath = path;
    qSize = size;
    qLastModified = lastModified;
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

void Tune::setPath(QString path) {
    qPath = path;
    setNameFromPath();
}

void Tune::setSize(QString size) {
    qSize = size;
}

void Tune::setLastModified(QString lastModified) {
    qLastModified = lastModified;
}

void Tune::setNameFromPath() {
    qName = qPath.right(qPath.length() - qPath.lastIndexOf("/") - 1);
}
