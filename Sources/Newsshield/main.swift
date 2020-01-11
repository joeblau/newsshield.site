import Foundation
import Publish
import Plot

enum DownloadState: CustomStringConvertible {
    case download
    case preOrder
    
    var description: String {
        switch self {
        case .download: return "download"
        case .preOrder: return "pre-order"
        }
    }
}

struct Download {
    let title = "Download"
    let subtitle = "Get News Shield for Safari on macOS"
    let appStoreURL = "https://apps.apple.com/us/app/news-shield/id1489025442?ls=1&mt=12"
    let state: DownloadState = .download
}

struct Differentiator {
    let symbol: String
    let title: String
    let description: String
    let href: String?
}

struct Features {
    let title = "Features"
    let subtitle = ""
    let differentiators = [
        Differentiator(symbol: "􀚉",
                       title: "Redact",
                       description: "Identifies sensational writing in news publications and redacts the sentences in-line for each article",
                       href: nil),
        Differentiator(symbol: "􀎬",
                       title: "Safari",
                       description: "Use Apple’s native Safari Application Extension API to securely read and replace text",
                       href: nil),
        Differentiator(symbol: "􀍾",
                       title: "Fast",
                       description: "Executes natural language processing and machine learning algorithms in real-time",
                       href: nil),
        Differentiator(symbol: "􀌏",
                       title: "No Tracking",
                       description: "No data is ever sent to any publication or third-party to track what is being redacted",
                       href: nil),
        Differentiator(symbol: "􀝊",
                       title: "Community",
                       description: "Heuristics for the classifier are driven by community contributions to our open source list",
                       href: "https://github.com/getshields/newslist")
    ]
 }
struct Brands {
    let title = "Brands"
    let subtitle = "Publications We Work With"
    let sources = ["abc-news",
                    "axios",
                    "bbc",
                    "business-insider",
                    "buzzfeed-news",
                    "cbs-news",
                    "cnn",
                    "fox-news-channel",
                    "ft",
                    "gizmodo",
                    "huffpost",
                    "jalopnik",
                    "los-angeles-times",
                    "new-york-post",
                    "techcrunch",
                    "the-guardian",
                    "the-information-logo",
                    "the-new-york-times",
                    "the-washington-post",
                    "yahoo!-news"]
}

// This type acts as the configuration for your website.
struct Newsshield: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://your-website-url.com")!
    var name = "News Shield"
    var description = "Redact Sensational News"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

extension Website {
    var keywords: String { "Redact, Sensational, News, Shield, Desational" }
    var copyright: String { "Copyright © 2019 - 2020 Get Shields" }
    var download: Download { Download() }
    var features: Features { Features() }
    var brands: Brands { Brands() }
}

// This will generate your website using the built-in Foundation theme:
try Newsshield().publish(withTheme: .stevenPaulJobs)
