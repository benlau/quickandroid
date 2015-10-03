#include <QtQml>
#include <QEvent>
#include "qamousesensor.h"

QAMouseSensor::QAMouseSensor(QQuickItem* parent) : QQuickItem(parent)
{
//    setAcceptedMouseButtons(Qt::LeftButton);
//    setFiltersChildMouseEvents(true);
    timerId = 0;
    m_filter = 0;
}

void QAMouseSensor::mousePressEvent(QMouseEvent *event)
{
    if (timerId != 0) {
        killTimer(timerId);
        timerId = 0;
    }

    timerId = startTimer(800,Qt::CoarseTimer);

    return QQuickItem::mousePressEvent(event);
}

void QAMouseSensor::mouseMoveEvent(QMouseEvent *event)
{
    QQuickItem::mouseMoveEvent(event);
}

void QAMouseSensor::mouseReleaseEvent(QMouseEvent *event)
{
    if (timerId != 0) {
        killTimer(timerId);
        timerId = 0;
    }

    QQuickItem::mouseReleaseEvent(event);
}

void QAMouseSensor::timerEvent(QTimerEvent *event)
{
    killTimer(timerId);
    Q_UNUSED(event);
    timerId = 0;
    emit pressAndHold();
}

bool QAMouseSensor::eventFilter(QObject *, QEvent *event)
{
    if (!isEnabled())
        return false;

    switch (event->type()) {
    case QEvent::MouseButtonPress:
    mousePressEvent((QMouseEvent*) event);
        break;
    case QEvent::MouseMove:
    mouseMoveEvent((QMouseEvent*) event);
        break;
    case QEvent::MouseButtonRelease:
    mouseReleaseEvent((QMouseEvent*) event);
        break;
    case QEvent::Timer:
        break;
    default:
        break;
    }

    return false;
}

void QAMouseSensor::search(QObject *object, bool installFilter)
{
    if (installFilter) {
        object->installEventFilter(this);
    } else {
        object->removeEventFilter(this);
    }

    QObjectList children = object->children();

    Q_FOREACH(QObject* child,children) {
        search(child,installFilter);
    }
}

QObject *QAMouseSensor::filter() const
{
    return m_filter;
}

void QAMouseSensor::setFilter(QObject *listenOn)
{
    if (m_filter) {
        search(m_filter,false);
    }

    m_filter = listenOn;

    if (m_filter) {
        search(m_filter,true);
    }

}

