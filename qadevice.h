#ifndef QADEVICE
#define QADEVICE

#include <QObject>

class QADevice : public QObject {
    Q_OBJECT
    Q_PROPERTY(qreal dp READ dp NOTIFY dpChanged)
    Q_PROPERTY(qreal dpi READ dpi NOTIFY dpiChanged)

public:
    QADevice(QObject* parent = 0);

    qreal dp();
    qreal dpi();

    static qreal readDp();

signals:
    void dpChanged();
    void dpiChanged();

private:

};

#endif // QADEVICE

