#!/bin/bash
album="QZJ"
artist="SA6MWA"
year="$(date +%Y)"
genre="Podcast"
comment="www.patreon.com/outsender"
coverfront="$HOME/qzj/artwork/qzj-1600x1600-1mib.jpeg"

t=()
d=()

t+=("001 Utesändaren blir också en podcast")
d+=("Avsnitt 91 av Utesändaren i podcastformat. Detta är starten på podcasten QZJ. Vad händer med vår moderna kommunkation? Blir basstationer i mobilnätet, repeatrar i diverse kommradionät och knutpunkter för datatrafik utan soppa till elverken då tystnar det i såväl kabel som etern. QZJ är en gammal militär Q-förkortning som sändes när man inte hörde svar på UKV och ber om kvittering via KV. UKV är ultrakortvåg - all mobil telefoni och kommradio är UKV. KV är kortvåg - det där gamla, förlegade sättet att kommunicera. KV kräver kompetens - precis som mycket annat när strömmen inte längre strömmar i vägguttaget. Tanken med QZJ är att fokusera på vad vi behöver kunna när det krisar och speciellt inom radiokommunikation.")

t+=("002 Erfarenheter från en framskjuten ledningsplats")
d+=("Detta avsnitt är en introduktion till QZJ. Vad ska podden handla om? Mot min erfarenhet av IT-ledningsstöd under branden i Västmanland 2014 så kretsar diskussionen runt det digitala arbetssätt vi kanske alltför väl vant oss vid. Arbetssättet lämpar sig inte alls särskilt bra under mindre primitiva tekniska förhållanden som exempelvis råder på en framskjuten ledningsplats. Det finns en berättelse bakom avsnittet och jag drar hela historien från mitt överlevnadsintresse, skogsbranden i Västmanland, amatörradiocertifikat till Hemvärnet. Jag hoppas avsnittet ska resultera i feedback inför kommande avsnitt. Skicka in dina frågor, tips, kommentarer till sa6mwa@radiohorisont.se.")

