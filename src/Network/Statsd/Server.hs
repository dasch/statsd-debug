import Network.Socket
import Network.Statsd
import Network.Statsd.Parser
import Control.Concurrent
import Control.Concurrent.Chan
import Data.Either

port = "8125"

main = do
    chan <- newChan
    forkIO $ networkServer chan
    metricServer chan

metricServer chan = do
    metric <- readChan chan
    print metric
    metricServer chan

networkServer chan = do
    addrinfos <- getAddrInfo (Just (defaultHints {addrFlags = [AI_PASSIVE]})) Nothing (Just port)
    let serveraddr = head addrinfos
    sock <- socket (addrFamily serveraddr) Datagram defaultProtocol
    bindSocket sock (addrAddress serveraddr)
    let handleMessage = do
            (msg, _, addr) <- recvFrom sock 1024
            case parseMetrics msg of
                Left error -> print $ "ERROR: " ++ msg
                Right metrics -> writeList2Chan chan metrics
            handleMessage
    handleMessage
