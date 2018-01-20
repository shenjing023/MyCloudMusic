#include "mainwidget.h"
#include "./SingleApplicationHelper/singleapplication.h"
#include <QFile>
#include <QSystemTrayIcon>
#include <QMessageBox>

int main(int argc, char *argv[])
{
    SingleApplication a(argc, argv);
    if(!a.isRunning())
    {
        QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
        QCoreApplication::setAttribute(Qt::AA_UseSoftwareOpenGL);
        //判断是否支持系统托盘
        if(!QSystemTrayIcon::isSystemTrayAvailable())
        {
            QMessageBox::critical(NULL,QObject::tr("Warning"),QObject::tr("No support systemtrayicon"));
            exit(0);
        }
        QFile qss(":/style.qss");
        qss.open(QFile::ReadOnly);
        qApp->setStyleSheet(qss.readAll());
        qss.close();
        MainWidget w;
        a.m_pMainWidget=&w;
        w.show();

        return a.exec();
    }
    return 0;
}
