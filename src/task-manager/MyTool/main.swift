import Foundation

let manager = TaskManager()

manager.addTask(title: "Отнести велосипед на ТО", category: .personal)
manager.addTask(title: "Сдать ДЗ по Swift", category: .study)
manager.addTask(title: "Выполнить НИР", category: .study)
manager.addTask(title: "Передвинуть таску в редмайне", category: .work)

show("Текущие учебные задачи", manager.filterTasks(by: .study))

do {
    guard let homework = manager.filterTasks(by: .study).first else {
        fatalError("Не найдено ни одной учебной задачи.")
    }
    try manager.toggleTaskCompletion(by: homework.id)
    
    show("Учебные задачи после выполнения '\(homework.title)'", manager.filterTasks(by: .study))
    show("Рабочие задачи", manager.filterTasks(by: .work))
    show("Личные задачи", manager.filterTasks(by: .personal))

    if let report = manager.filterTasks(by: .work).first {
        try manager.removeTask(by: report.id)
    }
    show("Рабочие задачи после удаления первой", manager.filterTasks(by: .work))
} catch TaskManagerError.elementNotFound {
    print("Ошибка: задача с указанным идентификатором не найдена.")
} catch {
    print("Неожиданная ошибка: \(error).")
}

func show(_ title: String, _ tasks: [TaskItem]) {
    guard !tasks.isEmpty else {
        print("\(title): отсутствуют.")
        
        return
    }
    
    print("\(title):")
    
    for task in tasks {
        print("  [\(task.isCompleted ? "V" : " ")] \(task.title) (\(task.category.rawValue))")
    }
}
