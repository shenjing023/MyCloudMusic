/***
  精选歌单
  **/
import QtQuick 2.9
import QtQuick.Controls 2.2

Item {

    ButtonGroup {
        id: tabBtnGroup
        onClicked: {
            button.btnClickedFunc()
        }
    }

    Row {
        id: tabBar
        height: 50
        spacing: 20
        anchors.horizontalCenter: parent.horizontalCenter

        TabBtn {
            btnText: qsTr("网易云音乐")
            ButtonGroup.group: tabBtnGroup
            btnClickedFunc: function () {}
            Component.onCompleted: {
                checked=true
            }
        }

        TabBtn {
            btnText: qsTr("虾米音乐")
            ButtonGroup.group: tabBtnGroup
            btnClickedFunc: function () {}
        }
    }

    Rectangle {
        anchors {
            top: tabBar.bottom
            topMargin: -1
            left: parent.left
            leftMargin: 20
            right: parent.right
            rightMargin: 20
        }
        height: 1
        color: "#202226"
    }

    ScrollView {
        anchors.top: tabBar.bottom
        anchors.topMargin: 5
        width: parent.width
        height: parent.height - tabBar.height
        clip: true

        ListView {
            model: 20
            delegate: ItemDelegate {
                text: "Item " + index
            }
            boundsBehavior: Flickable.StopAtBounds
        }
    }
}
