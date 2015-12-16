#include "testable.h"

Testable::Testable(QWidget *parent) : QWidget(parent)
{

}

QObject *Testable::search(QQuickItem *root, QString name)
{
    return root->findChild<QObject*>(name);
}

 QList<QObject*> Testable::filter(QObject *item, QVariantMap fields)
{
     QList<QObject*> res;
    if (fields.isEmpty()) {
        return res;
    }

    QMap<QString,QVariant>::Iterator iter = fields.begin();

    bool match = true;

    while (iter != fields.end()) {

        if (item->property(iter.key().toLocal8Bit()) != iter.value()) {
            match = false;
            break;
        }

        iter++;
    }

    if (match) {
        res.append(item);
    }

    int count = item->children().count();
    for (int i = 0 ; i < count ; i++) {
        QObject* child = item->children().at(i);
        QList<QObject*> subRes = filter(child,fields);
        if (subRes.size() > 0) {
            res.append(subRes);
        }
    }

    return res;

}

