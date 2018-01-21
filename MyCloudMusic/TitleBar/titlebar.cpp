/*******
 *来自http://blog.csdn.net/liang19890820/article/details/50555298，感谢
*******/

#include "titlebar.h"
#include <QLabel>
#include <QPushButton>
#include <QHBoxLayout>
#include <QStyle>
#include <QEvent>
#include <QMouseEvent>
#include <QLineEdit>

TitleBar::TitleBar(QWidget *parent) : QWidget(parent)
{
    //setObjectName(QStringLiteral("titleBar_widget"));
    //使用qss的方式设置背景没作用，还不知道原因，只能用如下方式
//    QPalette pal(palette());
//    pal.setColor(QPalette::Background, QColor(0, 153, 205));
//    setAutoFillBackground(true);
//    setPalette(pal);
    setFixedHeight(30);
    m_pIconLabel = new QLabel(this);
    m_pTitleLabel = new QLabel(this);
    m_pMinimizeButton = new QPushButton(this);
    m_pMaximizeButton = new QPushButton(this);
    m_pCloseButton = new QPushButton(this);

    //搜索框
//    m_pSearchLineEdit=new QLineEdit(this);
//    m_pSearchLineEdit->setObjectName("titleBar_search_lineEdit");
//    m_pSearchLineEdit->setFixedWidth(250);
//    m_pSearchButton = new QPushButton(this);
//    m_pSearchButton->setObjectName("titleBar_search_button");
//    m_pSearchButton->setCursor(Qt::PointingHandCursor);
//    m_pSearchButton->setFixedSize(22, 22);
//    m_pSearchButton->setToolTip(QStringLiteral("搜索"));
//    //防止文本框输入内容位于按钮之下
//    QMargins margins = m_pSearchLineEdit->textMargins();
//    m_pSearchLineEdit->setTextMargins(margins.left()+5, margins.top(), m_pSearchButton->width(), margins.bottom());
//    m_pSearchLineEdit->setPlaceholderText(QStringLiteral("请输入搜索内容"));
//    QHBoxLayout *pSearchLayout = new QHBoxLayout();
//    pSearchLayout->addStretch();
//    pSearchLayout->addWidget(m_pSearchButton);
//    pSearchLayout->setSpacing(0);
//    pSearchLayout->setContentsMargins(0, 0, 0, 0);
//    m_pSearchLineEdit->setLayout(pSearchLayout);

    //设置按钮样式
    QPixmap pix=style()->standardPixmap(QStyle::SP_TitleBarCloseButton);
    m_pCloseButton->setIcon(pix);
    pix=style()->standardPixmap(QStyle::SP_TitleBarMaxButton);
    m_pMaximizeButton->setIcon(pix);
    pix=style()->standardPixmap(QStyle::SP_TitleBarMinButton);
    m_pMinimizeButton->setIcon(pix);

    m_pIconLabel->setObjectName("titleBar_icon_label");
    m_pTitleLabel->setObjectName("titleBar_title_label");
    m_pMaximizeButton->setObjectName("titleBar_maxBtn_button");
    m_pMinimizeButton->setObjectName("titleBar_minBtn_button");
    m_pCloseButton->setObjectName("titleBar_closeBtn_button");

    m_pCloseButton->setToolTip(QStringLiteral("关闭"));
    m_pMaximizeButton->setToolTip(QStringLiteral("最大化"));
    m_pMinimizeButton->setToolTip(QStringLiteral("最小化"));

    m_pIconLabel->setFixedSize(20, 20);
    m_pIconLabel->setScaledContents(true);
    m_pTitleLabel->setFixedWidth(200);

    m_pMinimizeButton->setFixedSize(27, height());
    m_pMaximizeButton->setFixedSize(27, height());
    m_pCloseButton->setFixedSize(27, height());

    QHBoxLayout *pLayout = new QHBoxLayout(this);
    pLayout->addWidget(m_pIconLabel);
    pLayout->addSpacing(5);
    pLayout->addWidget(m_pTitleLabel);
    pLayout->addSpacing(20);
    //pLayout->addWidget(m_pSearchLineEdit);
    pLayout->addStretch(0);
    pLayout->addSpacing(200);
    pLayout->addWidget(m_pMinimizeButton);
    pLayout->addWidget(m_pMaximizeButton);
    pLayout->addWidget(m_pCloseButton);
    pLayout->setSpacing(0);
    pLayout->setContentsMargins(10, 0, 0, 0);

    setLayout(pLayout);

    connect(m_pCloseButton,SIGNAL(clicked(bool)),this,SLOT(onClicked()));
    connect(m_pMaximizeButton,SIGNAL(clicked(bool)),this,SLOT(onClicked()));
    connect(m_pMinimizeButton,SIGNAL(clicked(bool)),this,SLOT(onClicked()));
}

TitleBar::~TitleBar()
{

}

void TitleBar::mouseDoubleClickEvent(QMouseEvent *event)
{
    Q_UNUSED(event);
    emit m_pMaximizeButton->clicked();
}

bool TitleBar::eventFilter(QObject *obj, QEvent *event)
{
    switch (event->type())
    {
    case QEvent::WindowTitleChange:
    {
        QWidget *pWidget = qobject_cast<QWidget *>(obj);
        if (pWidget)
        {
            m_pTitleLabel->setText(pWidget->windowTitle());
            return true;
        }
    }
    case QEvent::WindowIconChange:
    {
        QWidget *pWidget = qobject_cast<QWidget *>(obj);
        if (pWidget)
        {
            QIcon icon = pWidget->windowIcon();
            m_pIconLabel->setPixmap(icon.pixmap(m_pIconLabel->size()));
            return true;
        }
    }
    case QEvent::WindowStateChange:
    case QEvent::Resize:
        updateMaximize();
        return true;
    }
    return QWidget::eventFilter(obj, event);
}

void TitleBar::onClicked()
{
    QPushButton *pButton = qobject_cast<QPushButton *>(sender());
    QWidget *pWindow = this->window();
    if (pWindow->isTopLevel())
    {
        if (pButton == m_pMinimizeButton)
        {
            pWindow->showMinimized();
        }
        else if (pButton == m_pMaximizeButton)
        {
            pWindow->isMaximized() ? pWindow->showNormal() : pWindow->showMaximized();
        }
        else if (pButton == m_pCloseButton)
        {
            pWindow->close();
        }
    }
}

void TitleBar::updateMaximize()
{
    QWidget *pWindow = this->window();
    if (pWindow->isTopLevel())
    {
        bool bMaximize = pWindow->isMaximized();
        if (bMaximize)
        {
            m_pMaximizeButton->setToolTip(QStringLiteral("还原"));
            QPixmap pix=style()->standardPixmap(QStyle::SP_TitleBarNormalButton);
            m_pMaximizeButton->setIcon(pix);
        }
        else
        {
            m_pMaximizeButton->setToolTip(QStringLiteral("最大化"));
            QPixmap pix=style()->standardPixmap(QStyle::SP_TitleBarMaxButton);
            m_pMaximizeButton->setIcon(pix);
        }
    }
}
