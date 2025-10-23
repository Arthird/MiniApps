#include "notemanager.h"
#include <QSettings> // Для сохранения и загрузки заметок
#include <QDebug>

// Ключ, по которому мы будем хранить список в QSettings
static constexpr const char* g_notesKey = "notesList";

NoteManager::NoteManager(QObject *parent)
    : QObject(parent)
{
    // Загружаем заметки при старте
    loadNotes();
}

QStringList NoteManager::notes() const
{
    return m_notes;
}

void NoteManager::addNote()
{
    // Добавляем новую заметку с текстом по умолчанию
    m_notes.append("New Note");
    emit notesChanged(); // Сообщаем QML, что модель обновилась
    saveNotes();         // Автоматически сохраняем
}

void NoteManager::deleteNote(int index)
{
    // Проверка на корректность индекса
    if (index < 0 || index >= m_notes.size())
        return;

    m_notes.removeAt(index);
    emit notesChanged();
    saveNotes();
}

void NoteManager::editNote(int index, const QString &newText)
{
    if (index < 0 || index >= m_notes.size())
        return;

    // Нет смысла обновлять, если текст тот же
    if (m_notes.at(index) == newText)
        return;

    m_notes[index] = newText;
    // Для QStringList-модели мы должны оповестить об изменении всего списка,
    // даже если изменился один элемент.
    emit notesChanged();
    saveNotes();
}

void NoteManager::saveNotes()
{
    // Используем QSettings для простого сохранения.
    // "MyCompany" и "MiniApps" - это просто идентификаторы.
    QSettings settings("MyCompany", "MiniApps");
    settings.setValue(g_notesKey, m_notes);
}

void NoteManager::loadNotes()
{
    QSettings settings("MyCompany", "MiniApps");
    // Загружаем список. Если ничего нет, вернется пустой список.
    m_notes = settings.value(g_notesKey).toStringList();

    // Оповещаем QML, чтобы он отобразил загруженные заметки
    if (!m_notes.isEmpty()) {
        emit notesChanged();
    }
}
