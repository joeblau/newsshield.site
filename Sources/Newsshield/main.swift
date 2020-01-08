import Foundation
import Publish
import Plot

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
    var keywords = "Redact, Sensational, News, Shield, Desational"
    var copyright = "Copyright © 2019 - 2020 Get Shields"
}

// This will generate your website using the built-in Foundation theme:
try Newsshield().publish(withTheme: .foundation)
