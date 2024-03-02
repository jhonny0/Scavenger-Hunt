//
//  TaskListView.swift
//  Scavenger Hunt
//
//  Created by Jonathan Fernandez on 3/2/24.
//

import SwiftUI

struct TaskListView: View {
    @State private var tasks: [Task] = [
        Task(title: "Find a historic landmark", description: "Take a photo of a historic landmark in your city."),
        Task(title: "Local Artwork", description: "Snap a picture of street art without any people in the frame."),
        Task(title: "Nature's Beauty", description: "Find and photograph a local wildflower."),
        Task(title: "Architectural Marvel", description: "Capture a building with unique architectural features."),
        
    // Add more tasks as needed
    ]
    var body: some View {
        NavigationView {
            List(tasks) { task in
                // Use a method to simplify navigation link destination
                NavigationLink(destination: self.destinationView(for: task)) {
                    Text(task.title)
                        .strikethrough(task.isCompleted, color: .gray)
                        .foregroundColor(task.isCompleted ? .gray : .black)
                }
            }
            .navigationTitle("Scavenger Hunt")
        }
    }

    // Method to return the destination view for a given task
    private func destinationView(for task: Task) -> some View {
        // Safely unwrap the index to avoid force unwrapping
        if let taskIndex = tasks.firstIndex(where: { $0.id == task.id }) {
            return AnyView(TaskDetailView(task: $tasks[taskIndex]))
        } else {
            // Return an empty view or some error view if the index isn't found
            return AnyView(EmptyView())
        }
    }
}

#Preview {
    TaskListView()
}
