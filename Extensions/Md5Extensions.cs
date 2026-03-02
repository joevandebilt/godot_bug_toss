using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace HelloGodot.Extensions
{
    public static class Md5Extensions
    {
        public static string GetMd5Checksum<T>(IList<T> data)
        {
            string json = JsonSerializer.Serialize(data);
            var tmpSource = ASCIIEncoding.ASCII.GetBytes(json);
            var md5 = MD5.HashData(tmpSource);
            return Convert.ToHexString(md5);
        }
    }
}
