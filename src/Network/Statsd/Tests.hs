import Network.Statsd.Parser

main = print metrics
    where metrics = parseMetrics "fuel.level:42|g\nlatency:250|ms"
