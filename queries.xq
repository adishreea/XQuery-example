<r> (: number of items listed on all continents :)
    <l>
        {
            for $x in doc("auction.xml")/site/regions/*
            return <count>&#xa;{count($x/item)}</count>
        }
    </l> (: names of items registered in Europe along with their descriptions :)
    <m>
        {
            for $x in doc("auction.xml")/site/regions/europe//item
            return <item>&#xa;<name>{$x/name/text()}</name>&#xa;<description>{$x/description}</description>&#xa;</item>
        }
    </m> (: names of persons and the number of items they bought :)
    <n>
        {
            for $x in distinct-values(doc("auction.xml")/site/closed_auctions/closed_auction/buyer/@person)
            return ($x, count(index-of(doc("auction.xml")/site/closed_auctions/closed_auction/buyer/@person, $x)), '&#xa;')
        }
    </n> (: all persons according to their interest, ie, for each interest category, display the persons :)
    <p>
        {
            for $x in doc("auction.xml")/site/people//person
            where exists($x/profile/interest/@category) = true
            return <person>&#xa;<name>{$x/name/text()}</name>&#xa;<category>{$x/profile/interest}</category>&#xa;</person>
        }
    </p> (: Group persons by their categories of interest and output the size of each group :)
    <q>
        {
            for $x in doc("auction.xml")/site/people/person
            group by $x/profile/interest[1]/@category
            where exists($x/profile/interest/@category) = true
            return <person>&#xa;<count>{count($x/name)}</count>&#xa;</person>
        }
    </q> (: names of persons and the names of the items they bought in Europe :)
    <d>
        {
            for $x in doc("auction.xml")/site/regions/europe/item
            for $y in doc("auction.xml")/site/closed_auctions/closed_auction
            for $z in doc("auction.xml")/site/people/person
            where ($x/@id = $y/itemref/@item) and ($y/buyer/@person = $z/@id)
            return <item>&#xa;<itemname>&#xa;{$x/name/text()}</itemname><personname>&#xa;{$z/name/text()}</personname></item>
    }
    </d> (: alphabetically ordered list of all items along with their location :)
    <g>
        {
            for $x in doc("auction.xml")/site/regions//item
            order by $x/name
            return <item>&#xa;<name>{$x/name/text()}</name>&#xa;<location>{$x/location/text()}</location>&#xa;</item>
        }
    </g> (: reserve prices of those open auctions where a certain person with id person3 issued a bid before another person with id person6. Here before means "listed before in the XML document", that is, before in document order. :)
     <j>
        {
            for $x in doc("auction.xml")/site/open_auctions/open_auction 
            where $x/bidder/personref/@person = 'person3'
            return <reserve>&#xa;{$x/reserve/text()}</reserve>
        }
     </j>	
 </r>