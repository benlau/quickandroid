#include <QtQml>
#include <QEvent>
#include "qamousesensor.h"

QAMouseSensor::QAMouseSensor(QQuickItem* parent) : QQuickItem(parent)
{
    setAcceptedMouseButtons(Qt::LeftButton);
    setFiltersChildMouseEvents(true);
    timerId = 0;
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
    if (timerId != 0) {
        killTimer(timerId);
        timerId = 0;
    }

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

