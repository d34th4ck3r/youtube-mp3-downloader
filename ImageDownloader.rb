require "nokogiri"
require "open-uri"
require "certified"

def getHTMLData(url)
	return open(url).read.to_s
end

def parseHTMLPage(htmlData)
	return Nokogiri::HTML(htmlData)
end

def getAllImagesURL(parsedHTMLPage)
	return parsedHTMLPage.xpath("//img").map { |i| i["src"]}
end

def getNameFromURL(url)
	return url.split("/")[-1]
end

def downloadImage(url)
	name=getNameFromURL(url)
	begin
		open(url){ |f|
			File.open("images/"+name, "wb") { |io| io.puts f.read }
		}	
	rescue Exception => e
		puts e.message
	end
	
end

def downloadAllImagesFromPage(url)
	getAllImagesURL(parseHTMLPage(getHTMLData(url))).each do |imageURL|
		if imageURL.split(".")[-1]=="jpg" or imageURL.split(".")[-1]=="png"
			downloadImage(imageURL)
		end
	end	
end

def generateAllURLAndDownload()
	(1..18010).each do |pageNo|
		puts pageNo
		url="http://www.xossip.com/showthread.php?t=691126&page=" + pageNo.to_s
		puts url
		downloadAllImagesFromPage(url)
	end
end

generateAllURLAndDownload()