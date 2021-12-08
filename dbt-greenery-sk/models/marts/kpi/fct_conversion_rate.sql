
{{sessions_with_checkout()}}

SELECT 
    sum(has_checkout)::numeric / count(session_id) as conv_rate
from sessions_with_checkout