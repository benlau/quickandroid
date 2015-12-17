#include <QPainter>
#include "qadevice.h"
#include "qaline.h"

QALine::QALine(QQuickItem* parent) : QQuickPaintedItem(parent)
{
    setFlag(QQuickItem::ItemHasContents,true);
    m_orientation = Qt::Horizontal;
    m_penWidth = 1;
    m_penStyle = SolidLine;
    m_color = Qt::black;
}

void QALine::paint(QPainter *painter)
{
    painter->save();

    QPen pen;
    pen.setStyle((Qt::PenStyle) m_penStyle);
    pen.setWidth(m_penWidth);
    pen.setColor(m_color);

//    qreal dp = QADevice::dp();
//    QVector<qreal> pattern = pen.dashPattern();
//    for (int i = 0 ; i < pattern.size() ; i++) {
//        pattern[i] = pattern[i] * dp;
//    }
//    pen.setDashPattern(pattern);

    painter->setPen(pen);

    QBrush brush;
    brush.setStyle(Qt::SolidPattern);
    brush.setColor(m_color);
    painter->setBrush(brush);

    qreal x1,x2,y1,y2;

    if (m_orientation == Qt::Horizontal) {
        x1 = 0;
        x2 = width();
        y1 = height() / 2;
        y2 = y1;
    } else {
        x1 = width() / 2.0;
        x2 = x1;
        y1 = 0;
        y2 = height();
    }

    QLineF line(x1,y1,x2,y2);
    painter->drawLine(line);

    painter->restore();
}

qreal QALine::penWidth() const
{
    return m_penWidth;
}

void QALine::setPenWidth(const qreal &penWidth)
{
    m_penWidth = penWidth;
    update();
    emit penWidthChanged();
}

QColor QALine::color() const
{
    return m_color;
}

void QALine::setColor(const QColor &color)
{
    m_color = color;
    update();
    emit colorChanged();
}

QALine::PenStyle QALine::penStyle() const
{
    return m_penStyle;
}

void QALine::setPenStyle(const PenStyle &penStyle)
{
    m_penStyle = penStyle;
    update();
    emit penStyleChanged();
}

int QALine::orientation() const
{
    return m_orientation;
}

void QALine::setOrientation(int orientation)
{
    m_orientation = orientation;
    update();
    emit orientationChanged();
}
