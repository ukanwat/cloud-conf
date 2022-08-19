local core     = require("apisix.core")
local consumer_mod = require("apisix.consumer")
local plugin_name = "custom-auth"


local lrucache = core.lrucache.new({
    type = "plugin",
})

local schema = {
    type = "object",
    properties = {
    },
}

local consumer_schema = {
    type = "object",
    properties = {
        key = {type = "string"},
        secret = {type = "string"},
    },
    required = {"key","secret"},
}


local _M = {
    version = 0.1,
    priority = 2600,
    type = 'auth',
    name = plugin_name,
    schema = schema,
    consumer_schema = consumer_schema,
}







local function fetch_jwt_token(ctx)
    local token = core.request.header(ctx, "authorization")
    if token then
        local prefix = sub_str(token, 1, 7)
        if prefix == 'Bearer ' or prefix == 'bearer ' then
            return sub_str(token, 8)
        end

        return token
    end

    token = ctx.var.arg_jwt
    if token then
        return token
    end

    local val = ctx.var.cookie_jwt
    if not val then
        return nil, "JWT not found in cookie"
    end
    return val
end






function _M.check_schema(conf, schema_type)
    if schema_type == core.schema.TYPE_CONSUMER then
        return true
    else
        return true
    end
end


function _M.rewrite(conf, ctx)
    local jwt_token, err = fetch_jwt_token(ctx)
    if not jwt_token then
        core.log.info("failed to fetch JWT token: ", err)
        return 401, {message = "Missing JWT token in request"}
    end

    

 

   


end


return _M