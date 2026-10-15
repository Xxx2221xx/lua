-- src/Config.lua
local Config = {}

-- API Configuration
Config.MESHY_API_BASE = "https://api.meshy.ai/v1"
Config.MESHY_API_KEY = os.getenv("MESHY_API_KEY") or "YOUR_KEY_HERE"

Config.CLAUDE_API_BASE = "https://api.anthropic.com/v1"
Config.CLAUDE_API_KEY = os.getenv("CLAUDE_API_KEY") or "YOUR_KEY_HERE"
Config.CLAUDE_MODEL = "claude-3-5-sonnet-20241022"

-- Generation Constraints
Config.MAX_PRIMARY_POLY_COUNT = 100000
Config.MAX_SECONDARY_OBJECTS = 25
Config.TERRAIN_SIZE = 256
Config.MAX_PARTICLES = 5000
Config.GENERATION_TIMEOUT_MESHY = 60
Config.GENERATION_TIMEOUT_CLAUDE = 30

-- Visual Defaults
Config.TARGET_FPS = 60
Config.MIN_FPS = 30
Config.DEFAULT_LIGHTING_MOOD = "neutral"

return Config
