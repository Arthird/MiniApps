// NoteManagerView.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import MiniApps // Наш C++ модуль

Page {
    id: notePage
    title: "Notes"

    // Создаем экземпляр нашей C++ логики
    NoteManager {
        id: noteManager
    }

    ListView {
        id: listView
        anchors.fill: parent
        clip: true
        spacing: 20

        model: noteManager.notes

        delegate: ItemDelegate {
                width: parent.width
                padding: 10

                RowLayout {
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 10

                // Текстовое поле для редактирования заметки
                TextField {
                    id: noteField
                    text: modelData
                    Layout.fillWidth: true
                    placeholderText: "Type your note..."

                    // Авто-сохранение, когда пользователь убирает фокус
                    onFocusChanged: {
                        if (!focus && text !== modelData) {
                            noteManager.editNote(index, text)
                        }
                    }

                    onAccepted: {
                        noteManager.editNote(index, text)
                        notePage.focus = true
                    }
                }

                // Кнопка удаления
                Button {
                    text: "X"
                    flat: true
                    onClicked: {
                        noteManager.deleteNote(index)
                    }

                    contentItem: Text {
                        text: parent.text
                        color: "red"
                        font.bold: true
                        font.pixelSize: 16
                    }
                    background: Rectangle {
                        color: "transparent"
                    }
                }
            }
        }

        ScrollIndicator.vertical: ScrollIndicator { }
    }

    footer: Button {
        text: "Add New Note"
        width: parent.width // Растягиваем на всю ширину

        onClicked: {
            noteManager.addNote()
            // Прокручиваем список в самый конец, чтобы увидеть новую заметку
            listView.positionViewAtEnd()
        }
    }
}
