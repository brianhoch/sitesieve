Feature: Crawl site's internal links
  As an information architect
  I want to get a full list of all the site's pages with their unique urls
  In order to identify all content in the site that we need to organize

  Scenario: Document page titles and URLs
  # Priority 1
    Given The web crawler is running within a site
    When The crawler has links to other pages in this site that haven't been documented
    Then The crawler creates a list of all pages in this site with Page titles and urls
    Then the crawler passes the list to the screen reader

# *** Do we want to document non-text content like images, videos, animations, plug-in content?

Feature: Scan site content
  As an information architect
  In order to assess the content of all the various site pages
  I want to collect the content of the site's pages for easy automated indexing and human reading

# Semantically correct pages provide better information about what in the page code is important
# How deep we dig into the semantics may be best to phase over multiple releases (for example microformats)
# HTML5 semantic elements (like aside, header, footer) may fit best in a future release
## HTML4 div ids/classes would be an equivalent

  Scenario: Parse out headings
  # Priority 2
    Given the current page being scanned
    When the parser finds h1, h2, h3, h4, h5, h6
    Then the parser pulls out the header content
    And adds the header level to the page analysis
    And adds he header content to the page analysis under it's corresponding heading

  Scenario: Parse out text content
  # Priority 2
    Given the current page has content in the <body>
    When the parser finds <div>
    Then search for other <div> inside
    When parser finds the most granular <div>
    Then search for <p> inside
    And add the <p> content from the most granular <div> to the page's content inventory
    Then search for other text content in the <div>
    And add the text content from the most granular <div> to the page's content inventory
    Then continue the search reviewing each <div> in the page

  Scenario: Parse out HTML5 semantic elements
  # Priority 5
    Given the current page is HTML5
    And the page has semantic elements (<article>, <section>, <aside>, <header>, <footer>)
    Then parse out the semantic elements as such
    And add the parsed semantic elements to the page analysis

  Scenario: Parse out HTML4 delivered HTML5 semantic elements
  # Priority 4
    Given the page being scanned is HTML4 or less
    When the parser encounters ids or class attributes in <div> or <p>     elements corresponding to HTML5 semantic elements
    # This is a potentially tricky list, cribbing from how Safari 5 Reader works could give some good pointers on parsing HTML4 for the primary page content
    Then parse out the semantically marked elements as semantic elements
    And add the parsed semantic elements to the page analysis

  Scenario: Parse out microformat data - hCal
  # Priority 4
    Given the page being scanned includes microformat data
    When the parser encounters hCal data
    # See microformats.org page to see how to identify hCal data
    Then add the calendar event to the events section of the page analysis

  Scenario: Parse out microformat data - hCard
  # Priority 4
    Given the page being scanned includes microformat data
    When the parser encounters hCard data
    # See microformats.org page to see how to identify hCard data
    Then add the calendar event to the events section of the page analysis

# Microformats: hCard, XFN, hCal, VoteLinks, hReview, rel-license, rel-tag, XOXO

  Scenario: Parse out linked images
  # Priority 3
    Given The page being scanned includes linked image
    When The crawler encounters linked images in a page
    Then add the image to the content inventory list
    And associate it to the heading, article, subsection, and/or paragraph under which it falls

  Scenario: Parse out linked video (HTML5)
  # Priority 5
    Given The page being scanned includes linked video
    And The page is in HTML5 (uses <video> instead of <embed>)
    When the parser encounters a linked video
    Then add the video to the content inventory
    And associate it to the heading, article, subsection, and/or paragraph under which it falls

  Scenario: Parse out embedded files (flash, video, plugin files)
  # Priority 4
    Given context
    When event
    Then outcome

Feature: Review resulting content inventory and first pass analysis
  As an information architect
  In order to analyze and organize the content of the site
  I want to review the site's contents and any related indexes and machine-performed analysis of the contents

# *** Auto generate site map exportable to visio, graffle, svg. Correlate the grouping data into placements?
# *** open source the tool, the idea isn't to productize the code but to sell the process in which the tool is featured as a service.
# *** Open source the tools Yeco was working on like the RBX JavaScript library stuff in svn. Get it to other team members to learn.
# *** For the various RBX projects getting open sourced, what technical documentation is needed alongside the code?