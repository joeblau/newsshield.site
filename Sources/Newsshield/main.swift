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

struct BulletPoint {
    let symbol: String
    let title: String
    let description: String
    var href: String? = nil
}

struct Step {
    let image: String
    let title: String
    let description: String
}

struct Why {
    let title = "We Need Better Journalism"
    let paragraphs = [
        "Today’s social media landscape has seen an increasing number of content producers. Social media platforms are competing engagement time away from news outlets as consumers access more information and entertainment online. News is a business that relies on engagement to make a profit. To stay in business, news outlets are working hard to come up with different strategies.",
        "One strategy has been that of publishing factual yet sensational headlines and phrases. These headlines and phrases are often designed to capture and arouse the reader, not to accurately reflect the news in the article. News Shield redacts sensational headlines and sentences from your browser, presenting the reader with only those sentences that are relevant to the story."
    ]
}

struct How {
    let title = "How It Works"
    let subtitle = "Redacting sensational news"
    let steps = [
    Step(image: "separate",
         title: "1. Separate",
         description: "News Shield reads an article on a white-listed page and separates the article into individual sentences."),
    Step(image: "classify",
         title: "2. Classify",
         description: "News Shield classifies each sentence as “News” or “Not News.”"),
    Step(image: "redact",
         title: "3. Redact",
         description: "News Shield replaces the sentences classified as “Not News” with redacted block text.")]
}

struct Download {
    let title = "Download"
    let subtitle = "Get News Shield for Safari on macOS"
    let appStoreURL = "https://apps.apple.com/us/app/news-shield/id1489025442?ls=1&mt=12"
    let state: DownloadState = .download
}

struct Technology {
    let title = "Technology"
    let subtitle = "High-tech simplicity"
    let features = [
        BulletPoint(symbol: "􀎾",
                       title: "Natural Language Processing",
                       description: "sanitizes each sentence by stripping invalid Unicode symbols from the author’s text. After the symbols are stripped, the Linguistic Tagger is used to split articles by sentence terminators and return a trimmed sentence that can be used as input to the machine learning classifier."),
        BulletPoint(symbol: "􀅮",
                       title: "Machine Learning",
                       description: "uses the output from the Natural Language Processing (NLP) string as input into the Text Classifier. The Text Classifier identifies sentences as either News or Not News. The model is built using transfer learning with a dynamically embedded feature extractor. Sentences that are tagged as Not News are replaced with redacted blocks to obscure sensational content from the reader.")
    ]
}

struct Features {
    let title = "Features"
    let subtitle = ""
    let differentiators = [
        BulletPoint(symbol: "􀚉",
                       title: "Redact",
                       description: "Identifies sensational writing in news publications and redacts the sentences in-line for each article"),
        BulletPoint(symbol: "􀎬",
                       title: "Safari",
                       description: "Use Apple’s native Safari Application Extension API to securely read and replace text"),
        BulletPoint(symbol: "􀍾",
                       title: "Fast",
                       description: "Executes natural language processing and machine learning algorithms in real-time"),
        BulletPoint(symbol: "􀌏",
                       title: "No Tracking",
                       description: "No data is ever sent to any publication or third-party to track what is being redacted"),
        BulletPoint(symbol: "􀝊",
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
    var url = URL(string: "https://newsshield.app")!
    var name = "News Shield"
    var description = "Redact Sensational News"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

extension Website {
    var keywords: String { "Redact, Sensational, News, Shield, Desational" }
    var copyright: String { "Copyright © 2019 - 2020 Get Shields" }
    var why: Why { Why() }
    var how: How { How() }
    var technology: Technology { Technology() }
    var features: Features { Features() }
    var brands: Brands { Brands() }
    var download: Download { Download() }
}

// This will generate your website using the built-in Foundation theme:
try Newsshield().publish(withTheme: .stevenPaulJobs)
