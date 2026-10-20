final class App {
    private let taskManager: TaskManager
    private let taskPrinter: TaskPrinter
    private let linePrinter: LinePrinter

    init(taskManager: TaskManager, taskPrinter: TaskPrinter, linePrinter: LinePrinter) {
        self.taskManager = taskManager
        self.taskPrinter = taskPrinter
        self.linePrinter = linePrinter
    }

    func run() {
        do {
            try runMainScenario()
        } catch TaskManagerError.elementNotFound {
            linePrinter.printLine("Ошибка: задача с указанным идентификатором не найдена.")
        } catch {
            linePrinter.printLine("Неожиданная ошибка: \(error).")
        }
    }

    private func addSampels() {
        manager.addTask(title: "Отнести велосипед на ТО", category: .personal)
        manager.addTask(title: "Сдать ДЗ по Swift", category: .study)
        manager.addTask(title: "Выполнить НИР", category: .study)
        manager.addTask(title: "Передвинуть таску в редмайне", category: .work)
    }

    private func runMainScenario() throws {
        addSampels()

        taskPrinter.print("Текущие учебные задачи", manager.filterTasks(by: .study))

        guard let homework = manager.filterTasks(by: .study).first else {
            fatalError("Не найдено ни одной учебной задачи.")
        }

        try manager.toggleTaskCompletion(by: homework.id)

        taskPrinter.print("Учебные задачи после выполнения '\(homework.title)'", manager.filterTasks(by: .study))
        taskPrinter.print("Рабочие задачи", manager.filterTasks(by: .work))
        taskPrinter.print("Личные задачи", manager.filterTasks(by: .personal))

        if let report = manager.filterTasks(by: .work).first {
            try manager.removeTask(by: report.id)
        }

        taskPrinter.print("Рабочие задачи после удаления первой", manager.filterTasks(by: .work))
    }
}
