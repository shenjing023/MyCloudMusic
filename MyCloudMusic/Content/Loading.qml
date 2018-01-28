import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    anchors.fill: parent

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: true
    }

    Label {
        anchors.top: busyIndicator.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("载入中...")
        font.family: "Microsoft YaHei"
        font.pixelSize: 18
        color: "#828385"
        verticalAlignment: Label.AlignVCenter
        horizontalAlignment: Label.AlignHCenter
    }
}
