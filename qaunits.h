#ifndef QAUNITS_H
#define QAUNITS_H

#include <QObject>

class QAUnits : public QObject
{
    Q_OBJECT
public:
    explicit QAUnits(QObject *parent = 0);

signals:

public slots:

    qreal dp(qreal value) const;
};

#endif // QAUNITS_H
