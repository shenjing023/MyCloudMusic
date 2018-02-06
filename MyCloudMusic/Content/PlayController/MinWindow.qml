import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    property string pic_url: "" //图片url
    property string song_name: ""
    property string singer: ""
    id: root
    anchors.fill: parent
    color: "#191b1f"

    function updateInfo(pic_url, song_name, singer) {
        root.pic_url = pic_url
        root.song_name = song_name
        root.singer = singer
    }

    Rectangle {
        width: parent.width
        height: 1
        color: "#23262c"
    }

    Image {
        id: image
        source: pic_url
        width: 70
        height: parent.height

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {

            }
        }
    }

    Column {
        anchors {
            top: parent.top
            topMargin: 1
            bottom: parent.bottom
            left: image.right
            right: parent.right
        }
        spacing: 5

        Label {
            width: parent.width
            height: parent.height / 2
            leftPadding: 10
            verticalAlignment: Label.AlignVCenter
            text: song_name
            color: "white"
            font.family: "Microsoft YaHei"
            font.pixelSize: 16
            elide: Text.ElideRight

            ToolTip.visible: false
            ToolTip.delay: 500
            ToolTip.text: song_name

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    ToolTip.visible = true
                    //需要这一句，否则ToolTip.text一直是一个固定值，通过Qt.binding也不管用，还不知原因
                    ToolTip.text = song_name
                }

                onExited: ToolTip.visible = false
            }
        }

        Label {
            width: parent.width
            height: parent.height / 2
            leftPadding: 10
            //            verticalAlignment: Label.AlignVCenter
            text: singer
            color: "white"
            font.family: "Microsoft YaHei"
            font.pixelSize: 16
            elide: Text.ElideRight
        }
    }
}
