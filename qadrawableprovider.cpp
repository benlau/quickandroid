#include <QtCore>
#include <QImageReader>
#include <QPainter>
#include <QColor>
#include "quickandroid.h"
#include "qadrawableprovider.h"

static QImage scaleIfValid(const QImage &image,const QSize& requestedSize) {
    QImage res = image;
    if (requestedSize.isValid()) {
        res = image.scaled(requestedSize,
                           Qt::IgnoreAspectRatio,
                           Qt::SmoothTransformation);
    }
    return res;
}

QADrawableProvider::QADrawableProvider() : QQuickImageProvider(QQmlImageProviderBase::Image)
{
    // 50MB
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
        image = scaleIfValid(image,requestedSize);
        return image;
    }

    // ID Parser.
    QUrl url(id);
    QString filename = url.path();
    QColor tintColor = parseTintColor(url.query());

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

    // Load from current DPI path

    QString dpi = resolutions.at(index).first;
    image = loadFileName(filename,dpi, tintColor);
    if (!image.isNull()) {
        insert(id,image);
        *size = image.size();
        image = scaleIfValid(image,requestedSize);
        return image;
    }

    for (int i = 0 ; i < resolutions.size() ; i++ ) {
        dpi = resolutions.at(i).first;
        qreal imageDp = resolutions.at(i).second;
        image = loadFileName(filename, dpi, tintColor, dp / imageDp);
        if (image.isNull())
            continue;

        insert(id,image);
        *size = image.size();
        image = scaleIfValid(image,requestedSize);
        return image;
    }

    // Load from drawable/ folder
    image = loadPrefix(m_basePath + "/drawable/" + filename, tintColor, 1.0);

    if (image.isNull()) {
        qWarning() << QString("Failed to load image://drawable/%1").arg(id);
    } else {
        insert(id,image);
        *size = image.size();
        image = scaleIfValid(image,requestedSize);
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
    int cost = image.byteCount();

    QImage *tmp = new QImage();
    *tmp = image;
    storage.insert(id,tmp,cost);
}

QImage QADrawableProvider::loadFileName(QString filename, QString dpi ,QColor tintColor, qreal scale)
{
    QString pathFormat("%1/drawable-%2/%3");
    QImage image;

    QString path = pathFormat.arg(m_basePath).arg(dpi).arg(filename);

    image = loadPrefix(path,tintColor, scale);

    return image;
}

QImage QADrawableProvider::loadPrefix(QString prefix, QColor tintColor, qreal scale)
{
    QImage image;
    QStringList exts;
    exts << ".png" << ".jpg" << ""; // In case extension is already included;

    for (int i = 0 ; i < exts.size();i++) {
        image = loadAbsPath(prefix + exts.at(i),tintColor, scale);
        if (!image.isNull())
            break;
    }

    return image;
}


QImage QADrawableProvider::loadAbsPath(QString path, QColor tintColor, qreal scale)
{
    QImage image;
    QFileInfo info(path);

    if (!info.exists())
        return image;

    QImageReader reader(path);

    if (scale != 1.0) {
        QSize size = reader.size();
        size.setWidth(size.width() * scale);
        size.setHeight(size.height() * scale);
        reader.setScaledSize(size);
    }

    image = reader.read();

    if (!image.isNull() && tintColor.isValid()) {
        image = colorize(image,tintColor);
    }

    if (image.isNull()) {
        qWarning() << QString("Failed to read %1 : %2").arg(path).arg(reader.errorString());
    }

    return image;
}

QColor QADrawableProvider::parseTintColor(const QString &query)
{
    QColor tintColor;

    QStringList token = query.split("&");

    Q_FOREACH(QString expression,token) {
        QStringList pair = expression.split("=");
        if (pair.size() != 2)
            continue;

        if (pair.at(0) != "tintColor")
            continue;

        QString color = pair.at(1);

        if (QColor::isValidColor(color)) {
            tintColor = QColor(color);
            break;
        }

        color = QString("#") + color;
        if (QColor::isValidColor(color)) {
            tintColor = QColor(color);
            break;
        }
    }

    return tintColor;
}

QImage QADrawableProvider::colorize(QImage src, QColor tintColor)
{
    if (src.format() != QImage::Format_ARGB32) {
        src = src.convertToFormat(QImage::Format_ARGB32);
    }

    QImage dst = QImage(src.size(), src.format());

    gray(dst,src);

    QPainter painter(&dst);

    QColor pureColor = tintColor;
    pureColor.setAlpha(255);

    painter.setCompositionMode(QPainter::CompositionMode_Screen);
    painter.fillRect(0,0,dst.width(),dst.height(),pureColor);
    painter.end();

    if (tintColor.alpha() != 255) {
        QImage buffer = QImage(src.size(), src.format());
        buffer.fill(QColor("transparent"));
        QPainter bufPainter(&buffer);
        qreal opacity = tintColor.alpha() / 255.0;
        bufPainter.setOpacity(opacity);
        bufPainter.drawImage(0,0,dst);
        bufPainter.end();
        dst = buffer;
    }

    if (src.hasAlphaChannel()) {
        dst.setAlphaChannel(src.alphaChannel());
    }

    return dst;
}

void QADrawableProvider::gray(QImage& dest,QImage& src)
{
    for (int y = 0; y < src.height(); ++y) {
        unsigned int *data = (unsigned int *)src.scanLine(y);
        unsigned int *outData = (unsigned int*)dest.scanLine(y);

        for (int x = 0 ; x < src.width(); x++) {
            int val = qGray(data[x]);
            outData[x] = qRgba(val,val,val,qAlpha(data[x]));
        }
    }

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


