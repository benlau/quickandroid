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

    /// Get the cache size limit
    int limit() const;

    /// Set the cache size limit by bytes
    void setLimit(int limit);

private:

    bool contains(const QString &id);
    QImage get(const QString &id);
    void insert(const QString &id,QImage image);

    QImage loadFileName(QString filename,QString dpi,QColor tintColor,qreal scale = 1.0);

    QImage loadPrefix(QString prefix,QColor tintColor, qreal scale = 1.0);

    QImage loadAbsPath(QString path,QColor tintColor, qreal scale = 1.0);

    QColor parseTintColor(const QString& query);

    QImage colorize(QImage image,QColor color);

    void gray(QImage&dest, QImage& image);

    QString m_basePath;
    QCache<QString,QImage> storage;
    mutable QMutex mutex;

    int m_limit;
};

#endif // QADRAWABLEPROVIDER_H
