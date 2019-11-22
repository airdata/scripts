wget -r -N -l inf --no-remove-listing http://toxitystudio.com

wget -r -k -l 1 --mirror http://toxitystudio.com

wget ‐‐execute robots=off ‐‐recursive ‐‐no-parent ‐‐continue ‐‐no-clobber http://toxitystudio.com


wget -r -k -l 1 --mirror  http://toxitystudio.com/


#Spider Websites with Wget – 20 Practical Examples

Wget is extremely powerful, but like with most other command line programs, the plethora of options it supports can be intimidating to new users. Thus what we have here are a collection of wget commands that you can use to accomplish common tasks from downloading single files to mirroring entire websites. It will help if you can read through the wget manual but for the busy souls, these commands are ready to execute.

1. Download a single file from the Internet
wget http://example.com/file.iso

2. Download a file but save it locally under a different name
wget ‐‐output-document=filename.html example.com

3. Download a file and save it in a specific folder
wget ‐‐directory-prefix=folder/subfolder example.com

4. Resume an interrupted download previously started by wget itself
wget ‐‐continue example.com/big.file.iso

5. Download a file but only if the version on server is newer than your local copy
wget ‐‐continue ‐‐timestamping wordpress.org/latest.zip

6. Download multiple URLs with wget. Put the list of URLs in another text file on separate lines and pass it to wget.
wget ‐‐input list-of-file-urls.txt

7. Download a list of sequentially numbered files from a server
wget http://example.com/images/{1..20}.jpg

8. Download a web page with all assets – like stylesheets and inline images – that are required to properly display the web page offline.
wget ‐‐page-requisites ‐‐span-hosts ‐‐convert-links ‐‐adjust-extension http://toxitystudio.com
Mirror websites with Wget

9. Download an entire website including all the linked pages and files


10. Download all the MP3 files from a sub directory
wget ‐‐level=1 ‐‐recursive ‐‐no-parent ‐‐accept mp3,MP3 http://example.com/mp3/

11. Download all images from a website in a common folder
wget ‐‐directory-prefix=files/pictures ‐‐no-directories ‐‐recursive ‐‐no-clobber ‐‐accept jpg,gif,png,jpeg http://example.com/images/


12. Download the PDF documents from a website through recursion but stay within specific domains.
wget ‐‐mirror ‐‐domains=abc.com,files.abc.com,docs.abc.com ‐‐accept=pdf http://abc.com/

13. Download all files from a website but exclude a few directories.
wget ‐‐recursive ‐‐no-clobber ‐‐no-parent ‐‐exclude-directories /forums,/support http://example.com

Wget for Downloading Restricted Content

Wget can be used for downloading content from sites that are behind a login screen or ones that check for the HTTP referer and the User Agent strings of the bot to prevent screen scraping.

14. Download files from websites that check the User Agent and the HTTP Referer
wget ‐‐refer=http://google.com ‐‐user-agent=”Mozilla/5.0 Firefox/4.0.1″ http://nytimes.com

15. Download files from a password protected sites
wget ‐‐http-user=labnol ‐‐http-password=hello123 http://example.com/secret/file.zip

16. Fetch pages that are behind a login page. You need to replace user and password with the actual form fields while the URL should point to the Form Submit (action) page.
wget ‐‐cookies=on ‐‐save-cookies cookies.txt ‐‐keep-session-cookies ‐‐post-data ‘user=labnol&password=123′ http://example.com/login.php
wget ‐‐cookies=on ‐‐load-cookies cookies.txt ‐‐keep-session-cookies http://example.com/paywall

Retrieve File Details with wget

17. Find the size of a file without downloading it (look for Content Length in the response, the size is in bytes)
wget ‐‐spider ‐‐server-response http://example.com/file.iso

18. Download a file and display the content on screen without saving it locally.
wget ‐‐output-document – ‐‐quiet google.com/humans.txt

wget
19. Know the last modified date of a web page (check the Last Modified tag in the HTTP header).
wget ‐‐server-response ‐‐spider http://www.labnol.org/

20. Check the links on your website to ensure that they are working. The spider option will not save the pages locally.
wget ‐‐output-file=logfile.txt ‐‐recursive ‐‐spider http://example.com

Also see: Essential Linux Commands

Wget – How to be nice to the server?

The wget tool is essentially a spider that scrapes / leeches web pages but some web hosts may block these spiders with the robots.txt files.
Also, wget will not follow links on web pages that use the rel=nofollow attribute.

You can however force wget to ignore the robots.txt and the nofollow directives by adding the switch ‐‐execute robots=off to all your wget commands.
If a web host is blocking wget requests by looking at the User Agent string, you can always fake that with the ‐‐user-agent=Mozilla switch.

The wget command will put additional strain on the site’s server because it will continuously traverse the links and download files.
A good scraper would therefore limit the retrieval rate and also include a wait period between consecutive fetch requests to reduce the server load.

wget ‐‐limit-rate=20k ‐‐wait=60 ‐‐random-wait ‐‐mirror example.com

In the above example, we have limited the download bandwidth rate to 20 KB/s and the wget utility will wait anywhere between 30s and 90 seconds before retrieving the next resource.

Finally, a little quiz. What do you think this wget command will do?
wget ‐‐span-hosts ‐‐level=inf ‐‐recursive dmoz.org

Retrieve /images/pic01.jpg from host example.com:

wget http://example.com/images/pic01.jpg
Retrieve /images/pic01.jpg from host example.com, specifying the user agent for IE7 on a Windows XP SP2 system instead of "Wget/1.xx":

wget --user-agent="Mozilla/4.0 (Windows; MSIE 7.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727)" http://example.com/images/pic01.jpg
Retrieve /images/pic01.jpg from host example.com, specifying "http://anothersite.example.com/search?hl=en&q=pictures" as the referer:

wget --referer="http://anothersite.example.com/search?hl=en&q=pictures" http://example.com/images/pic01.jpg
Resume download of /images/pic01.jpg from host example.com for partially downloaded files:

wget -c http://example.com/images/pic01.jpg
Mirror host example.com, but do not follow any links to external sites:

wget -m http://example.com/
Mirror host example.com, but only retrieve files with extensions .jpg and .gif:

wget -m --accept=jpg,gif http://example.com/
Only retrieve files with extensions .jpg and .gif from example.com. Do not create any directories:

wget -m --accept=jpg,gif -nd http://example.com/
Retrieve all files except those with extension .html from example.com. Do not create any directories:

wget -m --accept=* --reject=html -nd http://example.com/
Download all files with extension .pdf from FTP site ftp.example.com

wget -m --accept=pdf -nd ftp://ftp.example.com
Mirror host example.com. Wait exactly 5 seconds between retrievals:

wget -m --wait=5 http://example.com/
Mirror host example.com. Wait between 0 to 2 times the wait value between retrievals (i.e. by specifying a wait value of 5 seconds, the wait period between retrievals will vary between 0 to 10 seconds):

wget -m --wait=5 --random-wait http://example.com/
Mirror host example.com, ignoring the instructions specified in the robots.txt file (use this with caution), and limit the download rate to 50KB/s:

wget -m -e robots=off --limit-rate=50k http://example.com/
Mirror the hosts specified in the file input_file (enter one URL per line):

wget -m -i input_file
Same as the command above but run wget in the background after startup:

wget -b -m -i input_file
