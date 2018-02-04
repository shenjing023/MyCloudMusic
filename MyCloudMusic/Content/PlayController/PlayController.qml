/*
  窗口底部的播放控制器
  */
import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    id: root
    //anchors.fill: parent
    color: "#222225"

    Row {
        id: playBtnRow
        anchors.left: parent.left
        anchors.leftMargin: 30
        width: 220
        height: parent.height
        spacing: 25

        //上一首
        Button {
            id: previousBtn
            width: 30
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            text: "\ued06"

            background: Rectangle{
                anchors.fill: parent
                color: root.color
            }

            contentItem: Label {
                anchors.fill: parent
                text: previousBtn.text
                color: previousBtn.hovered ? "white" : "#5a5a5c"
                font.pixelSize: 30
                font.family: icomoonFont.name
                verticalAlignment: Label.AlignVCenter
                horizontalAlignment: Label.AlignHCenter
            }

            ToolTip.visible: previousBtn.hovered
            ToolTip.delay: 500
            ToolTip.text: "上一首"

            onClicked: {

            }
        }

        //播放或暂停
        Button {
            id: playBtn
            width: 35
            height: 35
            anchors.verticalCenter: parent.verticalCenter
            text: "\ued03"
            state: "pause"

            background: Rectangle{
                anchors.fill: parent
                color: root.color
            }

            contentItem: Label {
                anchors.fill: parent
                //anchors.verticalCenter: parent.verticalCenter

                text: playBtn.text
                color: playBtn.hovered ? "white" : "#5a5a5c"
                font.pixelSize: 35
                font.family: icomoonFont.name
                verticalAlignment: Label.AlignVCenter
                horizontalAlignment: Label.AlignHCenter
            }

            states: [
                State {
                    name: "play"
                    PropertyChanges {
                        target: playBtn
                        text: "\ued04"
                        ToolTip.text: "暂停"
                    }
                },
                State {
                    name: "pause"
                    PropertyChanges {
                        target: playBtn
                        text: "\ued03"
                        ToolTip.text: "播放"
                    }
                }
            ]

            ToolTip.visible: playBtn.hovered
            ToolTip.delay: 500
            ToolTip.text: "播放"

            onClicked: {
                if (playBtn.state === "play") {
                    playBtn.state = "pause"
                } else {
                    playBtn.state = "play"
                }
            }
        }

        //下一首
        Button {
            id: nextBtn
            width: 30
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            text: "\ued07"

            background: Rectangle{
                anchors.fill: parent
                color: root.color
            }

            contentItem: Label {
                anchors.fill: parent
                text: nextBtn.text
                color: nextBtn.hovered ? "white" : "#5a5a5c"
                font.pixelSize: 30
                font.family: icomoonFont.name
                verticalAlignment: Label.AlignVCenter
                horizontalAlignment: Label.AlignHCenter
            }

            ToolTip.visible: nextBtn.hovered
            ToolTip.delay: 500
            ToolTip.text: "下一首"

            onClicked: {

            }
        }
    }

    //当前歌曲已播放多长时间
    Label {
        id: playedTime
        anchors.left: playBtnRow.right
        anchors.leftMargin: 10
        width: 50
        height: parent.height
        text: "00:00"
        color: "#d2d3da"
        font.pixelSize: 14
        font.family: "Microsoft YaHei"
        verticalAlignment: Label.AlignVCenter
        horizontalAlignment: Label.AlignRight
    }

    //歌曲播放进度条
    PlaySlider {
        id: playSlider
        anchors {
            //通过左右位置来设置width，但是会出现Binding loop detected for property "implicitWidth"，效果却是对的
            left: playedTime.right
            leftMargin: 3
            right: totalTime.left
            rightMargin: 3
            verticalCenter: parent.verticalCenter
        }
        //width: 400
        height: 15
        minValue: 0.0
        maxValue: 10.0

        onValueChanged: {

        }
    }

    //歌曲时长
    Label {
        id: totalTime
        anchors.right: volumeLabel.left
        anchors.rightMargin: 15
        width: 50
        height: parent.height
        text: "00:00"
        color: "#d2d3da"
        font.pixelSize: 14
        font.family: "Microsoft YaHei"
        verticalAlignment: Label.AlignVCenter
        horizontalAlignment: Label.AlignLeft
    }

    //音量调节图标
    Button {
        property real currentVolume: 50 //当前的音量
        id: volumeLabel
        anchors.right: volumeSlider.left
        anchors.rightMargin: 3
        anchors.verticalCenter: parent.verticalCenter
        width: 30
        height: 30
        text: "\ued15"
        state: "volume"

        background: Rectangle{
            anchors.fill: parent
            color: root.color
        }

        contentItem: Label {
            anchors.fill: parent
            text: volumeLabel.text
            color: volumeLabel.hovered ? "white" : "#5a5a5c"
            font.pixelSize: 30
            font.family: icomoonFont.name
            verticalAlignment: Label.AlignVCenter
            horizontalAlignment: Label.AlignHCenter
        }

        ToolTip.visible: volumeLabel.hovered
        ToolTip.delay: 500
        ToolTip.text: "静音"

        states: [
            State {
                name: "volume"
                PropertyChanges {
                    target: volumeLabel
                    text: "\ued15"
                    ToolTip.text: "静音"
                }
            },
            State {
                name: "mutex"
                PropertyChanges {
                    target: volumeLabel
                    text: "\ued17"
                    ToolTip.text: "恢复音量"
                }
            }
        ]

        onClicked: {
            if (volumeLabel.state === "volume") {
                volumeLabel.state = "mutex"
                volumeLabel.currentVolume=volumeSlider.value
                volumeSlider.value=0
            } else {
                volumeLabel.state = "volume"
                volumeSlider.value=volumeLabel.currentVolume
            }
        }
    }

    //音量调节
    PlaySlider {
        id: volumeSlider
        anchors.right: playOrder.left
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        width: 100
        height: 15
        minValue: 0.0
        maxValue: 100.0
        isVisible: false
        value: 50

        onValueChanged: {

        }
    }

    //播放顺序
    Button {
        id: playOrder
        anchors.right: playlist.left
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        width: 40
        height: 30
        text: "\uf904"
        state: "order"

        background: Rectangle{
            anchors.fill: parent
            color: root.color
        }

        contentItem: Label {
            anchors.fill: parent
            text: playOrder.text
            color: playOrder.hovered ? "white" : "#5a5a5c"
            font.pixelSize: 30
            font.family: icomoonFont.name
            verticalAlignment: Label.AlignVCenter
            horizontalAlignment: Label.AlignHCenter
        }

        ToolTip.visible: playOrder.hovered
        ToolTip.delay: 500
        ToolTip.text: "顺序播放"

        states: [
            State {
                name: "order"
                PropertyChanges {
                    target: playOrder
                    text: "\uf904"
                    ToolTip.text: "顺序播放"
                }
            },
            State {
                name: "list"
                PropertyChanges {
                    target: playOrder
                    text: "\uf922"
                    ToolTip.text: "列表循环"
                }
            },
            State {
                name: "single"
                PropertyChanges {
                    target: playOrder
                    text: "\uf923"
                    ToolTip.text: "单曲循环"
                }
            },
            State {
                name: "random"
                PropertyChanges {
                    target: playOrder
                    text: "\uf962"
                    ToolTip.text: "随机播放"
                }
            }
        ]

        onClicked: {
            switch (playOrder.state) {
            case "order":
                playOrder.state = "list"
                break
            case "list":
                playOrder.state = "single"
                break
            case "single":
                playOrder.state = "random"
                break
            case "random":
                playOrder.state = "order"
                break
            }
        }
    }

    //歌曲列表
    Button {
        id: playlist
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        width: 30
        height: 30
        text: "\ueb9f"

        ToolTip.visible: playlist.hovered
        ToolTip.delay: 500
        ToolTip.text: "打开播放列表"

        background: Rectangle{
            anchors.fill: parent
            color: root.color
        }

        contentItem: Label {
            anchors.fill: parent
            text: playlist.text
            color: playlist.hovered ? "white" : "#5a5a5c"
            font.pixelSize: 30
            font.family: icomoonFont.name
            verticalAlignment: Label.AlignVCenter
            horizontalAlignment: Label.AlignHCenter
        }

        onClicked: {

        }
    }
}
