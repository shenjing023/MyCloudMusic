/*
  歌单详情具体页面
  */
import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    property string type: "netease" //歌单是属于网易云还是虾米
    property string pic_url: "" //歌单图片url
    property string name: "" //歌单名称
    property string user: "" //歌单作者
    property int songs_count: 0 //歌曲总数
    property int play_count: 0 //歌单播放数
    property int recommends_count: 0 //分享总数
    property int favorites_count: 0 //收藏总数
    id: root
    anchors.fill: parent

    Connections {
        target: root.parent
        onRequestFinished: {
            var data = JSON.parse(result)
            type=data['type']
            pic_url = data['pic']
            name = data['name']
            user = data['user']
            songs_count = data.songs_count
            play_count = data.play_count
            recommends_count = data.share_count
            favorites_count = data.favorite_count

            songsModel.clear()
            var songs = data.songs
            for (var i = 0; i < songs.length; ++i) {
                songsModel.append({
                                      _album_name: songs[i].album_name,
                                      _singers: songs[i].singers,
                                      _song_id: songs[i].song_id,
                                      _song_name: songs[i].song_name,
                                      _pic_url:songs[i].pic_url,
                                      _song_length:songs[i].song_length
                                  })
            }
        }
    }

    onPic_urlChanged: {
        songsView.positionViewAtBeginning()
    }

    ListModel {
        //歌曲列表model
        id: songsModel
    }

    //歌单信息
    Row {
        anchors {
            left: parent.left
            leftMargin: 10
            right: parent.right
            rightMargin: 10
            top: parent.top
            topMargin: 10
        }
        height: 180
        spacing: 20

        //歌单图片
        Image {
            height: parent.height
            width: 180
            source: pic_url
        }

        Column {
            width: parent.width - 200
            height: parent.height
            spacing: 20

            //歌单名称
            Label {
                text: name
                font.family: "Microsoft YaHei"
                font.pixelSize: 22
                verticalAlignment: Label.AlignVCenter
                color: "#5C5C5C"
            }
            //歌单作者
            Label {
                text: "制作人: " + user
                font.family: "Microsoft YaHei"
                font.pixelSize: 16
                verticalAlignment: Label.AlignVCenter
                color: "#5C5C5C"
            }
            //歌曲数
            Label {
                text: "歌曲数: " + songs_count
                font.family: "Microsoft YaHei"
                font.pixelSize: 16
                verticalAlignment: Label.AlignVCenter
                color: "#5C5C5C"
            }

            Row {
                width: parent.width
                spacing: 20

                Label {
                    text: "播放: " + play_count
                    font.family: "Microsoft YaHei"
                    font.pixelSize: 16
                    verticalAlignment: Label.AlignVCenter
                    color: "#5C5C5C"
                }
                Label {
                    text: "收藏: " + favorites_count
                    font.family: "Microsoft YaHei"
                    font.pixelSize: 16
                    verticalAlignment: Label.AlignVCenter
                    color: "#5C5C5C"
                }
                Label {
                    text: "分享: " + recommends_count
                    font.family: "Microsoft YaHei"
                    font.pixelSize: 16
                    verticalAlignment: Label.AlignVCenter
                    color: "#5C5C5C"
                }
            }
        }
    }

    Rectangle{
        anchors.top: parent.top
        anchors.topMargin: 210
        width: parent.width
        height: 1
        color: "#23262c"
    }

    //歌曲列表，这里用TableView可能更好
    Row {
        id: listHeader
        anchors.top: parent.top
        anchors.topMargin: 211
        width: parent.width
        height: 25
        spacing: 0

        Rectangle {
            width: parent.width / 15
            height: parent.height
            color: "transparent"
        }
        Rectangle {
            width: 1
            height: parent.height
            color: "#23262c"
        }
        Label {
            width: parent.width / 15
            height: parent.height
            padding: 5
            text: "操作"
            font.family: "Microsoft YaHei"
            font.pixelSize: 12
            color: "red"
        }
        Rectangle {
            width: 1
            height: parent.height
            color: "#23262c"
        }

        Label {
            width: (parent .width)*2/5
            height: parent.height
            padding: 5
            text: qsTr("音乐标题")
            font.family: "Microsoft YaHei"
            font.pixelSize: 12
            color: "red"
        }

        Rectangle {
            width: 1
            height: parent.height
            color: "#23262c"
        }

        Label {
            width: parent.width / 5
            height: parent.height
            padding: 5
            text: qsTr("歌手")
            font.family: "Microsoft YaHei"
            font.pixelSize: 12
            color: "red"
        }

        Rectangle {
            width: 1
            height: parent.height
            color: "#23262c"
        }

        Label {
            width: (parent.width)*4 / 15
            height: parent.height
            padding: 5
            text: qsTr("专辑")
            font.family: "Microsoft YaHei"
            font.pixelSize: 12
            color: "red"
        }
    }

    Rectangle{
        anchors.top: listHeader.bottom
        width: parent.width
        height: 1
        color: "#23262c"
    }

    ButtonGroup{
        id:songsBtnGroup
    }

    ListView {
        id: songsView
        anchors.top: listHeader.bottom
        anchors.topMargin: 1
        anchors.bottom: parent.bottom
        width: parent.width
        model: songsModel
        delegate: SongListItem {
            id:songlistItem
            song_index: index + 1
            song_name: _song_name
            singers: _singers
            album_name: _album_name
            song_id: _song_id
            pic_url: _pic_url
            song_length: _song_length
            ButtonGroup.group: songsBtnGroup

            onDoubleClicked: {
                playMusic("source="+root.type+"&id="+song_id,songlistItem.pic_url,songlistItem.song_length)
            }
        }

        clip: true
        ScrollBar.vertical: ScrollBar {
        }
        boundsBehavior: Flickable.StopAtBounds
    }
}
