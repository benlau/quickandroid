#include <QtCore>
#include <QImage>
#include <QStringList>
#include <QCoreApplication>
#include <QLine>
#include <QColor>

QImage removeBorder(QImage input){
    QRect rect(0,0,input.width(),input.height());

    rect.setWidth(rect.width() - 2);
    rect.setHeight(rect.height() - 2);
    rect.moveTopLeft(QPoint(1,1));

    return input.copy(rect);
}

QLine extractBlackGuide(QImage input,QPoint start,bool hor) {
    QLine line;
    QPoint step(1,0);
    if (!hor) {
        // vertical movement
        step = QPoint(0,1);
    }

    QPoint pt = start;

    while (pt.x() < input.width() && pt.y() < input.height()) {
        if (input.pixel(pt) == 0xFF000000) {
            line.setP1(pt);
            break;
        }
        pt += step;
    }

    while (pt.x() < input.width() && pt.y() < input.height()) {
        if (input.pixel(pt) != 0xFF000000) {
            line.setP2(pt);
            break;
        }
        pt += step;
    }

    return line;
}

QList<QLine> extractBlackGuides(QImage input) {
    QList<QLine> result;
    result << extractBlackGuide(input,QPoint(0,0),true); // top
    result << extractBlackGuide(input,QPoint(input.width() - 1,0),false); // right
    result << extractBlackGuide(input,QPoint(0,input.height() -1),true); // bottom
    result << extractBlackGuide(input,QPoint(0,0),false); // left
    return result;
}

QString generateQml(QVariantMap data) {
    QFile file(":/template.qml");
    file.open(QIODevice::ReadOnly);
    QString templ = file.readAll();

    QMapIterator<QString, QVariant> iter(data);
    while (iter.hasNext()) {
        iter.next();
        QString field = QString("'%%1'").arg(iter.key());

        templ.replace(field,iter.value().toString());
    }

    return templ;
}

QString convertToCamelCase(QString input) {
    QStringList token = input.split("_");
    QStringList upperToken;
    foreach (QString item,token) {
        upperToken << item.at(0).toUpper() + item.mid(1);
    }
    return upperToken.join("");
}

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    if (a.arguments().size() != 2) {
        qWarning() << "ninepatchconverter input";
        return -1;
    }

    QString fileName = a.arguments().at(1);
    QImage input;

    if (!input.load(fileName)) {
        qCritical() << "Failed to load image:" << fileName;
        return -1;
    }

    if (input.size().width() <= 2 || input.size().height() <=2) {
        qCritical() << "The image is too small";
        return -1;
    }

    QFileInfo info(fileName);
    QString outputFileName = info.baseName() + ".png";

    QImage output = removeBorder(input);
    output.save(outputFileName,"PNG");

    qDebug() << "Saved" << outputFileName;

    QList<QLine> lines = extractBlackGuides(input);
    QLine top,left,right,bottom;
    top = lines.at(0);
    right = lines.at(1);
    bottom = lines.at(2);
    left = lines.at(3);

    QVariantMap data;
    data["left"] = top.isNull() ? 0 : top.p1().x() - 1;
    data["right"] = top.isNull() ? 0 : input.width() - top.p2().x() - 1;
    data["top"] = left.isNull() ? 0 : left.p1().y() - 1;
    data["bottom"] = left.isNull() ? 0 : input.height() - left.p2().y() - 1;

    data["fillAreaLeft"] = bottom.isNull() ? 0 : bottom.p1().x() - 1;
    data["fillAreaRight"] = bottom.isNull() ? 0 : input.width() - bottom.p2().x() - 1;
    data["fillAreaTop"] = right.isNull() ? 0 : right.p1().y() - 1;
    data["fillAreaBottom"] = right.isNull() ? 0 : input.height() - right.p2().y() - 1;
    data["source"] = QString("\"%1\"").arg(outputFileName);

    QString qml = generateQml(data);

    QString qmlFileName = convertToCamelCase(info.baseName()) + ".qml";
    QFile file(qmlFileName);
    if (!file.open(QIODevice::WriteOnly)) {
        qCritical() << "Failed to write" << qmlFileName;
        return -1;
    }

    QTextStream stream(&file);
    stream << qml;
    file.close();

    qDebug() << "Saved" << qmlFileName;
    return 0;
}
