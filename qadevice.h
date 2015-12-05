#ifndef QADEVICE
#define QADEVICE

#include <QObject>

class QADevice : public QObject {
    Q_OBJECT
    Q_PROPERTY(qreal dp READ dp NOTIFY dpChanged)
    Q_PROPERTY(qreal dpi READ dpi NOTIFY dpiChanged)
    Q_PROPERTY(bool isTablet READ isTablet NOTIFY isTabletChanged)

public:
    QADevice(QObject* parent = 0);

    qreal dp() const;
    qreal dpi() const;
    qreal isTablet() const;

    static qreal readDp();

signals:
    void dpChanged();
    void dpiChanged();
    void isTabletChanged();

private:

};

#endif // QADEVICE

