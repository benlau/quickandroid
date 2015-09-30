#pragma once

#include <QObject>

/// Proxy of other MouseArea
class QAMouseAreaProxy : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QObject* source READ source WRITE setSource NOTIFY sourceChanged)
public:
    explicit QAMouseAreaProxy(QObject *parent = 0);

    QObject *source() const;
    void setSource(QObject *source);

signals:
    void sourceChanged();
    void pressAndHold();
    void clicked();

public slots:

protected:

private:
    void searchMouseArea(QObject* object);

    QObject* m_source;
    QObject* m_watched;
};

