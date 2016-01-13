#include <QtCore>
#include <QRunnable>
#include <QImageWriter>
#include "qaimagewriter.h"

class QAImageWriterRunnable : public QRunnable {
public:
    QPointer<QAImageWriter> owner;
    QImage image;
    QString fileUrl;

    void run() {
        if (fileUrl.isNull()) { // Save as temp
            QTemporaryFile tmp;
            QStringList paths = QStandardPaths::standardLocations(QStandardPaths::TempLocation);
            QString tmpPath = paths.at(0);

            tmp.setFileTemplate(tmpPath + "/XXXXXX.jpg");
            tmp.open();
            fileUrl = tmp.fileName();
            tmp.close();
        }

        image.save(fileUrl);
        QImageWriter writer;
        writer.setFileName(fileUrl);
        if (!writer.write(image)) {
            qWarning() << QString("Failed to save %1 : %2").arg(fileUrl).arg(writer.errorString());
        }

        if (!owner.isNull()) {
            QMetaObject::invokeMethod(owner.data(),"endSave",Qt::QueuedConnection,
                                      Q_ARG(QString,fileUrl));
        }
    }
};


QAImageWriter::QAImageWriter(QObject *parent) : QObject(parent)
{
    m_running = false;
}

bool QAImageWriter::running() const
{
    return m_running;
}

void QAImageWriter::setRunning(bool running)
{
    m_running = running;
    emit runningChanged();
}

QString QAImageWriter::fileUrl() const
{
    return m_fileUrl;
}

void QAImageWriter::setFileUrl(const QString &fileUrl)
{
    m_fileUrl = fileUrl;
    emit fileUrlChanged();
}

QImage QAImageWriter::image() const
{
    return m_image;
}

void QAImageWriter::setImage(const QImage &image)
{
    m_image = image;
    emit imageChanged();
}

void QAImageWriter::save(QString fileUrl)
{
    if (!fileUrl.isNull()) {
        setFileUrl(fileUrl);
    }

    if (m_running) {
        qWarning() << "ImageWriter::save() - It is already running.";
        return;
    }

    if (m_image.isNull()) {
        qWarning() << "ImageWriter::save() - image is null.";
        return;
    }

    setRunning(true);

    QAImageWriterRunnable* saver = new QAImageWriterRunnable();
    saver->setAutoDelete(true);
    saver->owner = this;
    saver->fileUrl = m_fileUrl;
    saver->image = m_image;

    QThreadPool::globalInstance()->start(saver);
}

void QAImageWriter::clear()
{
    setImage(QImage());
    setFileUrl("");
}

void QAImageWriter::endSave(QString fileUrl)
{
    setFileUrl(fileUrl);
    setRunning(false);
    emit finished();
}

