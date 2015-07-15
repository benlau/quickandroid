#include "qasystemdispatcher.h"
#include "automator.h"

Automator::Automator(QObject *parent) : QObject(parent)
{

}

Automator::~Automator()
{

}

void Automator::start()
{
    connect(QASystemDispatcher::instance(),SIGNAL(dispatched(QString,QVariantMap)),
            this,SLOT(onDispatched(QString,QVariantMap)));
}

void Automator::onDispatched(QString name, QVariantMap message)
{
    if (name == "Automater::echo") {
        QASystemDispatcher::instance()->dispatch("Automater::response",message);
    }
}

