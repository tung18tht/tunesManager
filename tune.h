#ifndef TUNE_H
#define TUNE_H

#include <QObject>
#include "time.h"

using namespace std;

// Abstract Tune class with basic properties, get set methods
// Names are taken from file paths

class Tune : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString name READ name)
    Q_PROPERTY(QString path READ path)
    Q_PROPERTY(QString size READ size)
    Q_PROPERTY(QString lastModified READ lastModified)
    Q_PROPERTY(bool duplicate READ duplicate WRITE setDuplicate)

public:
    explicit Tune(QObject *parent = 0);
    Tune(QString path, int size, int lastModified);

    QString name();
    QString path();
    QString size();
    QString lastModified();
    bool duplicate();

    QString iSizeString();
    QString iLastModifiedString();

    void setDuplicate(bool duplicate);

private:
    QString qName, qPath, qLastModified, qSize;
    bool qDuplicate;
    int iSize, iLastModified; // size, lastModified in int for sorting

    // Convert size form such as: 1234567 to "1,235KB"
    static QString evaluateSize(int size);
    // Convert EPOCH time to readable string
    static QString evaluateLastModified(int lastModified);
    void setNameFromPath();
};

#endif // TUNE_H
