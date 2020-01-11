//
//  File.swift
//  
//
//  Created by Joe Blau on 1/8/20.
//

import Publish
import Plot

enum PublishError: Error {
    case castSiteError
    case notImplemented
}

public extension Theme {
    /// The default "Foundation" theme that Publish ships with, a very
    /// basic theme mostly implemented for demonstration purposes.
    static var stevenPaulJobs: Self {
        Theme(
            htmlFactory: FoundationHTMLFactory(),
            resourcePaths: [
                "Resources/css/styles.css"
            ]
        )
    }
}

private struct FoundationHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index,
                       context: PublishingContext<Site>) throws -> HTML {
        return HTML(
            .lang(context.site.language),
            .head(for: index,
                  on: context.site,
                  titleSeparator: " | ",
                  stylesheetPaths: ["styles.css",
                                    "StevenPaulJobsTheme/css/news-shield-styles.css",
                                    "StevenPaulJobsTheme/fonts/stylesheet.css"],
                  rssFeedPath: .defaultForRSSFeed,
                  rssFeedTitle: nil),
            .body(
                .hero(for: context.site),
                .main(
                    .why(for: context.site),
                    .how(for: context.site),
                    .technology(for: context.site),
                    .features(for: context.site),
                    .brands(for: context.site),
                    .download(for: context.site)
                ),
                .footer(for: context.site)
            )
        )
    }
    
    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        return HTML()
    }
    
    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        return HTML()
    }
    
    func makePageHTML(for page: Page,
                      context: PublishingContext<Site>) throws -> HTML {
        return HTML()
    }
    
    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Site>) throws -> HTML? {
        return HTML()
    }
    
    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? {
        return HTML()
    }
}

