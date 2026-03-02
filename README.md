# Oigetit News List & Article 

This project was developed as a technical assessment to showcase proficiency in **SwiftUI**, **MVVM**, and **Clean Architecture**. Per the assessment constraints, the app operates entirely on simulated dummy data, allowing the focus to remain on domain logic, data parsing safety, and user experience (handling loading, error, and offline states).

## Approaches

* **JSON Parsing:** Safely decodes nested dummy JSON data using `JSONDecoder`, `CodingKeys`, and custom Date formatting strategies (ISO8601 to relative/absolute UI strings).
* **Native Article Detail View:** The article detail screen was built entirely natively in SwiftUI to demonstrate complex view composition, typography scaling, and dynamic layout constraints. Even though in a real news aggregator it is very common to use `SFSafariViewController` or `WKWebView` approach, to handle the variety of content styles each publisher has.
* **Skeleton Loading States:** Implements a skeleton placeholder view that mimics the structure of the news feed, improving perceived performance when fetching data from the endpoint.
* **Real-time Network Monitoring:** Utilises Apple's native `NWPathMonitor` on a custom background queue to actively track internet connectivity and gracefully handle offline states on the UI thread.
* **Async Image Loading:** Safely unwraps and fetches remote thumbnails, providing custom fallback views and timeout logic if the remote image fails to load.
* **Programmatic Routing:** Uses a custom `AppRouter` as an `@EnvironmentObject` to manage view hierarchies and navigation cleanly. P.S. Inspired by the Coordinator pattern

## Technology Stack

* **Language:** Swift 5+
* **Framework:** SwiftUI
* **Architecture:** MVVM (Model-View-ViewModel) + Clean Architecture (Use Cases)
* **Native Libraries:** * `Foundation` (Data parsing, Date styling)
  * `Network` (`NWPathMonitor` for connectivity)
  * `Combine` for reactiveness

## Architecture Decisions

* **Why a Native Detail View?** While a production news aggregator would likely pass the article URL to a `WKWebView` to display the publisher's site, a fully native detail view was chosen here to explicitly demonstrate SwiftUI layout skills, scroll view management, and dynamic data injection.
* **Why Use Cases (`ArticleUseCase`)?** Abstracting the data fetching and decoding into a Use Case protocol ensures the ViewModel remains lightweight and decoupled from the data layer, adhering to Clean Architecture principles and making the code highly testable.

## How to Run the Project

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Zaidaan/Oigetit_Replicate.git

2. Open the project in Xcode:
   Navigate to the cloned directory and open the .xcodeproj file (or .xcworkspace if applicable).

3. Select a Simulator:
   Choose your preferred iOS simulator (e.g., iPhone 15 Pro) from the Xcode toolbar. Ensure you are running a target of iOS 16.0 or later to support the latest SwiftUI navigation modifiers.

4. Build and Run:
   Press Cmd + R or click the play button in the top left corner of Xcode. No external API keys or CocoaPods/SPM dependencies are required.

## Possible Improvements
* If this app were to be scaled for production with a real backend, the following improvements would be implemented:
* Swapping the native detail view for a WKWebView to render the publisher's actual web page.
* Implementing pagination/infinite scrolling in the LazyVStack to handle large API payloads.
* Adding a persistence layer (CoreData or SwiftData) to cache articles for offline reading or when the connection is lost.
