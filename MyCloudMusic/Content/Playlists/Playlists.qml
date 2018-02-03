/***
  精选歌单
  **/
import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls 1.4 as Controls_1_4
import QtQuick.Controls.Styles 1.4
import Network 1.0

Item {
    property int currentPage: 0 //当前是第几页
    signal requestFinished(string result)

    Connections {
        target: loader.source=="qrc:/Content/Playlists/Playlist.qml"?loader.item : null
        onPlaylistRequest: {
            loader.setSource("qrc:/Content/Loading.qml")
            currentPage = page
            var offset = page * 60
            if (neteaseBtn.checked) {
                network.get("/playlists?source=netease&limit=60&offset=" + offset)
            } else {
                network.get("/playlists?source=xiami&limit=60&page=" + (page + 1))
            }
        }

        onPlaylistDetail:{
            if(neteaseBtn.checked){
                listDetail.list_url="/playlist/detail?source=netease&id="+list_id
            }
            else{
                listDetail.list_url="/playlist/detail?source=xiami&id="+list_id
            }
            listDetail.open()
        }
    }

    Network {
        id: network
        onSign_requestFinished: {
            loader.setSource("qrc:/Content/Playlists/Playlist.qml", {
                                 page: currentPage
                             })
            loader.requestFinished(bytes)
        }
        onSign_requestError: {
            loader.source = "qrc:/Content/NetworkError.qml"
        }
    }

    Details{
        id:listDetail
        x:parent.x
        y:parent.y
        width: parent.width
        height: parent.height
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
            id: neteaseBtn
            btnText: qsTr("网易云音乐")
            ButtonGroup.group: tabBtnGroup
            btnClickedFunc: function () {
                loader.setSource("qrc:/Content/Loading.qml")
                currentPage = 0
                network.get("/playlists?source=netease&limit=60")
            }
        }

        TabBtn {
            id: xiamiBtn
            btnText: qsTr("虾米音乐")
            ButtonGroup.group: tabBtnGroup
            btnClickedFunc: function () {
                loader.setSource("qrc:/Content/Loading.qml")
                currentPage = 0
                network.get("/playlists?source=xiami&limit=60")
                //scrollView.flickableItem.contentY = 0
            }
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

    Loader {
        //这里还可以再封装一下
        id: loader
        anchors.top: tabBar.bottom
        anchors.topMargin: 5
        width: parent.width
        height: parent.height - tabBar.height
        source: "qrc:/Content/Loading.qml"

        signal requestFinished(string result)
    }

    Component.onCompleted: {
        neteaseBtn.checked = true
        neteaseBtn.clicked()
    }
}
