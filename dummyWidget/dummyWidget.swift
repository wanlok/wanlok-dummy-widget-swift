//
//  dummyWidget.swift
//  dummyWidget
//
//  Created by Robert Wan on 22/4/2025.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        for minuteOffset in 0..<60 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }
        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

let formatter: DateFormatter = {
    let df = DateFormatter()
//    df.dateFormat = "HH:mm:ss"
    df.dateFormat = "mm"
    return df
}()

struct dummyWidgetEntryView : View {
   @AppStorage("rate", store: UserDefaults(suiteName: "group.com.wanlok.dummyWidgetApp"))
   var rate: String = "0.0000"
    
    var entry: Provider.Entry

    var body: some View {
        GeometryReader { geometry in
            let w = geometry.size.width
            let h = geometry.size.height
            VStack(spacing: 0) {
                VStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 16)
                        .frame(width: w / 2 + 16 * 2, height: h / 2)
                        .background(Color.red)
                }
                .frame(width: w, height: h / 2)
                .background(Color.blue)
                Text("Rate: " + rate + " (" + formatter.string(from: entry.date) + ")")
                    .padding(16)
                    .frame(height: h / 2)
                    .background(Color.yellow)
            }
            .frame(width: w, height: h)
            .background(Color.green)
        }
    }
}

struct dummyWidget: Widget {
    let kind: String = "dummyWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            dummyWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    dummyWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
//    SimpleEntry(date: .now, rate: "0.0000", configuration: .starEyes)
}
