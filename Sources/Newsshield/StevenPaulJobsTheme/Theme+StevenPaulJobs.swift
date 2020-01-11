//
//  File.swift
//  
//
//  Created by Joe Blau on 1/8/20.
//

import Publish
import Plot

public extension Theme {
    /// The default "Foundation" theme that Publish ships with, a very
    /// basic theme mostly implemented for demonstration purposes.
    static var stevenPaulJobs: Self {
        Theme(
            htmlFactory: FoundationHTMLFactory(),
            resourcePaths: [
                "Resources/StevenPaulJobsTheme/css/styles.css",
                "Resources/css/news-shield-styles.css"
            ]
        )
    }
}

private struct FoundationHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index,
                       context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body(
                .hero(for: context, selectedSection: nil),
                .main(
                    .brands(for: context.site),
                    .footer(for: context.site)
                    )
            )
        )
    }

    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body(
                .header(for: context, selectedSection: section.id),
                .wrapper(
                    .h1(.text(section.title)),
                    .itemList(for: section.items, on: context.site)
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .class("item-page"),
                .header(for: context, selectedSection: item.sectionID),
                .wrapper(
                    .article(
                        .div(
                            .class("content"),
                            .contentBody(item.body)
                        ),
                        .span("Tagged with: "),
                        .tagList(for: item, on: context.site)
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makePageHTML(for page: Page,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(

                ),
                .footer(for: context.site)
            )
        )
    }

    func makeTagListHTML(for page: TagListPage,
                         context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1("Browse all tags"),
                    .ul(
                        .class("all-tags"),
                        .forEach(page.tags.sorted()) { tag in
                            .li(
                                .class("tag"),
                                .a(
                                    .href(context.site.path(for: tag)),
                                    .text(tag.string)
                                )
                            )
                        }
                    )
                ),
                .footer(for: context.site)
            )
        )
    }

    func makeTagDetailsHTML(for page: TagDetailsPage,
                            context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site),
            .body(
                .header(for: context, selectedSection: nil),
                .wrapper(
                    .h1(
                        "Tagged with ",
                        .span(.class("tag"), .text(page.tag.string))
                    ),
                    .a(
                        .class("browse-all"),
                        .text("Browse all tags"),
                        .href(context.site.tagListPath)
                    ),
                    .itemList(
                        for: context.items(
                            taggedWith: page.tag,
                            sortedBy: \.date,
                            order: .descending
                        ),
                        on: context.site
                    )
                ),
                .footer(for: context.site)
            )
        )
    }
}

private extension Node where Context == HTML.BodyContext {
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }

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
                            .li(.a(
                                .class(section == selectedSection ? "selected" : ""),
                                .href(context.sections[section].path),
                                .text(context.sections[section].title)
                            ))
                        })
                    )
                )
            )
        )
    }
    
    static func hero<T: Website>(
        for context: PublishingContext<T>,
        selectedSection: T.SectionID?
    ) -> Node {
        let newsshield = context.site as! Newsshield
        print(newsshield.download)
        return header(
            .class("hero hero-background"),
            .h1(.text(context.site.name)),
            .a(
                .href(newsshield.download.appStoreURL),
                .text(newsshield.download.title)
            ),
            .div(
                .img(
                    .src("/img/dark/nytimes-hero.png")
                )
            )
        )
    }

    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .ul(
            .class("item-list"),
            .forEach(items) { item in
                .li(.article(
                    .h1(.a(
                        .href(item.path),
                        .text(item.title)
                    )),
                    .tagList(for: item, on: site),
                    .p(.text(item.description))
                ))
            }
        )
    }

    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
            ))
        })
    }
    

    static func brands<T: Website>(for site: T) -> Node {
        let newsshield = site as! Newsshield
        return .element(named: "", nodes: [
        .header(
             .h2(.text(newsshield.brands.title)),
             .if(newsshield.brands.subtitle.isEmpty == false,
                 .h4(.text(newsshield.brands.subtitle))
             )
         ),
         .section(
             .class("brands"),
             .forEach(newsshield.brands.sources) { source in
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

    static func footer<T: Website>(for site: T) -> Node {
        let newsshield = site as! Newsshield
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
            .element(named: "small", text: newsshield.copyright)
        )
    }
}
