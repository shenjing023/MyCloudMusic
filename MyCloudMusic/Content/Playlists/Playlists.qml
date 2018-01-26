/***
  精选歌单
  **/
import QtQuick 2.9
import QtQuick.Controls 2.2
import Network 1.0

Item {
//    width: parent.width
//    height: parent.height

    Network {
        id: network
        onSign_requestFinished: {
            console.log("222")
            console.log(bytes)
        }
    }

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
                checked = true
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
        id:scrollView
        anchors.top: tabBar.bottom
        anchors.topMargin: 5
        width: parent.width
        height: parent.height - tabBar.height
        clip: true

        Grid {
            id: playlists
            anchors.left: parent.left
            //设置居中不管用，不知原因,另外下列的scrollView不能改成parent，不知原因
//anchors.horizontalCenter: scrollView.horizontalCenter
            anchors.leftMargin: (scrollView.width-width)/2
            columns: 4
            rows: 10
            spacing: 15
            horizontalItemAlignment: Grid.AlignHCenter
            verticalItemAlignment: Grid.AlignVCenter



            Repeater{
                model: 40
                delegate: PlaylistItem{
                    _imageSource: "http://p1.music.126.net/sRtc-rijlUxW9XpKmkSx4g==/109951163117146235.jpg"
                    _title: "我在零下的阳光里等一场雪"
                }
            }

            Component.onCompleted: {
                console.log(scrollView.width-width)
        }
    }
    }

    Component.onCompleted: {

        //network.get()
        console.log(scrollView.width)
    }
}
