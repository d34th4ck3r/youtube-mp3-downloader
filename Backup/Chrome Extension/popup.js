// Called when the user clicks on the browser action.

var youtube_url;
chrome.browserAction.onClicked.addListener(function(tab) {
  // No tabs or host permissions needed!
  youtube_url=tab.url;
  var http= new XMLHttpRequest();
  var url="http://127.0.0.1:8000/youtube";
  var params="url="+youtube_url;
  http.open("GET", url+"?"+params, true);
  http.onreadystatechange = function()
  {
    if (http.readyState==4 )
    {
      chrome.tabs.executeScript({
        code: "alert('"+http.status+"');"
      }); 
    }
  };
  http.send(null);
});
