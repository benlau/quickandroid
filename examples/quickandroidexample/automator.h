#ifndef AUTOMATOR_H
#define AUTOMATOR_H

#include <QObject>
#include <QVariantMap>

/// For unit test purpose. Not needed for regular project.

class Automator : public QObject
{
    Q_OBJECT
public:
    explicit Automator(QObject *parent = 0);
    ~Automator();

    void start();

signals:

public slots:

private slots:
    void onDispatched(QString name,QVariantMap message);

};

#endif // AUTOMATOR_H
