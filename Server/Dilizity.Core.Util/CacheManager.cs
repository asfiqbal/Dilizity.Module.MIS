using Dilizity.Core.Util;
using System;
using System.Runtime.Caching;

namespace Dilizity.Core.Util.Cache
{
    public enum MyCachePriority
    {
        Default,
        NotRemovable
    };

    public class CacheManager 
    {
        private static volatile CacheManager instance;
        private static object syncRoot = new Object();

    // Gets a reference to the default MemoryCache instance. 
        private static ObjectCache cache = MemoryCache.Default; 
        private CacheItemPolicy policy = null; 
        private CacheEntryRemovedCallback callback = null;

        private CacheManager() { }

        public static CacheManager Instance
        {
            get
            {
                if (instance == null)
                {
                    lock (syncRoot)
                    {
                        if (instance == null)
                            instance = new CacheManager();
                    }
                }
                return instance;
            }
        }

        public void Add(String CacheKeyName, Object CacheItem, MyCachePriority MyCacheItemPriority) 
        {
            using (FnTraceWrap tracer = new FnTraceWrap(CacheKeyName, CacheItem, MyCacheItemPriority))
            {
                callback = new CacheEntryRemovedCallback(this.CachedItemRemovedCallback);
                policy = new CacheItemPolicy();
                policy.Priority = (MyCacheItemPriority == MyCachePriority.Default) ?
                        CacheItemPriority.Default : CacheItemPriority.NotRemovable;
                //policy.AbsoluteExpiration = DateTimeOffset.Now.AddSeconds(10.00); 
                policy.RemovedCallback = callback;
                //policy.ChangeMonitors.Add(new HostFileChangeMonitor(FilePath));

                // Add inside cache 
                cache.Set(CacheKeyName, CacheItem, policy);
            }
        }

        public bool ContainsKey(string key)
        {
            return cache.Contains(key);
        }

        public void Add(String CacheKeyName, Object CacheItem)
        {
            using (FnTraceWrap tracer = new FnTraceWrap(CacheKeyName, CacheItem))
            {
                callback = new CacheEntryRemovedCallback(this.CachedItemRemovedCallback);
                policy = new CacheItemPolicy();
                policy.Priority = CacheItemPriority.Default | CacheItemPriority.NotRemovable;
                policy.RemovedCallback = callback;
                cache.Set(CacheKeyName, CacheItem, policy);
            }
        }

        public Object Get(String CacheKeyName) 
        { 
        // 
            return cache[CacheKeyName] as Object; 
        }

        public void Remove(String CacheKeyName) 
        { 
            if (cache.Contains(CacheKeyName)) 
            { 
                cache.Remove(CacheKeyName); 
            } 
        }

        private void CachedItemRemovedCallback(CacheEntryRemovedArguments arguments) 
        {
            using (FnTraceWrap tracer = new FnTraceWrap())
            {
                String strLog = String.Concat("Reason: ", arguments.RemovedReason.ToString(), " | Key-Name: ", arguments.CacheItem.Key, " | Value-Object: ", arguments.CacheItem.Value.ToString());
            }
        }
    } 
    
}
