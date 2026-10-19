import Foundation

struct TaskItem: Identifiable {
    let id: UUID
    let title: String
    var isCompleted: Bool
    let category: TaskCategory
    
    init(id: UUID = UUID(),
         title: String,
         isCompleted: Bool = false,
         category: TaskCategory) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.category = category
    }
}
