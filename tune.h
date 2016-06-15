#ifndef TUNE_H
#define TUNE_H

#include <QObject>

class Tune : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString name READ name)
    Q_PROPERTY(QString path READ path WRITE setPath)
    Q_PROPERTY(int size READ size WRITE setSize)
    Q_PROPERTY(QString lastModified READ lastModified WRITE setLastModified)

public:
    explicit Tune(QObject *parent = 0);
    Tune(QString path, int size, QString lastModified);

    QString name();
    QString path();
    int size();
    QString lastModified();

    void setPath(QString path);
    void setSize(int size);
    void setLastModified(QString lastModified);

private:
    QString qName, qPath, qLastModified;
    int qSize;

    void setNameFromPath();
};

#endif // TUNE_H
