module Network.Statsd.Parser (parseMetrics) where

import Network.Statsd

parseMetrics :: String -> [Metric]
parseMetrics input = map parseMetric (lines input)

parseMetric :: String -> Metric
parseMetric string = Metric metricType name (read value)
    where (name, rest) = break (== ':') string
          (value, rest') = break (== '|') (tail rest)
          metricType = parseType (tail rest')

parseType :: String -> MetricType
parseType "g" = Gauge
parseType "ms" = Timer
parseType "c" = Counter
parseType x = error $ "invalid type: " ++ x
