struct TaskPrinter : TaskPrinting {
    private let output: Output
    
    init(output: Output) {
        self.output = output
    }
    
    func show(_ title: String, _ tasks: [TaskItem]) {
        guard !tasks.isEmpty else {
            output.Show("\(title): отсутствуют.")
            return
        }
        
        output.Show("\(title):")
        
        for task in tasks {
            output.Show("  [\(task.isCompleted ? "V" : " ")] \(task.title) (\(task.category.rawValue))")
        }
    }
}
