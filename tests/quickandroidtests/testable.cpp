#include "testable.h"

Testable::Testable(QWidget *parent) : QWidget(parent)
{

}

QObject *Testable::search(QQuickItem *root, QString name)
{
    return root->findChild<QObject*>(name);
}

