using System;
using System.Text;
using System.Web.Routing;

namespace MemShellScan
{
    public class RouterScan
    {
        public static string listAllRouter()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<h4>Router scan result</h4>");
            sb.Append(
                "<table border=\"1\" cellspacing=\"0\" width=\"95%\" style=\"table-layout:fixed;word-break:break-all;background:#f2f2f2\">\n" +
                "    <thead>\n" +
                "        <th width=\"5%\">ID</th>\n" +
                "        <th width=\"20%\">Router Type</th>\n" +
                "        <th width=\"10%\">URL</th>\n" +
                "        <th width=\"10%\">RouteHandler Type</th>\n" +
                "        <th width=\"10%\">CodeBase</th>\n" +
                "        <th width=\"5%\">kill</th>\n" +
                "    </thead>\n" +
                "    <tbody>");

            RouteCollection routes = RouteTable.Routes;
            int i = 0;
            foreach (RouteBase route in routes)
            {
                i++;
                string type = route.GetType().ToString();
                string url, handlerType, codebase;
                if (route.GetType() == typeof(Route))
                {
                    Route r = (Route)route;
                    url = r.Url;
                    handlerType = r.RouteHandler.GetType().ToString();
                    codebase = r.RouteHandler.GetType().Assembly.CodeBase;
                }
                else
                {
                    url = "*";
                    handlerType = "null";
                    codebase = route.GetType().Assembly.CodeBase;
                }

                sb.Append(String.Format(
                    "<td style=\"text-align:center\">{0}</td><td>{1}</td><td>{2}</td><td>{3}</td><td>{4}</td><td style=\"text-align:center\"><a href=\"?action=deleteRouter&name={5}&id={6}\">kill</a></td>"
                    , i
                    , type
                    , url
                    , handlerType
                    , codebase
                    , System.Web.HttpUtility.UrlEncode(type)
                    , i
                ));
                sb.Append("</tr>");
            }

            sb.Append("</tbody></table>");
            return sb.ToString();
        }

        public static string deleteRouter(int id, string name)
        {
            try
            {
                RouteCollection routes = RouteTable.Routes;
                int i = 0;
                foreach (RouteBase route in routes)
                {
                    i++;
                    string type = route.GetType().ToString();
                    if (i == id && type.Equals(name))
                    {
                        routes.Remove(route);
                        return name + " delete Success!";
                    }
                }
            }
            catch (Exception e)
            {
                return name + " delete Failed! " + e;
            }

            return "Can not find target router: " + name;
        }
    }
}