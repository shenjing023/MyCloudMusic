#ifndef NETWORK_H
#define NETWORK_H

#include <QObject>
#include <QVariant>
#include <QSharedPointer>

class QNetworkReply;
class QNetworkAccessManager;

class Network : public QObject
{
    Q_OBJECT
public:
    explicit Network(QObject *parent = nullptr);

    Q_INVOKABLE void get();

signals:
    void sign_requestFinished(QVariant bytes);
    //void sign_requestError();

public slots:
    void slot_requestFinished(QNetworkReply*);

private:
    //static QSharedPointer<QNetworkAccessManager> m_pManager;
    QNetworkAccessManager *m_pManager;
};

#endif // NETWORK_H
