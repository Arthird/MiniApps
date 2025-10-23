#pragma once

#include <QObject>
#include <QStringList>

class NoteManager : public QObject
{
    Q_OBJECT
    // Мы делаем список заметок свойством, чтобы QML мог его "видеть"
    Q_PROPERTY(QStringList notes READ notes NOTIFY notesChanged)

public:
    explicit NoteManager(QObject *parent = nullptr);

    // Геттер для нашего свойства
    QStringList notes() const;

    // Методы, которые можно будет вызывать прямо из QML
    Q_INVOKABLE void addNote();
    Q_INVOKABLE void deleteNote(int index);
    Q_INVOKABLE void editNote(int index, const QString &newText);

signals:
    // Сигнал, который сообщает QML, что список заметок изменился
    void notesChanged();

private:
    // Вспомогательные функции для сохранения и загрузки
    void saveNotes();
    void loadNotes();

    QStringList m_notes; // Здесь хранятся наши заметки
};
