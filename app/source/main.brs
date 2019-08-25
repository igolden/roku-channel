' ********** Copyright 2016 Roku Corp.  All Rights Reserved. ********** 
 
 sub RunUserInterface()
    screen = CreateObject("roSGScreen")
    scene = screen.CreateScene("HomeScene")
    port = CreateObject("roMessagePort")
    screen.SetMessagePort(port)
    screen.Show()
    
    jsonAsString = ReadAsciiFile("pkg:/json/titles.json")
    LabelList = ParseJSON(jsonAsString)
    
    OptionsList = [{Title:"Play"},
                   {Title:"Play video too"}]             
    scene.Content = ContentList2Node(GetApiArray())
    scene.LabelContent = ContentList2Node(LabelList)
    scene.OptionsContent = ContentList2Node(OptionsList)
    while true
        msg = wait(0, port)
        print "------------------"
        print "msg = "; msg
    end while
    
    if screen <> invalid then
        screen.Close()
        screen = invalid
    end if
    
end sub


Function ParseXMLContent(list As Object)
    RowItems = createObject("RoSGNode","ContentNode")
    
    for each rowAA in list
        row = ContentList2Node(rowAA.ContentList)
        row.Title = rowAA.Title
        RowItems.appendChild(row)
    end for

    return RowItems
End Function

function ContentList2Node(contentList as Object) as Object
    result = createObject("roSGNode","ContentNode")
    
    for each itemAA in contentList
        item = createObject("roSGNode", "ContentNode")
        item.SetFields(itemAA)
        result.appendChild(item)
    end for
    
    return result
end function

Function GetApiArray()
    jsonAsString = ReadAsciiFile("pkg:/json/videos.json")
    responseArray = ParseJSON(jsonAsString)

    result = []

    for each video in responseArray
      item = {}
      item.title = video.Title
      item.link = video.Link
      item.description = video.Description
      item.stream = video.Url
      item.url = video.Url
      item.streamFormat = "mp4"
      result.push(item)
    end for

    return result
End Function


Function ParseXML(str As String) As dynamic
    if str = invalid return invalid
    xml = CreateObject("roXMLElement")
    if not xml.Parse(str) return invalid
    return xml
End Function
