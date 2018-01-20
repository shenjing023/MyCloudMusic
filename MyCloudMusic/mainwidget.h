#ifndef MAINWIDGET_H
#define MAINWIDGET_H

#include <QWidget>

class MainWidget : public QWidget
{
    Q_OBJECT

public:
    MainWidget(QWidget *parent = 0);
    ~MainWidget();

protected:
    virtual void paintEvent(QPaintEvent *event);    //窗口边框
    virtual void closeEvent(QCloseEvent *event);
};

#endif // MAINWIDGET_H
