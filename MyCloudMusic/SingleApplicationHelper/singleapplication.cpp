#include "singleapplication.h"
#include <QLocalServer>
#include <QLocalSocket>
#include <QFileInfo>
#include <QWidget>
#include <QSettings>

SingleApplication::SingleApplication(int argc,char *argv[]):QApplication(argc,argv)
    ,m_isRunning(false)
    ,m_pMainWidget(Q_NULLPTR)
    ,m_localServer(Q_NULLPTR)
{
    // 取应用程序名作为LocalServer的名字
    m_serverName = QFileInfo(QCoreApplication::applicationFilePath()).fileName();
    initLocalConnection();
}

SingleApplication::~SingleApplication()
{

}

void SingleApplication::initLocalConnection()
{
    m_isRunning=false;
    QLocalSocket socket;
    //连接本地服务
    socket.connectToServer(m_serverName);
    if(socket.waitForConnected(500))
    {
        //连接成功
        m_isRunning=true;
        return;
    }
    //连接失败,新建一个
    newLocalServer();
}

void SingleApplication::newLocalServer()
{
    m_localServer=new QLocalServer(this);
    connect(m_localServer,&QLocalServer::newConnection,this,&SingleApplication::newLocalConnection);
    if(!m_localServer->listen(m_serverName))
    {
        //监听失败，可能是程序崩溃时残留进程服务导致的,移除
        if(m_localServer->serverError() == QAbstractSocket::AddressInUseError)
        {
            QLocalServer::removeServer(m_serverName);
            m_localServer->listen(m_serverName); // 再次监听
        }
    }
}

void SingleApplication::newLocalConnection()
{
    QLocalSocket *socket =m_localServer->nextPendingConnection();
    if(socket!=NULL)
    {
        socket->waitForReadyRead(1000);
        delete socket;
        socket=NULL;
        activedMainWidget();
    }
}

void SingleApplication::activedMainWidget()
{
    if(m_pMainWidget!=Q_NULLPTR)
    {
        QSettings settings("MyCompany", "MyApp");
        m_pMainWidget->restoreGeometry(settings.value("geometry").toByteArray());
        if(m_pMainWidget->windowState()==Qt::WindowMaximized)
            m_pMainWidget->showMaximized();
        else
            m_pMainWidget->show();
        m_pMainWidget->raise();
        m_pMainWidget->activateWindow();
    }
}

bool SingleApplication::isRunning()
{
    return m_isRunning;
}
