import Foundation

let manager = TaskManager()
let output = ConsoleOutput()
let printer = TaskPrinter(output: output)

let app = App(taskManager: manager, taskPrinter: printer, output: output)

app.run()
