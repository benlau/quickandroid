#ifndef TESTABLE_H
#define TESTABLE_H

#include <QObject>
#include <QWidget>
#include <QQuickItem>

class Testable : public QWidget
{
    Q_OBJECT
public:
    explicit Testable(QWidget *parent = 0);

    Q_INVOKABLE QObject* search(QQuickItem* root,QString name);

    Q_INVOKABLE QList<QObject*> filter(QObject* root, QVariantMap fields);

signals:

public slots:
};

#endif // TESTABLE_H
