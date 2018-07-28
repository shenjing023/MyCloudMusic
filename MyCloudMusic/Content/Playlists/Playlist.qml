import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls 1.4 as Controls_1_4
import QtQuick.Controls.Styles 1.4

Item {
    property int page: 0   //当前是第几页
    id:root
    //anchors.fill: parent

    signal playlistRequest(int page)    //请求第几页数据
    signal playlistDetail(string list_id)    //请求歌单详情

    Connections{
        target: root.parent
        onRequestFinished:{
            var data = JSON.parse(result)
            playlistsModel.clear()
            for (var i = 0; i < data.length; ++i) {
                playlistsModel.append({
                                          _imageSource: data[i].logo,
                                          _title: data[i].collect_name,
                                          _list_id: data[i].list_id
                                      })
            }

            pageBtnGroup.buttons[page].checked=true
        }
    }

    ButtonGroup{
        id:pageBtnGroup
        onClicked: {
            playlistRequest(parseInt(button.text) - 1)
        }
    }

    /*
      control2与control1.4的scrollview都有各自的特点，经过比较，
      在这里个人觉得使用1.4比较好
      */
    ListModel {
        id: playlistsModel
    }

    Controls_1_4.ScrollView {
        id: scrollView
        anchors.fill: parent
        clip: true
        verticalScrollBarPolicy: Qt.ScrollBarAsNeeded
        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

        Column {
            spacing: 30
            bottomPadding: 20

            Grid {
                id: playlists
                anchors.left: parent.left
                //设置居中不管用，不知原因,另外下列的scrollView不能改成parent，不知原因
                //anchors.horizontalCenter: parent.horizontalCenter
                anchors.leftMargin: (scrollView.width - width) / 2
                columns: 4
                rows: 15
                spacing: 15
                horizontalItemAlignment: Grid.AlignHCenter
                verticalItemAlignment: Grid.AlignVCenter

                Repeater {
                    model: playlistsModel
                    delegate: PlaylistItem {
                        imageSource: _imageSource
                        title: _title
                        list_id: _list_id

                        onItemClicked: {
                            playlistDetail(list_id)
                        }
                    }
                }
            }

            //页码
            Row {
                id: pagination
                height: 30
                anchors.left: parent.left
                anchors.leftMargin: (scrollView.width - width) / 2
                spacing: 10

                Repeater {
                    model: 10
                    delegate: Button {
                        width: 25
                        height: 25
                        checkable: true
                        ButtonGroup.group: pageBtnGroup
                        text: index + 1

                        background: Rectangle {
                            anchors.fill: parent
                            color: parent.pressed | parent.hovered
                                   | parent.checked ? "#E6E7EA" : "transparent"
                        }

                        contentItem: Label {
                            anchors.centerIn: parent
                            text: parent.text
                            font.family: "Microsoft YaHei"
                            font.pixelSize: 12
                            horizontalAlignment: Label.AlignHCenter
                            verticalAlignment: Label.AlignVCenter
                            color: {
                                if (parent.hovered)
                                    return "black"
                                else if (parent.checked)
                                    return "red"
                                else
                                    return "#5C5C5C"
                            }
                        }
                    }
                }
            }
        }

        style: ScrollViewStyle {
            handle: Rectangle {
                implicitWidth: 5
                implicitHeight: 0
                color: "#2F3134"
                radius: 5
                anchors.fill: parent
                anchors.top: parent.top
                //anchors.topMargin: -1*dp;
                anchors.right: parent.right
            }
            scrollBarBackground: Rectangle {
                anchors.top: parent.top
                anchors.right: parent.right
                implicitWidth: 5
                implicitHeight: 0
                color: "transparent"
            }
            //可以使区域向上或者向右移动的区域和按钮
            decrementControl: Rectangle {
                implicitWidth: 0
                implicitHeight: 0
            }
            //可以使区域向下或者向左移动的区域和按钮
            incrementControl: Rectangle {
                implicitWidth: 0
                implicitHeight: 0
            }
        }
    }

    /*
    //    ScrollView {
    //        id: scrollView
    //        anchors.top: tabBar.bottom
    //        anchors.topMargin: 5
    //        width: parent.width
    //        height: parent.height - tabBar.height
    //        clip: true

    //        ListModel {
    //            id: playlistsModel
    //        }

    //        Column {
    //            anchors.fill: parent
    //            spacing: 10
    //            bottomPadding: 20

    //            Grid {
    //                id: playlists
    //                anchors.left: parent.left
    //                //设置居中不管用，不知原因,另外下列的scrollView不能改成parent，不知原因
    //                //anchors.horizontalCenter: parent.horizontalCenter
    //                anchors.leftMargin: (scrollView.width - width) / 2
    //                //            anchors.bottom: parent.bottom
    //                //            anchors.bottomMargin: 50
    //                columns: 4
    //                rows: 15
    //                spacing: 15
    //                horizontalItemAlignment: Grid.AlignHCenter
    //                verticalItemAlignment: Grid.AlignVCenter

    //                Repeater {
    //                    model: playlistsModel
    //                    delegate: PlaylistItem {
    //                        imageSource: _imageSource
    //                        title: _title
    //                        list_id: _list_id
    //                    }
    //                }

    //                Component.onCompleted: {
    //                    //console.log(scrollView.width - width)
    //                }
    //            }

    //            //页码
    //            Row {
    //                id: pagination
    //                height: 30
    //                anchors.left: parent.left
    //                anchors.leftMargin: (scrollView.width - width) / 2
    //                spacing: 10

    //                Rectangle {
    //                    width: 40
    //                    height: parent.height
    //                    color: "red"
    //                }
    //                Rectangle {
    //                    width: 40
    //                    height: parent.height
    //                    color: "red"
    //                }
    //                Rectangle {
    //                    width: 40
    //                    height: parent.height
    //                    color: "red"
    //                }
    //            }
    //        }
    //    }
    */
}
