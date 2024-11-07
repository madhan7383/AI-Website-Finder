############Developer: ????################
use strict;
use LWP::UserAgent;
use HTTP::Cookies;
use URI::Escape;
use HTML::Entities;
use URI::URL;
use URI;
use Net::FTP;
use Cwd;
# use MIME::Lite;
use File::Copy;
# $ENV{'PERL_LWP_SSL_VERIFY_HOSTNAME'} = 0;
my $ua=LWP::UserAgent->new;
$ua->agent("Mozilla/5.0 (Windows NT 5.1; rv:18.0) Gecko/20100101 Firefox/18.0");
my $cookie_jar = HTTP::Cookies->new(file=>$0."_cookie.txt",autosave => 1,);
$ua->cookie_jar($cookie_jar);
$ua->max_redirect('0');
use LWP::ConnCache;
# my $conn_cache = LWP::ConnCache->new;
# $conn_cache->total_capacity([1]) ;
# $ua->conn_cache($conn_cache) ;
my $arg=$ARGV[0];
open fo,">Output_$arg.txt";
print fo "Input Name\tAddress\tGoogle URL\tMain Url\tSub_Title\tListed Title\tListed Snippet\tLength\n";
close fo;
my ($website_url,$snippet,$result);
	open fi,"<input_$arg.txt";
	my $nom=0;
	while(<fi>)
	{
	$nom++;
	print"No of instance:: $nom\n";
		chomp;
		my ($sno,$ip_website,$Address)=split('\t',$_);
		
		my $web="$ip_website"."+"."$Address";
		print("Web=>$web\n");
		$web=uri_escape($web);
		#print"\n==================input website:$ip_website==================\n";

			my @third_party=("zillow.com","angi.co","buildzoom.com","www.dnb.com","www.maps.google.com","www.merchantcircle.com","www.aussieweb.com","www.whitepages.com","www.hotfrog.com","www.startlocal.com","www.yellowpages.com","www.dlook.com","www.local.com","www.enterprisesearch.com","www.truelocal.com","www.findlocal.com","www.aussieweb.com","www.jobseeker.com","www.local.yahoo.com","www.firecheck.com","www.simplyhired.com","www.localbusinessguide.com","www.ozplumbers.com","www.easyfindguide.com","www.nationaldirectory.com","www.simplyhired.com","www.alljobs.com","www.queensland-business-directory-australia.com","www.tradingpost.com","www.searchzone.com","www.wa.autotrader.com","www.easyfindguide.com","www.enterprisesearch.com","www.investsmart.com","www.realestate.com","www.flingfinder.com ","www.qrme.org","www.deploysafe.com","www.catalogues.bestandless.com","www.womow.com","www.clark.com","www.paperinklings.com","www.roadworthyinspections.com","www.personlookup.com","www.cybergamer.com","www.nationwide.com","www.companylist.com","www.australian-business-directory.com","www.aussienow.com","www.justweb.com","www.ozebiz.com","www.kmdirectory.com","www.australia-business-listing.com","www.aussiesrus.com","www.thebusinesstree.com","www.localbusinessguide.com","www.southaustralia.localitylist.com","www.ausdirectory.org","www.free-business-directory.com","www.australian-business-listing.com","www.surfpacific.net","www.shopseek.com","www.smesecrets.com","www.salesgenerator.com","www.mybusinesscentral.com","www.australia-seek.com","www.businesslistings.net","www.business-directory-online.com","www.australianbizdirectory.com","www.localcompanies.com","www.businesslist.com","www.localbusinesssearch.com","www.numberway.com","www.whoisthegreatest.com","www.hitcity.com","www.webwombat.com","www.agfg.com","www.bestrestaurants.com","www.twincities.citysearch.com","www.seattle.citysearch.com","www.portland.citysearch.com","www.hellosandiego.com","www.merchantcircle.com","www.yellowbot.com","www.sandiego.citysearch.com","www.yellowpages.com","www.yellowpages.10news.com","www.yelp.com","www.manta.com","www.bizfind.us","www.yp.yahoo.com","www.djexplosionsd.com","www.superpages.com","www.judysbook.com","www.signonsandiego.com","www.servicetowns.com","www.sandiego.boomtrek.us","www.yellowpages.thebostonchannel.com","www.facebook.com","www.bizdirectory.signonsandiego.com","www.centerstagechicago.com","www.family.go.com","www.encyclopedia.com","www.us.imdb.com","www.virtualtourist.com","www.vegas.com","www.ehow.com","www.destination360.com","www.govegas.about.com","www.ravel.yahoo.com","www.lastminute.com","www.lasvegas-livethedream.com","www.hotels.com","www.events.myspace.com","www.likeme.net","www.jetsetreport.com","www.travelchannel.com","www.insiderpages.com","www.travel.justluxe.com","www.tripadvisor.com","www.travelintelligence.com","www.frommers.com","www.linkedin.com","www.kathika.com","www.reviewlasvegas.ne","www.vegaschatter.com","www.a2zlasvegas.com","www.foodfashionista.com","www.imdb.com","www.clubzone.com","www.casinocitypress.com","www.travelpod.com","www.bonotel.com","www.concierge.com","www.inrgb.com","www.cityvoter.com","www.columbus.metromix.com","www.mytravelguide.com","www.clubplanet.com","www.barfinder.com","www.secondsaturdayscolumbus.com","www.metromix.com","www.local.oaoa.com","www.mapmuse.com","www.houstonrestaurantsonline.com","www.blogspot.com","www.menuism.com","www.igougo.com","www.stlouis.metromix.com","www.chowhound.chow.com","www.scanews.com","www.urbanspoon.com","www.golflink.com","www.activediner.com","www.restaurants.uptake.com","www.goplacez.com","www.chow.com","www.sf.tastyr.com","www.menupix.com","www.allmenus.com","www.weblo.com","www.search.chow.com","www.bn.gohoto.com","www.yeschinese.com","www.foodiebytes.com","www.b4-u-eat.com","www.movoto.com","www.boorah.com","www.cylex-usa.com","www.oodio54.com","www.pickarestaurant.com","www.placefacts.net","www.kudzu.com","www.zagat.com","www.chinesefood-recipes.com","www.nmgastronome.com","www.neofill-dining.com","www.idine.com","www.restaurantshenderson.net","www.laokay.com","www.coffeebean.com","www.kcrw.com","www.restaurants.philly.com","www.linktown.kmov.com","www.local.stltoday.com","www.loopnet.com","www.stlouis.com","www.westpalmbeach.com","www.mo.allpages.com","www.national-coffee-guide.com","www.thealexa.com","www.coffeegeek.comf","www.mystore411.com","www.yipit.com","www.foodio54.com","www.mustseenewyork.com","www.serviceslisted.com","www.livestrong.com","www.locallife.com","www.gomobo.com","www.househunt.com","www.getfave.com","www.pubcrawler.com","www.flyertalk.com","www.nyc.com","www.mojo.kfog.com","www.lucidcafe.com","www.coffeeratings.com","www.mojopages.com","www.teanavigator.com","www.teaguide.net","www.foodieview.com","www.all-about-restaurants.info","www.restaurants.topgrubs.com","www.shopinusa.com","www.bluetoad.com","www.ev1.yp.atti.com","www.mustardpages.com","www.hotelsvalued.com","www.atlanta.diningguide.com","www.atlanta.metromix.com","www.campusfood.com","www.restaurantplace.com","www.bestpartyever.com","www.eastpointga.usl.myareaguide.com","www.8coupons.com","www.piapizza.com","www.thebigfork.com","www.zvents.com","www.scribd.com","www.printable.retailmenot.com","www.issuu.com","www.realpageslive.com","www.theusaexplorer.com","www.menubites.com","www.2findlocal.com","www.thinklocal.com","www.lead411.com","www.mmahotstuff.com","www.city-data.com","www.baylist.sfgate.com","www.restaurant.com","www.sporq.com","www.fredrandolph.com","www.happyhours.sfweekly.com","www.ovahere.com","www.allpages.com","www.thefreelibrary.com","www.spiderbites.nytimes.com","www.thesushibar.com","www.miami.everyblock.com","www.pensacolarestaurant.net","www.southflorida.menupages.com","www.miamiforvisitors.com","www.specialtygrocery.net","www.pennysaverusa.com","www.nysonglines.com","www.aozoranyc.com","www.aclawrence.com","www.sushiref.com","www.nycfoodie.com","www.pattonboggs.com","www.chopsticksny.com","www.savorycities.com","www.well.com","www.citidex.com","www.thenextsteprealty.com","www.newyorkcity2005.web.infoseek.co.jp","www.cititour.com","www.thescene.com","www.myspace.com","www.thepopoff.net","www.events.nbcphiladelphia.com","www.foursquare.com","www.foobooz.com","www.philadelphia.cities2night.com","www.milwaukeedowntown.com","www.jsonline.com","www.expressmilwaukee.com","www.milwaukeedrinks.com","www.milwaukeemagazine.com","www.milwaukeeokay.com","www.chamberofcommerce.com","www.mygreenpages.com","www.gotime.com","www.upspring.com","www.dreamtown.com","www.rogerspark.wordpress.com","www.events.stltoday.com","www.couponmap.com","www.americantowns.com","www.couponcabin.com","www.entertainment-savings-offers.com","www.centerd.com","www.localdirectory.azcentral.com","www.zaams.com","www.goby.com","www.publicityx.com","www.yellowassistance.com","www.virginiahighland.com","www.friendseat.com","www.decaturrestaurantguide.com","www.vitals.com","www.bayprocorp.com","www.austinrestaurants.us","www.meetup.com","www.dishola.com","www.business.intuit.com","www.austinist.com","www.usmenuguide.com","www.geospot.com","www.fooddigger.com","www.ieatvegas.com","www.syr-area.com","www.spyonvegas.com","www.mylocalpizzaguy.com","www.userinstinct.com","www.pizza-restaurant.netfirms.com","www.local.nwitimes.com","www.indy-dining.com","www.indydt.com","www.usaelectionpolls.com","www.pizzacouponsource.com","www.events.theledger.com","www.orlandorestaurant.us","www.goodfoodnearyou.com","www.139001.net","www.dexknows.com","www.southloopchamber.com","www.chicagopizza.net","www.freebase.com","www.metaflavor.com","www.opentable.com","www.gayot.com","www.nileguide.com","www.travel.aol.com","www.sf.everyblock.com","www.grubhub.com","www.mypizza.com","www.schmap.com","www.nctimes.com","www.sesandiego.com","www.discoversd.com","www.kgtv.cityvoter.com","www.hotelplanner.com","www.phoenix.arizonahighways.com","www.hotelstravel.com","www.food.theplainjane.com","www.elitemeetings.com","www.sceneadvisor.com","www.eventful.com","www.contemporan.com","www.nextstop.com","www.reverbnation.com","www.brookhavengeorgia.com","www.albuquerque.krqe.com","www.restaurantica.com","www.dineindie.com","www.travelmuse.com","www.sortuv.com","www.cuisinenet.com","www.ww.tomtunney.com","www.chasbender.com","www.condosinlakeview.com","www.asurefit.com","www.viewpoints.com","www.pegasusnews.com","www.bluedoorway.com","www.putershop.com","www.menutopia.com","www.mojo.chron.com","www.ecommunity.westchasedistrict.com","www.walnutterraceapts.com","www.crestapts.com","www.214area.com","www.local.msn.com","www.wrtv.cityvoter.com","www.coupons.chacha.com","www.rentindyapartments.com","www.dinesite.com","www.associatedcontent.com","www.coupons4indy.com","www.mojo.987kissfm.com","www.events.nytimes.com","www.foodspotting.com","www.aae.gulffy.com","www.thenycitydish.com","www.livinginthenyc.blogspot.com","www.hopstop.com","www.talkinbroadway.com","www.tupalo.com","www.happyhours.westword.com","www.restaurants.post-gazette.com","www.restaurant.abemadi.com","www.smokinghotwaitress.com","www.aaag.com","www.web3.userinstinct.com","www.myhuckleberry.com","www.ahbenergy.com","www.indy.com","www.visitindy.com","www.wherethelocalseat.com","www.roadfood.com","www.10best.com","www.realtravel.com","www.americascuisine.com","www.indyrestaurantscene.blogspot.com","www.weddingmapper.com","www.mychoyce.com","www.sfweekly.com","www.calendar.insidebayarea.com","www.bingrebates.com","www.print2webcorp.com","www.lvbusinesspress.com","www.loopt.com","www.businessnetworkinglife.com","www.viewnews.com","www.mistercrawler.com","www.oursideoftown.wordpress.com","www.urbandaddy.com","www.hollywoodhotel.net","www.discoverlosangeles.com","www.nightliferatings.com","www.nymag.com","www.thursdayclub.com","www.gotickets.com","www.officialsite.com","www.queenofnewyork.com","www.velvetlist.com","www.favbars.com","www.thedjlist.com","www.clubvibes.com","www.newyears.com","www.politicalpalace.yuku.com","www.beatfreax.com","www.starhotelny.com","www.celiac.buzzspree.com","www.friendfeed.com","www.dionysusrecords.com","www.lonelyplanet.com","www.cjazzic-soul.com","www.nyc.alltheparties.com","www.citycliq.com","www.whrrl.com","www.sloshspot.com","www.spittapacxvhtx.eventbrite.com","www.wholeteam.com","www.e-streetteam.com","www.blackplanet.com","www.thehottestparties.com","www.page2rss.com","www.anpedia.com","www.ubcsa.org","www.brownbook.net","www.sanantonio.citysearch.com","www.angelfoodministries.com","www.savvysource.com","www.thecityofsanantonio.com","www.usachurch.com","www.sachamber.org","www.webmasterinternational.com","www.stason.org","www.bible.org","www.mysanantonio.com","www.saworship.com","www.sabeacon.com","www.tollbrothers.com","www.churchangel.com","www.hellosanantonio.com","www.pekerjaanterbaru.com","www.privateschoolreview.com","www.jigsaw.com","www.kumon.com","www.local.ingenio.com","www.linktown.khou.com","www.tx.allpages.com","www.local.botw.org","www.yellowpages.click2houston.com","www.findtutoring.org","www.local.yahoo.com","www.start.cortera.com","www.cplai.stirhost.co.cc","www.houstonokay.com","www.houston.citysearch.com","www.reocities.com","www.web.mac.com","www.childcarecenter.us","www.sunbiz.org","www.elcofduval.org","www.fullofjobs","www.smallbusiness.dnb.com","www.mohavecountykids.com","www.familyfunspotsmag.com","www.nationalchildcareconnection.com","www.snapspans.com","www.atlantanewhomesdirectory.com","www.magicyellow.com","www.sears.com","www.ziphip.com","www.quickr.org","www.travels.com","www.snagajob.com","www.militaryymca.com","www.calif.aaa.com","www.cruisinggays.com","www.bbb.org","www.lancerrobotics.org","www.sandiegobizmart.com","www.sears-missionvalley.suggestionbox.com","www.superhomecenter.com","www.militaryavenue.com","www.en.wikipedia.org","www.neimanmarcus.com","www.vialuxe.com","www.tripwolf.com","www.gosanfrancisco.about.com","www.yellowpages.lycos.com","www.neimanmarcuscareers.com","www.unionsquareshop.com","www.7x7.com","www.nokachocolate.com","www.brightkite.com","www.franckmullerusa.com","www.sallybernstein.com","www.commons.wikimedia.org","www.seibertron.com","www.mojo.wsradiolv.com","www.insidertags.com","www.yellowpages.aol.com","www.allhandbagsdirectory.com","www.www8.garmin.com","www.lasvegastourism.com","www.allstays.com","www.spacebag.com","www.milo.com","www.lasvegassun.com","www.sites.target.com","www.articles.directorym.com","www.peoplesautism.org","www.local.youngmoney.com","www.b2byellowpages.com","www.chicago.metromix.com","www.thebridgeburners.com","www.epturkeytrot.homestead.com","www.edisonparkchamber.chambermaster.com","www.pioneerlocal.com","www.highbeam.com","www.active.com","www.epturkeytrot.org","www.delmark.com","www.chicagocelticyouth.com","www.streets.metrobot.com","www.gardensofnorwoodpark.com","www.voodoopilot.com","www.votewithyourfeetchicago.blogspot.com","www.nightlife.uptake.com","www.chicago.com","www.chicagosirishpubs.com","www.thepassionatedarter.com","www.newyork.joonbug.com","www.newyorkontap.com","www.rhythmism.com","www.blogs.myspace.com","www.directory.newyork.com","www.downdeepnyc.com","www.newyork.timeout.com","www.forums.joeuser.com","www.mapquest.com","www.charlotte.citysearch.com","www.events.charlotteobserver.com","www.360charlotte.com","www.hbcudigest.com","www.us.loadedweb.com","www.obsent.blogspot.com","www.skyscrapercity.com","www.clclt.com","www.hellolosangeles.com","www.network.bestfriends.org","www.puppymillmom.blogspot.com","www.hollywoodjinky.newsvine.com","www.canyon-news.com","www.losangeles.citysearch.com","www.cbs2.com","www.yellowpages.superpages.com","www.outside.in","www.antmandesign.com","www.lovethydog.com","www.poochieofbeverlyhills.com","www.nbclosangeles.com","www.la411.com","www.cid-97895bbb8ad10f37.spaces.live.com","www.petstorelist.abeautifulurn.com","www.tamargeller.com","www.kooldogkafe.com","www.poochoutfitters.com","www.beautynewsnyc.com","www.doggroomingindex.com","www.strategichumancapital.co.za","www.blog.windycityparrot.com","www.yellowpages.duquoin.com","www.avantlink.com","www.tjoos.com","www.cgi3.ebay.com","www.search.windycityparrot.com","www.extranet.mivamerchant.com","www.avitec.com","www.local.com","www.shop.com","www.yp.com","www.saddleupmag.com","www.birdboard.com","www.genieknows.com","www.sherpapetgroup.com","www.chicago.citysearch.com","www.localdirectory.nydailynews.com","www.dogtime.com","www.collar-and-leash.com","www.usa-local-search.com","www.bloggedadvice.com","www.yellowpage.hirby.com","www.pspoaklawn.com","www.oak_lawn-il.yellowusa.com","www.ffga.com","www.linktown.kvue.com","www.mojo.austinmetro.com","www.buydesignereyewear.com","www.yellowpages-eyecare.com","www.directoryofaustin.com","www.georgetown-tx.yellowusa.com","www.nursinghomegrades.com","www.glassesstores.com","www.austinondemand.com","www.austin.kudzu.com","www.selectcdrates.com","www.peelinc-newsletters.com","www.docstoc.com","www.myeweb.com","www.allbusiness.com","www.atlanta.citysearch.com","www.pipl.com","www.helloatlanta.com","www.investdog.com","www.atlanta.creativeloafing.com","www.memberbenefits.com","www.cherrycreeknorth.com","www.denver.citysearch.com","www.kmgh.cityvoter.com","www.the-optical.com","www.groupon.com","www.citysquares.com","www.yellowpages.thedenverchannel.com","www.eyeglasses.com","www.topix.com","www.firmoo.com","www.optometristsdenver.com","www.helloaustin.com","www.impactnews.com","www.teegolfclub.com","www.austin.citysearch.com","www.yellowbook.com","www.rankarea.com","www.bobburnsgolf.com","www.celinea.com","www.boccierigolf.com","www.howdiduknow.com","www.callawaygolfwatches.com","www.webtrafficagents.com","www.edwinwattsgolfcatalogs.com","www.mygov.governmentguide.com","www.miami.citysearch.com","www.buyonlineshiptopr.com","www.hellomiami.com","www.importgenius.com","www.sportsauthoritypromo.com","www.findmespot.com","www.texashillcountry.com","www.harbingerfitness.com","www.sanfrancisco.citysearch.com","www.lombardisports.com","www.cbs5.funcheap.com","www.orage.com","www.sfstation.com","www.mobilespinach.com","www.hotronic.com","www.sanfrancisco.com","www.powgloves.com","www.k2skis.com","www.akama.com","www.findarticles.com","www.madrockclimbing.com","www.sportiva.com","www.events.sfgate.com","www.weddingbee.com","www.projectwedding.com","www.uncensoredbrides.net","www.lookupbook.com","www.ecure.weddingwire.com","www.yorlando.com","www.hotfrog.com","www.bestorlandoweddings.com","www.tools.marthastewartweddings.com","www.ja-jp.facebook.com","www.weddingbook.com","www.justsaidyes.com","www.weddingaces.com","www.weddingwire.com","www.orlando-fl.addresses.com","www.iaf.net","www.dannychoo.com","www.wedding-cafe.net","www.houston.com","www.localsearch.com","www.ontargetlocal.com","www.brides.com","www.dbdev2.trellist.com","www.thecityofhouston.com","www.onewhitewedding.com","www.ido.ivillage.com","www.banquethallusa.com","www.yellowpages.mysanantonio.com","www.weddingvendors.com","www.shopinsanantonio.com","www.linktown.kens5.com","www.divinasposaamericas.com","www.sanantoniookay.com","www.orlando.citysearch.com","www.helloorlando.com","www.beautystaffs.com","www.mysearch.com","www.lovelyweddingdresses.com","www.orlandocitypages.com","www.masterseek.com","www.dimensionmedia.com","www.citysearch.com","www.hellosanfrancisco.com","www.truspa.com","www.reservation.travelaffiliatepro.com","www.sanfranciscohiltonhotel.com","www.simonandbaker.com","www.hotelres.com","www.sanfrancisco.lovetoknow.com","www.gridskipper.com","www.discovering-sanfrancisco.com","www.shanghaicelebration.com","www.la-salon.com","www.travel-library.com","www.giantclub.com","www.glasssteelandstone.com","www.laorpheum.com","www.comevisitlosangeles.com","www.hewittfirst.com","www.adulttoysdiscreet.com","www.wego.com","www.boomyeah.com","www.myspachicago.com","www.fairmont.com","www.apartments.oodle.com","www.hellochicago.com","www.donnetempo.com","www.businesstraveldestinations.com","www.examiner.com","www.twitter.com","www.dailycandy.com","www.wahanda.com","www.dealbase.com","www.forbestravelguide.com","www.choosechicago.com","www.besthotelpackagesite.com","www.illinoisspadeals.com","www.cybernos.com","www.yellowpages.clickorlando.com","www.yellowpages.wesh.com","www.veterinarians.com","www.dirklus.com","www.granddisplays.net","www.pionusmarketing.com","www.hellodenver.com","www.chipyourcat.com","www.yellowpages.gazette.com","www.resources.petfinder.com","www.blogs.denverpost.com","www.5280.com","www.doctor-review.com","www.rabbitsonline.net","www.co.allpages.com","www.coloradohrs.com","www.mountainwestdogfanciers.com","www.directory.louisville.com","www.yext.com","www.contexphuket.com","www.animal-hospitals.abeautifulurn.com","www.omnimedicalsearch.com","www.chirodirectory.com","www.coconutgrovefl.wil.myareaguide.com","www.123people.com","www.ymiami.com","www.massage.addresses.com","www.medicalclinics.in","www.fl.allpages.com","www.drchiropractor.org","www.123chiropractors.com","www.healthline.com","www.chiropractorservices.info","www.flbiz.oscnewsgazette.com","www.locateadoc.com","www.checkbook.org","www.mojo.cbs2chicago.com","www.wellness.com","www.local.lubbockonline.com","www.edmunds.com","www.getauto.com","www.carlocate.com","www.motorauthority.com","www.justgoodcars.com","www.autotrader.com","www.search.collegenews.com","www.repairpal.com","www.lemonfree.com","www.everycarlisted.com","www.txautowizard.com","www.autonetfinancial.com","www.autotropolis.com","www.localautospot.net","www.sacreditapproval.com","www.autos2.mysanantonio.com","www.southtx.texasford.com","www.houston.jobing.com","www.dealerrater.com","www.autospies.com","www.texassports.com","www.mazdacrossover.com","www.houstoncarsused.com","www.dealermiles.com","www.informationpages.com","www.usedcarx.com","www.carcasher.com","www.dealernet.com","www.autodealerdirectory.us","www.rxlist.com","www.specialneedsneighborhood.com","www.rain-tree.com","www.nearestpharmacy.org","www.ibegin.com","www.townsendletter.com","www.findit.reviewjournal.com","www.stressatwork.com","www.hellovegas.com","www.nursing-homes-ratings.com","www.pharmyellow.com","www.zapconnect.com","www.colorwalk.com","www.imxinc.com","www.hot-racing.com","www.web2.userinstinct.com","www.localdatabase.com","www.rcracingusa.net","www.local.findtarget.com","www.rcgroups.com","www.oklahomacitypreferred.us","www.oklahomacityokay.com","www.shopinoklahomacity.com","www.tyloon.com","www.rccaraction-digital.com","www.powerprofiles.com","www.localbizsearch.timescall.com","www.amivisible.org","www.denversalon.com","www.beautysalondenver.net","www.washpark.com","www.aboutsite.org","www.neighborhood.hairstyle-blog.com","www.local.qualityhealth.com","www.articles.directorym.net","www.local.momsnetwork.com","www.uslbl.com","www.coloradocyclist.net","www.neighborhood.ageless-beauty.com","www.local.askandyaboutclothes","www.webstersonline.com","www.hoovers.com","www.crmz.com","www.investing.businessweek.com","www.spoke.com","www.whitepages.com","www.thomasnet.com","www.macraesbluebook.com","www.goliath.ecnext.com","www.processregister.com","www.portfolio.com","www.kompass.com","www.zibb.com","www.usadirectory.biz","www.businessdirectoryofusa.com","www.referenceusa.com","www.555-1212.com","www.uscity.net","www.anywho.com","www.switchboard.com","www.kompass-usa.com","www.aboutus.org","www.melissadata.com","www.yahoo.com","www.demandbase.com","www.google.com","www.tourisme.fr","www.firmy.cz","www.hbi.cz","www.czechtrade.us","www.czech-trade.us","www.thecityofmilwaukee.com","www.yellowpagecity.com","www.hellomilwaukee.com","www.milwaukee.com","www.milwaukee.citysearch.com","www.milwauke.org","www.zipweb.com","www.chicagopreferred.us","www.il.allpages.com","www.child-care-directory.info","www.101eldercare.com","www.directory.chicagodirect.info","www.afb.org","www.umc.org","www.bestbuy.com","www.americanehr.com","www.localhotelexplorer.com","www.colorado.inetgiant.com","www.phonelookup.com","www.forbes.com","www.gocitykids.parentsconnect.com","www.splendora.com","www.lilaguide.com","www.travel.yahoo.com","www.guidespot.com","www.tinagivens.blogspot.com","www.cradleplayroom.com","www.kidcosmic.stores.yahoo.net","www.niceshirtbaby.com","www.thecradle.com","www.volcom.com","www.slifter.com","www.brandstopper.com","www.hourdb.com","www.helloindianapolis.com","www.newyork.citysearch.com","www.gonyc.about.com","www.blackbookmag.com","www.pursepage.com","www.new.york.retailguide.com","www.newyork.metromix.com","www.flickr.com","www.hellomanhattan.com","www.empowereddoctor.com","www.lifescript.com","www.catholicmanhattan.blogspot.com","www.answers.com","www.wapedia.mobi","www.nypost.com","www.youtube.com","www.huffingtonpost.com","www.streetsblog.org","www.medicinenet.com","www.carionltd.com","www.travelersvaccines.com","www.austinwomanmagazine.com","www.parentwiseaustin.com","www.fmcfsme.com","www.searchpeopledirectory.com","www.rateitall.com","www.healthcare.com","www.healthgrades.com","www.roadsideamerica.com","www.ihsadvantage.com","www.metrotravelguide.com","www.refdesk.whitepages.com","www.rentalcars.com","www.local.peninsulaclarion.com","www.oddpath.com","www.localautospot.com","www.sanantoniotx.txs.myareaguide.com","www.gosanantonio.com","www.columbus.citysearch.com","www.experiencecolumbus.com","www.rentacarnow.com","www.columbus-homefinder.com","www.automotix.net","www.events.columbusalive.com","www.yourcitysurf.com","www.usdirectory.com","www.chicagookay.com","www.localadlink.com","www.chicago.timeout.com","www.trulia.com","www.luxuryrentalsmanhattan.com","www.collegeview.com","www.collegeactingprograms.com","www.studyplaces.com","www.summeroncampus.com","www.learn4good.com","www.ny.com","www.festivals.documentaryfilms.net","www.nafsainternationaleducationmarketplace.com","www.whois.domaintools.com","www.campusexplorer.com","www.citytowninfo.com","www.classesandcareers.com","www.american-school-search.com","www.collegeprowler.com","www.officialusa.com","www.trade-schools.net","www.privatestudentloans.com","www.degreedriven.com","www.guidetocareereducation.com","www.howtogetin.com","www.univdir.com","www.tsb.edu-search.com","www.education.careers.org","www.alltradeschools.com","www.humble-tx.yellowusa.com","www.alumnisouvenirs.com","www.campus.online-education.net","www.university-directory.eu","www.mycollegeusa.com","www.nmhphysicians.photobooks.com","www.ncbi.nlm.nih.gov","www.indexedamerica.com","www.womenobgyn.net","www.thecityofchicago.com","www.jhwm.net","www.hivpregnancyhotline.org","www.zocdoc.com","www.philadelphia.citysearch.com","www.ucomparehealthcare.com","www.localtom.com","www.pa.idoget.biz","www.thecityofphiladelphia.com","www.hospitalsoup.com","www.local.sanmarcosrecord.com","www.thecityofaustin.com","www.treeswingmedia.com","www.local.healthvideo.com","www.qualityhealth.com","www.texascommunitycare.com","www.citiservi.com","www.losangelespreferred.us","www.filmbiz.com","www.myglobalprofile.com","www.boulder-411.dailycamera.com","www.experts123.com","www.myvideomag.com","www.shopindenver.com","www.littletongov.org","www.denver-plumbers.com","www.postnewstools.com","www.myyp.com","www.marvistaplumbingsupplies.com","www.hollywoodplumbingsupplies.com","www.plumbers.dapeem.com","www.moninil10.0fees.net","www.ci.ftlaud.fl.us","www.jobtrio.com","www.directory.palmbeachpost.com","www.miamifl.usl.myareaguide.com","www.infoguiamiami.com","www.my411411.com","www.localhometown.com","www.hellohouston.com","www.whitepages.yellowpages.com","www.houston-tx.areapages.com","www.buyerzone.com","www.businessfinder.cleveland.com","www.search.lancastereaglegazette.com","www.deals.newarkadvocate.com","www.ezlocal.com","www.sales.ypex.com","www.loqal.com","www.zipslocal.com","www.aacoonline.org","www.oklahomacity.citysearch.com","www.sallisaw-ok.iaf.net","www.local.bobvila.com","www.edmondoklahomalocal.us","www.local.ineedthis.com","www.inet-asst.com","www.hotelguides.com","www.stubhub.com","www.explorechicago.org","www.chicago.everyblock.com","www.last.fm","www.chicago.urban-history.org","www.avclub.com","www.articlesnatch.com","www.concertlivewire.com","www.questia.com","www.ticketmaster.com","www.songkick.com","www.nytheatre.com","www.newyorkcitytheatre.com","www.playbill.com","www.ibdb.com","www.viator.com","www.nytix.com","www.theatermania.com","www.ezinearticles.com","www.broadwaytheatretickets.com","www.curtainup.com","www.groups.telecharge.com","www.nyctrip.com","www.all-used-tires.com","www.yellowpages.cbsatlanta.com","www.norcross-ga.yellowusa.com","www.localndex.com","www.indianapolis.citysearch.com","www.hellosouthbend.com","www.carmelcarcare.com","www.automd.com","www.autorepaircompanies.com","www.downtownloftrental.com","www.yellowpages.latimes.com","www.autoinsuranceplanners.com","www.harris.county-texas.com","www.auto-dealers.milwaukee.ypeek.com","www.glendale-chamber.com","www.hellooklahomacity.com","www.wimgo.com","www.ok.allpages.com","www.calculateme.com","www.insurance-guide.netfirms.com","www.thebawdycloister.com","www.badcreditcarloans-online.com","www.1483.yippie.biz","www.insurance.freeadvice.com","www.cribankruptcy.com","www.pagelink.com","www.askyp.org","www.buyherepayherecarlots.net","www.directory.sanantoniodirect.info","www.ypeek.com","www.cars.trovit.com","www.1clickautomobile.com","www.forddelaflorida.com","www.miamibeachdealers.org","www.pompanobeachdealers.org","www.hollywooddealers.org","www.miamicars.com","www.complaints.com","www.automobilemag.com","www.indeed.com","www.cardealershipatlanta.com","www.usedcardealersatlanta.com","www.shopping.com","www.the-how-to-blog.com","www.urbanpetguide.com","www.petdogandcatservices.com","www.petplanetmiami.com","www.dogster.com","www.findmyveterinarian.com","www.directory.nwaonline.com","www.hardwaterfish.com","www.directory.nh.com","www.usa-veterinarians.com","www.zootoo.com","www.4vetclinics.com","www.hautedogmagazine.com","www.austinspetdirectory.com","www.austinanimed.com","www.wetnoseguide.com","www.pawprintsthemagazine.com","www.dogbreedgift.net","www.local.petplace.com","www.hellodallas.com","www.readyvetgo.com","www.directory.wfaa.com","www.foundationsrecoverynetwork.com","www.memphis.citysearch.com","www.aboutrecovery.com","www.usrehabguide.com","www.msn.careerbuilder.com","www.local.selfhelpmagazine.com","www.frnalumni.com","www.itsallinthejourney.com","www.memphisantique.com","www.thegooddrugsguide.com","www.caring4youth.org","www.lasvegas.citysearch.com","www.altiusdirectory.com","www.scumdoctor.com","www.walkersresearch.com","www.rehab-international.org","www.southernnevadahealthdistrict.org","www.lasvegasweddinghalls.com","www.nursing.theclinics.com","www.ask.com","www.hospitalsworldwide.com","www.volunteermatch.org","www.apartmentshoustonmovingrelocation.com","www.volunteer.truist.com","www.annals.org","www.fullofjobs.com","www.gownsman.org","www.healthclubdirectory.com","www.sellerzone.com","www.ppotter.com","www.findlocaldoctor.com","www.myweightlossclinics.com","www.healthamerica.coventryhealthcare.com","www.altmd.com","www.rambosvalleysports.com","www.yellowpages.ohio.com","www.wellsphere.com","www.signupforcamp.com","www.swim.isport.com","www.advance.org","www.surfaidinternational.org","www.businessdirectory.bizjournals.com","www.sanjose.com","www.hellocolumbus.com","www.danesfort.com","www.uasupersite.com","www.local.singleedition.com","www.uaoh.net","www.columbusokay.com","www.qromag.com","www.nypress.com","www.villagevoice.com","www.vulgaras.livejournal.com","www.usbanklocations.com","www.supermarketpage.com","www.hotcouponworld.com","www.search.cyclopages.com","www.42.tiguquji-qudolumu.dns2go.com","www.findabetterbank.com","www.banklocations.net","www.thethriftstorewhore.blogspot.com","www.andersonscountrymarket.net","www.money.blogs.time.com","www.ways-to-save-money.org","www.wikitravel.org","www.exploredance.com","www.tugbbs.com","www.local.skiido.com","www.wheregrocery.com","www.books.google.co.in","www.luxemb.info","www.bellevue.attorneys.oneyellow.com","www.golfersweb.com","www.golf18network.com","www.expedia.com","www.worldgolf.com","www.placesofamerica.com","www.visitsanantonio.com","www.golf.com","www.golftexas.com","www.raveable.com","www.cybergolf.com","www.golftravel.about.com","www.golfnow.com","www.golfcoursesguide.org","www.denver.about.com","www.courses.golf.com","www.golfshot.com","www.denverrealestateonline.com","www.golfq.com","www.publicgolfcourses.net","www.timeout.com","www.lasvegasgolfcourses.com","www.vegas4locals.com","www.vegas365.com","www.teetimes.net","www.lasvegasgolf.com","www.lawyers.com","www.trademarkia.com","www.corporationwiki.com","www.pview.findlaw.com","www.lawyers-fl.com","www.attorneyhelp.org","www.lawyersguide.com","www.lawyercentral.com","www.floridaabogados.net","www.101attorney.com","www.sallygierke.com","www.lawyers.justia.com","www.hg.org","www.helplinelaw.com","www.uslawyersdb.com","www.best-dui-lawyers.com","www.louisville.bizjournals.com","www.lawyers.local-data.com","www.wikimapia.org","www.419legal.org","www.kybiz.com","www.louisville-ky.yellowusa.com","www.lawyers.llrx.com","www.martindale.com","www.lawguru.com","www.lawyers.oyez.org","www.houston.boomtrek.us","www.daddytypes.com","www.newyorkcityextra.com","www.nycrecessiondiary.com","www.icravefreebies.com","www.cityrealty.com","www.new-york-hotels.biz","www.buyisraelgoods.org","www.catalog.findyourfurniture.com","www.calendar.denverpost.com","www.importers-directory.net","www.reviewfoo.com","www.referrallist.com","www.cityofthornton.net","www.furniturequest.com","www.bankruptcylawyerssanantonio.com","www.bestbedguide.com","www.thestockmarketwizard.com","www.thecityofphoenix.com","www.findcontractor.org","www.sandiegodentistsguide.com","www.101dentist.com","www.san-diego.doctoroogle.com","www.manttus.com","www.sandiegoorthodontists.net","www.dentalvisits.com","www.sandiego.thegeoguide.com","www.edentist.com","www.yellowpages.theindychannel.com","www.dentistsdirectory.us","www.health.yahoo.net","www.yasabe.com","www.thecityoflosangeles.org","www.trueyellow.com","www.primecaredental.net","www.colorbasepair.com","www.insurancecompany.com","www.zlinked.com","www.thecityoflouisville.com","www.thedentistsearch.com","www.ky.allpages.com","www.inlab.com","www.goldbamboo.com","www.reallymadeinusa.info","www.kentucky.cityvoter.com","www.carecredit.com","www.dentistinlouisvilleky.com","www.thecityofmemphis.com","www.memphis-tn.localpages.com","www.local.picayuneitem.com","www.tn.idoget.biz","www.furniturecatch.com","www.youadlist.com","www.cms.nycgo.com","www.esna-nyc.net","www.winickdaily.com","www.flatironbid.org","www.jacksonville.citysearch.com","www.metrojacksonville.com","www.gametimeanytime.com","www.hellojacksonville.com","www.eventective.com","www.mywikibiz.com","www.floridabirthdayparty.com","www.calendar.jacksonville.com","www.floridaattractions.org","www.visitjacksonville.com","www.jacksonvilleswestside.info","www.care2.com","www.family-vacation-getaways-at-los-angeles-theme-parks.com","www.calendar.reviewjournal.com","www.badwax.net","www.chacha.com","www.travelodgevegasstrip.com","www.guest.cvent.com","www.stlouis.citysearch.com","www.citydeals.com","www.attractions.uptake.com","www.battingcagefinder.com","www.ontowns.com","www.movietickets.com","www.moviefone.com","www.charlotte.mrmovietimes.com","www.charlotte.about.com","www.fandango.com","www.bigscreen.com","www.movies.eventful.com","www.metalbandsaw.net","www.flixster.com","www.charlotte.ohsohandy.com","www.panx.amerr.no-ip.be","www.wegoplaces.com","www.charlotte.creativeloafing.com","www.bookoful.angelfire.com","www.wildaboutmovies.com","www.cinematreasures.org","www.tributemovies.com","www.getthebigpicture.net","www.kimeraldupdates.blogspot.com","www.sites.google.com","www.tagalog-movie.com","www.theater-directory.info","www.showtimecity.com","www.evergreensalesusa.com","www.abs-cbnglobalmovies.com","www.inticketing.com","www.dallas.citysearch.com","www.listings.guidelive.com","www.dallasobserver.com","www.stub.com","www.iliveindallas.com","www.dontstayin.com","www.texasautoinjuryblog.com","www.attorneypages.com","www.houstonlegalmarketingblog.blogspot.com","www.lawyer.com","www.avvo.com","www.hrlawyersblog.com","www.kgb-law.com","www.myemploymentlawyer.com","www.findalawyerfree.com","www.local.ksat.com","www.hrlawyersblog.lexblognetwork.com","www.members.sanantoniodirect.info","www.deathpenaltynews.blogspot.com","www.patentlaw-attorneys.com","www.420magazine.com","www.employmentlawyer.addresses.com","www.orlandomalpractice.net","www.geopage.com","www.usa-attorneys.us","www.miamilawyers.boomja.com","www.lawyers.webdesigntops.com","www.divorce360.com","www.usattorneylegalservices.com","www.iwpharmacy.com","www.car-accident-law.org","www.katychristianmagazine.com","www.local.click2houston.com","www.homesecuritysystemsite.com","www.reviewexpo.com","www.austin.finditnow.com","www.autoservicelist.com","www.hellophiladelphia.com","www.rususa.com","www.directory.womensradio.com","www.eteamz.com","www.lasvegasokay.com","www.cccarto.com","www.ripoffreport.com","www.cardealershipsdirectory.com","www.blogs.lasvegasnow.com","www.wikicity.com","www.radiatorinfo.com","www.smogsandiego.com","www.coupons.sandiegoreader.com","www.autosaleseek.com","www.sanantonioduiattorney.net","www.besthotelsanantonio.com","www.local.tirereview.com","www.memphispreferred.us","www.columbus.boomtrek.us","www.carcentral.com","www.autopartscompanies.com","www.eat.columbusdiningguide.com","www.truckinginfo.com","www.local.yodle.com","www.neworusedcars.org","www.local.oldcarsweekly.com","www.localdirectory.wmctv.com","www.local.jdpower.com","www.directory.gjsentinel.com","www.olive_branch-ms.localpages.com","www.memphis.boomtrek.us","www.carjunky.com","www.matchpoint.com","www.newtosandiego.com","www.scooterportal.com","www.sandiego.about.com","www.royalbastardsscooterclub.com","www.bimmershops.com","www.directory.dallasnews.com","www.us-cardealers.com","www.compuquotes.com","www.jewishinstlouis.org","www.ovkosher.org","www.stlbeacon.org","www.comevisitchicago.com","www.cakes.com","www.wickerparkhomes4sale.com","www.jkronk.localadlink.com","www.companydatabase.org","www.elmendorf.bestrestaurantsincity.com","www.sacurrent.com","www.local.slippymap.com","www.atlantaataglance.com","www.atlantarestaurants.com","www.atlanta-ga.restaurantsrc.com","www.mallcrawl.com","www.spotsfordates.com","www.diningwithsophie.com","www.food.truth.travel","www.hoodscopesf.com","www.localforage.com","www.skokienet.org","www.articles.chicagotribune.com","www.meckw.com","www.dimbeautyofchicago.blogspot.com","www.louisville-ky.addresses.com","www.whodoesyourhair.com","www.louisville.tmnews.com","www.pinoya.com","www.pa.allpages.com","www.n-kosi.com","www.findabeautysalon.com","www.beautysalontreatments.com","www.weddingbycolor.com","www.morrow-ga.yellowusa.com","www.nappturality.suddenlaunch2.com","www.thenaturalhaircaredirectory.com","www.thehair411.com","www.malls.com","www.quailspringsmall.com","www.okcsalons.net","www.salonfinder.us","www.houstonataglance.com","www.houstonbeautysalon.info","www.salons.com","www.supermarket-directory.info","www.findhairstylists.org","www.beautyitems.com","www.austin360.com","www.blogthishere.com","www.travel-island.com","www.librarything.com","www.openwifispots.com","www.booksite.com","www.spotlightonnycbookstores.com","www.powells.com","www.indiebound.org","www.books.eguidepro.com","www.downtowncolumbus.com","www.floridabooksellers.com","www.americanaexchange.com","www.cosmography.com","www.thedailynewyorker.com","www.journals.lww.com","www.iguide.travel","www.bargainlink.com","www.sandiego.readlocal.org","www.thesunmagazine.org","www.directory.pe.com","www.tripsage.com","www.home.earthlink.net","www.amazon.com","www.go2.com","www.vegasinvestmenthomes.com","www.supercheapcar.com","www.newpages.com","www.bookmarket.com","www.bookreporter.com","www.local.times-news.com","www.allonesearch.com","www.planning.theknot.com","www.planning.thebump.com","www.newyorkweddingdresses.co","www.hellolouisville.com","www.findit.com","www.oumag.com","www.onewed.com","www.thelmagazine.com","www.usaclothingstores.com","www.local.pigeonforge.com","www.austin.usaweddingmall.com","www.stlislam.org","www.themanregistry.com","www.modestprom.com","www.muslimnetworkstl.com","www.spafinder.com","www.medicaiddentistry.com","www.bridalgroup.com","www.louisvillediner.com","www.itunes.apple.com","www.foodpage.us","www.cooks.com","www.articles.sfgate.com","www.artchive.com","www.thefreedictionary.com","www.theflyer.com","www.dallasdinesout.com","www.catering-directory.info","www.thedeliciouslife.com","www.engadget.com","www.southstreet.com","www.prolebrity.com","www.en.academic.ru","www.myleague.com","www.laist.com","www.dallasnews.com","www.gandhibazar.com","www.diningaid.com","www.entertainment.accessatlanta.com","www.seamlessweb.com","www.therealdeal.com","www.archive.org","www.ecnext.com","www.sandiegoreader.com","www.events.dailynews.com","www.lthforum.com","www.mojo.myfoxny.com","www.westword.com","www.louisvilleokay.com","www.buscadordemexico.com","www.laweekly.com","www.phoenix.gov","www.chibarproject.com","www.boston.com","www.89thandbroke.com","www.dot.ca.gov","www.ordertexasrotisserie.com","www.discogs.com","www.winedanddined.com","www.burritophile.com","www.orlandoweekly.com","www.nyindia.us","www.washingtonpost.com","www.science.tamu.edu","www.ordermanhattandiner.com","www.linktown.wcnc.com","www.angelfire.com","www.austinchronicle.com","www.bestcitydining.com","www.phillytown.com","www.drupal.org","www.columbusalive.com","www.newsobserver.com","www.spicebazaar.com","www.riverfronttimes.com","www.food.com","www.travel.nytimes.com","www.justfab.com","www.courmenu.com","www.gaebler.com","www.pa.usacategory.com","www.nytimes.com","www.inetours.com","www.posthoc.com","www.luxist.com","www.http://fafsa.ed.gov","www.allaboutjazz.com","www.bleachanime.org","www.newyork.beforelastcall.com","www.observer.com","www.colleges.collegetoolkit.com","www.notfortourists.com","www.denverpost.com","www.artistdirect.com","www.sheckysnightlife.com","www.greatjoints.com","www.foodler.com","www.bigfooty.com","www.uppereast.com","www.mapplr.com","www.charlottemagazine.com","www.food212.com","www.midtownlunch.com","www.etsy.com","www.indoamerican-news.com","www.sushifaq.com","www.stlmag.com","www.fedorahosted.org","www.lybane.com","www.gaiaonline.com","www.baseball-reference.com","www.jacksonville-fl.yellowusa.com","www.blogs.villagevoice.com","www.nj.com","www.discoverourtown.com","www.oasis-open.org","www.ecovian.com","www.foodhoe.com","www.menukarma.com","www.templesf.com","www.losangeles.going.com","www.classicalrevolution.org","www.fudcourt.com","www.zipperpages.com","www.eatbufordhighway.com","www.commercialappeal.com","www.myhappyhour.com","www.globalnightlifeguides.com","www.eatflorida.com","www.intermediagraphics.net","www.happycow.net","www.championstamp.com","www.prairie.org","www.projects.eveningedge.com","www.drinkdeal.com","www.linktown.whas11.com","www.informatik.uni-trier.de","www.acronymfinder.com","www.alwaysonvacation.com","www.horseshoetavernsf.com","www.unitedcc.org","www.mylife.com","www.events.kgoradio.com","www.ciusf.com","www.sherlockspubco.com","www.smoothskinbysimona.com","www.completefish.com","www.mobile.earthcomber.com","www.vegguide.org","www.hihostels.com","www.beeradvocate.com","www.eatsushi.com","www.biggestmenu.com","www.randomhouse.com","www.bakeryquest.com","www.la.foodblogging.com","www.gnu.org","www.hrm.uh.edu","www.cookeatshare.com","www.tartburner-review3-webstores.info","www.most-beautiful.ru-woman.com","www.newyork.seriouseats.com","www.crepesoncole.com","www.buckeyeillustrated.com","www.gothere.com","www.urbandictionary.com","www.startribune.com","www.gotham2go.com","www.socialweb.net","www.chi-il.com","www.today.msnbc.msn.com","www.louisvillehotbytes.com","www.events.pbpulse.com","www.faispdx.org","www.clatl.com","www.cheapfareguru.com","www.sfsurvey.com","www.miami.about.com","www.newyorker.com","www.apps.bowl.com","www.fodors.com","www.2ndon2nd.com","www.azcentral.com","www.gothamist.com","www.runawaysquirrels.com","www.nlm.nih.gov","www.eatnear.com","www.feastinginphoenix.com","www.sandiego.going.com","www.chron.com","www.overstock.com","www.pickadinner.com","www.curlisto.com","www.sscnet.ucla.edu","www.coyoteuglysaloon.com","www.hellophoenix.com","www.phoenix.about.com","www.ibiblio.org","www.sf.eater.com","www.aht.seriouseats.com","www.zillow.com","www.nochelatina.com","www.harlemonestop.com","www.bostonherald.com","www.homes.point2.com","www.jama.ama-assn.org","www.reviewstream.com","www.boutiqueville.com","www.eskimo.com","www.britannica.com","www.grantpark.org","www.about-food-cafe.pizzainny.com","www.haroldschicken.com","www.claudebrissart.com","www.spyfoo.com","www.trueknowledge.com","www.kittybradshaw.com","www.takeouttonight.com","www.ask.metafilter.com","www.beauty-for-you.w-ru.com","www.onlinecolumbusohio.com","www.dehood.com","www.dailymail.co.uk","www.supervegan.com","www.tl.wikipedia.org","www.jcs.biologists.org","www.thevillager.com","www.allrecipes.com","www.satellitetvfamily.com","www.porkknifeandspoon.com","www.lobbyattwelve.com","www.diglounge.net","www.alacrastore.com","www.dine.com","www.texasburgerguy.com","www.sabot.org","www.whitehouse.gov","www.whobyyou.com","www.wantickets.com","www.revenue.state.pa.us","www.phoenixnewtimes.com","www.ybca.org","www.schubas.com","www.myfloridalicense.com","www.ph.88db.com","www.publicearth.com","www.acronyms.thefreedictionary.com","www.seriouseats.com","www.consumer.discoverohio.com","www.license.state.tx.us","www.losangeles.tribe.net","www.classipages.com","www.do512.com","www.stleats.com","www.eataroundokc.com","www.eateryrow.com","www.menugourmet.com","www.greattacohunt.com","www.charlotte.everyblock.com","www.foodnow.tv","www.okcbites.com","www.cheapassfood.com","www.bbonline.com","www.hort.purdue.edu","www.discoverfountainsquare.com","www.guesshookah.com","www.losanjealous.com","www.columbus.bizjournals.com","www.blog.seattlepi.com","www.epinions.com","www.french.about.com","www.wehonews.com","www.newyork.grubstreet.com","www.wsoctv.com","www.nature.com","www.prlog.org","www.cityinsights.com","www.events.nydailynews.com","www.elnandu.com","www.travellady.com","www.chefmoz.org","www.cpedia.com","www.thehudspethreport.com","www.stlgumbo.webs.com","www.streetdirectory.com","www.westallisnow.com","www.askanewyorker.com","www.semissourian.com","www.forum.wordreference.com","www.sandiegomagazine.com","www.panoramio.com","www.legendsofamerica.com","www.guardian.co.uk","www.foodaphilia.com","www.worldstarhiphop.com","www.www1.utsa.edu","www.diningoutwithrobbalon.com","www.parks.ca.gov","www.hi.nelso.in","www.epicurious.com","www.ig6.gijibot.no-ip.fr","www.nud.ge","www.latimesblogs.latimes.com","www.cs.wisc.edu","www.newyork.grubia.com","www.ciao.co.uk","www.buzzd.com","www.collegetoolkit.com","www.foodpages.ca","www.italyinsf.com","www.metrotimes.com","www.soccer365.com","www.kansassampler.org","www.miaminewtimes.com","www.phillychinatown.com","www.celebrity-gossip.net","www.thebonaventure.com","www.icecreamuniversity.org","www.charlottefoodblog.com","www.themenupage.com","www.itoen.com","www.crystalinks.com","www.frederick.com","www.ditch.com","www.jacksonvillelanding.com","www.charlotte.diningchannel.com","www.parkingcarma.com","www.qualityfoodonline.com","www.december.com","www.ec.europa.eu","www.directory.dmagazine.com","www.mydivebar.com","www.miamipreferred.us","www.afterellen.com","www.websitetrafficspy.com","www.ny.eater.com","www.phxrailfood.com","www.torrentreactor.net","www.audiemurphy.com","www.squidoo.com","www.punjabgovt.nic.in","www.bronx-ny.yellowusa.com","www.thestranger.com","www.clicklinktracker.com","www.wdwinfo.com","www.dining512.com","www.waiter.com","www.law.emory.edu","www.travbuddy.com","www.miami.com","www.v4.jiwire.com","www.citycheers.com","www.merriam-webster.com","www.snack.blogs.com","www.bootsintheoven.com","www.lowermanhattan.info","www.cplusplus.com","www.mayoclinic.com","www.vimeo.com","www.okcupid.com","www.marcandblue.com","www.mtv.com","www.qcdc.org","www.stanford.edu","www.trustedplaces.com","www.mt.list-of-companies.org","www.austinokay.com","www.thrillist.com","www.skilletdoux.com","www.gutfud.com","www.sfgate.com","www.weblaunchsolutions.com","www.dictionary.reference.com","www.nfi.foodfromthailand.com","www.events.jacksonville.com","www.msu.edu","www.goldentooth.wordpress.com","www.planeteye.com","www.sandiego.org","www.wthr.com","www.la.eater.com","www.arkansasonline.com","www.forums.louisvillehotbytes.com","www.ruadventures.com","www.faqs.org","www.lyricsmode.com","www.isd623.org","www.atlantaonthecheap.com","www.nameplayground.com","www.dine.to","www.thesuggestr.com","www.easterniowalife.com","www.directory.newsday.com","www.instameme.com","www.childsup.ca.gov","www.nbcnewyork.com","www.sonoma-county.org","www.energycorridor.org","www.entertainment.com","www.philly.everyblock.com","www.forums.egullet.org","www.valpak.com","www.mouthfulsfood.com","www.bodybuilding.com","www.columbusunderground.com","www.philly.planetdiscover.com","www.nydailynews.com","www.order-togo.net","www.osha.gov","www.vegfamily.com","www.directory.northjersey.com","www.yowed.com","www.weddingvendorsearch.com","www.wherenevadagetsengaged.com","www.phoenix.boomtrek.us","www.whozlocal.com","www.party-wedding.info","www.local.sanfrancisco.com","www.aboutweddings.com","www.findasider.com","www.doorswindowscompany.com","www.replacementwindowsconnect.com","www.austin.com","www.shopping.statesman.com","www.builderquotes.com","www.local.commercejournal.com","www.constructionscope.com","www.apartmentcities.com","www.metroatlantayellowpages.com","www.localcarsdealers.com","www.constructionworld.us","www.floridalookup.com","www.contractspot.com","www.findremodelers.net","www.builders-directory.us","www.floridalocalinfo.com","www.timeinorlando.blogspot.com","www.laminate-floor.biz","www.local.mobilehome.com","www.cityofmadison.com","www.buzios.com","www.foodspot.com","www.orderpizzapizza.com","www.ad.doubleclick.net","www.orderbluenine.com","www.payless.com","www.bardriver.com","www.orderaspenrestaurant.com","www.new.york.diningguide.net","www.diningguide.net","www.bangkokbest.com","www.garciaseafood.com","www.houstonsrestaurants.com","www.ilcovochicago.com","www.restaurantslive.com","www.restaurantdb.net","www.apartmentguide.com","www.apartments.com","www.apartmentsearch.com","www.forrent.com","www.luxelisthome.com","www.move.com","www.mycheapapartments.com","www.mynewplace.com","www.rent.com","www.rentals.com","www.cbre.com","www.loopnet.com","www.forrent.info","www.apartmentratings.com","www.apartmenthomeliving.com","www.apartmentcities.com","www.apartmentsmart.com","www.anapartmentforrent.com","plus.google.com","www.crunchbase.com","www.payscale.com","www.glassdoor.com","www.facebook.com","www.linkedin.com","en.wikipedia.org","brightscope.com","zomminfo.com","findthecompanyname.com","cortera.com","twitter.com","justdial.com",".pdf","tradeindia.com","zaubacorp.com","yellowpages.co","businessinsider.com","money.cnn.com","marketwatch.com","nasdaq.com","bloomberg.com","reuters.com","bbb.org","yelp","pitchbook.com",".gov","opencorporates.com","nevadacorporates.com","buzzfile.com","federalpay.org","sec.report","directory","sba.com","texaskit.com","us.centralindex.com","hotels.com","hotels.in","birdeye.com","inc.com","instagram","zoominfo","cbinsights","prnewswire","facebook","ariba.com","thebluebook","hbaws.net","usaopps","nevadacorporates","tripadvisor","largestcompanies","facebook","promarketing","allbiz","support.google.com","linkedin.com");

			my $url="http://api.scraperapi.com/?api_key="Key"&url=https://www.google.com/search?sclient=psy-ab&biw=1064&bih=587&q=$web&oq=$web&gs_l&country_code=us";
			pingagain:
			# my $ran=int(rand(20));
			# if($ran<5)
			# {
				# $ran=$ran+5;
			# }
			#print"\nSleep time: $ran\n";
			#sleep($ran);
			my $con=&CONTENT('GET',$url);
			open fo1,">source.html";
            print fo1 "$con";
            close fo1;
            # print "waiting....\n";
            # <stdin>;
			if($con=~m/<input[^<]*?type\=\"text\"[^<]*?name\=\"captcha\"/is)
			{
				#sleep(90);
				print"\nSleep state\n";
				goto pingagain;
			}
			my $flag=0;
			my $dup_flag=0;
            
            # while(($con=~m/<div\s*class\=\"[^>]*?>\s*<a\s*href\=\"([^>]*?)\"\s*[^>]*?onmousedown\=\"return/igs)||($con=~m/<div\s*class\=\"kCrYT\">\s*<a\s*href\=\"\/url?[^>]*?url\=([^>]*?)\&amp\;[^>]*?\"\s*>\s*<h3/igs)||($con=~m/<div\s*class\=\"kCrYT\">\s*<a\s*href\=\"\/url?[^>]*?url\=([^>]*?)\"\s*>\s*<h3/igs)||($con=~m/<div\s*class\=\"[^>]*?\">\s*<a\s*href\=\"\/url?[^>]*?url\=([^>]*?)\&amp\;[^>]*?\"\s*>\s*<h3/igs)||($con=~m/<div\s*class\=\"[^>]*?\">\s*<a\s*href\=\"\/url?[^>]*?url\=([^>]*?)\"\s*>\s*<h3/igs)||($con=~m/<div\s*class\=\"[^>]*?\">\s*<a\s*href\=\"([^>]*?)\"\s*data\-ved/igs)||($con=~m/class\=\"[^>]*?\"\s*href\=\"\/url\?q\=([^>]*?)&amp\;/igs))
			# {
            
            foreach my $regex('<a\s*jsname\=\"\s*[^>]*?\"\s*href\=\"\s*([^>]*?)\s*\"','<div\s*class\=\"[^>]*?>\s*<a\s*href\=\"([^>]*?)\"\s*[^>]*?onmousedown\=\"return','<div\s*class\=\"kCrYT\">\s*<a\s*href\=\"\/url?[^>]*?url\=([^>]*?)\&amp\;[^>]*?\"\s*>\s*<h3','<div\s*class\=\"kCrYT\">\s*<a\s*href\=\"\/url?[^>]*?url\=([^>]*?)\"\s*>\s*<h3','<div\s*class\=\"[^>]*?\">\s*<a\s*href\=\"\/url?[^>]*?url\=([^>]*?)\&amp\;[^>]*?\"\s*>\s*<h3','<div\s*class\=\"[^>]*?\">\s*<a\s*href\=\"\/url?[^>]*?url\=([^>]*?)\"\s*>\s*<h3','<div\s*class\=\"[^>]*?\">\s*<a\s*href\=\"([^>]*?)\"\s*data\-ved','class\=\"[^>]*?\"\s*href\=\"\/url\?q\=([^>]*?)&amp\;')
            {
					print "Regx=>$regex\n";
				if($con=~/$regex/is)
				{ 
					while($con=~m/$regex/igs)
					{
							
						my $ttempp=$1;
						my $dup_flag=0;
						# $ttempp=~s/\/[^>]*?\///igs;
						# $ttempp=~s/\/[^>]*?//igs;
						print "Regex=>$regex\n";
						print "website: $ttempp\n\n";
						#$ttempp=decode_entities($ttempp);
						foreach my $temp1 (@third_party)
						{
							if($ttempp=~m/$temp1/is)
							{
								$dup_flag=1;
								#print "website: im here in dup\n\n";
							}					
						}
						if ($dup_flag==1)
						{
							# $result="$ip_website\t$Address\t$url\t\t\t\t\n";
							# open fo,">>Output_$arg.txt";
							# print fo "$result";
							# close fo;
							#$dup_flag=0;
							print "website Skip: $ttempp\n\n";
							#goto end;
							#goto next123;
							next;
						}
						else
						{
							my $website_url=$ttempp;
							 print "website123: $website_url\n\n";
							my $temp=$website_url;
							$temp=~s/http\:\/\///igs;
							$temp=~s/https\:\/\///igs;
							# $temp=~s/\/[^>]*?\///igs;
							# $temp=~s/\/[^>]*?//igs;
							# print"$temp\n";
							my $len=length($temp);
							if((length($temp)<=50)&&(length($temp)>=10))
							{
								if($flag==0)
								{
									# print"\n=====================Output Title:$website_title======================\n";
									$result="$ip_website\t$Address\t$url\t$website_url\t$temp\n";
									open fo,">>Output_$arg.txt";
									print fo "$result";
									close fo;
									undef($website_url);
									goto end;
								}
							}
							else
							{
								$result="$ip_website\t$Address\t$url\t\t\t\t$len\n";
								# open fo,">>Output_$arg.txt";
								# print fo "$result";
								# close fo;
								# goto end;
							}
						}
					  next123:   
					}
				# $con='';
				end:  
				# $con='';
            }
            }
		}
	close fi;
# &upload_Output($arg);
################	
sub upload_Output()
{

	my $arg = shift;
	my @files;
	my $folder_path=cwd();
	my $localtime=localtime();
	my $ftp_folder;
	
	$ftp_folder="Company URL";
			
	my $ftp_dir="/Company URL";
	
	my ($host,$ftp_uname,$ftp_pass)=('','','');
	my @file_list=glob("*.txt");
	foreach (@file_list)
	{
		if($_=~m/Output/is)
		{
			print "----------output::$_----------\n";
			push(@files,$_);
		}
	}
	
	eval 
	{
		my $ftp1;
		my $ftp1_flag=0;
		my $ftp_count=0;
		my $path="/Company URL";
		ftpconnect1:
		if($ftp1= Net::FTP->new($host, Debug => 0))
		{
			print "successfully host connected\n";
			if($ftp1->login($ftp_uname,$ftp_pass))
			{
				print "successfully logged in\n";
								
				$ftp1->cwd("/");
#				$ftp1->mkdir($ftp_dir) or die "Cannot create $ftp_dir " . $ftp1->message;		
				$ftp1->cwd("$ftp_dir");
				foreach my $filename (@files)
				{
					print "file_name::$filename\n";
					$ftp1->cwd("/");
					# $ftp1->binary();
					$ftp1->put("$folder_path/$filename","$ftp_dir/$filename") or $ftp1_flag=1;
				}
				$ftp1->quit();
				if($ftp1_flag==1)
				{
					if($ftp_count==3)
					{
						open(e_log,">>errorlog.txt");
						print e_log "$ftp1->message";
						close e_log;
					}
					$ftp_count++;
					$ftp1_flag=0;
					goto ftpconnect1;
				}
				else
				{
					return(1);
				}	
			}
		}
	};	
	#&completed_mail($arg);
}

#################
sub clean()
{
my $var=shift;
$var=~s/\s/\+/igs;
$var=~s/\,/%2C/igs;
return $var;
}
#################
sub CONTENT
{
	my $type=shift;
	my $url=shift;
	my $conlen=shift;
	my $con_type=shift;
	my $ref=shift;
	my $cke=shift;
	my ($req);
	
	my $m;
	start:
	$req=HTTP::Request->new($type=>$url);
	$req->content($conlen) if($conlen ne '');
	$req->header("Accept"=>"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
	$req->header("Content-Type"=>"application/x-www-form-urlencoded") if($con_type ne '');
	$req->header("Referer"=>$ref) if($ref ne '');
	# $req->header("Cookie"=>$cke) if($cke ne '');
	my $res=$ua->request($req);
	my $code=$res->status_line();
	#print "\nCODE: $code\n";
	if($code=~m/20/is)
	{
		# print "\nCODE: $code\n";
		my $con=$res->content();
		if($con=~m/(?:<html|<meta|"[^"]+?"\s*:|<[^>]*?(?:xml|php)[^>]*?>|\s+function|getopt\s*\(|Content-type)/is)
		{
			$con=~s/\n/  /igs;
			return $con;
		}
		else
		{
			my $con1=$res->decoded_content();
			$con1=~s/\n/  /igs;
			return $con1;
		}
	}
	elsif($code=~m/30/is)
	{
		my $loc=$res->header("Location");
		$loc=URI->new_abs($loc,$url);
		my $request1=HTTP::Request->new(GET=>$loc);
        $request1->header("Content-Type"=>"application/x-www-form-urlencoded");
        my $res1=$ua->request($request1);
		my $code1=$res1->status_line();
		if($code1=~m/^\s*20/is)
		{
			my $con1=$res1->content();
			return $con1;
		
		}
		elsif($code1=~m/^\s*30/is)
		{
			$url=$loc;
			goto start;
		}
		else
		{
			sleep(5);
			goto start;
		}
	}
	elsif($code=~m/40/is)
	{
		print "\nCODE: $code URL not found\n";
		open(Network_log,">>NetworkLog.txt");		
		print Network_log "$code : $url\n";
		close(Network_log);
		my $req2=HTTP::Request->new("GET"=>$url);
		$req2->header("Content-Type"=>"application/x-www-form-urlencoded");
		my $res2=$ua->request($req2);
		my $con2=$res2->content();
		return $con2;
	}
	elsif($code=~m/50/is)
	{
		print "\nCODE: $code Net Failure\n";
		open(n,">>network_error.txt");
		print n "500 Error::$url \n";
		close(n);
		#sleep(50);
			# goto start;			
			$m++;
			if($m<=2)
			{
				goto start;
			}
	}

}

sub content()
{
	my ($url,$content,$reference,$method,$domain)=@_;
	my ($re_ping);

	if($url!~m/http/is)
	{
		$url='http://'.$url;
	}

	if($url eq ''){return 'NoURL';}
	netfail:
	my $request=HTTP::Request->new("$method"=>$url);
	print"\n$url\n";
	$request->header("Accept"=>"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
	$request->header("Content-Type"=>"application/x-www-form-urlencoded");	
	$request->content($content) if($content ne '');
	my $res=$ua->request($request);

	$cookie_jar->extract_cookies($res);
	$cookie_jar->save;
	$cookie_jar->add_cookie_header($request);

	my $status=$res->status_line();
	my $code=$res->code;
	if($code==200)
	{
		my $content=$res->content();
		#$cookie_jar->clear;
		print"CODE: $status\n";
		return $content;
	}
	elsif($code=~m/50/is)
	{
		print"CODE: $status\n";
		if($status=~m/internal\s*server\s*error/is)
		{
			print "\n$status\n";
			return;
		}
		print"\n Net Failure:\tsleeping(10)\n";
		$re_ping++;
		if($re_ping>3)
		{
			print "Re ping exists $re_ping times\n";
			my $content=$res->content();
			open(ERR,">>Error_503_url.txt");
			print ERR "$url\n";
			close ERR;
			exit;
			return;
		}
		sleep(2);		
		goto netfail;
	}
	elsif($code=~m/30/is)
	{
		print"CODE: $status\n";
		my $loc=$res->header("Location");
		if($loc!~m/http/is)
		{
		$loc=URI::URL->new_abs($loc,$domain);
		}
		else
		{
			$loc=URI::URL->new_abs($loc);
			print"\nYes\n";
		}
		print "\nLocation: $loc\n";
		my $request1=HTTP::Request->new(GET=>$loc);
		$request1->header("Content-Type"=>"application/x-www-form-urlencoded");
		my $res1=$ua->request($request1);
		$cookie_jar->extract_cookies($res1);
		$cookie_jar->save;
		$cookie_jar->add_cookie_header($request1);
		my $content1=$res1->content();
		return $content1;

	}
	elsif($code=~m/40/is)
	{
		print"CODE: $status\n";
		print "\nURL Not found\n";
	}
}
sub Curr_time
{
 my @months = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
 my @weekDays = qw(Sun Mon Tue Wed Thu Fri Sat Sun);
 my ($second, $minute, $hour, $dayOfMonth, $month, $yearOffset, $dayOfWeek, $dayOfYear, $daylightSavings) = localtime();
 my $year = 1900 + $yearOffset;
 #my myTime = "$hour:$minute:$second, $weekDays[$dayOfWeek] $months[$month] $dayOfMonth, $year";
 my $myTime = "$year-$months[$month]-$dayOfMonth $weekDays[$dayOfWeek] $hour:$minute:$second";
 return $myTime;
}

sub getcont()
{
    my($ur,$cont,$ref,$method)=@_;
    netfail:
    my $request=HTTP::Request->new("$method"=>$ur);
    $request->header("Content-Type"=>"application/x-www-form-urlencoded");
    $request->header("Accept"=>"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
    $request->header("Host"=>"www.adviserinfo.sec.gov");
    if($ref ne '')
    {
   
        $request->header("Referer"=>"$ref");
    }
    if(lc $method eq 'post')
    {
   
        $request->content($cont);
    }
    my $res=$ua->request($request);
    $cookie_jar->extract_cookies($res);
    $cookie_jar->save;
    $cookie_jar->add_cookie_header($request);
    my $code=$res->code;
    print"\n $code";
    if($code==200)
    {
       
        my $content=$res->content();
		#$content=decode_entities($content);
        return $content;
    }
    elsif($code=~m/50/is)
    {
        print"\n Net Failure";
        sleep(15);
        goto netfail;
    }
    elsif($code=~m/30/is)
    {
       
        my $loc="http://www.adviserinfo.sec.gov".$res->header("Location");
         #print "\nLocation: $loc";
        my $request1=HTTP::Request->new(GET=>$loc);
        $request1->header("Content-Type"=>"application/x-www-form-urlencoded");
        my $res1=$ua->request($request1);
        $cookie_jar->extract_cookies($res1);
        $cookie_jar->save;
        $cookie_jar->add_cookie_header($request1);
        my $content1=$res1->content();
        return $content1;

    }
    elsif($code=~m/40/is)
    {
        print "\n URL Not found";
    }
}

sub state()
	{
	my $var=shift;
	$var=~s/Alabama/AL/igs;
	$var=~s/Alaska/AK/igs;
	$var=~s/Arizona/AZ/igs;
	$var=~s/Arkansas/AR/igs;
	$var=~s/California/CA/igs;
	$var=~s/Colorado/CO/igs;
	$var=~s/Connecticut/CT/igs;
	$var=~s/Delaware/DE/igs;
	$var=~s/Florida/FL/igs;
	$var=~s/Georgia/GA/igs;
	$var=~s/Hawaii/HI/igs;
	$var=~s/Idaho/ID/igs;
	$var=~s/Illinois/IL/igs;
	$var=~s/Indiana/IN/igs;
	$var=~s/Iowa/IA/igs;
	$var=~s/Kansas/KS/igs;
	$var=~s/Kentucky/KY/igs;
	$var=~s/Louisiana/LA/igs;
	$var=~s/Maine/ME/igs;
	$var=~s/Maryland/MD/igs;
	$var=~s/Massachusetts/MA/igs;
	$var=~s/Michigan/MI/igs;
	$var=~s/Minnesota/MN/igs;
	$var=~s/Mississippi/MS/igs;
	$var=~s/Missouri/MO/igs;
	$var=~s/Montana/MT/igs;
	$var=~s/Nebraska/NE/igs;
	$var=~s/Nevada/NV/igs;
	$var=~s/New Hampshire/NH/igs;
	$var=~s/New Jersey/NJ/igs;
	$var=~s/New Mexico/NM/igs;
	$var=~s/New York/NY/igs;
	$var=~s/North Carolina/NC/igs;
	$var=~s/North Dakota/ND/igs;
	$var=~s/Ohio/OH/igs;
	$var=~s/Oklahoma/OK/igs;
	$var=~s/Oregon/OR/igs;
	$var=~s/Pennsylvania/PA/igs;
	$var=~s/Rhode Island/RI/igs;
	$var=~s/South Carolina/SC/igs;
	$var=~s/South Dakota/SD/igs;
	$var=~s/Tennessee/TN/igs;
	$var=~s/Texas/TX/igs;
	$var=~s/Utah/UT/igs;
	$var=~s/Vermont/VT/igs;
	$var=~s/Virginia/VA/igs;
	$var=~s/Washington/WA/igs;
	$var=~s/West Virginia/WV/igs;
	$var=~s/Wisconsin/WI/igs;
	$var=~s/Wyoming/WY/igs;
	$var=~s/Washington DC/WA/igs;
	$var=~s/Puerto Rico/PR/igs;
	$var=~s/District Of Columbia/DC/igs;
	return ($var);
	}
sub country()
	{
	my $var=shift;
	$var=~s/Afghanistan/AF/igs;
	$var=~s/United States/USA/igs;
	$var=~s/Aland Islands/AX/igs;
	$var=~s/Albania/AL/igs;
	$var=~s/Algeria/DZ/igs;
	$var=~s/American Samoa/AS/igs;
	$var=~s/Andorra/AD/igs;
	$var=~s/Angola/AO/igs;
	$var=~s/Anguilla/AI/igs;
	$var=~s/Antarctica/AQ/igs;
	$var=~s/Antigua and Barbuda/AG/igs;
	$var=~s/Argentina/AR/igs;
	$var=~s/Armenia/AM/igs;
	$var=~s/Aruba/AW/igs;
	$var=~s/Australia/AU/igs;
	$var=~s/Austria/AT/igs;
	$var=~s/Azerbaijan/AZ/igs;
	$var=~s/Bahamas/BS/igs;
	$var=~s/Bahrain/BH/igs;
	$var=~s/Bangladesh/BD/igs;
	$var=~s/Barbados/BB/igs;
	$var=~s/Belarus/BY/igs;
	$var=~s/Belgium/BE/igs;
	$var=~s/Belize/BZ/igs;
	$var=~s/Benin/BJ/igs;
	$var=~s/Bermuda/BM/igs;
	$var=~s/Bhutan/BT/igs;
	$var=~s/Bolivia/BO/igs;
	$var=~s/Bosnia and Herzegovina/BA/igs;
	$var=~s/Botswana/BW/igs;
	$var=~s/Bouvet Island/BV/igs;
	$var=~s/Brazil/BR/igs;
	$var=~s/British Indian Ocean Territory/IO/igs;
	$var=~s/British Virgin Islands/VG/igs;
	$var=~s/Brunei/BN/igs;
	$var=~s/Bulgaria/BG/igs;
	$var=~s/Burkina Faso/BF/igs;
	$var=~s/Burundi/BI/igs;
	$var=~s/Cambodia/KH/igs;
	$var=~s/Cameroon/CM/igs;
	$var=~s/Canada/CA/igs;
	$var=~s/Cape Verde/CV/igs;
	$var=~s/Cayman Islands/KY/igs;
	$var=~s/Central African Republic/CF/igs;
	$var=~s/Chad/TD/igs;
	$var=~s/Chile/CL/igs;
	$var=~s/China/CN/igs;
	$var=~s/Christmas Island/CX/igs;
	$var=~s/Cocos (Keeling) Islands/CC/igs;
	$var=~s/Colombia/CO/igs;
	$var=~s/Comoros/KM/igs;
	$var=~s/Congo/CG/igs;
	$var=~s/Cook Islands/CK/igs;
	$var=~s/Costa Rica/CR/igs;
	$var=~s/Cote d Ivoire/CI/igs;
	$var=~s/Croatia/HR/igs;
	$var=~s/Cuba/CU/igs;
	$var=~s/Cyprus/CY/igs;
	$var=~s/Czech Republic/CZ/igs;
	$var=~s/Denmark/DK/igs;
	$var=~s/Djibouti/DJ/igs;
	$var=~s/Dominica/DM/igs;
	$var=~s/Dominican Republic/DO/igs;
	$var=~s/Ecuador/EC/igs;
	$var=~s/Egypt/EG/igs;
	$var=~s/El Salvador/SV/igs;
	$var=~s/Equatorial Guinea/GQ/igs;
	$var=~s/Eritrea/ER/igs;
	$var=~s/Estonia/EE/igs;
	$var=~s/Ethiopia/ET/igs;
	$var=~s/Falkland Islands/FK/igs;
	$var=~s/Faroe Islands/FO/igs;
	$var=~s/Fiji/FJ/igs;
	$var=~s/Finland/FI/igs;
	$var=~s/France/FR/igs;
	$var=~s/French Guiana/GF/igs;
	$var=~s/French Polynesia/PF/igs;
	$var=~s/French Southern Territories/TF/igs;
	$var=~s/Gabon/GA/igs;
	$var=~s/Gambia/GM/igs;
	$var=~s/Georgia/GE/igs;
	$var=~s/Germany/DE/igs;
	$var=~s/Ghana/GH/igs;
	$var=~s/Gibraltar/GI/igs;
	$var=~s/Greece/GR/igs;
	$var=~s/Greenland/GL/igs;
	$var=~s/Grenada/GD/igs;
	$var=~s/Guadeloupe/GP/igs;
	$var=~s/Guam/GU/igs;
	$var=~s/Guatemala/GT/igs;
	$var=~s/Guinea/GN/igs;
	$var=~s/Guinea-Bissau/GW/igs;
	$var=~s/Guyana/GY/igs;
	$var=~s/Haiti/HT/igs;
	$var=~s/Heard Island and McDonald Islands/HM/igs;
	$var=~s/Honduras/HN/igs;
	$var=~s/Hong Kong/HK/igs;
	$var=~s/Hungary/HU/igs;
	$var=~s/Iceland/IS/igs;
	$var=~s/India/IN/igs;
	$var=~s/Indonesia/ID/igs;
	$var=~s/Iran/IR/igs;
	$var=~s/Iraq/IQ/igs;
	$var=~s/Ireland/IE/igs;
	$var=~s/Israel/IL/igs;
	$var=~s/Italy/IT/igs;
	$var=~s/Jamaica/JM/igs;
	$var=~s/Japan/JP/igs;
	$var=~s/Jordan/JO/igs;
	$var=~s/Kazakhstan/KZ/igs;
	$var=~s/Kenya/KE/igs;
	$var=~s/Kiribati/KI/igs;
	$var=~s/Kuwait/KW/igs;
	$var=~s/Kyrgyzstan/KG/igs;
	$var=~s/Laos/LA/igs;
	return ($var);

	}
sub clean111()
	{
	my $var=shift;
	$var=~s/<[^>]*?>//igs;
	$var=~s/&nbsp\;/ /igs;
	# $var=decode_entities($var);$var=decode_entities($var);
	# $var=~s/^\|//igs;
	# $var=~s/\|$//igs;
	$var=~s/^\>//igs;
	$var=~s/\>$//igs;
	$var=~s/\s+/ /igs;
	$var=~s/^\s+//igs;
	$var=~s/\.\s*\./. /igs;
	$var=~s/^\s*\,\s*//igs;
	$var=~s/\s*\,\s*$//igs;
	$var=~s/\s*\,\,\s*$/,/igs;
	$var=~s/amp\;//igs;
	$var=~s/\bIII\b/III/igs;
	$var=~s/\bII\b/II/igs;
	$var=~s/\bIV\b/IV/igs;
	$var=~s/\bV\b/V/igs;
	$var=~s/\bVI\b/VI/igs;
	$var=~s/\bVII\b/VII/igs;
	$var=~s/\bVIII\b/VIII/igs;
	$var=~s/\bIX\b/IX/igs;
	$var=~s/\bX\b/X/igs;
	$var=~s/\bXI\b/XI/igs;
	$var=~s/\bXII\b/XII/igs;
	$var=~s/\bXIII\b/XIII/igs;
	$var=~s/\bXIV\b/XIV/igs;
	$var=~s/\bXV\b/XV/igs;
	$var=~s/\bXVI\b/XVI/igs;
	$var=~s/\bXVII\b/XVII/igs;
	$var=~s/\bXVIII\b/XVIII/igs;
	$var=~s/\bXIX\b/XIX/igs;
	$var=~s/\bXX\b/XX/igs;
	$var=~s/\bXXX\b/XXX/igs;
	$var=~s/\bXxi\b/XXI/igs;
	$var=~s/\bXxii\b/XXII/igs;
	$var=~s/\bXxiii\b/XXIII/igs;
	$var=~s/\bXxiv\b/XXIV/igs;
	$var=~s/\bXxv\b/XXV/igs;
	$var=~s/\bXxvi\b/XXVI/igs;
	$var=~s/\bXxvii\b/XXVII/igs;
	$var=~s/\bXxviii\b/XXVIII/igs;
	$var=~s/(\b(?:[\.\s*])?C(?:[\.\s*])?E(?:[\.\s*])?O(?:[\.\s*])?\b)/ CEO /igs;
	$var=~s/(\b(?:[\.\s*])?C(?:[\.\s*])?F(?:[\.\s*])?O(?:[\.\s*])?\b)/ CFO /igs;
	$var=~s/(\b(?:[\.\s*])?C(?:[\.\s*])?O(?:[\.\s*])?O(?:[\.\s*])?\b)/ COO /igs;
	$var=~s/(\b(?:[\.\s*])?C(?:[\.\s*])?C(?:[\.\s*])?O(?:[\.\s*])?\b)/ CCO /igs;
	$var=~s/(\b(?:[\.\s*])?C(?:[\.\s*])?T(?:[\.\s*])?O(?:[\.\s*])?\b)/CTO /igs;
	$var=~s/(\b(?:[\.\s*])?V(?:[\.\s*])?P(?:[\.\s*])?\b)/ VP /igs;
	$var=~s/(\b(?:[\.\s*])?E(?:[\.\s*])?V(?:[\.\s*])?P(?:[\.\s*])?\b)/ E.V.P. /igs;
	$var=~s/(\b(?:[\.\s*])?C(?:[\.\s*])?L(?:[\.\s*])?O(?:[\.\s*])?\b)/ CLO /igs;
	$var=~s/(\b(?:[\.\s*])?A(?:[\.\s*])?V(?:[\.\s*])?P(?:[\.\s*])?\b)/ AVP /igs;
	$var=~s/\s*\s+/ /igs;
	$var=~s/^\s+//igs;
	$var=~s/\s+$//igs;
	$var=~s/\s\.\s/ /igs;
	return ($var);
	}
sub clean()
	{
	my $var=shift;
	$var=~s/<[^>]*?>//igs;
	$var=~s/&nbsp\;/ /igs;
	$var=decode_entities($var);
	# $var=~s/^\|//igs;
	# $var=~s/\|$//igs;
	$var=~s/^\>//igs;
	$var=~s/\$//igs;
	$var=~s/\>$//igs;
	$var=~s/\s+/ /igs;
	$var=~s/^\s+//igs;
	$var=~s/\.\s\./. /igs;
	$var=~s/^\s*\,\s*//igs;
	$var=~s/\s*\,\s*$//igs;
	$var=~s/\s*\,\,\s*$/,/igs;
	$var=~s/amp\;//igs;
	# $var=~s/\bII\b//igs;
	# $var=~s/\bIII\b//igs;
	# $var=~s/\b IV\b//igs;
	# $var=~s/\b V\b//igs;
	# $var=~s/\b VI\b//igs;
	# $var=~s/\bVII\b//igs;
	# $var=~s/\bVIII\b//igs;
	# $var=~s/\bIX\b//igs;
	# $var=~s/\b X\b//igs;
	# $var=~s/\b XI\b//igs;
	# $var=~s/\bXII\b//igs;
	# $var=~s/\bXIII\b//igs;
	# $var=~s/\bXIV\b//igs;
	# $var=~s/\bXV\b//igs;
	# $var=~s/\bXVI\b//igs;
	# $var=~s/\bXVII\b//igs;
	# $var=~s/\bXVIII\b//igs;
	# $var=~s/\bXIX\b//igs;
	# $var=~s/\bXX\b//igs;
	# $var=~s/\bXXX\b//igs;
	# $var=~s/(\b(?:[\.\s*])?C(?:[\.\s*])?E(?:[\.\s*])?O(?:[\.\s*])?\b)/ CEO /igs;
	# $var=~s/(\b(?:[\.\s*])?C(?:[\.\s*])?F(?:[\.\s*])?O(?:[\.\s*])?\b)/ CFO /igs;
	# $var=~s/(\b(?:[\.\s*])?C(?:[\.\s*])?O(?:[\.\s*])?O(?:[\.\s*])?\b)/ COO /igs;
	# $var=~s/(\b(?:[\.\s*])?C(?:[\.\s*])?C(?:[\.\s*])?O(?:[\.\s*])?\b)/ CCO /igs;
	# $var=~s/(\b(?:[\.\s*])?C(?:[\.\s*])?T(?:[\.\s*])?O(?:[\.\s*])?\b)/CTO /igs;
	# $var=~s/(\b(?:[\.\s*])?V(?:[\.\s*])?P(?:[\.\s*])?\b)/ VP /igs;
	# $var=~s/(\b(?:[\.\s*])?E(?:[\.\s*])?V(?:[\.\s*])?P(?:[\.\s*])?\b)/ EVP /igs;
	# $var=~s/(\b(?:[\.\s*])?C(?:[\.\s*])?L(?:[\.\s*])?O(?:[\.\s*])?\b)/ CLO /igs;
	# $var=~s/(\b(?:[\.\s*])?A(?:[\.\s*])?V(?:[\.\s*])?P(?:[\.\s*])?\b)/ AVP /igs;
	$var=~s/\s*\s+/ /igs;
	$var=~s/^\s+//igs;
	$var=~s/\s+$//igs;
	$var=~s/\s\.\s/ /igs;
	$var=~s/\&nbsp\;//igs;
	$var=~s/^\'//igs;
	return ($var);
	}
sub ProperCase
{
    join(' ',map{ucfirst(lc("$_"))}split(/\s/,$_[0]));
}
sub LEGAL_END
{
	my $comp1=shift;
	$comp1=~s/\bLTIMITED\b/Limited/igs;
	$comp1=~s/\bCorp\b/Corporation/igs;
	$comp1=~s/\bLMITED\b/Limited/igs;
	$comp1=~s/\bLMTD\b/Limited/igs;
	$comp1=~s/\bAndelsselskab\s*med\s*begrænset\s*ansvar\b/AMBA/igs;
	$comp1=~s/\bA\s*M\s*B\s*A\b/AMBA/igs;
	$comp1=~s/\beenpersoons\s*besloten\s*vennootschap\s*met\s*beperkte\s*aansprakelijkheid\b/EBVBA/igs;
	$comp1=~s/\bE\s*B\s*V\s*B\s*A\b/EBVBA/igs;
	$comp1=~s/\bcoöperatieve\s*vennootschap\s*met\s*onbeperkte\s*aansprakelijkheid\b/CVOA/igs;
	$comp1=~s/\bC\s*V\s*O\s*A\b/CVOA/igs;
	$comp1=~s/\bcoöperatieve\s*vennootschap\s*met\s*beperkte\s*aansprakelijkheid\b/CVBA/igs;
	$comp1=~s/\bC\s*V\s*B\s*A\b/CVBA/igs;
	$comp1=~s/\bsociété\s*privée\s*à\s*responsabilité\s*limitée\s*unipersonnelle\b/SPRLU/igs;
	$comp1=~s/\bS\s*P\s*R\s*L\s*U\b/SPRLU/igs;
	$comp1=~s/\bbesloten\s*vennootschap\s*met\s*beperkte\s*aansprakelijkheid\b/BVBA/igs;
	$comp1=~s/\bB\s*V\s*B\s*A\b/BVBA/igs;
	$comp1=~s/\bEntreprise\s*unipersonnelle\s*à\s*responsabilité\s*limitée\b/EURL/igs;
	$comp1=~s/\bE\s*U\s*R\s*L\b/EURL/igs;
	$comp1=~s/\bPublic\s*Establishment\s*with\s*Economic\s*characteristics\b/PEEC/igs;
	$comp1=~s/\bP\s*E\s*E\s*C\b/PEEC/igs;
	$comp1=~s/\bTovarishchestvo\s*s\s*ogranichennoy\s*otvetstvennostyu\b/TOO/igs;
	$comp1=~s/\bT\s*O\s*O\b/TOO/igs;
	$comp1=~s/\bEmpresa\s*Individual\s*de\s*Responsabilidad\s*Limitada\b/EIRL/igs;
	$comp1=~s/\bE\s*I\s*R\s*L\b/EIRL/igs;
	$comp1=~s/\bsociété\s*coopérative\s*à\s*responsabilité\s*illimitée\b/SCRI/igs;
	$comp1=~s/\bS\s*C\s*R\s*I\b/SCRI/igs;
	$comp1=~s/\bSociété\s*par\s*actions\s*simplifiée\s*unipersonnelle\b/SASU/igs;
	$comp1=~s/\bS\s*A\s*S\s*U\b/SASU/igs;
	$comp1=~s/\bSocietà\s*cooperativa\s*a\s*responsabilità\s*limitata\b/SCRL/igs;
	$comp1=~s/\bSociety\s*Cooperative\s*a\s*responsibility\s*Limited\b/SCRL/igs;
	$comp1=~s/\bsociété\s*coopérative\s*à\s*responsabilité\s*limitée\b/SCRL/igs;
	$comp1=~s/\bS\s*C\s*R\s*L\b/SCRL/igs;
	$comp1=~s/\bNova\s*Scotia\s*Unlimited\s*liability\s*corporations\b/NSULC/igs;
	$comp1=~s/\bN\s*S\s*U\s*L\s*C\b/NSULC/igs;
	$comp1=~s/\bSociété\s*d\'?\s*investissement\s*à\s*capital\s*variable\b/SICAV/igs;
	$comp1=~s/\bS\s*I\s*C\s*A\s*V\b/SICAV/igs;
	$comp1=~s/\bMonoprósopi\s*Etería\s*Periorisménis\s*Efthínis\b/MEPE/igs;
	$comp1=~s/\bM\s*E\s*P\s*E\b/MEPE/igs;
	$comp1=~s/\bAlberta\s*Unlimited\s*liability\s*corporations\b/AULC/igs;
	$comp1=~s/\bA\s*U\s*L\s*C\b/AULC/igs;
	$comp1=~s/\bVereinigung\s*ohne\s*Gewinnerzielungsabsicht\b/VoG/igs;
	$comp1=~s/\bV\s*o\s*G\b/VoG/igs;
	$comp1=~s/\bSociedad\s*Anónima\s*Promotora\s*de\s*Inversión\b/SAPI/igs;
	$comp1=~s/\bS\s*A\s*P\s*I\b/SAPI/igs;
	$comp1=~s/\bSociété\s*d\'?\s*investissement\s*à\s*capital\s*fixe\b/SICAF/igs;
	$comp1=~s/\bS\s*I\s*C\s*A\s*F\b/SICAF/igs;
	$comp1=~s/\bsociété\s*privée\s*à\s*responsabilité\s*limitée\b/SPRL/igs;
	$comp1=~s/\bS\s*P\s*R\s*L\b/SPRL/igs;
	$comp1=~s/\bcommanditaire\s*vennootschap\s*op\s*aandelen\b/CommVA/igs;
	$comp1=~s/\bComm\s*VA\b/CommVA/igs;
	$comp1=~s/\bPerseroan\s*Terbatas\s*Terbuka\b/Tbk PT/igs;
	$comp1=~s/\bPerseroan\s*Terbuka\b/Tbk PT/igs;
	$comp1=~s/\bPT\s*Tbk\b/Tbk PT/igs;
	$comp1=~s/\bPERSERO\b/Tbk PT/igs;
	$comp1=~s/\bTbk\b/Tbk PT/igs;
	$comp1=~s/\bPT\b/Tbk PT/igs;
	$comp1=~s/\bSociedad\s*de\s*Resposabilidad\s*Limitada\b/SRL/igs;
	$comp1=~s/\bSocietà\s*a\s*Responsabilità\s*Limitata\b/SRL/igs;
	$comp1=~s/\bS\s*de\s*R\s*L\b/SRL/igs;
	$comp1=~s/\bEurooppalainen\s*taloudellinen\s*etuyhtymä\b/EEIG/igs;
	$comp1=~s/\bEuropean\s*Economic\s*Interest\s*Grouping\b/EEIG/igs;
	$comp1=~s/\bE\s*E\s*I\s*G\b/EEIG/igs;
	$comp1=~s/\bentreprise\s*en\s*nom\s*personnel\b/EI/igs;
	$comp1=~s/\bEntreprise\s*individuelle\b/EI/igs;
	$comp1=~s/\beenmanszaak\b/EI/igs;
	$comp1=~s/\bE\s*I\b/EI/igs;
	$comp1=~s/\bPartnerschaftsgesellschaft\b/PartG/igs;
	$comp1=~s/\bPart\s*G\b/PartG/igs;
	$comp1=~s/\bSociedade\s*Anônima\b/SA/igs;
	$comp1=~s/\bSociedad\s*Anonima\b/SA/igs;
	$comp1=~s/\bSociedad\s*Anónima\b/SA/igs;
	$comp1=~s/\bSociedade\s*Anonima\b/SA/igs;
	$comp1=~s/\bSociété\s*anonyme\b/SA/igs;
	$comp1=~s/\bsocieté\s*anonyme\b/SA/igs;
	$comp1=~s/\bspólka\s*akcyjna\b/SA/igs;
	$comp1=~s/\bS\s*A\b/SA/igs;
	$comp1=~s/\bco\s*opérative\b/co op/igs;
	$comp1=~s/\bco\s*op\b/co op/igs;
	$comp1=~s/\bco\s*operative\b/co op/igs;
	$comp1=~s/\bSociété\s*en\s*commandite\s*simple\b/SCS/igs;
	$comp1=~s/\bSociedad\s*En\s*Comandita\s*Simple\b/SCS/igs;
	$comp1=~s/\bS\s*E\s*C\s*S\b/SCS/igs;
	$comp1=~s/\bS\s*C\s*S\b/SCS/igs;
	$comp1=~s/\bInterkommunalt\s*selskap\b/IKS/igs;
	$comp1=~s/\bI\s*K\s*S\b/IKS/igs;
	$comp1=~s/\bIncorporation\b/Inc/igs;
	$comp1=~s/\bIncorporated\b/Inc/igs;
	$comp1=~s/\bIncorporée\b/Inc/igs;
	$comp1=~s/\bIncorp\b/Inc/igs;
	$comp1=~s/\bI\s*n\s*c\b/Inc/igs;
	$comp1=~s/\bVolontariat\s*international\s*d\'?\s*entreprise\b/VIE/igs;
	$comp1=~s/\bV\s*I\s*E\b/VIE/igs;
	$comp1=~s/\bGesellschaft\s*mit\s*beschränkter\s*Haftung\b/GmbH/igs;
	$comp1=~s/\bGes\s*m\s*b\s*H\b/GmbH/igs;
	$comp1=~s/\bG\s*m\s*b\s*H\b/GmbH/igs;
	$comp1=~s/\bOmórithmi\s*Viomihanikí\s*Emborikí\s*Etería\b/OVEE/igs;
	$comp1=~s/\bO\s*V\s*E\s*E\b/OVEE/igs;
	$comp1=~s/\bSociété\s*par\s*actions\s*de\s*régime\s*fédéral\b/SARF/igs;
	$comp1=~s/\bS\s*A\s*R\s*F\b/SARF/igs;
	$comp1=~s/\bGesellschaft\s*des\s*bürgerlichen\s*Rechts\b/GesbR/igs;
	$comp1=~s/\bGes\s*b\s*R\b/GesbR/igs;
	$comp1=~s/\bSingle\s*Member\s*Private\s*Limited\s*Company\b/SM P L/igs;
	$comp1=~s/\bSM\s*Pte\s*Ltd\b/SM P L/igs;
	$comp1=~s/\bSingle\s*member\s*company\s*private\s*Limited\b/SME P L/igs;
	$comp1=~s/\bS\s*M\s*E\s*Pvt\s*Ltd\b/SME P L/igs;
	$comp1=~s/\bjednoosobowa\s*dzialalnosc\s*gospodarcza\b/jednoosobowa dzialalnosc gospodarcza/igs;
	$comp1=~s/\bSociedad\s*de\s*responsabilidad\s*limitada\b/LTDA/igs;
	$comp1=~s/\bSociedade\s*Limitada\b/LTDA/igs;
	$comp1=~s/\bLTD\s*A\b/LTDA/igs;
	#$comp1=~s/\bLTD\b/Limited/igs;
	#$comp1=~s/\bLTD\.\b/Limited./igs;
	$comp1=~s/\bGP\b/GP/igs;
	$comp1=~s/\bL\.P\.\b/L.P./igs;
	$comp1=~s/\bL\.P\b/L.P/igs;
	$comp1=~s/\bL\sP\b/L.P/igs;
	$comp1=~s/\bP\s*L\s*C\b/PLC/igs;
	$comp1=~s/\bP\s*\.\s*L\s*\.\s*C\b/PLC/igs;
	$comp1=~s/\bP\s*\.\s*L\s*\.\s*C\s*\.\s*\b/PLC/igs;
	$comp1=~s/\bSociedades\s*por\s*acciones\s*simplificada\b/SAS/igs;
	$comp1=~s/\bSocietà\s*in\s*accomandita\s*semplice\b/SAS/igs;
	$comp1=~s/\bSociété\s*par\s*actions\s*simplifiée\b/SAS/igs;
	$comp1=~s/\bS\s*A\s*S\b/SAS/igs;
	$comp1=~s/\bAnónimi\s*Viomihanikí\s*Emborikí\s*Etería\b/AVEE/igs;
	$comp1=~s/\bA\s*V\s*E\s*E\b/AVEE/igs;
	$comp1=~s/\bNorskregistrert\s*utenlandsk\s*foretak\b/NUF/igs;
	$comp1=~s/\bN\s*U\s*F\b/NUF/igs;
	$comp1=~s/\bSociedad\s*en\s*Comandita\s*por\s*Acciones\b/SCA/igs;
	$comp1=~s/\bSociété\s*en\s*commandite\s*par\s*actions\b/SCA/igs;
	$comp1=~s/\bComandita\s*por\s*acciones\b/SCA/igs;
	$comp1=~s/\bS\s*C\s*A\b/SCA/igs;
	$comp1=~s/\bSabiedriba\s*ar\s*ierobežotu\s*atbildibu\b/SIA/igs;
	$comp1=~s/\bS\s*I\s*A\b/SIA/igs;
	$comp1=~s/\bSociedade\s*em\s*Conta\s*de\s*Participação\b/Sociedade em Conta de Participação/igs;
	$comp1=~s/\bgewone\s*commanditaire\s*vennootschap\b/CommV/igs;
	$comp1=~s/\bComm\s*V\b/CommV/igs;
	$comp1=~s/\bSocietà\s*in\s*accomandita\s*per\s*azioni\b/SAPA/igs;
	$comp1=~s/\bS\s*A\s*P\s*A\b/SAPA/igs;
	$comp1=~s/\bGesellschaft\s*bürgerlichen\s*Rechts\b/GBR/igs;
	$comp1=~s/\bG\s*B\s*R\b/GBR/igs;
	$comp1=~s/\bKommanditgesellschaft\s*auf\s*Aktien\b/KGAA/igs;
	$comp1=~s/\bK\s*G\s*A\s*A\b/KGAA/igs;
	$comp1=~s/\bsociété\s*à\s*responsabilité\s*limitée\b/SARL/igs;
	$comp1=~s/\bS\s*A\s*R\s*L\b/SARL/igs;
	$comp1=~s/\bS\s*à\s*R\s*L\b/SARL/igs;
	$comp1=~s/\bSociété\s*coopérative\s*de\s*production\b/SCOP/igs;
	$comp1=~s/\bS\s*C\s*O\s*P\b/SCOP/igs;
	$comp1=~s/\bUnlimited\s*liability\s*corporations\b/ULC/igs;
	$comp1=~s/\bU\s*L\s*C\b/ULC/igs;
	$comp1=~s/\bCompagnie\s*Kommanditgesellschaft\b/CO KG/igs;
	$comp1=~s/\bC\s*O\s*K\s*G\b/CO KG/igs;
	$comp1=~s/\beconomisch\s*samenwerkingsverband\b/ESV/igs;
	$comp1=~s/\bE\s*S\s*V\b/ESV/igs;
	$comp1=~s/\bgroupement\s*d\'?\s*intérêt\s*économique\b/GIE/igs;
	$comp1=~s/\bG\s*I\s*E\b/GIE/igs;
	$comp1=~s/\bSociété\s*commerciale\s*canadienne\b/SCC/igs;
	$comp1=~s/\bS\s*C\s*C\b/SCC/igs;
	$comp1=~s/\bSociedade\s*em\s*Comandita\s*Simples\b/Sociedade em Comandita Simples/igs;
	$comp1=~s/\btijdelijke\s*handelsvennootschap\b/tijdelijke handelsvennootschap/igs;
	$comp1=~s/\bsociété\s*momentanée\b/tijdelijke handelsvennootschap/igs;
	$comp1=~s/\bvereniging\s*zonder\s*winstoogmerk\b/VZW/igs;
	$comp1=~s/\bV\s*Z\s*W\b/VZW/igs;
	$comp1=~s/\bassociation\s*sans\s*but\s*lucratif\b/ASBL/igs;
	$comp1=~s/\bA\s*S\s*B\s*L\b/ASBL/igs;
	$comp1=~s/\bAssociação\s*em\s*sentido\s*estrito\b/Associação em sentido estrito/igs;
	$comp1=~s/\bsem\s*finalidade\s*lucrativa\b/Associação em sentido estrito/igs;
	$comp1=~s/\bEtería\s*Periorisménis\s*Efthínis\b/EPE/igs;
	$comp1=~s/\bE\s*P\s*E\b/EPE/igs;
	$comp1=~s/\bForening\s*med\s*begrænset\s*ansvar\b/FMBA/igs;
	$comp1=~s/\bF\s*M\s*B\s*A\b/FMBA/igs;
	$comp1=~s/\blimited\s*liability\s*partnership\b/LLP/igs;
	$comp1=~s/\bL\s*L\s*P\b/LLP/igs;
	$comp1=~s/\bSocietas\s*Cooperativa\s*Europaea\b/SCE/igs;
	$comp1=~s/\bEurooppaosuuskunta\b/SCE/igs;
	$comp1=~s/\bS\s*C\s*E\b/SCE/igs;
	$comp1=~s/\bspolecnost\s*s\s*rucením\s*omezeným\b/SRO/igs;
	$comp1=~s/\bS\s*R\s*O\b/SRO/igs;
	$comp1=~s/\bSelskap\s*med\s*begrenset\s*ansvar\b/BA/igs;
	$comp1=~s/\bB\s*A\b/BA/igs;
	$comp1=~s/\bKommanditerwerbsgesellschaft\b/KEG/igs;
	$comp1=~s/\bK\s*E\s*G\b/KEG/igs;
	$comp1=~s/\bSelskab\s*med\s*begrænset\s*ansvar\b/SMBA/igs;
	$comp1=~s/\bS\s*M\s*B\s*A\b/SMBA/igs;
	$comp1=~s/\bstichting\s*van\s*openbaar\s*nut\b/stichting van openbaar nut/igs;
	$comp1=~s/\bfondation\s*d\'?\s*utilité\s*publique\b/stichting van openbaar nut/igs;
	$comp1=~s/\beingetragene\s*Genossenschaft\b/EG/igs;
	$comp1=~s/\be\s*g\b/EG/igs;
	$comp1=~s/\bProprietary\s*Limited\s*Company\b/Pty Limited Company/igs;
	$comp1=~s/\bProprietary\s*Limited\b/Pty Limited/igs;
	$comp1=~s/\bPropriety\s*Limited\b/Pty Limited/igs;
	$comp1=~s/\bPty\s*Ltd\s*Co\b/Pty Limited/igs;
	$comp1=~s/\bPty\s*Ltd\b/Pty Limited/igs;
	$comp1=~s/\bSharikat\s*Tawssiyah\s*Belashom\b/Sharikat Tawssiyah Belashom/igs;
	$comp1=~s/\bState\s*Joint\s*Venture\s*Company\b/State Joint Venture Company/igs;
	$comp1=~s/\bstichting\s*van\s*openbaar\s*nut\b/stichting van openbaar nut/igs;
	$comp1=~s/\bfondation\s*d\'?\s*utilité\s*publique\b/stichting van openbaar nut/igs;
	$comp1=~s/\bverejná\s*obchodní\s*spolecnost\b/VOS/igs;
	$comp1=~s/\bV\s*O\s*S\b/VOS/igs;
	$comp1=~s/\bCommanditaire\s*vennootschap\b/CV/igs;
	$comp1=~s/\bC\s*V\b/CV/igs;
	$comp1=~s/\bOffene\s*Erwerbsgesellschaft\b/OEG/igs;
	$comp1=~s/\bO\s*E\s*G\b/OEG/igs;
	$comp1=~s/\boffene\s*Handelsgesellschaft\b/OHG/igs;
	$comp1=~s/\bO\s*H\s*G\b/OHG/igs;
	$comp1=~s/\bPrzedsiebiorstwo\s*Panstwowe\b/PP/igs;
	$comp1=~s/\bP\s*P\b/PP/igs;
	$comp1=~s/\bStructural\s*Adjustment\s*Loan\b/SAL/igs;
	$comp1=~s/\bSociete\s*Anonyme\s*Libanaise\b/SAL/igs;
	$comp1=~s/\bS\s*A\s*L\b/SAL/igs;
	$comp1=~s/\bSharikat\s*Tawssiyah\s*Bassita\b/Sharikat Tawssiyah Bassita/igs;
	$comp1=~s/\bSocietà\s*in\s*nome\s*collettivo\b/SNC/igs;
	$comp1=~s/\bSociété\s*en\s*nom\s*collectif\b/SNC/igs;
	$comp1=~s/\bS\s*N\s*C\b/SNC/igs;
	$comp1=~s/\bSociedade\s*em\s*Nome\s*Coletivo\b/Sociedade em Nome Coletivo/igs;
	$comp1=~s/\bstille\s*handelsvennootschap\b/stille handelsvennootschap/igs;
	$comp1=~s/\bsociété\s*interne\b/stille handelsvennootschap/igs;
	$comp1=~s/\bLimited\s*Liability\s*Company\b/LLC/igs;
	$comp1=~s/\bL\s*L\s*C\b/LLC/igs;
	$comp1=~s/\bL\s*\.\s*L\s*\.\s*C\b/LLC/igs;
	$comp1=~s/\bSociedad\s*Anónima\s*Bursátil\b/SAB/igs;
	$comp1=~s/\bS\s*A\s*B\b/SAB/igs;
	$comp1=~s/\bSocietas\s*Privata\s*Europaea\b/SPE/igs;
	$comp1=~s/\bS\s*P\s*E\b/SPE/igs;
	$comp1=~s/\bIndividualais\s*komersants\b/IK/igs;
	$comp1=~s/\bI\s*K\b/IK/igs;
	$comp1=~s/\bSociedad\s*Anónima\s*Abierta\b/SAA/igs;
	$comp1=~s/\bS\s*A\s*A\b/SAA/igs;
	$comp1=~s/\bSociété\s*d\'?\s*économie\s*mixte\b/SEM/igs;
	$comp1=~s/\bS\s*E\s*M\b/SEM/igs;
	$comp1=~s/\bSociété\s*en\s*participation\b/SEP/igs;
	$comp1=~s/\bS\s*E\s*P\b/SEP/igs;
	$comp1=~s/\bUždaroji\s*akcine\s*bendrove\b/UAB/igs;
	$comp1=~s/\bU\s*A\s*B\b/UAB/igs;
	$comp1=~s/\bvennootschap\s*onder\s*firma\b/VOF/igs;
	$comp1=~s/\bV\s*O\s*F\b/VOF/igs;
	$comp1=~s/\bAktsionernoe\s*obschestvo\b/AO/igs;
	$comp1=~s/\bA\s*O\b/AO/igs;
	$comp1=~s/\bSelskap\s*med\s*delt\s*ansvar\b/DA/igs;
	$comp1=~s/\bD\s*A\b/DA/igs;
	$comp1=~s/\bFylkeskommunalt\s*foretak\b/FKF/igs;
	$comp1=~s/\bF\s*K\s*F\b/FKF/igs;
	$comp1=~s/\bprivate\s*stichting\b/P Stichting/igs;
	#$comp1=~s/\bprivate\b/P/igs;
	$comp1=~s/\bpvt\b/Private/igs;
	$comp1=~s/\bLimited\s*by\s*Guarantee\b/L Gte/igs;
	$comp1=~s/\bLtd\s*Gte\b/Limited Gte/igs;
	$comp1=~s/\bSpecial\s*Purpose\s*Vehicle\b/SPV/igs;
	$comp1=~s/\bS\s*P\s*V\b/SPV/igs;
	$comp1=~s/\bHindu\s*Undivided\s*Family\b/HUF/igs;
	$comp1=~s/\bH\s*U\s*F\b/HUF/igs;
	$comp1=~s/\bPersekutuan\s*Komanditer\b/Persekutuan Komanditer/igs;
	$comp1=~s/\bPublic\s*Limited\s*Company\b/PLC/igs;
	$comp1=~s/\bP\s*L\s*C\b/PLC/igs;
	$comp1=~s/\bRelitioznoe\s*Obedinenie\b/PO/igs;
	$comp1=~s/\bP\s*O\b/PO/igs;
	$comp1=~s/\bRegionalt\s*helseforetak\b/RHF/igs;
	$comp1=~s/\bR\s*H\s*F\b/RHF/igs;
	$comp1=~s/\bSharikat\s*al\s*\-?\s*Mossahamah\b/SAE/igs;
	$comp1=~s/\bS\s*A\s*E\b/SAE/igs;
	$comp1=~s/\bBesloten\s*vennootschap\b/BV/igs;
	$comp1=~s/\bB\s*V\b/BV/igs;
	$comp1=~s/\bErhvervsdrivende\s*fond\b/Erhvervsdrivende fond/igs;
	$comp1=~s/\bFamily\s*Owned\s*Business\b/Family Owned Business/igs;
	$comp1=~s/\bkomanditní\s*spolecnost\b/KS/igs;
	$comp1=~s/\bKomanditsabiedriba\b/KS/igs;
	$comp1=~s/\bKommandittselskap\b/KS/igs;
	$comp1=~s/\bKommanditselskab\b/KS/igs;
	$comp1=~s/\bK\s*S\b/KS/igs;
	$comp1=~s/\bKommanditgesellschaft\b/KG/igs;
	$comp1=~s/\bK\s*G\b/KG/igs;
	$comp1=~s/\bnaamloze\s*vennootschap\b/NV/igs;
	$comp1=~s/\bN\s*V\b/NV/igs;
	$comp1=~s/\bKommanditaktieselskab\b/PS/igs;
	$comp1=~s/\bPartnerselskab\b/PS/igs;
	$comp1=~s/\bPilnsabiedriba\b/PS/igs;
	$comp1=~s/\bP\s*S\b/PS/igs;
	$comp1=~s/\bsociété\s*de\s*fait\b/feitelijke\s*vereniging/igs;
	$comp1=~s/\bSociedad\s*por\s*acciones\b/SPA/igs;
	$comp1=~s/\bSocietà\s*per\s*azioni\b/SPA/igs;
	$comp1=~s/\bS\s*P\s*A\b/SPA/igs;
	$comp1=~s/\beingetragener\s*Verein\b/EV/igs;
	$comp1=~s/\begyéni\s*vállalkozó\b/EV/igs;
	$comp1=~s/\bE\s*V\b/EV/igs;
	$comp1=~s/\bSociedad\s*en\s*Comandita\b/LP/igs;
	$comp1=~s/\bLimited\s*Partnership\b/LP/igs;
	$comp1=~s/\bPartners\s*Limited\b/LP/igs;
	$comp1=~s/\bL\s*P\b/LP/igs;
	$comp1=~s/\bNATIONAL\s*ASSOCIATION\b/NA/igs;
	$comp1=~s/\bN\s*A\b/NA/igs;
	$comp1=~s/\bAllmennaksjeselskap\b/ASA/igs;
	$comp1=~s/\bA\s*S\s*A\b/ASA/igs;
	$comp1=~s/\bEterórithmos\s*Etería\b/EE/igs;
	$comp1=~s/\bE\s*E\b/EE/igs;
	$comp1=~s/\bEmpresa\s*unipersonal\b/EU/igs;
	$comp1=~s/\bE\s*U\b/EU/igs;
	$comp1=~s/\bGeneral\s*Partnership\b/GP/igs;
	$comp1=~s/\bPersekutuan\s*Perdata\b/Maatschap/igs;
	$comp1=~s/\boffene\s*Gesellschaft\b/OG/igs;
	$comp1=~s/\bO\s*G\b/OG/igs;
	$comp1=~s/\bopinbert\s*hlutafélag\b/OHF/igs;
	$comp1=~s/\bO\s*H\s*F\b/OHF/igs;
	$comp1=~s/\bjulkinen\s*osakeyhtiö\b/OYJ/igs;
	$comp1=~s/\bO\s*Y\s*J\b/OYJ/igs;
	$comp1=~s/\bSociedad\s*del\s*Estado\b/SE/igs;
	$comp1=~s/\bSocietas\s*Europaea\b/SE/igs;
	$comp1=~s/\bEurooppayhtiö\b/SE/igs;
	$comp1=~s/\bS\s*E\b/SE/igs;
	$comp1=~s/\bSole\s*Proprietorship\b/SP/igs;
	$comp1=~s/\bS\s*P\b/SP/igs;
	$comp1=~s/\bstille\s*Gesellschaft\b/STG/igs;
	$comp1=~s/\bS\s*T\s*G\b/STG/igs;
	$comp1=~s/\bSuc\s*de\s*Descendants\b/Suc de Descendants/igs;
	$comp1=~s/\bUnlimited\s*company\b/Unlimited co/igs;
	$comp1=~s/\bCompany\s*Limited\b/Co L/igs;
	$comp1=~s/\bCo\s*Limited\b/Co Limited/igs;
	$comp1=~s/\bCo\s*Ltd\b/Co Limited/igs;
	$comp1=~s/\bLimited\s*Company\b/Limited Company/igs;
	$comp1=~s/\bLtd\s*Co\b/Limited Company/igs;
	$comp1=~s/\bCorp\s*Ltd\b/Corp L/igs;
	$comp1=~s/\bCorporation\s*Limited\b/Corporation Limited/igs;
	$comp1=~s/\bCorp\s*Limited\b/Corporation Limited/igs;
	$comp1=~s/\bLimited\b/Limited/igs;
	$comp1=~s/\bL\s*t\s*d\b/Limited/igs;
	$comp1=~s/\bState\s*Company\b/State Company/igs;
	$comp1=~s/\bCompany\b/Company/igs;
	$comp1=~s/\bBancorporation\b/BANCORP/igs;
	$comp1=~s/\bCORPORATION\b/Corporation/igs;
	$comp1=~s/\bCorporate\b/Corporate/igs;
	$comp1=~s/\bCorporat\b/Corporate/igs;
	$comp1=~s/\bCorpn\b/Corp/igs;
	$comp1=~s/\bCORP\s*OF\b/Corporation/igs;
	$comp1=~s/\bCpn\b/Corporation/igs;
	$comp1=~s/\bCo\s*operativa\b/Co op/igs;
	$comp1=~s/\bAkciju\s*sabiedriba\b/AS/igs;
	$comp1=~s/\bAktieselskab\b/AS/igs;
	$comp1=~s/\bAksjeselskap\b/AS/igs;
	$comp1=~s/\bA\s*S\b/AS/igs;
	$comp1=~s/\bTechnology\b/Tech/igs;
	$comp1=~s/\bTechnologies\b/Tech/igs;
	$comp1=~s/\bTechnique\b/Tech/igs;
	$comp1=~s/\bTech\s*no\b/Tech/igs;
	$comp1=~s/\bManagement\b/Management/igs;
	$comp1=~s/\bMngmt\b/Management/igs;
	$comp1=~s/\bMgmt\b/Management/igs;
	$comp1=~s/\bHolding\b/Holdings/igs;
	$comp1=~s/\bHoldings\b/Holdings/igs;
	$comp1=~s/\bHldgs\b/Holdings/igs;
	$comp1=~s/\bAnsvarlig\s*selskap\b/ANS/igs;
	$comp1=~s/\bA\s*N\s*S\b/ANS/igs;
	$comp1=~s/\bKommunalt\s*foretak\b/KF/igs;
	$comp1=~s/\bK\s*F\b/KF/igs;
	$comp1=~s/\bOmórithmos\s*Etería\b/OE/igs;
	$comp1=~s/\bO\s*E\b/OE/igs;
	$comp1=~s/\bhelseforetak\b/HF/igs;
	$comp1=~s/\bH\s*F\b/HF/igs;
	$comp1=~s/\bAktiengesellschaft\b/AG/igs;
	$comp1=~s/\bA\s*G\b/AG/igs;
	$comp1=~s/\bPublic\s*Sector\s*Unit\b/PSU/igs;
	$comp1=~s/\bP\s*S\s*U\b/PSU/igs;
	$comp1=~s/\bNo\s*liability\b/NL/igs;
	$comp1=~s/\bN\s*L\b/NL/igs;
	$comp1=~s/\bAnpartsselskab\b/APS/igs;
	$comp1=~s/\bA\s*P\s*S\b/APS/igs;
	$comp1=~s/\bBorettslag\b/BL/igs;
	$comp1=~s/\bB\s*L\b/BL/igs;
	$comp1=~s/\bStatsforetak\b/SF/igs;
	$comp1=~s/\bS\s*F\b/SF/igs;
	$comp1=~s/\bSocietà\s*semplice\b/SS/igs;
	$comp1=~s/\bS\s*S\b/SS/igs;
	$comp1=~s/\bExports\b/Expo/igs;
	$comp1=~s/\bExport\b/Expo/igs;
	$comp1=~s/\bSendirian\s*Berhad\b/Sdn Bhd/igs;
	$comp1=~s/\bSdn\s*Bhd\b/Sdn Bhd/igs;
	$comp1=~s/\bInteressentskab\b/IS/igs;
	$comp1=~s/\bI\s*S\b/IS/igs;
	$comp1=~s/\bGroup\b/Group/igs;
	$comp1=~s/\bGroups\b/Group/igs;
	$comp1=~s/\bService\b/Service/igs;
	$comp1=~s/\bServices\b/Service/igs;
	$comp1=~s/\bPHARMACEUTICAL\b/Pharma/igs;
	$comp1=~s/\bPHARMACEUTICALS\b/Pharma/igs;
	$comp1=~s/\bPreferred\s*Funding\b/Prf Fd/igs;
	$comp1=~s/\bPrf\s*Fd\b/Prf Fd/igs;
	#$comp1=~s/\bInvestment\b/Inv/igs;
	#$comp1=~s/\bInvestments\b/Inv/igs;
	#$comp1=~s/\bBank\b/BK/igs;
	#$comp1=~s/\bBanks\b/BK/igs;
	$comp1=~s/\bB\s*K\b/BK/igs;
	$comp1=~s/\bGensidigt\s*selskab\b/GS/igs;
	$comp1=~s/\bG\s*S\b/GS/igs;
	# $comp1=~s/\bTRUSTS\b/TR/igs;
	# $comp1=~s/\bTRUST\b/TR/igs;
	# $comp1=~s/\bK\s*K\b/KK/igs;
	# $comp1=~s/\bIndia\b/I/igs;
	# $comp1=~s/\bIndian\b/I/igs;
	# $comp1=~s/\bInd\b/I/igs;
	$comp1=~s/\bandelslag\b/ANL/igs;
	$comp1=~s/\bA\s*N\s*L\b/ANL/igs;
	$comp1=~s/\bGenossenschaft\b/GEN/igs;
	$comp1=~s/\bG\s*e\s*n\b/GEN/igs;
	$comp1=~s/\bProprietary\b/Pty/igs;
	$comp1=~s/\bPropriety\b/Pty/igs;
	$comp1=~s/\bCompañía\b/Cía/igs;
	$comp1=~s/\bC\s*í\s*a\b/Cía/igs;
	$comp1=~s/\bavoin\s*yhtiö\b/AY/igs;
	$comp1=~s/\ba\s*y\b/AY/igs;
	$comp1=~s/\bDEVELOPMENT\b/DEVE/igs;
	$comp1=~s/\bDEVELOPMENTS\b/DEVE/igs;
	$comp1=~s/\bGarments\b/Garment/igs;
	$comp1=~s/\beinkahlutafélag\b/ehf/igs;
	$comp1=~s/\be\s*h\s*f\b/ehf/igs;
	$comp1=~s/\bkommanditbolag\b/KB/igs;
	$comp1=~s/\bk\s*b\b/KB/igs;
	$comp1=~s/\bosuuskunta\b/OK/igs;
	$comp1=~s/\bo\s*k\b/OK/igs;
	$comp1=~s/\bBerhad\b/Bhd/igs;
	$comp1=~s/\bPerusahaan\s*Umum\b/Perum/igs;
	$comp1=~s/\bLimitée\b/L/igs;
	$comp1=~s/\bLtée\b/L/igs;
	$comp1=~s/\bEnterprise\b/Ent/igs;
	$comp1=~s/\bEnterprises\b/Ent/igs;
	$comp1=~s/\bInternational\b/International/igs;
	$comp1=~s/\bIntl\b/Int/igs;
	$comp1=~s/\bkommandiittiyhtiö\b/KY/igs;
	$comp1=~s/\bK\s*Y\b/KY/igs;
	$comp1=~s/\bIndustries\b/INDS/igs;
	$comp1=~s/\bIndustry\b/INDS/igs;
	$comp1=~s/\bINDU\b/INDS/igs;
	#$comp1=~s/\bNATIONAL\b/N/igs;
	$comp1=~s/\bNAT\b/N/igs;
	$comp1=~s/\bFirma\b/Fa/igs;
	#$comp1=~s/\bFINANCIAL\b/FINANCE/igs;
	$comp1=~s/\bSharikat\s*Tadamun\b/Sharikat Tadamun/igs;
	$comp1=~s/\bSociedade\s*em\s*Comum\b/Sociedade em Comum/igs;
	$comp1=~s/\bSociedade\s*Simples\b/Sociedade Simples/igs;
	$comp1=~s/\bSPINNING\b/SPG/igs;
	$comp1=~s/\bS\s*P\s*G\b/SPG/igs;
	$comp1=~s/\bUsaha\s*Dagang\b/UD/igs;
	$comp1=~s/\bU\s*D\b/UD/igs;
	$comp1=~s/\bWEAVING\b/WVG/igs;
	$comp1=~s/\bW\s*V\s*G\b/WVG/igs;
	$comp1=~s/\bAkcine\s*bendrove\b/AB/igs;
	$comp1=~s/\bA\s*B\b/AB/igs;
	$comp1=~s/\bpublikt\s*aktiebolag\b/Abp/igs;
	$comp1=~s/\bAnónimi\s*Etería\b/AE/igs;
	$comp1=~s/\bFINANCE\b/Finance/igs;
	return($comp1);
}

