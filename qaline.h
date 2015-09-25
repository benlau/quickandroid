#ifndef QALINE_H
#define QALINE_H

#include <QQuickItem>
#include <QQuickPaintedItem>

class QALine : public QQuickPaintedItem
{
    Q_OBJECT
    Q_ENUMS(PenStyle)
    Q_PROPERTY(int orientation READ orientation WRITE setOrientation NOTIFY orientationChanged)
    Q_PROPERTY(PenStyle penStyle READ penStyle WRITE setPenStyle NOTIFY penStyleChanged)
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(qreal penWidth READ penWidth WRITE setPenWidth NOTIFY penWidthChanged)

public:
    enum PenStyle {
        SolidLine = Qt::SolidLine,
        DashLine = Qt::DashLine,
        DotLine = Qt::DotLine,
        DashDotLine = Qt::DashDotLine,
        DashDotDotLine = Qt::DashDotDotLine
    };

    QALine(QQuickItem* parent = 0);

    int orientation() const;
    void setOrientation(int orientation);

    PenStyle penStyle() const;
    void setPenStyle(const PenStyle &penStyle);

    QColor color() const;
    void setColor(const QColor &color);

    qreal penWidth() const;
    void setPenWidth(const qreal &penWidth);

signals:
    void orientationChanged();
    void colorChanged();
    void penWidthChanged();
    void penStyleChanged();

private:
    void paint(QPainter * painter);

    int m_orientation;
    PenStyle m_penStyle;
    QColor m_color;
    qreal m_penWidth;
};

#endif // QALINE_H
