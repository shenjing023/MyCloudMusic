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
            iconText: "\uef51";
            btnText: qsTr("发现音乐");
            width: parent.width;
            height: 30;
            ButtonGroup.group: navigationBtnGroup;
            btnClickedFunc: function(){
                console.log(btnText);
            }
        }

        NavigationBtn{
            iconText: "\uec0b";
            btnText: qsTr("私人FM");
            width: parent.width;
            height: 30;
            ButtonGroup.group: navigationBtnGroup;
            btnClickedFunc: function(){
                console.log(btnText);
            }
        }

        NavigationBtn{
            iconText: "\uf3ac";
            btnText: qsTr("MV");
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
            iconText: "\uf867";
            btnText: qsTr("本地音乐");
            width: parent.width;
            height: 30;
            ButtonGroup.group: navigationBtnGroup;
            btnClickedFunc: function(){
                console.log(btnText);
            }
        }

        NavigationBtn{
            iconText: "\uef26";
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
