//Main.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import MiniApps

ApplicationWindow {
    id: rootWindow

    width: 360
    height: 640
    visible: true

    // Заголовок окна будет меняться в зависимости от активной вкладки
    title: swipeView.currentItem.title

    // SwipeView для "пролистывания" страниц
    SwipeView {
        id: swipeView
        anchors.fill: parent // Занимает все место, кроме footer
        currentIndex: tabBar.currentIndex // Связываем с TabBar

        // Страница 1: Калькулятор
        CalculatorView {
            id: calculatorPage
        }

        // Страница 2: Заметки
        NoteManagerView {
            id: notesPage
        }
    }

    // Нижняя панель навигации
    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Calculator")
        }
        TabButton {
            text: qsTr("Notes")
        }
    }
}
