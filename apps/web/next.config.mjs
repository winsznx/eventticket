/** @type {import('next').NextConfig} */
const nextConfig = {
    reactStrictMode: true,
    transpilePackages: ['@eventticket/shared', '@eventticket/base-adapter', '@eventticket/stacks-adapter'],
};

export default nextConfig;
