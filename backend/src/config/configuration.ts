export default () => ({
  port: parseInt(process.env.PORT ?? '3000', 10),
  nodeEnv: process.env.NODE_ENV || 'development',
  ticketmaster: {
    apiKey: process.env.TM_API_KEY,
    baseUrl: process.env.TM_BASE_URL || 'https://app.ticketmaster.com/discovery/v2',
  },
  supabase: {
    url: process.env.SUPABASE_URL,
    anonKey: process.env.SUPABASE_ANON_KEY,
    serviceRoleKey: process.env.SUPABASE_SERVICE_ROLE_KEY,
  },
  cache: {
    ttl: parseInt(process.env.CACHE_TTL ?? '3600', 10),
  },
});
