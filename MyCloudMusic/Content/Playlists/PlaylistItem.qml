import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    property string imageSource: "" //图片url
    property string title: "" //歌单标题
    property string list_id: "" //歌单id

    width: 175
    height: 215
    color: "transparent"

    signal itemClicked(string list_id)

    Image {
        id: image
        source: imageSource
        width: parent.width
        height: parent.height - 40
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onEntered: {
                playBtn.visible = true
            }

            onExited: {
                playBtn.visible = false
            }

            onClicked: {
                itemClicked(list_id)
            }
        }
        //图像底部play按钮
        Label {
            id: playBtn
            width: 40
            height: 40
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            text: "\uf144"
            color: "#e6e9ec"
            font.family: awesomeFont_regular.name
            font.pixelSize: 30
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            visible: false

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                propagateComposedEvents: true

                onEntered: {
                    playBtn.visible = true
                }
                onClicked: {
                    mouse.accepted = false
                }
            }
        }
    }

    Label {
        anchors.top: image.bottom
        anchors.topMargin: 5
        width: parent.width
        height: 40
        text: title
        color: "#000000"
        font.family: "Microsoft YaHei"
        font.pixelSize: 14
        wrapMode: Text.Wrap
    }
}
