#include <QtCore>
#include <QEvent>
#include "qamouseareaproxy.h"

QAMouseAreaProxy::QAMouseAreaProxy(QObject *parent) : QObject(parent)
{
    m_source = 0;
    m_watched = 0;
}

QObject *QAMouseAreaProxy::source() const
{
    return m_source;
}

void QAMouseAreaProxy::setSource(QObject *target)
{
    if (m_watched) {
        m_watched->disconnect(this);
        m_watched = 0;
    }

    m_source = target;

    if (target) {
        searchMouseArea(target);
    }
    emit sourceChanged();
}

void QAMouseAreaProxy::searchMouseArea(QObject *object)
{
    QString className = object->metaObject()->className();

    if (className.indexOf("QQuickMouseArea_") == 0) {
        m_watched = object;

//        for (int i = 0 ; i < object->metaObject()->methodCount(); i++) {
//            qDebug() << object->metaObject()->method(i).methodSignature();
//        }
        connect(m_watched,SIGNAL(pressAndHold(QQuickMouseEvent*)),
                this,SIGNAL(pressAndHold()));

        connect(m_watched,SIGNAL(clicked(QQuickMouseEvent*)),
                this,SIGNAL(clicked()));

        return;
    }

    QObjectList children = object->children();

    Q_FOREACH(QObject* child,children) {
        searchMouseArea(child);
    }
}

