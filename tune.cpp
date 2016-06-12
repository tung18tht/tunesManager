#include "tune.h"

Tune::Tune(QObject *parent) : QObject(parent) {

}

Tune::Tune() {

}

Tune::Tune(QString name, int size, QString lastModified) {
    qName = name;
    qSize = size;
    qLastModified = lastModified;
}

QString Tune::name() {
    return qName;
}

int Tune::size() {
    return qSize;
}

QString Tune::lastModified() {
    return qLastModified;
}

void Tune::setName(QString name) {
    qName = name;
}

void Tune::setSize(int size) {
    qSize = size;
}

void Tune::setLastModified(QString lastModified) {
    qLastModified = lastModified;
}
