import QtQuick 2.9
import QtQuick.Controls 2.2

Button{
    property string iconText:"";   //图标名称
    property string btnText: "";    //按钮名称
    property var btnClickedFunc: (function(){}) //按钮点击处理函数
    id:root;
    width: parent.width;
    height: 30;
    checkable: true;

    background: Rectangle{
        anchors.fill: parent;
        color: parent.pressed | parent.checked?"#E6E7EA":"transparent";

        Rectangle{
            implicitWidth: 3;
            implicitHeight: parent.height;
            anchors.left: parent.left;
            color: "#99CC00";
            visible:  root.pressed |root.checked? true : false;
        }
    }

    contentItem: Rectangle{
        anchors.fill: parent;
        color: "transparent";

        Label{
            id:iconLabel;
            anchors{
                left: parent.left;
                leftMargin: 15;
                verticalCenter: parent.verticalCenter;
            }
            width: 25;
            height: parent.height;
            text:iconText;
            font.family: awesomeFont_solid.name;
            font.pixelSize: 16;
            verticalAlignment:Label.AlignVCenter;
            horizontalAlignment: Label.AlignHCenter;
            color: root.hovered | root.pressed ?"#000000":"#5C5C5C";
        }

        Label{
            anchors{
                left: iconLabel.right;
                leftMargin: 10;
                right: parent.right;
                rightMargin: 3;
            }
            height: parent.height;
            text:btnText;
            font.family: "Microsoft YaHei";
            font.pixelSize: 12;
            wrapMode: Text.Wrap;
            verticalAlignment:Label.AlignVCenter;
            color: root.hovered | root.checked ?"#000000":"#5C5C5C";
        }
    }
}
