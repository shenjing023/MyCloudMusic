#ifndef SYSTEMTRAY_H
#define SYSTEMTRAY_H

#include <QSystemTrayIcon>

class QWidget;

class SystemTray : public QSystemTrayIcon
{
    Q_OBJECT
public:
    explicit SystemTray(QWidget *parent=nullptr);
    ~SystemTray();

private slots:
    void slot_activatedSysTrayIcon(QSystemTrayIcon::ActivationReason reason);

private:
    QWidget *m_pWidget;

};

#endif // SYSTEMTRAY_H
