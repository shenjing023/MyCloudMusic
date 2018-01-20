import QtQuick 2.9
import QtQuick.Controls 2.2
import "NavigationBar"

Rectangle{
    id:root;
    color: "transparent";

    FontLoader{
        id:icomoonFont;
        source: "qrc:/Font/icomoon.ttf";
    }

    Rectangle{
        width: parent.width;
        height: 1;
        color: "#99CC00";
    }

    NavigationBar{
        anchors.left: parent.left;
        width: 150;
        height: parent.height;
    }
}
