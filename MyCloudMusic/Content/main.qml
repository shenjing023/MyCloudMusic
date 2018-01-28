import QtQuick 2.9
import QtQuick.Controls 2.2
import "NavigationBar"
import "Playlists"

Rectangle {
    id: root
    color: "transparent"

    FontLoader {
        id: icomoonFont
        source: "qrc:/Font/icomoon.ttf"
    }

    Rectangle {
        width: parent.width
        height: 2
        color: "#99CC00"
    }

    NavigationBar {
        id: navigationBar
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 2
        width: 200
        height: parent.height - 2
    }

    Loader {
        id: contentWindow
        anchors {
            top: parent.top
            topMargin: 2
            left: navigationBar.right
            leftMargin: 2
            right: parent.right
        }
        height: parent.height - 2

        source: "qrc:/Content/Playlists/Playlists.qml"
    }
}
