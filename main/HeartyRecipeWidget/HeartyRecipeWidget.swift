//
//  HeartyRecipeWidget.swift
//  HeartyRecipeWidget
//
//  Created by Intan Nurjanah on 07/06/21.
//

import WidgetKit
import SwiftUI
import HeartyRecipeHelper

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), recipe: getRandomRecipe())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), recipe: getRandomRecipe())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, recipe: getRandomRecipe())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let recipe: RecipeBaseClass?
}

struct HeartyRecipeWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        HeartyRecipeWidgetView(recipe: entry.recipe)
    }
}

@main
struct HeartyRecipeWidget: Widget {
    let kind: String = "HeartyRecipeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HeartyRecipeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Hearty Recipe Widget")
        .description("Display a widget with a random recipe that is updated every 1 hour.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct HeartyRecipeWidget_Previews: PreviewProvider {
    static var previews: some View {
        HeartyRecipeWidgetEntryView(entry: SimpleEntry(date: Date(), recipe: getRandomRecipe()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
