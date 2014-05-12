module Network.Statsd.Parser (parseMetrics) where

import Network.Statsd
import Text.ParserCombinators.Parsec
import Text.Parsec.Numbers

parseMetrics :: String -> Either ParseError [Metric]
parseMetrics input = parse parseString "(unknown)" input

parseString :: GenParser Char st [Metric]
parseString = do
    result <- many parseLine
    eof
    return result

parseLine = do
    result <- parseMetric
    optional $ char '\n'
    return result

parseMetric = do
    name <- parseName
    value <- parseValue
    metricType <- parseType
    tags <- option [] parseTags
    return $ Metric metricType name value tags

parseName = do
    name <- many1 $ noneOf ":\n"
    char ':'
    return name

parseValue = do
    value <- parseFloat
    char '|'
    return value

parseType = do
    metricType <- many1 $ noneOf "|\n"
    optional $ char '|'
    return $ mapType metricType

parseTags :: GenParser Char st [(String, String)]
parseTags = do
    char '#'
    tags <- many1 parseTag
    return tags

parseTag :: GenParser Char st (String, String)
parseTag = do
    optional $ char ','
    name <- many1 $ noneOf ":,\n"
    char ':'
    value <- many $ noneOf ",\n"
    return (name, value)

mapType :: String -> MetricType
mapType "g" = Gauge
mapType "ms" = Timer
mapType "c" = Counter
mapType x = error $ "invalid type: " ++ x
