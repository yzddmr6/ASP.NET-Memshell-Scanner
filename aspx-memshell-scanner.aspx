<%@ Page Language="c#"%>
<%@ Import Namespace="System.Web.Hosting" %>

<head>
    <title>ASP.NET-Memshell-Killer</title>
</head>
<script runat="server">
    public string listAllVPP()
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<h4>VirtualPathProvider scan result</h4>");
        sb.Append(
            "<table border=\"1\" cellspacing=\"0\" width=\"95%\" style=\"table-layout:fixed;word-break:break-all;background:#f2f2f2\">\n" +
            "    <thead>\n" +
            "        <th width=\"5%\">ID</th>\n" +
            "        <th width=\"20%\">Class Name</th>\n" +
            "        <th width=\"10%\">Pattern(AntSword)</th>\n" +
            "        <th width=\"20%\">File Content(AntSword)</th>\n" +
            "        <th width=\"10%\">Password(Godzilla)</th>\n" +
            "        <th width=\"10%\">Key(Godzilla)</th>\n" +
            "        <th width=\"5%\">kill</th>\n" +
            "    </thead>\n" +
            "    <tbody>");
        VirtualPathProvider current = HostingEnvironment.VirtualPathProvider;
        int i = 0;
        while (current != null)
        {
            i += 1;
            sb.Append("<tr>");
            var vpptype = current.GetType();
            var contentfield = vpptype.GetField("_fileContent",
                System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
            var dirfield = vpptype.GetField("_virtualDir",
                System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
            var gslpwdField = vpptype.GetField("password");
            var gslkeyField = vpptype.GetField("key");
            var prefield = typeof(VirtualPathProvider).GetField("_previous",
                System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
            string _fileContent = "null";
            string _virtualDir = "null";
            string gslpwd = "null";
            string gslkey = "null";
            if (contentfield != null && dirfield != null)
            {
                _fileContent = (string)contentfield.GetValue(current);
                _virtualDir = (string)dirfield.GetValue(current);
            }
            if (gslpwdField != null && gslkeyField != null)
            {
                gslpwd = (string)gslpwdField.GetValue(current);
                gslkey = (string)gslkeyField.GetValue(current);
            }

            VirtualPathProvider _previous = (VirtualPathProvider)prefield.GetValue(current);
            sb.Append(String.Format(
                "<td style=\"text-align:center\">{0}</td><td>{1}</td><td>{2}</td><td>{3}</td><td>{4}</td><td>{5}</td><td style=\"text-align:center\"><a href=\"?action=deleteVPP&name={6}\">kill</a></td>"
                , i
                , vpptype
                , _virtualDir
                , _fileContent
                , gslpwd
                , gslkey
                , vpptype));
            sb.Append("</tr>");
            current = _previous;
        }

        sb.Append("</tbody></table>");
        return sb.ToString();
    }

    public string deleteVPP(string className)
    {
        VirtualPathProvider bak = null; //后一个节点
        VirtualPathProvider current = HostingEnvironment.VirtualPathProvider; //当前节点
        VirtualPathProvider _previous = null; //前一个节点
        while (current != null)
        {
            var vpptype = current.GetType();
            var prefield = typeof(VirtualPathProvider).GetField("_previous",
                System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
            string _fileContent = "null";
            string _virtualDir = "null";

            _previous = (VirtualPathProvider)prefield.GetValue(current);

            if (vpptype.ToString().Equals(className)) //如果匹配到目标节点
            {
                if (bak == null) //如果删除的为当前节点，直接把当前节点设为_previous
                {
                    setVPP(_previous);
                    return className + " delete Success!";
                }
                else
                {
                    setPrevious(bak, _previous); //否则把后一个节点的pre节点设为当前节点的下一个节点
                    return className + " delete Success!";
                }
            }

            bak = current;
            current = _previous;
        }

        return "Cannot find target child " + className;
    }

    public static void setVPP(VirtualPathProvider obj)
    {
        var hostenvField = typeof(HostingEnvironment).GetField("_theHostingEnvironment",
            System.Reflection.BindingFlags.Static | System.Reflection.BindingFlags.NonPublic);
        var hostenvobj = hostenvField.GetValue(null);

        var vppfield = hostenvobj.GetType().GetField("_virtualPathProvider",
            System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
        vppfield.SetValue(hostenvobj, obj);
    }

    public static void setPrevious(VirtualPathProvider obj, VirtualPathProvider target)
    {
        var prefield = typeof(VirtualPathProvider).GetField("_previous",
            System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
        prefield.SetValue(obj, target);
    }
</script>

<%
    Response.Write("<h2>ASP.NET Memshell Killer v1.0</h2>");
    Response.Write("code by yzddmr6");
    string result = "";
    string action = Request.Params["action"];
    string name = Request.Params["name"];
    if (action != null && name != null)
    {
        if (action.Equals("deleteVPP"))
        {
            result += deleteVPP(name);
            Response.Write(String.Format("<script language=javascript>alert(\"{0}\")</script>", result));
        }
        Response.Write("<script language=javascript>window.history.go(-1);window.location.reload(true)</script>");
    }
    else
    {
        result += listAllVPP();
        Response.Write(result);
    }

%>