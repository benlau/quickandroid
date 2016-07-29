#include "qaunits.h"
#include "qadevice.h"

QAUnits::QAUnits(QObject *parent) : QObject(parent)
{

}

qreal QAUnits::dp(qreal value) const
{
    return QADevice::readDp() * value;
}
