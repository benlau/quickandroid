#ifndef QADRAWABLEPROVIDER_H
#define QADRAWABLEPROVIDER_H

#include <QQuickImageProvider>
#include <QMap>
#include <QMutex>
#include <QCache>

class QADrawableProvider : public QQuickImageProvider
{
public:
    QADrawableProvider();

    QString basePath() const;

    /// Set the base path for resource loading
    void setBasePath(const QString &basePath);

    virtual QImage requestImage(const QString &id, QSize *size, const QSize& requestedSize);

    int limit() const;
    void setLimit(int limit);

private:

    bool contains(const QString &id);
    QImage get(const QString &id);
    void insert(const QString &id,QImage image);

    QImage tryLoad(QString dpi,QString id,qreal scale = 1.0);

    QString m_basePath;
    QCache<QString,QImage> storage;
    mutable QMutex mutex;

    int m_limit;
};

#endif // QADRAWABLEPROVIDER_H
