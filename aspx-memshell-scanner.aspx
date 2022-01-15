<%@ Page Language="c#"%>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="System.Web.Hosting" %>
<%@ Import Namespace="System.Web.Mvc" %>

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
            "        <th width=\"10%\">CodeBase</th>\n" +
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
            Type vpptype = current.GetType();
            string codebase = vpptype.Assembly.CodeBase;
            FieldInfo contentfield = vpptype.GetField("_fileContent",
                System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
            FieldInfo dirfield = vpptype.GetField("_virtualDir",
                System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
            FieldInfo gslpwdField = vpptype.GetField("password");
            FieldInfo gslkeyField = vpptype.GetField("key");
            FieldInfo prefield = typeof(VirtualPathProvider).GetField("_previous",
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
                "<td style=\"text-align:center\">{0}</td><td>{1}</td><td>{2}</td><td>{3}</td><td>{4}</td><td>{5}</td><td>{6}</td><td style=\"text-align:center\"><a href=\"?action=deleteVPP&name={7}\">kill</a></td>"
                , i
                , vpptype
                , _virtualDir
                , _fileContent
                , gslpwd
                , gslkey
                , codebase
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
            Type vpptype = current.GetType();
            FieldInfo prefield = typeof(VirtualPathProvider).GetField("_previous",
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
        FieldInfo hostenvField = typeof(HostingEnvironment).GetField("_theHostingEnvironment",
            System.Reflection.BindingFlags.Static | System.Reflection.BindingFlags.NonPublic);
        Object hostenvobj = hostenvField.GetValue(null);

        FieldInfo vppfield = hostenvobj.GetType().GetField("_virtualPathProvider",
            System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
        vppfield.SetValue(hostenvobj, obj);
    }

    public static void setPrevious(VirtualPathProvider obj, VirtualPathProvider target)
    {
        FieldInfo prefield = typeof(VirtualPathProvider).GetField("_previous",
            System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
        prefield.SetValue(obj, target);
    }

    public static string listAllFilter()
    {
        try
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<h4>MVC Filter scan result</h4>");
            sb.Append(
                "<table border=\"1\" cellspacing=\"0\" width=\"95%\" style=\"table-layout:fixed;word-break:break-all;background:#f2f2f2\">\n" +
                "    <thead>\n" +
                "        <th width=\"5%\">ID</th>\n" +
                "        <th width=\"20%\">Filter Type</th>\n" +
                "        <th width=\"5%\">Order</th>\n" +
                "        <th width=\"10%\">Scope</th>\n" +
                "        <th width=\"10%\">CodeBase</th>\n" +
                "        <th width=\"5%\">kill</th>\n" +
                "    </thead>\n" +
                "    <tbody>");

            GlobalFilterCollection globalFilterCollection = GlobalFilters.Filters;
            int i = 0;

            foreach (Filter filter in globalFilterCollection)
            {
                i++;
                string filterType = filter.Instance.GetType().ToString();
                string codebase = filter.Instance.GetType().Assembly.CodeBase;
                int filterOrder = filter.Order;
                FilterScope filterScope = filter.Scope;
                sb.Append(String.Format(
                    "<td style=\"text-align:center\">{0}</td><td>{1}</td><td>{2}</td><td>{3}</td><td>{4}</td><td style=\"text-align:center\"><a href=\"?action=deleteFilter&name={5}\">kill</a></td>"
                    , i
                    , filterType
                    , filterOrder
                    , filterScope
                    , codebase
                    , filterType
                    ));
                sb.Append("</tr>");
            }
            sb.Append("</tbody></table>");
            return sb.ToString();
        }
        catch (Exception e)
        {
            // Console.WriteLine(e);
            return "No filter";
        }
    }
    
</script>

<%
    Response.Write("<h2>ASP.NET Memshell Killer v1.1</h2>");
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
        result += listAllFilter();
        Response.Write(result);
    }

%>