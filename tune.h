#ifndef TUNE_H
#define TUNE_H

#include <QObject>

class Tune : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString name READ name WRITE setName)
    Q_PROPERTY(int size READ size WRITE setSize)
    Q_PROPERTY(QString lastModified READ lastModified WRITE setLastModified)

public:
    explicit Tune(QObject *parent = 0);
    Tune();
    Tune(QString name, int size, QString lastModified);

    QString name();
    int size();
    QString lastModified();

    void setName(QString name);
    void setSize(int size);
    void setLastModified(QString lastModified);

private:
    QString qName, qLastModified;
    int qSize;
};

#endif // TUNE_H