t+=("003 Radiokommunikation för effektiv ledning och komplexa system")
d+=("Detta avsnitt handlar om komplexa system och nyttan med alternativ i kris och höjd beredskap. Avsnittet tar avstamp in i denna djungel från skogsbranden i Älvdalen 2018 och de kommunikationsproblem man upplevde med ett radiosystem tänkt för trygg och säker kommunikation i kris och höjd beredskap.
Länkar:
https://www.dn.se/nyheter/politik/problem-med-raddningstjanstens-kommunikationssystem-sakerhetsrisk/
https://how.complexsystems.fail
https://www.patreon.com/outsender
https://youtube.com/c/utesandaren
sa6mwa@radiohorisont.se")

t+=("004 7S")
d+=("I detta avsnittet lär du dig initialförkortningen 7S innan- och utantill. 7S står för stund, ställe, styrka, slag, sysselsättning, symbol och sagesman. Det kan även avslutas med ett 8:e S: sedan. En rättning är att pansarbilen (pb) i spaningsrapportexemplet förmodligen mer korrekt är en pansarterrängbil, ptgb.
Länkar:
https://www.patreon.com/outsender
https://hemvarn.wordpress.com/2020/03/13/15-spaningsrapport-7s-och-dess-8-punkter/
sa6mwa@radiohorisont.se")

t+=("005 Eftersnack QZJ003")
d+=("Extramaterial för medlemmar på patreon.com/outsender. Jag rättar mig själv och reder ut begreppen robusthet och motståndskraft (resilience) i komplexa system enligt Dr Richard Cook, m.fl samt tänker högt angående min ambition att föra in Uppdragstaktik i IT-branschen. Lite om hur man skulle kunnat anpassa RAKEL fort att fungera under skogsbränder även när man inte har basstationer (signlister och att vara snabb genom OODA-loopen). Avslutas med vad nästa avsnitt ska handla om: 7S.
https://www.youtube.com/watch?v=2S0k12uZR14")

t+=("006 HNY Introduktion till Morsekod")
d+=("En liten introduktion till CW samt Morse-kod och framför allt lite tips utifrån mina misstag hur man kan gå tillväga för att lära sig Morse-kod samt hur lång tid man kan förvänta sig att det tar.
Länkar:
https://www.ditdit.fm/shows/episode-31-cw-traffic-nets
https://qninewsletterdotnet.files.wordpress.com/2015/11/qni-2014-4.pdf
https://www.arrl.org/files/file/Public%20Service/ARES/Cascadia%20Rising%202016%20-%20Final%20Report.pdf
https://www.patreon.com/outsender")

t+=("007 Morsealfabetet")
d+=("Övningsmaterial med alfabetet A till Ö samt siffror 0 till 9 enligt International/Continental Morse Code.")

t+=("008 Genomgång CW QSO och förkortningar")
d+=("Avsnittet går igenom formatet på ett lagom långt CW QSO och vad flertalet av trafikförkortningarna man kommer i kontakt med betyder. Liknande format och förkortningar återfinns även i RTTY och PSK31 QSOn. Många av trafikförkortningarna och Q-koderna används även inom militär signalering både på CW och via RTTY.
Tillägg: QRL? frågas om frekvensen är ledig, eller snarare om frekvensen är upptagen. Får man QRL tillbaka (utan fråegetecken) så är frekvensen upptagen (QRL = Jag är upptagen, QRL? = Är du upptagen?).
https://www.patreon.com/outsender")

t+=("009 Utesändaren blickar bakåt och framåt")
d+=("En tillbakablick vad som hänt sen YouTube-kanalen Utesändaren introducerades och även bakgrunden till beslutet att starta kanalen. Jag blickar även framåt och presenterar hur upplägget kan tänkas bli framöver. Avsnittet spretar åt olika håll och utlovar en hel del episk musik (från videvo.net).
https://www.youtube.com/c/utesandaren
Lästips och en referens bland många till innehållet:
https://ieeexplore.ieee.org/document/9250315
Stöd QZJ och Utesändaren på:
https://www.patreon.com/outsender")

t+=("010 HF Non-Cooperative Target Recognition (HFNCTR)")
d+=("Detta är avsnitt 97 av Utesändaren, men som podcast och handlar om RÖS - röjande strålning samt huruvida man är ett samarbetsvilligt respektive icke samarbetsvilligt mål. Avsnittet behandlar hur kortvåg är resilient mot pejling och utstörning, men bara om man samtidigt tar hänsyn till dess sårbarheter och att därmed inte vara ett samarbetsvilligt mål.
https://www.youtube.com/c/utesandaren
https://youtu.be/CsXpRmljY94
https://youtu.be/JZEoqFP4xHQ
https://ieeexplore.ieee.org/document/9250315
https://www.ausa.org/articles/russia-gives-lessons-electronic-warfare
Stöd QZJ och Utesändaren på:
https://www.patreon.com/outsender")

t+=("011 Så lär du dig Morsekod")
d+=("I detta avsnitt tar jag upp några tips om hur man lämpligen lär sig telegrafi med Morsekod vare sig det är som blivande signalmatros, radioamatör, signalspanare, radiotelegrafist eller helt vanlig nörd. Syftet med avsnittet är att belysa problemen med de många snabbfix-metoder som bl.a florerar på YouTube. Dessa metoder hävdar att du lär dig telegrafera på 15 minuter och annat trams. Jag har flera år av träning bakom mig för att nå den hastighet jag klarar av idag och delar med mig av mina erfarenheter samt inom radioamatörhobbyn vedertagna metoder för att komma upp i användbar hastighet.
Stöd QZJ och Utesändaren på:
https://www.patreon.com/outsender")

t+=("012 Scrum och Uppdragstaktik")
d+=("Off-topic, fast relevant för den som kan komma att arbeta som signalist i t.ex en stab. Avsnitt 12 handlar om min åsikt att Scrum och Agile har sitt ursprung i ledarskapsfilosofin Uppdragstaktik, dvs Auftragstaktik, Führen mit Auftrag. Jag går igenom var Uppdragstaktik kommer ifrån och vad det är samt min syn på under vilken gemensam värdegrund det fungerar allra bäst. Därtill introducerar jag dig till överste John Boyd och OODA-loopen samt Boyd's ramverk Organizational Climate For Operational Success. Näst sist går jag igenom hela ramverket Scrum och hur det fungerar rent praktiskt. Allra sist redogör jag för hur vår familj förverkligar semesterplanerna med hjälp av Scrum där semestern är uppdelad i 10 så kallade sprintar.

Stöd QZJ och Utesändaren på:
https://www.patreon.com/outsender

Länk nämnd i avsnittet:
https://kkrva.se/forsvarsmakten-och-uppdragstaktiken/")

t+=("013 Normaltaktikens nya kläder")
d+=("Om avsnitt 12 kort handlade om vad som är uppdragstaktik enligt dess tyska förlaga Auftragstaktik så handlar detta avsnitt om vad som inte är uppdragstaktik samt vad som inte är agilitet inom IT-världen i samma avsnitt. Jag ramar in avsnittet runt en artikel av överstelöjtnant Ola Palmquist - chef för Taktikavdelningen vid Markstridsskolan - med titeln Uppdragstaktik, en svensk papperstiger?

Referenser:
https://kkrva.se/uppdragstaktik-en-svensk-papperstiger/
https://kkrva.se/tillbaka-till-framtiden/
https://www.armyupress.army.mil/Portals/7/combat-studies-institute/csi-books/Sonnenberger_Book.pdf

Annat:
https://youtu.be/0pYf_odrgLE
https://ryansydnor.com/blog/certain-to-win/
https://youtube.com/playlist?list=PL4pmLxkc7CTcukIlpD0UThT7Y_K09oxXe
")

t+=("014 Arke")
d+=("Hur kommunicerar man i ockuperat område mellan motståndsrörelsen, det som finns kvar av landets försvar och en exil-regering? Det är frågor som projekt Arke ämnar sysselsätta sig med och detta avsnittet presenterar dess bakgrund och varför det har fått namnet Arke.

Lästips...
Der Totale Widerstand / Total Resistance:
https://en.wikipedia.org/wiki/Total_Resistance_(book)
https://www.adlibris.com/se/bok/total-resistance-9781607963042

Referenser återfinns i följande inlägg:
https://www.patreon.com/posts/projekt-arke-56989898
https://www.patreon.com/posts/arke-framat-57208191

Stöd QZJ och Utesändaren på:
https://www.patreon.com/outsender
")

t+=("015 Planering Under Tidspress")
d+=("Grundläggande om metoden Planering Under Tidspress (PUT) av Peter Thunholm, originalet Recognitional Planning Model (RPM) samt Recognition-primed Decision Model (RPD) av Gary Klein och John F Schmitt.

Planering kan vara frustrerande och man vill bara ut och verkställa, men även de mest ivriga praktikerna inser att planering behövs. För oss som hatar långa planeringsmöten och planer som aldrig håller i verkligheten så är det fantastiskt att Planering Under Tidspress finns. Detta avsnittet går kortfattat igenom metoden, dess värde och underförstått varför Svenska Försvarsmakten använder metoden nästan uteslutande från åtminstone bataljon och nedåt - den är helt enkelt grym för otåliga taktiker. Jag utgår ifrån ett mer generellt tillämpningsperspektiv och menar att metoden går att utnyttja i all verksamhet man vill planera.

Stöd QZJ Utesändaren på Patreon:
https://www.patreon.com/outsender
")

if [ $# -lt 2 ]; then
  echo "usage: $0 TRACKNUMBER_IN_META_ARRAY podcast.flac [input2.flac] ..." >&2
  exit
fi
if ! [[ $1 =~ ^[0-9]+$ ]]; then
  echo "Not a number: $1" >&2
  exit 1
fi
if [ $1 -lt 1 ]; then
  echo "Track number need to be 1 or above." >&2
  exit 1
fi
let tracknumber=$1
let i=$1-1
shift

set -x

for f in $*
do
  metaflac --preserve-modtime \
    --set-tag=ALBUM="$album" \
    --set-tag=ARTIST="$artist" \
    --set-tag=TITLE="${t[$i]}" \
    --set-tag=TRACKNUMBER="${tracknumber}" \
    --set-tag=DATE="$year" \
    --set-tag=GENRE="$genre" \
    --set-tag=COMMENT="$comment" \
    --set-tag=DESCRIPTION="${d[$i]}" \
    --import-picture-from="$coverfront" \
    $f
done
