import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle {
    property string _imageSource: "" //图片url
    property string _title: ""    //歌单标题

    width: 175
    height: 215
    color: "transparent"

    Image {
        id: image
        source: _imageSource
        width: parent.width
        height: parent.height-40
    }

    Label{
        anchors.top: image.bottom
        anchors.topMargin: 5
        width: parent.width
        height: 40
        text: _title
        color: "#dcdde4"
        font.family: "Microsoft YaHei"
        font.pixelSize: 14
        wrapMode: Text.Wrap
    }
}
