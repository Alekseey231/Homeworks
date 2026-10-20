class App {
    private let taskManager: TaskManager
    private let taskPrinter: TaskPrinter
    private let output: Output
    
    init (taskManager: TaskManager, taskPrinter: TaskPrinter, output: Output)
    {
        self.taskManager = taskManager
        self.taskPrinter = taskPrinter
        self.output = output
    }
    
    func run() {
        do {
            try runMainScenario()
        }
        catch TaskManagerError.elementNotFound {
            output.Show("Ошибка: задача с указанным идентификатором не найдена.")
        }
        catch {
            output.Show("Неожиданная ошибка: \(error).")
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
        
        taskPrinter.show("Текущие учебные задачи", manager.filterTasks(by: .study))
        
        guard let homework = manager.filterTasks(by: .study).first else {
            fatalError("Не найдено ни одной учебной задачи.")
        }
        
        try manager.toggleTaskCompletion(by: homework.id)
        
        taskPrinter.show("Учебные задачи после выполнения '\(homework.title)'", manager.filterTasks(by: .study))
        taskPrinter.show("Рабочие задачи", manager.filterTasks(by: .work))
        taskPrinter.show("Личные задачи", manager.filterTasks(by: .personal))

        if let report = manager.filterTasks(by: .work).first {
            try manager.removeTask(by: report.id)
        }
        
        taskPrinter.show("Рабочие задачи после удаления первой", manager.filterTasks(by: .work))
    }
}

