
<cfscript>
try{
    ftpsClient = CreateObject("java","org.apache.commons.net.ftp.FTPSClient").init(JavaCast("boolean",false));
    // set server address to connect to and begin
  ftpsClient.connect(JavaCast("string","ftp.chattanoogashooting.com"),2501);
    // set credentials
     username='your user name'
     password='you password'
    loggedIn = ftpsClient.login(username,password);
    if (loggedIn){
        //enter passive mode
        ftpsClient.enterLocalPassiveMode();
        // Set protection buffer size
        ftpsClient.execPBSZ(0);
        // Set data channel protection to private
        ftpsClient.execPROT("P");

        // LIST DIRECTORIES
        writeOutput("<h6>Directories List</h6>");
        writeOutput("<ul>");
        for (_file in ftpsClient.listDirectories())
            writeOutput("<li>" & _file.getName() & "</li>");
        writeOutput("</ul>");

        writeOutput("<h6>Files List</h6>");
        writeOutput("<ul>");
        for (_file in ftpsClient.listNames())
            writeOutput("<li>" & _file & "</li>");
        writeOutput("</ul>");

        // LIST FILES
        writeOutput("<ul>");
        for (_file in ftpsClient.listFiles("/_offline"))
            writeOutput("<li>" & _file.getName() & "</li>");
        writeOutput("</ul>");


        if (ftpsClient.isConnected()){
            ftpsClient.logout();
            ftpsClient.disconnect();
        }
    }
}
catch (any e){
    writeDump(e);
}
</cfscript>

