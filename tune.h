#ifndef TUNE_H
#define TUNE_H

#include <QObject>

class Tune : public QObject
{
    Q_OBJECT
public:
    explicit Tune(QObject *parent = 0);

signals:

public slots:
};

#endif // TUNE_H