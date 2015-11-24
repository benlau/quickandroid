#ifndef QAIMAGEWRITER_H
#define QAIMAGEWRITER_H

#include <QObject>
#include <QImage>

class QAImageWriter : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool running READ running WRITE setRunning NOTIFY runningChanged)
    Q_PROPERTY(QString fileUrl READ fileUrl WRITE setFileUrl NOTIFY fileUrlChanged)
    Q_PROPERTY(QImage image READ image WRITE setImage NOTIFY imageChanged)

public:
    explicit QAImageWriter(QObject *parent = 0);

    bool running() const;
    void setRunning(bool running);

    QString fileUrl() const;
    void setFileUrl(const QString &fileUrl);

    QImage image() const;
    void setImage(const QImage &image);

public slots:

    void save(QString fileUrl = QString());

    void clear();

signals:
    void runningChanged();
    void fileUrlChanged();
    void imageChanged();
    void finished();

private slots:

    void endSave(QString fileUrl);

private:
    bool m_running;
    QString m_fileUrl;
    QImage m_image;
};

#endif // QAIMAGEWRITER_H
