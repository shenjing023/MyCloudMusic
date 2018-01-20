#ifndef SINGLEAPPLICATION_H
#define SINGLEAPPLICATION_H

#include <QApplication>

class QLocalServer;
class QWidget;

class SingleApplication : public QApplication
{
    Q_OBJECT
public:
    explicit SingleApplication(int argc,char *argv[]);
    ~SingleApplication();
    //判断进程是否存在
    bool isRunning();

public:
    QWidget *m_pMainWidget;//主窗口

private slots:
    void newLocalConnection();

private:
    //初始化本地连接
    void initLocalConnection();
    //新建服务端
    void newLocalServer();
    //激活已存在的窗口
    void activedMainWidget();

private:
    bool m_isRunning;
    QLocalServer *m_localServer;
    QString m_serverName;   //服务名称
};

#endif // SINGLEAPPLICATION_H
