/*
  窗口底部的播放控制器
  */
import QtQuick 2.9
import QtQuick.Controls 2.2
import QtMultimedia 5.9
import Network 1.0

Rectangle {
    property string song_url: "" //歌曲的url
    property string pic_url: "" //歌曲专辑图片
    property int song_length: 0 //歌曲的长度
    property string song_name: ""
    property string singer: ""
    id: root
    color: "#222225"

    //格式化歌曲长度
    function durationFormat(length) {
        var m = parseInt(length / 60) >= 10 ? parseInt(
                                                  length / 60) : "0" + parseInt(
                                                  length / 60)
        var s = parseInt(length % 60) >= 10 ? parseInt(
                                                  length % 60) : "0" + parseInt(
                                                  length % 60)
        return m + ":" + s
    }

    Network {
        id: network
        onSign_requestFinished: {
            var data = JSON.parse(bytes)
            console.log(data['song_url'])
            var url = data['song_url']
            mediaplayer.source = url
            mediaplayer.play()
        }
    }

    MediaPlayer {
        id: mediaplayer
        volume: volumeSlider.volume

        onError: {

        }
        onPlaying: {
            playBtn.state = "play"
        }
        onStopped: {
            playBtn.state = "pause"
        }
        onSourceChanged: {

        }
        onPositionChanged: {
            if (!playSlider.isPressed)
                playSlider.value = position / 1000
        }
    }

    onSong_urlChanged: {
        network.get("/music/url?" + song_url)
        infoLoader.item.updateInfo(pic_url, song_name, singer)
    }

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
            text: "\uf048"

            background: Rectangle {
                anchors.fill: parent
                color: root.color
            }

            contentItem: Label {
                anchors.fill: parent
                text: previousBtn.text
                color: previousBtn.hovered ? "white" : "#5a5a5c"
                font.pixelSize: 24
                font.family: awesomeFont_solid.name
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
            width: 30
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            text: "\uf04b"
            state: "pause"

            background: Rectangle {
                anchors.fill: parent
                color: root.color
            }

            contentItem: Label {
                anchors.fill: parent

                //anchors.verticalCenter: parent.verticalCenter
                text: playBtn.text
                color: playBtn.hovered ? "white" : "#5a5a5c"
                font.pixelSize: 28
                font.family: awesomeFont_solid.name
                verticalAlignment: Label.AlignVCenter
                horizontalAlignment: Label.AlignHCenter
            }

            states: [
                State {
                    name: "play"
                    PropertyChanges {
                        target: playBtn
                        text: "\uf04c"
                        ToolTip.text: "暂停"
                    }
                },
                State {
                    name: "pause"
                    PropertyChanges {
                        target: playBtn
                        text: "\uf04b"
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
                    mediaplayer.pause()
                } else {
                    playBtn.state = "play"
                    mediaplayer.play()
                }
            }
        }

        //下一首
        Button {
            id: nextBtn
            width: 30
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            text: "\uf051"

            background: Rectangle {
                anchors.fill: parent
                color: root.color
            }

            contentItem: Label {
                anchors.fill: parent
                text: nextBtn.text
                color: nextBtn.hovered ? "white" : "#5a5a5c"
                font.pixelSize: 24
                font.family: awesomeFont_solid.name
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
        maxValue: root.song_length
        releasedFunc: function () {
            mediaplayer.seek(playSlider.value * 1000)
        }

        onValueChanged: {
            playedTime.text = durationFormat(playSlider.value)
        }

        onMoved: {
            mediaplayer.seek(playSlider.value * 1000)
        }
    }

    //歌曲时长
    Label {
        id: totalTime
        anchors.right: volumeLabel.left
        anchors.rightMargin: 15
        width: 50
        height: parent.height
        text: durationFormat(root.song_length)

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
        text: "\uf027"
        state: "volume"

        background: Rectangle {
            anchors.fill: parent
            color: root.color
        }

        contentItem: Label {
            anchors.fill: parent
            text: volumeLabel.text
            color: volumeLabel.hovered ? "white" : "#5a5a5c"
            font.pixelSize: 30
            font.family: awesomeFont_solid.name
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
                    text: "\uf027"
                    ToolTip.text: "静音"
                }
            },
            State {
                name: "mutex"
                PropertyChanges {
                    target: volumeLabel
                    text: "\uf026"
                    ToolTip.text: "恢复音量"
                }
            }
        ]

        onClicked: {
            if (volumeLabel.state === "volume") {
                volumeLabel.state = "mutex"
                volumeLabel.currentVolume = volumeSlider.value
                volumeSlider.value = 0
            } else {
                volumeLabel.state = "volume"
                volumeSlider.value = volumeLabel.currentVolume
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

        property real volume: QtMultimedia.convertVolume(
                                  volumeSlider.value / 100,
                                  QtMultimedia.LogarithmicVolumeScale,
                                  QtMultimedia.LinearVolumeScale)

        onValueChanged: {
            if (value == 0)
                volumeLabel.state = "mutex"
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
        text: "\uf0cb"
        state: "order"

        background: Rectangle {
            anchors.fill: parent
            color: root.color
        }

        contentItem: Label {
            anchors.fill: parent
            text: playOrder.text
            color: playOrder.hovered ? "white" : "#5a5a5c"
            font.pixelSize: 24
            font.family: awesomeFont_solid.name
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
                    text: "\uf0cb"
                    ToolTip.text: "顺序播放"
                }
            },
            State {
                name: "list"
                PropertyChanges {
                    target: playOrder
                    text: "\uf0ca"
                    ToolTip.text: "列表循环"
                }
            },
            State {
                name: "single"
                PropertyChanges {
                    target: playOrder
                    text: "\uf365"
                    ToolTip.text: "单曲循环"
                }
            },
            State {
                name: "random"
                PropertyChanges {
                    target: playOrder
                    text: "\uf074"
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
        text: "\uf1ea"

        ToolTip.visible: playlist.hovered
        ToolTip.delay: 500
        ToolTip.text: "打开播放列表"

        background: Rectangle {
            anchors.fill: parent
            color: root.color
        }

        contentItem: Label {
            anchors.fill: parent
            text: playlist.text
            color: playlist.hovered ? "white" : "#5a5a5c"
            font.pixelSize: 24
            font.family: awesomeFont_solid.name
            verticalAlignment: Label.AlignVCenter
            horizontalAlignment: Label.AlignHCenter
        }

        onClicked: {

        }
    }

    //显示歌名、歌手等信息的窗口
    Loader {
        id: infoLoader
        anchors.left: parent.left
        anchors.bottom: parent.top
        width: 200
        height: 65
        visible: mediaplayer.status === MediaPlayer.NoMedia
                 || mediaplayer.status === MediaPlayer.UnknownStatus ? false : true
        source: "qrc:/Content/PlayController/MinWindow.qml"
    }
}
