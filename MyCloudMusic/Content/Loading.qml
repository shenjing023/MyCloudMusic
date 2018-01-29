import QtQuick 2.9
import QtQuick.Controls 1.4
/*
  在qt5.9.3版本中，controls2.2的BusyIndicator在此处不会动，只有在刷新界面的时候动，而1.4版本就没事
  */

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
