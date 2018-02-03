/*
  歌单详情窗口
  */
import QtQuick 2.9
import QtQuick.Controls 2.2
import Network 1.0

Popup {
    property string list_url: ""    //歌单的url
    id: root
    width: parent.width
    height: parent.height

    onList_urlChanged:{
        detailLoader.setSource("qrc:/Content/Loading.qml")
        detailsNetwork.get(list_url)
    }


    Network{
        id:detailsNetwork
        onSign_requestFinished: {
            detailLoader.setSource("qrc:/Content/Playlists/PlaylistDetails.qml")
            detailLoader.requestFinished(bytes)
        }
        onSign_requestError: {
            detailLoader.setSource("qrc:/Content/NetworkError.qml")
        }
    }

    background: Rectangle {
        anchors.fill: parent
        color: "#16181C"
    }

    //这里如果不用contentItem，会使界面有一小段距离的margin
    contentItem:  Loader {
        id: detailLoader
        anchors.fill: parent
        source: "qrc:/Content/Loading.qml"

        signal requestFinished(string result)
    }

    Label {
        //右上角关闭
        anchors {
            right: parent.right
            top: parent.top
        }
        text: "\uf750"
        font.family: icomoonFont.name
        font.pixelSize: 28
        verticalAlignment: Label.AlignVCenter
        horizontalAlignment: Label.AlignHCenter
        z:10

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                root.close()
            }
        }
    }

//    Component.onCompleted: {
//        detailLoader.setSource("qrc:/Content/Playlists/PlaylistDetails.qml", {
//                                   name: "歌单名称",
//                                   user: "歌单作者",
//                                   songs_count: 11,
//                                   play_count: 123,
//                                   recommends_count: 1223,
//                                   favorites_count: 231
//                               })
//    }
}
