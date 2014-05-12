import Network.Socket
import Network.Statsd
import Network.Statsd.Parser
import Data.Either

main = do
    let port = "8125"
    addrinfos <- getAddrInfo (Just (defaultHints {addrFlags = [AI_PASSIVE]})) Nothing (Just port)
    let serveraddr = head addrinfos
    sock <- socket (addrFamily serveraddr) Datagram defaultProtocol
    bindSocket sock (addrAddress serveraddr)
    handleMessage sock

handleMessage sock = do
    (msg, _, addr) <- recvFrom sock 1024
    case parseMetrics msg of
        Left error -> print $ "ERROR: " ++ msg
        Right metrics -> print metrics
    handleMessage sock
