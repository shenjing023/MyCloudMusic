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

void Network::get()
{
    QNetworkRequest request;
    request.setUrl(QUrl("http://192.168.217.147:5000/music/url?source=xiami&id=1795925587"));
    m_pManager->get(request);
//    connect(reply, static_cast<void(QNetworkReply::*)(QNetworkReply::NetworkError)>(&QNetworkReply::error),
//          [=](QNetworkReply::NetworkError code){ qDebug()<<"code:"<<code; });
}

void Network::slot_requestFinished(QNetworkReply *reply)
{
    //获取响应的信息，状态码
    QVariant code=reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);
    qDebug()<<code;

    //无错误
    if(reply->error()==QNetworkReply::NoError)
    {
        QByteArray bytes=reply->readAll();
        Q_EMIT sign_requestFinished(bytes);
    }
    else
    {
        qDebug()<<reply->errorString();
    }
    reply->deleteLater();
}
