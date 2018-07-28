import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    anchors.fill: parent

    Label {
        id: iconLab
        anchors.centerIn: parent
        text: "\uf00d"
        color: "#32343B"
        font.family: awesomeFont.name
        font.pixelSize: 200
        verticalAlignment: Label.AlignVCenter
        horizontalAlignment: Label.AlignHCenter
    }

    Label {
        anchors.top: iconLab.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("网络不给力哦，请检查你的网络设置~")
        font.family: "Microsoft YaHei"
        font.pixelSize: 24
        color: "#828385"
        verticalAlignment: Label.AlignVCenter
        horizontalAlignment: Label.AlignHCenter
    }
}
