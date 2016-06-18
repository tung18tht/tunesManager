#ifndef TUNE_H
#define TUNE_H

#include <QObject>

class Tune : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString name READ name)
    Q_PROPERTY(QString path READ path WRITE setPath)
    Q_PROPERTY(QString size READ size WRITE setSize)
    Q_PROPERTY(QString lastModified READ lastModified WRITE setLastModified)
    Q_PROPERTY(bool duplicate READ duplicate WRITE setDuplicate)

public:
    explicit Tune(QObject *parent = 0);
    Tune(QString path, QString size, QString lastModified);

    QString name();
    QString path();
    QString size();
    QString lastModified();
    bool duplicate();

    void setPath(QString path);
    void setSize(QString size);
    void setLastModified(QString lastModified);
    void setDuplicate(bool duplicate);

private:
    QString qName, qPath, qLastModified, qSize;
    bool qDuplicate;

    void setNameFromPath();
};

#endif // TUNE_H
