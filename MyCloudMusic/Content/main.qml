import QtQuick 2.9
import QtQuick.Controls 2.2
import "NavigationBar"
import "Playlists"
import "PlayController"

Rectangle {
    id: root
    color: "transparent"

    FontLoader {
        id: awesomeFont
        source: "qrc:/Font/fontawesome-webfont.ttf"
    }

    FontLoader {
        id: awesomeFont_regular
        source: "qrc:/Font/FontAwesome5-Regular.otf"
    }

    FontLoader {
        id: awesomeFont_solid
        source: "qrc:/Font/FontAwesome5-Solid.otf"
    }

    FontLoader {
        id: awesomeFont_light
        source: "qrc:/Font/FontAwesome5-Light.otf"
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
            //leftMargin: 2
            right: parent.right
        }
        height: parent.height - 2-playController.height

        source: "qrc:/Content/Playlists/Playlists.qml"
    }

    PlayController {
        id: playController
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        height: 45
    }

    /*
      播放歌曲
      url  获取歌曲的链接url
      pic_url  歌曲专辑图片
      song_length 歌曲的长度
      */
    function playMusic(url,pic_url,song_length,song_name,singer){
        playController.pic_url=pic_url
        playController.song_length=song_length
        playController.song_name=song_name
        playController.singer=singer
        playController.song_url=url //song_url要在最后，因为PlayController的onSong_urlChanged
    }

    /*
      切换右边内容界面
      */
    function setContentView(view){
        contentWindow.source=view
    }

}
