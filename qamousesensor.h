#ifndef QAMOUSESENSOR_H
#define QAMOUSESENSOR_H

#include <QQuickItem>

/*!
 * \brief MouseSensor is a non-blockable MouseArea item. It will propagate all the event to parent component.
 */

class QAMouseSensor : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QObject* filter READ filter WRITE setFilter NOTIFY filterChanged)
public:
    QAMouseSensor(QQuickItem* parent = 0);

    QObject *filter() const;
    void setFilter(QObject *filter);

signals:
    void pressAndHold();
    void filterChanged();

public slots:

protected:
    void mousePressEvent(QMouseEvent* event);
    void mouseMoveEvent(QMouseEvent* event);
    void mouseReleaseEvent(QMouseEvent* event);
    void timerEvent(QTimerEvent * event);
    bool eventFilter(QObject *, QEvent *);

private:
    void search(QObject* object,bool installFilter);

    int timerId;
    QObject* m_filter;
};

#endif // QAMOUSESENSOR_H
