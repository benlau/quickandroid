#ifndef QAMOUSESENSOR_H
#define QAMOUSESENSOR_H

#include <QQuickItem>

/// MouseSensor is a non-blockable MouseArea item. It will propagate all the event to parent component.

class QAMouseSensor : public QQuickItem
{
    Q_OBJECT
public:
    QAMouseSensor(QQuickItem* parent = 0);

signals:
    void pressAndHold();

public slots:

protected:
    void mousePressEvent(QMouseEvent* event);
    void mouseMoveEvent(QMouseEvent* event);
    void mouseReleaseEvent(QMouseEvent* event);
    void timerEvent(QTimerEvent * event);

private:
    int timerId;
};

#endif // QAMOUSESENSOR_H
