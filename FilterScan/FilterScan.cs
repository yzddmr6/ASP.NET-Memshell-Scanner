using System;
using System.Collections.Generic;
using System.Reflection;
using System.Text;
using System.Web.Mvc;

namespace MemShellScan
{
    public class FilterScan
    {
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
                        "<td style=\"text-align:center\">{0}</td><td>{1}</td><td>{2}</td><td>{3}</td><td>{4}</td><td style=\"text-align:center\"><a href=\"?action=deleteFilter&name={5}&id={6}\">kill</a></td>"
                        , i
                        , filterType
                        , filterOrder
                        , filterScope
                        , codebase
                        , System.Web.HttpUtility.UrlEncode(filterType)
                        , i
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

        public static string deleteFilter(int id, string name)
        {
            try
            {
                GlobalFilterCollection globalFilterCollection = GlobalFilters.Filters;
                int i = 0;

                foreach (Filter filter in globalFilterCollection)
                {
                    i++;
                    string filterType = filter.Instance.GetType().ToString();
                    if (i == id && filterType.Equals(name))
                    {
                        // globalFilterCollection.Remove(filter);
                        FieldInfo filtersField = globalFilterCollection.GetType().GetField("_filters",
                            System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
                        List<Filter> filtersList = (List<Filter>)filtersField.GetValue(globalFilterCollection);
                        bool flag = filtersList.Remove(filter);
                        if (flag)
                        {
                            return name + " delete Success!";
                        }
                        else
                        {
                            return name + " delete Failed!";
                        }
                    }
                }
            }
            catch (Exception e)
            {
                return name + " delete Failed! " + e;
            }

            return "Can not find target filter: " + name;
        }
    }
}