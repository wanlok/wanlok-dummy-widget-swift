//
//  dummyWidgetLiveActivity.swift
//  dummyWidget
//
//  Created by Robert Wan on 22/4/2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct dummyWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct dummyWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: dummyWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension dummyWidgetAttributes {
    fileprivate static var preview: dummyWidgetAttributes {
        dummyWidgetAttributes(name: "World")
    }
}

extension dummyWidgetAttributes.ContentState {
    fileprivate static var smiley: dummyWidgetAttributes.ContentState {
        dummyWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: dummyWidgetAttributes.ContentState {
         dummyWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: dummyWidgetAttributes.preview) {
   dummyWidgetLiveActivity()
} contentStates: {
    dummyWidgetAttributes.ContentState.smiley
    dummyWidgetAttributes.ContentState.starEyes
}
