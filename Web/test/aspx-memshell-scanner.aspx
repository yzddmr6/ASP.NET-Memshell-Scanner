<%@ Page Language="c#"%>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="System.Web.Hosting" %>

<head>
    <title>ASP.NET-Memshell-Killer</title>
</head>
<script runat="server">

    public static string FilterScanBase64 = "TVqQAAMAAAAEAAAA//8AALgAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAA4fug4AtAnNIbgBTM0hVGhpcyBwcm9ncmFtIGNhbm5vdCBiZSBydW4gaW4gRE9TIG1vZGUuDQ0KJAAAAAAAAABQRQAATAEDAB1g5GQAAAAAAAAAAOAAIiALATAAABQAAAAGAAAAAAAAIjMAAAAgAAAAQAAAAAAAEAAgAAAAAgAABAAAAAAAAAAGAAAAAAAAAACAAAAAAgAAAAAAAAMAYIUAABAAABAAAAAAEAAAEAAAAAAAABAAAAAAAAAAAAAAANAyAABPAAAAAEAAAIgDAAAAAAAAAAAAAAAAAAAAAAAAAGAAAAwAAACYMQAAHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAACAAAAAAAAAAAAAAACCAAAEgAAAAAAAAAAAAAAC50ZXh0AAAAKBMAAAAgAAAAFAAAAAIAAAAAAAAAAAAAAAAAACAAAGAucnNyYwAAAIgDAAAAQAAAAAQAAAAWAAAAAAAAAAAAAAAAAABAAABALnJlbG9jAAAMAAAAAGAAAAACAAAAGgAAAAAAAAAAAAAAAAAAQAAAQgAAAAAAAAAAAAAAAAAAAAAEMwAAAAAAAEgAAAACAAUA0CIAAMgOAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABswBgAaAQAAAQAAEQAAcw8AAAoKBnIBAABwbxAAAAomBnJBAABwbxAAAAomKBEAAAoLFgwAB28SAAAKDTioAAAACW8TAAAKEwQACBdYDBEEbxQAAApvFQAACm8WAAAKEwURBG8UAAAKbxUAAApvFwAACm8YAAAKEwYRBG8ZAAAKEwcRBG8aAAAKEwgGchgDAHAdjRAAAAElFgiMHAAAAaIlFxEFoiUYEQeMHAAAAaIlGREIjBUAAAGiJRoRBqIlGxEFKBsAAAqiJRwIjBwAAAGiKBwAAApvEAAACiYGcnsEAHBvEAAACiYACW8dAAAKOk3////eCwksBwlvHgAACgDcBnKHBABwbxAAAAomBm8WAAAKEwneDBMKAHKpBABwEwneABEJKgAAQTQAAAIAAAAwAAAAugAAAOoAAAALAAAAAAAAAAAAAAABAAAACgEAAAsBAAAMAAAAFgAAARswBADuAAAAAgAAEQAAKBEAAAoKFgsABm8SAAAKDDiKAAAACG8TAAAKDQAHF1gLCW8UAAAKbxUAAApvFgAAChMEBwIzChEEA28fAAAKKwEWEwURBSxWAAZvFQAACnK9BABwHyRvIAAAChMGEQYGbyEAAAp0AgAAGxMHEQcJbyIAAAoTCBEIEwkRCSwQAANyzwQAcCgjAAAKEwreWwADcvEEAHAoIwAAChMK3ksACG8dAAAKOmv////eCwgsBwhvHgAACgDcAN4gEwsAA3IRBQBwEQslLQQmFCsFbxYAAAooJAAAChMK3g9yMwUAcAMoIwAAChMKKwARCioAAAEcAAACABIAnK4ACwAAAAAAAAEAu7wAIBYAAAEiAiglAAAKACoAAABCU0pCAQABAAAAAAAMAAAAdjQuMC4zMDMxOQAAAAAFAGwAAAD0AgAAI34AAGADAAAYBAAAI1N0cmluZ3MAAAAAeAcAAHAFAAAjVVMA6AwAABAAAAAjR1VJRAAAAPgMAADQAQAAI0Jsb2IAAAAAAAAAAgAAAUcVAggJAAAAAPoBMwAWAAABAAAAIQAAAAIAAAADAAAAAgAAACUAAAAOAAAAAgAAAAIAAAABAAAAAwAAAAAAaQIBAAAAAAAGAKsBWQMGABgCWQMGAN8AJwMPAHkDAAAGAAcBlwIGAI4BlwIGAG8BlwIGAP8BlwIGAMsBlwIGAOQBlwIGAB4BlwIGAPMAOgMGANEAOgMGAFIBlwIGADkBRgIGANcDeAIGANQC8wMKAKkCVAAGAAEAOQAKAAADVAAKAKgAVAAGAMACeAIGAMoClwIGAA8AOQAKALsDVAAGALcAeAIGAAMElwIGABYAeAIOAAwEJQAGAGICeAIGAAcDnAMGAI0AeAIGAIgDlwIAAAAAHAAAAAAAAQABAAEAEACMAn8CQQABAAEAUCAAAAAAlgD5AuIAAQCsIQAAAACWAOwC5gABAMQiAAAAAIYYIQMGAAMAAAABAGMAAAACAJkACQAhAwEAEQAhAwYAGQAhAwoAKQAhAxAAMQAhAxAAOQAhAxAAQQAhAxAASQAhAxAAUQAhAxAAWQAhAxAAYQAhAxUAaQAhAxAAcQAhAxAAeQAhAxAAiQAhAwYAiQBvADIAyQCvAzgAkQATAz0ADADeA00AoQB2AFIAgQC0AFYAgQBgAlsA0QD/A18A2QC8AFsAoQDiAmQAoQCeAGgA6QCDAG0A8QDQA3IA+QDqA3kAAQHJAAYA8QCVA5oA0QBmAJ8AuQA2AqgAFAA/ArQA8QDJA7oA8QDJA8AAgQAhAwYALgALAOwALgATAPUALgAbABQBLgAjAB0BLgArAC0BLgAzAC0BLgA7AC0BLgBDAB0BLgBLADMBLgBTAC0BLgBbAC0BLgBjAEsBLgBrAHUBLgBzAIIBGgB9AEYArQAEgAAAAQAAAAAAAAAAAAAAAACMAgAABAAAAAAAAAAAAAAAxwAwAAAAAAAFAAIABwAAAAAAAADQAFQAAAAAAAQAAAAAAAAAAAAAANkAJQAAAAAAAAAASUVudW1lcmF0b3JgMQBMaXN0YDEASW50MzIAPE1vZHVsZT4AU3lzdGVtLldlYgBtc2NvcmxpYgBTeXN0ZW0uQ29sbGVjdGlvbnMuR2VuZXJpYwBTeXN0ZW0uV2ViLk12YwBpZABHZXRGaWVsZABBcHBlbmQAZ2V0X0luc3RhbmNlAFVybEVuY29kZQBJRGlzcG9zYWJsZQBuYW1lAGdldF9TY29wZQBGaWx0ZXJTY29wZQBHZXRUeXBlAGdldF9Db2RlQmFzZQBEaXNwb3NlAEd1aWRBdHRyaWJ1dGUARGVidWdnYWJsZUF0dHJpYnV0ZQBDb21WaXNpYmxlQXR0cmlidXRlAEFzc2VtYmx5VGl0bGVBdHRyaWJ1dGUAQXNzZW1ibHlUcmFkZW1hcmtBdHRyaWJ1dGUAVGFyZ2V0RnJhbWV3b3JrQXR0cmlidXRlAEFzc2VtYmx5RmlsZVZlcnNpb25BdHRyaWJ1dGUAQXNzZW1ibHlDb25maWd1cmF0aW9uQXR0cmlidXRlAEFzc2VtYmx5RGVzY3JpcHRpb25BdHRyaWJ1dGUAQ29tcGlsYXRpb25SZWxheGF0aW9uc0F0dHJpYnV0ZQBBc3NlbWJseVByb2R1Y3RBdHRyaWJ1dGUAQXNzZW1ibHlDb3B5cmlnaHRBdHRyaWJ1dGUAQXNzZW1ibHlDb21wYW55QXR0cmlidXRlAFJ1bnRpbWVDb21wYXRpYmlsaXR5QXR0cmlidXRlAEdldFZhbHVlAFJlbW92ZQBTeXN0ZW0uUnVudGltZS5WZXJzaW9uaW5nAFRvU3RyaW5nAEZpbHRlclNjYW4uZGxsAFN5c3RlbQBNZW1TaGVsbFNjYW4ARmlsdGVyU2NhbgBTeXN0ZW0uUmVmbGVjdGlvbgBHbG9iYWxGaWx0ZXJDb2xsZWN0aW9uAEV4Y2VwdGlvbgBGaWVsZEluZm8AU3RyaW5nQnVpbGRlcgBnZXRfT3JkZXIAZGVsZXRlRmlsdGVyAGxpc3RBbGxGaWx0ZXIASUVudW1lcmF0b3IAR2V0RW51bWVyYXRvcgAuY3RvcgBTeXN0ZW0uRGlhZ25vc3RpY3MAU3lzdGVtLlJ1bnRpbWUuSW50ZXJvcFNlcnZpY2VzAFN5c3RlbS5SdW50aW1lLkNvbXBpbGVyU2VydmljZXMARGVidWdnaW5nTW9kZXMAQmluZGluZ0ZsYWdzAEVxdWFscwBTeXN0ZW0uQ29sbGVjdGlvbnMAZ2V0X0ZpbHRlcnMAR2xvYmFsRmlsdGVycwBDb25jYXQARm9ybWF0AE9iamVjdABnZXRfQ3VycmVudABNb3ZlTmV4dABTeXN0ZW0uVGV4dABnZXRfQXNzZW1ibHkASHR0cFV0aWxpdHkAAD88AGgANAA+AE0AVgBDACAARgBpAGwAdABlAHIAIABzAGMAYQBuACAAcgBlAHMAdQBsAHQAPAAvAGgANAA+AACC1TwAdABhAGIAbABlACAAYgBvAHIAZABlAHIAPQAiADEAIgAgAGMAZQBsAGwAcwBwAGEAYwBpAG4AZwA9ACIAMAAiACAAdwBpAGQAdABoAD0AIgA5ADUAJQAiACAAcwB0AHkAbABlAD0AIgB0AGEAYgBsAGUALQBsAGEAeQBvAHUAdAA6AGYAaQB4AGUAZAA7AHcAbwByAGQALQBiAHIAZQBhAGsAOgBiAHIAZQBhAGsALQBhAGwAbAA7AGIAYQBjAGsAZwByAG8AdQBuAGQAOgAjAGYAMgBmADIAZgAyACIAPgAKACAAIAAgACAAPAB0AGgAZQBhAGQAPgAKACAAIAAgACAAIAAgACAAIAA8AHQAaAAgAHcAaQBkAHQAaAA9ACIANQAlACIAPgBJAEQAPAAvAHQAaAA+AAoAIAAgACAAIAAgACAAIAAgADwAdABoACAAdwBpAGQAdABoAD0AIgAyADAAJQAiAD4ARgBpAGwAdABlAHIAIABUAHkAcABlADwALwB0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";
    public static string RouterScanBase64 = "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eAD5ANoDfwABAc0ABgDxAJ8DlgAMACcCmwDxALkDoQDxALkDpwB5AC0DBgAuAAsA0wAuABMA3AAuABsA+wAuACMABAEuACsAFAEuADMAFAEuADsAFAEuAEMABAEuAEsAGgEuAFMAFAEuAFsAFAEuAGMAMgEuAGsAXAEaAIMAPQBNAASAAAABAAAAAAAAAAAAAAAAAJQCAAACAAAAAAAAAAAAAACuADYAAAAAAAMABQAAAAAAAAAAALcANwIAAAAAAgAAAAAAAAAAAAAAwAArAAAAAAAAAAAAAENvbGxlY3Rpb25gMQBJRW51bWVyYXRvcmAxAEludDMyADxNb2R1bGU+AFN5c3RlbS5XZWIAbXNjb3JsaWIAU3lzdGVtLkNvbGxlY3Rpb25zLkdlbmVyaWMAaWQAQXBwZW5kAFVybEVuY29kZQBSb3V0ZVRhYmxlAElEaXNwb3NhYmxlAFJ1bnRpbWVUeXBlSGFuZGxlAEdldFR5cGVGcm9tSGFuZGxlAG5hbWUAR2V0VHlwZQBnZXRfQ29kZUJhc2UAUm91dGVCYXNlAERpc3Bvc2UAR3VpZEF0dHJpYnV0ZQBEZWJ1Z2dhYmxlQXR0cmlidXRlAENvbVZpc2libGVBdHRyaWJ1dGUAQXNzZW1ibHlUaXRsZUF0dHJpYnV0ZQBBc3NlbWJseVRyYWRlbWFya0F0dHJpYnV0ZQBBc3NlbWJseUZpbGVWZXJzaW9uQXR0cmlidXRlAEFzc2VtYmx5Q29uZmlndXJhdGlvbkF0dHJpYnV0ZQBBc3NlbWJseURlc2NyaXB0aW9uQXR0cmlidXRlAENvbXBpbGF0aW9uUmVsYXhhdGlvbnNBdHRyaWJ1dGUAQXNzZW1ibHlQcm9kdWN0QXR0cmlidXRlAEFzc2VtYmx5Q29weXJpZ2h0QXR0cmlidXRlAEFzc2VtYmx5Q29tcGFueUF0dHJpYnV0ZQBSdW50aW1lQ29tcGF0aWJpbGl0eUF0dHJpYnV0ZQBSb3V0ZQBSZW1vdmUAVG9TdHJpbmcAU3lzdGVtLldlYi5Sb3V0aW5nAFN5c3RlbS5Db2xsZWN0aW9ucy5PYmplY3RNb2RlbABSb3V0ZXJTY2FuLmRsbABnZXRfVXJsAFN5c3RlbQBNZW1TaGVsbFNjYW4AUm91dGVyU2NhbgBTeXN0ZW0uUmVmbGVjdGlvbgBSb3V0ZUNvbGxlY3Rpb24ARXhjZXB0aW9uAFN0cmluZ0J1aWxkZXIASVJvdXRlSGFuZGxlcgBnZXRfUm91dGVIYW5kbGVyAGRlbGV0ZVJvdXRlcgBsaXN0QWxsUm91dGVyAElFbnVtZXJhdG9yAEdldEVudW1lcmF0b3IALmN0b3IAU3lzdGVtLkRpYWdub3N0aWNzAFN5c3RlbS5SdW50aW1lLkludGVyb3BTZXJ2aWNlcwBTeXN0ZW0uUnVudGltZS5Db21waWxlclNlcnZpY2VzAERlYnVnZ2luZ01vZGVzAGdldF9Sb3V0ZXMARXF1YWxzAFN5c3RlbS5Db2xsZWN0aW9ucwBDb25jYXQARm9ybWF0AE9iamVjdABnZXRfQ3VycmVudABNb3ZlTmV4dABTeXN0ZW0uVGV4dABnZXRfQXNzZW1ibHkASHR0cFV0aWxpdHkAADc8AGgANAA+AFIAbwB1AHQAZQByACAAcwBjAGEAbgAgAHIAZQBzAHUAbAB0ADwALwBoADQAPgAAgus8AHQAYQBiAGwAZQAgAGIAbwByAGQAZQByAD0AIgAxACIAIABjAGUAbABsAHMAcABhAGMAaQBuAGcAPQAiADAAIgAgAHcAaQBkAHQAaAA9ACIAOQA1ACUAIgAgAHMAdAB5AGwAZQA9ACIAdABhAGIAbABlAC0AbABhAHkAbwB1AHQAOgBmAGkAeABlAGQAOwB3AG8AcgBkAC0AYgByAGUAYQBrADoAYgByAGUAYQBrAC0AYQBsAGwAOwBiAGEAYwBrAGcAcgBvAHUAbgBkADoAIwBmADIAZgAyAGYAMgAiAD4ACgAgACAAIAAgADwAdABoAGUAYQBkAD4ACgAgACAAIAAgACAAIAAgACAAPAB0AGgAIAB3AGkAZAB0AGgAPQAiADUAJQAiAD4ASQBEADwALwB0AGgAPgAKACAAIAAgACAAIAAgACAAIAA8AHQAaAAgAHcAaQBkAHQAaAA9ACIAMgAwACUAIgA+AFIAbwB1AHQAZQByACAAVAB5AHAAZQA8AC8AdABoAD4ACgAgACAAIAAgACAAIAAgACAAPAB0AGgAIAB3AGkAZAB0AGgAPQAiADEAMAAlACIAPgBVAFIATAA8AC8AdABoAD4ACgAgACAAIAAgACAAIAAgACAAPAB0AGgAIAB3AGkAZAB0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";
    public static Assembly FilterScanAssemb = null;
    public static Assembly RouterScanAssemb = null;


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
                "<td style=\"text-align:center\">{0}</td><td>{1}</td><td>{2}</td><td>{3}</td><td>{4}</td><td>{5}</td><td>{6}</td><td style=\"text-align:center\"><a href=\"?action=deleteVPP&name={7}&id={8}\">kill</a></td>"
                , i
                , vpptype
                , _virtualDir
                , _fileContent
                , gslpwd
                , gslkey
                , codebase
                , System.Web.HttpUtility.UrlEncode(vpptype.ToString())
                , i));
            sb.Append("</tr>");
            current = _previous;
        }

        sb.Append("</tbody></table>");
        return sb.ToString();
    }

    public string deleteVPP(int id, string className)
    {
        VirtualPathProvider bak = null; //后一个节点
        VirtualPathProvider current = HostingEnvironment.VirtualPathProvider; //当前节点
        VirtualPathProvider _previous = null; //前一个节点
        int i = 0;
        while (current != null)
        {
            i += 1;
            Type vpptype = current.GetType();
            FieldInfo prefield = typeof(VirtualPathProvider).GetField("_previous",
                System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
            string _fileContent = "null";
            string _virtualDir = "null";

            _previous = (VirtualPathProvider)prefield.GetValue(current);

            if (i == id && vpptype.ToString().Equals(className)) //如果匹配到目标节点
            {
                if (bak == null) //如果删除的为当前节点，直接把当前节点设为_previous
                {
                    setVPP(_previous);
                }
                else
                {
                    setPrevious(bak, _previous); //否则把后一个节点的pre节点设为当前节点的下一个节点
                }
                return className + " delete Success!";
            }

            bak = current;
            current = _previous;
        }

        return "Cannot find target VPP " + className;
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
        Type type = FilterScanAssemb.GetType("MemShellScan.FilterScan");
        string s = (string)type.GetMethod("listAllFilter").Invoke(null, null);
        return s;
    }

    public static string deleteFilter(int id, string name)
    {
        Type type = FilterScanAssemb.GetType("MemShellScan.FilterScan");
        string s = (string)type.GetMethod("deleteFilter").Invoke(null, new object[] { id, name });
        return s;
    }

    public static string listAllRouter()
    {
        Type type = RouterScanAssemb.GetType("MemShellScan.RouterScan");
        string s = (string)type.GetMethod("listAllRouter").Invoke(null, null);
        return s;
    }

    public static string deleteRouter(int id, string name)
    {
        Type type = RouterScanAssemb.GetType("MemShellScan.RouterScan");
        string s = (string)type.GetMethod("deleteRouter").Invoke(null, new object[] { id, name });
        return s;
    }


</script>

<%
    Response.Write("<h2>ASP.NET Memshell Killer v1.4</h2>");
    Response.Write("code by yzddmr6");
    try
    {
        FilterScanAssemb = Assembly.Load(Convert.FromBase64String(FilterScanBase64));
        RouterScanAssemb = Assembly.Load(Convert.FromBase64String(RouterScanBase64));
    }
    catch (Exception e)
    {
        Response.Write("ScanAssembly加载失败");
    }

    string result = "";
    string action = Request.Params["action"];
    string name = Request.Params["name"];
    if (action != null && name != null)
    {
        int id = int.Parse(Request.Params["id"]);
        if (action.Equals("deleteVPP"))
        {
            result += deleteVPP(id, name);
        }
        else if (action.Equals("deleteFilter"))
        {
            result += deleteFilter(id, name);
        }
        else if (action.Equals("deleteRouter"))
        {
            result += deleteRouter(id, name);
        }
        Response.Write(String.Format("<script language=javascript>alert(\"{0}\")</script>", result));
        Response.Write("<script language=javascript>window.location.replace(document.referrer);</script>");
    }
    else
    {
        result += listAllVPP();
        try
        {
            result += listAllFilter();
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            result += "FilterScan失败，可能当前环境不支持Filter内存马： " + e;
        }
        try
        {
            result += listAllRouter();
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            result += "RouterScan失败，可能当前环境不支持Router内存马： " + e;
        }

        Response.Write(result);
    }

%>