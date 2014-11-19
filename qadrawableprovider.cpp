#include <QtCore>
#include <QImageReader>
#include "quickandroid.h"
#include "qadrawableprovider.h"

QADrawableProvider::QADrawableProvider() : QQuickImageProvider(QQmlImageProviderBase::Image)
{
    setLimit(50 *1024 * 1024);
}

QString QADrawableProvider::basePath() const
{
    return m_basePath;
}

void QADrawableProvider::setBasePath(const QString &basePath)
{
    m_basePath = basePath;

    if (m_basePath.indexOf("qrc://") == 0)
        m_basePath.replace(QRegExp("^qrc://"),":");
}

QImage QADrawableProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    Q_UNUSED(requestedSize);
    QImage image;

    if (contains(id)) {
        image = get(id);
        *size = image.size();
        return get(id);
    }

    QList<QPair<QString,qreal> > resolutions;

    resolutions << QPair<QString,qreal>("xxxhdpi",4)
                << QPair<QString,qreal>("xxhdpi",3)
                << QPair<QString,qreal>("xhdpi",2)
                << QPair<QString,qreal>("hdpi",1.5)
                << QPair<QString,qreal>("mdpi",1)
                << QPair<QString,qreal>("ldpi",0.75);

    qreal dp = QuickAndroid::dp(); // Try the best solution
    int index = -1;
    for (int i = 0 ; i < resolutions.size() ; i++ ) {
        if (resolutions.at(i).second == dp) {
            index = i;
            break;
        }
    }

    if (index < 0) {
        qWarning() << "Unknown DP!?";
        index = 0;
    }

    QString dpi = resolutions.at(index).first;
    image = tryLoad(dpi,id);
    if (!image.isNull()) {
        insert(id,image);
        *size = image.size();
        return image;
    }

    for (int i = 0 ; i < resolutions.size() ; i++ ) {
        dpi = resolutions.at(i).first;
        qreal imageDp = resolutions.at(i).second;
        image = tryLoad(dpi,id , dp / imageDp);
        if (image.isNull())
            continue;

        insert(id,image);
        *size = image.size();
        break;
    }

    return image;
}

bool QADrawableProvider::contains(const QString &id)
{
    QMutexLocker locker(&mutex);
    Q_UNUSED(locker);

    return storage.contains(id);
}

QImage QADrawableProvider::get(const QString &id)
{
    QMutexLocker locker(&mutex);
    Q_UNUSED(locker);

    return *storage[id];
}

void QADrawableProvider::insert(const QString &id, QImage image)
{
    QMutexLocker locker(&mutex);
    Q_UNUSED(locker);
    QSize size = image.size();
    int cost = size.width() * size.height();

    QImage *tmp = new QImage();
    *tmp = image;
    storage.insert(id,tmp,cost);
}

QImage QADrawableProvider::tryLoad(QString dpi, QString id,qreal scale)
{
    QString pathFormat("%1/drawable-%2/%3%4");
    QImage image;
    QStringList exts;
    exts << ".png" << ".jpg" << ""; // In case extension is already included;

    for (int i = 0 ; i < exts.size();i++) {
        QString path = pathFormat.arg(m_basePath).arg(dpi).arg(id).arg(exts.at(i));

        QFileInfo info(path);

        if (!info.exists())
            continue;

        QImageReader reader(path);

        if (scale != 1.0) {
            QSize size = reader.size();
            size.setWidth(size.width() * scale);
            size.setHeight(size.height() * scale);
            reader.setScaledSize(size);
        }

        image = reader.read();

        if (image.isNull()) {
            qWarning() << QString("image://drawable/%1 is failed to read: %2").arg(id).arg(reader.errorString());
        }
        break;
    }

    return image;
}

int QADrawableProvider::limit() const
{
    return m_limit;
}

void QADrawableProvider::setLimit(int limit)
{
    QMutexLocker locker(&mutex);
    Q_UNUSED(locker);

    m_limit = limit;

}