private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }
    
    // MARK: - Site
    
    static func header<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        let sectionIDs = T.SectionID.allCases
        
        return .header(
            .wrapper(
                .a(.class("site-name"), .href("/"), .text(context.site.name)),
                .if(sectionIDs.count > 1,
                    .nav(
                        .ul(.forEach(sectionIDs) { section in
                            .li(
                                .a(
                                    .class(section == selectedSection ? "selected" : ""),
                                    .href(context.sections[section].path),
                                    .text(context.sections[section].title)
                                )
                            )
                            }
                        )
                    )
                )
            )
        )
    }
    
    static func hero<T: Website>(for site: T) -> Node {
        return header(
            .class("hero hero-background"),
            .h1(.text(site.name)),
            .appStoreLink(for: site),
            .div(
                .img(
                    .src("/img/dark/nytimes-hero.png")
                )
            )
        )
    }
    
    static func why<T: Website>(for site: T) -> Node {
        return .section(
            .class("why"),
            .header(
                .h4(.text(site.why.title))
            ),
            .div(
                .class("max-section"),
                .forEach(site.why.paragraphs) { paragraph in
                    .p(.text(paragraph))
                }
            )
        )
    }
    
    static func how<T: Website>(for site: T) -> Node {
        return .element(named: "", nodes: [
            .header(
                .h2(.text(site.how.title)),
                .if(site.how.subtitle.isEmpty == false,
                    .h4(.text(site.how.subtitle))
                )
            ),
            
            .section(
                .class("how max-section"),
                .forEach(site.how.steps) { step in
                    .div(
                        .class("well"),
                        .img(
                            .class("how-image"),
                            .src("/img/\(step.image).svg")
                        ),
                        .h4(
                            .text(step.title),
                            .br(),
                            .element(named: "small", nodes: [.text(step.description)])
                        )
                    )
                }
            )
        ])
    }
    
    static func technology<T: Website>(for site: T) -> Node {
        return .element(named: "", nodes: [
            .header(
                .h2(.text(site.technology.title)),
                .if(site.technology.subtitle.isEmpty == false,
                    .h4(.text(site.technology.subtitle))
                )
            ),
            .section(
                .class("technology"),
                .forEach(site.technology.features) { feature in
                    .div(
                        .class("well"),
                        .h2(
                            .element(named: "mark", nodes: [
                                .class("span-red icon"),
                                .text(feature.symbol)
                            ])
                        ),
                        .p(
                            .strong(
                                .class("system-red"),
                                .text(feature.title)
                            ),
                            .text(" \(feature.description)")
                        )
                    )
                }
            )
        ])
    }
    
    static func features<T: Website>(for site: T) -> Node {
        return .element(named: "", nodes: [
            .header(
                .h2(.text(site.features.title)),
                .if(site.features.subtitle.isEmpty == false,
                    .h4(.text(site.features.subtitle))
                )
            ),
            .section(
                .class("features max-section"),
                .forEach(site.features.differentiators) { differentiator in
                    .div(
                        .h3(
                            .span(.class("icon"), .text(differentiator.symbol)),
                            .br(),
                            .element(named: "small", text: differentiator.title)
                        ),
                        .p(.text(differentiator.description)),
                        .if(differentiator.href != nil,
                            .a(
                                .href(differentiator.href ?? ""),
                                .text("Learn More "),
                                .span(.class("icon"), .text("􀄯"))
                            )
                        )
                    )
                }
            )
        ])
    }
    
    static func brands<T: Website>(for site: T) -> Node {
        return .element(named: "", nodes: [
            .header(
                .h2(.text(site.brands.title)),
                .if(site.brands.subtitle.isEmpty == false,
                    .h4(.text(site.brands.subtitle))
                )
            ),
            .section(
                .class("brands"),
                .forEach(site.brands.sources) { source in
                    .div(
                        .element(named: "picture", nodes: [
                            .selfClosedElement(named: "source", attributes: [
                                .attribute(named: "src", value: "/img/dark/source/\(source).png"),
                                .attribute(named: "srcset", value: "/img/dark/source/\(source)@2x.png 2x"),
                                .attribute(named: "media", value: "(prefers-color-scheme: dark)")
                            ]),
                            .selfClosedElement(named: "img", attributes: [
                                .attribute(named: "class", value: "brand-image"),
                                .attribute(named: "src", value: "/img/light/source/\(source).png"),
                                .attribute(named: "srcset", value: "/img/light/source/\(source)@2x.png 2x")
                            ])
                        ])
                        
                    )
                }
            )
        ])
    }
    
    static func download<T: Website>(for site: T) -> Node {
        return .element(named: "", nodes: [
            .header(
                .h2(.text(site.download.title)),
                .if(site.download.subtitle.isEmpty == false,
                    .h4(.text(site.download.subtitle))
                )
            ),
            .section(
                .class("downloads"),
                .div(
                    .appStoreLink(for: site)
                )
            )
        ])
    }
    
    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
            .a(.href("/"), .text("Home")),
            .text(" • "),
            .a(.href("https://twitter.com/getshields"), .text("Twitter")),
            .text(" • "),
            .a(.href("https://instagram.com/getshields"), .text("Instagram")),
            .text(" • "),
            .a(.href("https://github.com/getshields"), .text("GitHub")),
            .text(" • "),
            .a(.href("/privacy"), .text("Privacy")),
            .br(),
            .element(named: "small", text: site.copyright)
        )
    }
    
    //MARK: - Utility functions
    
    static func appStoreLink<T: Website>(for site: T) -> Node {
        return .a(
            .href(site.download.appStoreURL),
            .element(named: "picture", nodes: [
                .class("download-image"),
                .selfClosedElement(named: "source", attributes: [
                    .attribute(named: "srcset", value: "/StevenPaulJobsTheme/img/\(site.download.state.description)-mac-app-store/us-uk/white.svg"),
                    .attribute(named: "media", value: "(prefers-color-scheme: dark)")
                ]),
                .selfClosedElement(named: "img", attributes: [
                    .attribute(named: "src", value: "/StevenPaulJobsTheme/img/\(site.download.state.description)-mac-app-store/us-uk/black.svg"),
                ])
            ])
        )
    }
}
