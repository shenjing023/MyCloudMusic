#ifndef TITLEBARHELPER_H
#define TITLEBARHELPER_H

#include <QWidget>

class QLabel;
class QPushButton;
class QLineEdit;

class TitleBar : public QWidget
{
    Q_OBJECT
public:
    explicit TitleBar(QWidget *parent = nullptr);
    ~TitleBar();

protected:
    // 双击标题栏进行界面的最大化/还原
    virtual void mouseDoubleClickEvent(QMouseEvent *event);
    // 设置界面标题与图标
        virtual bool eventFilter(QObject *obj, QEvent *event);

signals:

public slots:

private slots:
    // 进行最小化、最大化/还原、关闭操作
        void onClicked();

private:
        // 最大化/还原
            void updateMaximize();

private:
    QLabel *m_pIconLabel;
    QLabel *m_pTitleLabel;
    QPushButton *m_pMinimizeButton;
    QPushButton *m_pMaximizeButton;
    QPushButton *m_pCloseButton;
//    QLineEdit *m_pSearchLineEdit;   //搜索框
//    QPushButton *m_pSearchButton;

};

#endif // TITLEBARHELPER_H
