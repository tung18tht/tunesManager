#ifndef FILESMANAGER_H
#define FILESMANAGER_H

#include <QObject>

using namespace std;

class FilesManager : public QObject {
    Q_OBJECT
public:
    explicit FilesManager(QObject *parent = 0);

signals:

public slots:

private:
};

#endif // FILESMANAGER_H
