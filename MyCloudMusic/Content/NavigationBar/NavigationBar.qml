/***
  左侧导航栏
  */

import QtQuick 2.9
import QtQuick.Controls 2.2

Rectangle{
    id:root;
    width: 200;
    height: parent.height;
    color: "#F5F5F7";

    ButtonGroup{
        id:navigationBtnGroup;
        onClicked: {
            button.btnClickedFunc();
        }
    }

    Column{
        anchors.fill: parent;
        spacing: 0;

        Label{
            anchors{
                left: parent.left;
                leftMargin: 10;
            }
            width: parent.width;
            height: 30;
            verticalAlignment: Label.AlignVCenter
            text:qsTr("推荐")
            font.family: "Microsoft YaHei";
            font.pixelSize: 12;
            color: "#7d7d7d";
        }

        NavigationBtn{
            iconText: "\uf001";
            btnText: qsTr("精选歌单");
            width: parent.width;
            height: 30;
            ButtonGroup.group: navigationBtnGroup;
            btnClickedFunc: function(){
                console.log(btnText);
                setContentView("qrc:/Content/Playlists/Playlists.qml")
            }
            Component.onCompleted: {
                checked=true
            }
        }

        NavigationBtn{
            iconText: "\uf025";
            btnText: qsTr("私人FM");
            width: parent.width;
            height: 30;
            ButtonGroup.group: navigationBtnGroup;
            btnClickedFunc: function(){
                console.log(btnText);
                setContentView("qrc:/Content/PersonFM/PersonFM.qml")
            }
        }

        NavigationBtn{
            iconText: "\uf002";
            btnText: qsTr("快速搜索");
            width: parent.width;
            height: 30;
            ButtonGroup.group: navigationBtnGroup;
            btnClickedFunc: function(){
                console.log(btnText);
            }
        }

        Label{
            anchors{
                left: parent.left;
                leftMargin: 10;
            }
            width: parent.width;
            height: 30;
            verticalAlignment: Label.AlignVCenter
            text:qsTr("我的音乐")
            font.family: "Microsoft YaHei";
            font.pixelSize: 12;
            color: "#7d7d7d";
        }

        NavigationBtn{
            iconText: "\uf015";
            btnText: qsTr("本地音乐");
            width: parent.width;
            height: 30;
            ButtonGroup.group: navigationBtnGroup;
            btnClickedFunc: function(){
                console.log(btnText);
            }
        }

        NavigationBtn{
            iconText: "\uf019";
            btnText: qsTr("下载管理");
            width: parent.width;
            height: 30;
            ButtonGroup.group: navigationBtnGroup;
            btnClickedFunc: function(){
                console.log(btnText);
            }
        }
    }
}
