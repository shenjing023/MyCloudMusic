#include "network.h"
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QDebug>


//QSharedPointer<QNetworkAccessManager> Network::m_pManager=QSharedPointer<QNetworkAccessManager>(new QNetworkAccessManager());
//QNetworkAccessManager* Network::m_pManager=new QNetworkAccessManager();
Network::Network(QObject *parent) : QObject(parent)
{
    m_pManager=new QNetworkAccessManager(this);
    connect(m_pManager,SIGNAL(finished(QNetworkReply*)),this,SLOT(slot_requestFinished(QNetworkReply*)));
}

void Network::get(const QString &url)
{
    QNetworkRequest request;
    request.setUrl(QUrl("http://192.168.2.108:8000"+url));
    m_pManager->get(request);
}

void Network::slot_requestFinished(QNetworkReply *reply)
{
    //获取响应的信息，状态码
//    QVariant code=reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
//    qDebug()<<code;

    //无错误
    if(reply->error()==QNetworkReply::NoError)
    {
        QByteArray bytes=reply->readAll();
        Q_EMIT sign_requestFinished(bytes);
    }
    else
    {
        Q_EMIT sign_requestError();
    }
    reply->deleteLater();
}
