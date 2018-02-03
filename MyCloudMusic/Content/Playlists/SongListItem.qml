import QtQuick 2.9
import QtQuick.Controls 2.2

Button {
    property int song_index: 0 //歌曲序号
    property string song_name: "" //歌名
    property string singers: "" //歌手
    property string album_name: "" //专辑名
    property string song_id: "" //歌曲id
    property color backgroundColor: {
        if (song_index % 2 === 0)
            return "#1a1c20"
        else
            return "transparent"
    }

    id: root
    width: parent.width
    height: 30
    checkable: true

    background: Rectangle {
        anchors.fill: parent
        color: {
            if(root.checked)
                return "#2C2E32"
            else if(root.hovered)
                return "#232529"
            else
                return backgroundColor
        }

        Row {
            anchors.fill: parent
            spacing: 5

            Label {
                width: parent.width / 15
                height: parent.height
                text: song_index < 10 ? "0" + song_index : song_index
                padding: 5
                font.family: "Microsoft YaHei"
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                color: root.checked?"white": "#828385"
            }
            Label {
                width: parent.width / 15
                height: parent.height

                Label {
                    width: parent.width / 2
                    height: parent.height
                    color: "#333538"
                    text: "\ufab4"
                    font.family: icomoonFont.name
                    font.pixelSize: 16
                    verticalAlignment: Label.AlignVCenter
                    horizontalAlignment: Label.AlignHCenter
                }

                Label {
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    width: parent.width / 2-5
                    height: parent.height
                    color: "#333538"
                    text: "\uef26"
                    font.family: icomoonFont.name
                    font.pixelSize: 16
                    verticalAlignment: Label.AlignVCenter
                    horizontalAlignment: Label.AlignHCenter
                }
            }

            //歌名
            Label {
                width: (parent .width)*2/5
                height: parent.height
                text: song_name
                font.family: "Microsoft YaHei"
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                color: "white"
                elide: Text.ElideRight
            }

            //歌手
            Label {
                width: parent.width / 5
                height: parent.height
                text: singers
                font.family: "Microsoft YaHei"
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                color: root.checked||root.hovered?"white": "#e2e2e2"
                elide: Text.ElideRight
            }

            //专辑
            Label {
                width: (parent.width)*4 / 15
                height: parent.height
                text: album_name
                font.family: "Microsoft YaHei"
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                color: root.checked||root.hovered?"white": "#e2e2e2"
                elide: Text.ElideRight
            }
        }
    }
}
