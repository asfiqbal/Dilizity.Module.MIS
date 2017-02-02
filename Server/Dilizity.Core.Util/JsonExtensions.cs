using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Dilizity.Core.Util
{
    public static class JsonExtensions
    {
        public static List<JToken> FindTokens(this JToken containerToken, string name)
        {
            List<JToken> matches = new List<JToken>();
            FindTokens(containerToken, name, matches);
            return matches;
        }

        private static void FindTokens(JToken containerToken, string name, List<JToken> matches)
        {
            if (containerToken.Type == JTokenType.Object)
            {
                foreach (JProperty child in containerToken.Children<JProperty>())
                {
                    if (child.Name == name)
                    {
                        matches.Add(child.Value);
                    }
                    FindTokens(child.Value, name, matches);
                }
            }
            else if (containerToken.Type == JTokenType.Array)
            {
                foreach (JToken child in containerToken.Children())
                {
                    FindTokens(child, name, matches);
                }
            }
        }

        public static JToken RemoveEmptyChildren(JToken token)
        {
            if (token.Type == JTokenType.Object)
            {
                JObject copy = new JObject();
                foreach (JProperty prop in token.Children<JProperty>())
                {
                    JToken child = prop.Value;
                    if (child.HasValues)
                    {
                        child = RemoveEmptyChildren(child);
                    }
                    if (!IsEmpty(child))
                    {
                        //                if (child.HasValues)
                        copy.Add(prop.Name, child);
                    }
                }
                return copy;
            }
            else if (token.Type == JTokenType.Array)
            {
                JArray copy = new JArray();
                foreach (JToken item in token.Children())
                {
                    JToken child = item;
                    if (child.HasValues)
                    {
                        child = RemoveEmptyChildren(child);
                    }
                    if (!IsEmpty(child))
                    {
                        copy.Add(child);
                    }
                }
                return copy;
            }
            return token;
        }

        private static bool IsEmpty(JToken token)
        {
            return (token.Type == JTokenType.Null);
        }

        public static void RemoveFields(JToken token, string[] fields)
        {
            JContainer container = token as JContainer;
            if (container == null) return;

            List<JToken> removeList = new List<JToken>();
            foreach (JToken el in container.Children())
            {
                JProperty p = el as JProperty;
                if (p != null && fields.Contains(p.Name))
                {
                    removeList.Add(el);
                }
                RemoveFields(el, fields);
            }

            foreach (JToken el in removeList)
            {
                el.Remove();
            }
        }

        private static void ClearEmpty(JToken token, List<JToken> nodesToDelete)
        {
            JContainer container = token as JContainer;
            if (container == null) return;

            foreach (var child in container.Children())
            {
                var cont = child as JContainer;

                if (child.Type == JTokenType.Property ||
                    child.Type == JTokenType.Object ||
                    child.Type == JTokenType.Array)
                {
                    if (child.HasValues)
                    {
                        ClearEmpty((JToken)cont, nodesToDelete);
                    }
                    else
                    {
                        nodesToDelete.Add(child.Parent);
                    }
                }
            }
        }

        public static void DeepRemove(JToken jsonDocument)
        {
            var nodesToDelete = new List<JToken>();
            var parsed = (JContainer)jsonDocument;

            do
            {
                nodesToDelete.Clear();

                ClearEmpty(parsed, nodesToDelete);

                foreach (var token in nodesToDelete)
                {
                    token.Remove();
                }
            } while (nodesToDelete.Count > 0);
        }
    }
}
