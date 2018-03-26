import UIKit

class TramsTableViewController: UITableViewController {
    
    var station: StationPresentable?
    var refreshData: ()->() = {}
    var color: UIColor = UIColor.black
    
    public func dataRefreshed(station: StationPresentable, error: Error?) {
        if let error = error {
            showError(error: error)
        } 
        self.station = station
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyStyles()
        tableView.register(UINib.init(nibName: "LargeTramTableViewCell", bundle: nil), forCellReuseIdentifier: "LargeTramTableViewCell")
        tableView.register(UINib.init(nibName: "MessageBoardTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageBoardTableViewCell")
        refreshControl?.addTarget(self, action: #selector(refreshStation), for: UIControlEvents.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    @objc func refreshStation() {
        refreshData()
    }
    
    func applyStyles() {
        view.backgroundColor = self.color
        tableView.backgroundColor = self.color
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Loading Problem", message: "There was a problem loading the feed; check your connection and try again, error code:\(error._code)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let station = station else {
            return 1
        }
        return station.trams.count > 0 ? station.trams.count+1 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        Հայերեն Shqip ‫العربية‫العربية   Български Català 中文简体 Hrvatski Česky Dansk Nederlands English Eesti Filipino Suomi Français ქართული Deutsch Ελληνικά ‫עברית‫עברית   हिन्दी Magyar Indonesia Italiano Latviski Lietuviškai македонски Melayu Norsk Polski Português Româna Pyccкий Српски Slovenčina Slovenščina Español Svenska ไทย Türkçe Українська Tiếng Việt
        //        Lorem Ipsum
        //        "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..."
        //        "There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain..."
        //
        //        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        //        Nam sed eros a nunc convallis venenatis.
        //        Vestibulum non arcu elementum turpis blandit blandit non eget nunc.
        //        Etiam id nibh et nisi finibus fermentum vel a odio.
        //        Praesent feugiat ante sed imperdiet facilisis.
        //        Cras sagittis magna in ex pellentesque aliquam quis ut risus.
        //        Donec efficitur elit pellentesque tempus mattis.
        //        Mauris tempor odio at justo interdum sodales.
        //        Donec in massa varius, commodo ante in, consequat risus.
        //        Morbi vestibulum turpis sit amet cursus pretium.
        //        Aenean rhoncus est nec est varius, a placerat neque tempor.
        //        In dignissim sem nec leo sodales pharetra ac ut magna.
        //        Nullam nec nibh scelerisque, ornare elit quis, viverra velit.
        //        Fusce sollicitudin diam sed auctor condimentum.
        //        Nam tempor risus ut lacinia mollis.
        //        Pellentesque eget lorem iaculis, sodales urna non, pretium enim.
        //        Ut id nulla non purus interdum pharetra nec id erat.
        //        Etiam ac mauris sed sem eleifend dictum a ut ligula.
        //        Aliquam vel odio quis ex eleifend fermentum.
        //        Etiam sit amet augue eleifend purus porta convallis.
        //        Cras id ante vel urna maximus tincidunt non efficitur est.
        //        Praesent id libero ac nunc lacinia maximus.
        //        Morbi pharetra ex a consequat maximus.
        //        Suspendisse bibendum risus nec varius finibus.
        //        Proin eleifend magna eget quam blandit sollicitudin non id ligula.
        //        Donec sit amet nibh in nulla euismod rhoncus ac non velit.
        //        Nam sed nisl quis massa varius facilisis.
        //        Duis elementum felis ut scelerisque tempor.
        //        Duis convallis neque sed lorem luctus fringilla.
        //        Vivamus sit amet ante eu nisl scelerisque dignissim sed eu ipsum.
        //        Integer ut nibh non arcu tristique condimentum.
        //        Curabitur vel urna quis erat dictum fringilla dignissim vel nibh.
        //        Fusce quis lectus eget enim molestie malesuada.
        //        Fusce quis velit interdum, feugiat lorem ac, egestas tortor.
        //        In pellentesque arcu eu nisi tempor rutrum vel non orci.
        //        In gravida quam sit amet augue interdum sodales.
        //        Integer pellentesque erat aliquam tristique lacinia.
        //        Ut id elit hendrerit, molestie libero at, congue ipsum.
        //        Mauris quis ante ac arcu ultrices laoreet non non felis.
        //        Nam sodales nulla pharetra tempus blandit.
        //        Maecenas non quam eget erat egestas sodales ut at diam.
        //        Aliquam egestas odio id elit dignissim, in pretium felis sodales.
        //        Suspendisse viverra sem id posuere gravida.
        //        Donec ac purus consectetur, dictum enim eget, varius nisl.
        //        Donec a mauris maximus, vestibulum mi et, sodales diam.
        //        Donec ornare nunc sit amet nunc suscipit, at tempus sapien gravida.
        //        Praesent ut libero porta, gravida est ac, vehicula purus.
        //        Sed nec velit sit amet nisl porttitor suscipit ac ut augue.
        //        Sed suscipit turpis in blandit bibendum.
        //        Suspendisse ut nisi id mauris placerat molestie.
        //        Fusce in sapien ut nisl aliquet porttitor efficitur sed velit.
        //        Aenean rhoncus quam in dolor tempus, nec tristique nisl pellentesque.
        //        Mauris accumsan sapien quis quam mollis pretium a pharetra libero.
        //        Nunc ornare nulla eu nisl dignissim, sed efficitur nibh ullamcorper.
        //        Duis ac leo nec libero placerat dapibus.
        //        Sed euismod urna mattis porttitor malesuada.
        //        Curabitur nec enim viverra, commodo lectus pulvinar, interdum est.
        //        Nulla porta augue quis justo imperdiet, sit amet commodo nisi ornare.
        //        Proin dapibus velit auctor dolor eleifend porta.
        //        Aenean finibus tortor nec eros volutpat, nec gravida tellus pulvinar.
        //        Integer dignissim lacus tristique, placerat metus ac, porta orci.
        //        Mauris ut ligula consequat, laoreet velit sit amet, sollicitudin risus.
        //        Aliquam convallis lectus ac nunc auctor, in aliquam sem eleifend.
        //        Curabitur ultrices tellus ac urna fermentum, nec gravida diam fermentum.
        //        Sed eget ante eget erat finibus aliquet.
        //        Aenean ullamcorper metus nec nibh lobortis consectetur.
        //        Donec rutrum nulla et leo mollis, in ultrices ligula tristique.
        //        Donec commodo nisl sed mattis dignissim.
        //        Sed dictum nibh eget sagittis elementum.
        //        In eget elit volutpat, vulputate ipsum sit amet, vehicula enim.
        //        Maecenas tincidunt quam id ligula consectetur, sit amet imperdiet augue ullamcorper.
        //        Cras in leo sit amet sapien imperdiet malesuada ut sed sem.
        //        Nullam ultrices nisi quis facilisis consectetur.
        //        In sit amet sapien vitae massa ultrices egestas in at erat.
        //        Integer porttitor turpis eu leo egestas aliquet.
        //        Cras at elit id libero varius vehicula.
        //        Cras eu purus et lorem cursus ullamcorper.
        //        Praesent vitae quam vitae justo volutpat convallis.
        //        Cras mattis ligula et mi congue tincidunt.
        //        Nulla venenatis magna nec neque tempus commodo.
        //        Donec facilisis metus at pellentesque cursus.
        //        Curabitur feugiat lectus vel nulla imperdiet, placerat lobortis elit condimentum.
        //        Proin sit amet magna quis odio posuere maximus.
        //        Sed eu mauris ac orci posuere varius sed at nibh.
        //        Curabitur quis dolor quis urna convallis tincidunt.
        //        Quisque eget lectus at enim sodales accumsan vel sed orci.
        //        Sed placerat sapien sed enim vehicula varius.
        //        Aenean convallis sem vitae porttitor porttitor.
        //        Morbi id purus eu tellus lacinia facilisis.
        //        Mauris ac leo ut quam porttitor pellentesque.
        //        Praesent aliquam quam non hendrerit pharetra.
        //        Sed ut arcu placerat, consequat est et, consequat felis.
        //        Praesent et est fringilla nisl porttitor feugiat.
        //        Donec eu augue posuere, bibendum dolor a, condimentum quam.
        //        Curabitur lacinia dui in hendrerit consectetur.
        //        Donec iaculis diam ac arcu dignissim, vitae volutpat mauris dictum.
        //        Aenean consectetur elit eget magna ultrices luctus.
        //        Vivamus pulvinar velit vel ligula consequat tincidunt.
        //        Phasellus nec magna tristique, bibendum elit eget, vehicula mi.
        //        Curabitur lacinia lacus vitae rhoncus rutrum.
        //        Cras pulvinar libero vel sagittis bibendum.
        //        Donec ornare risus in lectus ultricies, non varius metus tincidunt.
        //        Ut eu nibh in lectus egestas aliquam.
        //        Nullam ultricies enim vitae eros eleifend sodales.
        //        Cras at dui feugiat, lobortis dolor eget, iaculis lorem.
        //        Nam iaculis velit eu sollicitudin fermentum.
        //        Proin bibendum est mollis, tincidunt nibh elementum, lobortis est.
        //        Vivamus vulputate turpis quis maximus pellentesque.
        //        Praesent consectetur ante ac lectus varius, ac egestas massa tincidunt.
        //        Phasellus bibendum lorem varius pulvinar rutrum.
        //        Aenean finibus arcu a orci ullamcorper, et consequat eros congue.
        //        Morbi sed diam tincidunt, consequat erat nec, interdum mauris.
        //        Ut sed velit vehicula dui sagittis bibendum et eu lectus.
        //        Duis pellentesque tellus in fermentum convallis.
        //        Donec ac arcu non arcu tincidunt fermentum.
        //        Integer dictum felis non nulla tempus volutpat.
        //        Praesent ac est in leo sodales feugiat vel ac ipsum.
        //        Fusce vitae felis dictum, sagittis neque faucibus, venenatis nisi.
        //        Quisque ultrices enim non sodales aliquet.
        //        Aenean in risus luctus, aliquam enim sit amet, iaculis nisi.
        //        Fusce commodo ante ut imperdiet porta.
        //        Cras eu orci imperdiet, blandit sem placerat, maximus turpis.
        //        Donec eu turpis vitae risus ultrices mattis eget rhoncus enim.
        //        Sed tempus lectus et luctus porttitor.
        //        Quisque condimentum risus ac viverra tempus.
        //        Proin tincidunt nunc vel tellus dictum dignissim.
        //        Nam quis erat in magna porttitor gravida.
        //        Quisque hendrerit odio non tempor auctor.
        //        Mauris luctus nunc sed neque viverra, non porta magna pharetra.
        //        Phasellus cursus quam eu volutpat ullamcorper.
        //        Fusce in ipsum vitae sem blandit molestie vitae et neque.
        //        Duis commodo magna in sodales scelerisque.
        //        Donec dignissim felis in nisl suscipit, ut efficitur dui elementum.
        //        Sed fringilla tellus a ligula scelerisque, sed sagittis orci aliquam.
        //        Cras feugiat dui vel augue fringilla, eu sagittis est dignissim.
        //        Sed sit amet odio dapibus, molestie tellus a, varius risus.
        //        Morbi vel elit eu augue ultricies mattis in in sem.
        //        In eget nisi eget nibh porttitor hendrerit eu vel lectus.
        //        Phasellus ultricies ex id nisi euismod pretium.
        //        Phasellus volutpat lectus sit amet risus condimentum, at aliquet sapien interdum.
        //        Aenean in libero scelerisque, malesuada magna eu, imperdiet quam.
        //        Curabitur sollicitudin risus in posuere sollicitudin.
        //        Cras eget enim pretium, congue ligula in, interdum nunc.
        //        Vivamus interdum ipsum eget tristique pulvinar.
        //        Cras ac sem id sem malesuada sagittis.
        //        Sed pretium urna ac sem facilisis convallis.
        //        Duis porta magna nec turpis iaculis elementum.
        //        Donec posuere diam eget congue ultricies.
        //        Maecenas id nulla faucibus, malesuada mi nec, tempus sem.
        //        Maecenas euismod odio fringilla leo tempor auctor.
        //        Donec et massa gravida, tempor tellus eget, lobortis massa.
        //        Ut ac nisi sed orci iaculis sodales.
        //        Nam aliquet elit nec enim luctus, non porttitor mauris ultrices.
        //        Aliquam quis quam quis sem fringilla mollis in et ex.
        //        Mauris iaculis sem sit amet ligula dapibus, bibendum efficitur augue tincidunt.
        //        Vivamus ac dui laoreet, scelerisque sapien id, scelerisque velit.
        //        Morbi dictum nulla ut libero porta, et cursus urna facilisis.
        //        Aenean viverra tellus eu ipsum rhoncus sagittis vel a mi.
        //        Fusce euismod ipsum at eleifend auctor.
        //        Morbi congue nisl nec sem pharetra, eget rhoncus ante lacinia.
        //        Morbi aliquam urna id pellentesque tempor.
        //        Nam scelerisque sem sit amet elit vulputate blandit.
        //        Fusce vulputate ante ac odio fringilla, ac venenatis tortor sollicitudin.
        //        Donec convallis ex porta nisl congue lacinia.
        //        Curabitur egestas massa nec lorem consequat, vehicula elementum purus tincidunt.
        //        Ut euismod nisi eu lacus dapibus porttitor.
        //        Suspendisse in massa vel orci eleifend pharetra.
        //        Fusce sit amet enim eget velit hendrerit dapibus.
        //        Sed eu erat volutpat neque lacinia aliquet a quis justo.
        //        Praesent semper nunc et ultrices sodales.
        //        Praesent eu lacus ut massa fringilla placerat.
        //        Duis suscipit magna ut sapien pellentesque sodales.
        //        In id justo et est volutpat malesuada.
        //        Integer sit amet enim molestie, varius massa vitae, molestie erat.
        //        Etiam ut leo placerat, imperdiet dolor lacinia, mattis dolor.
        //        Nullam quis risus finibus, molestie leo non, ornare turpis.
        //        Quisque sed neque ac metus malesuada posuere non quis neque.
        //        Etiam et mi dignissim, sodales risus ac, facilisis velit.
        //        Etiam condimentum nibh posuere convallis porta.
        //        Nunc tempus nisl et nisi dignissim consectetur.
        //        In id libero congue, condimentum quam quis, pretium sem.
        //        Ut fringilla nulla ut nisl euismod pharetra.
        //        Aenean facilisis neque id nibh vulputate laoreet.
        //        Fusce quis justo et risus faucibus ultrices nec vel lacus.
        //        Donec id lectus vel lorem congue auctor.
        //        Nam ac quam aliquet, pellentesque turpis id, eleifend magna.
        //        Ut vel magna a ligula ultrices pellentesque.
        //        Sed aliquam nibh nec lectus efficitur, vitae hendrerit elit tempus.
        //        Nulla fringilla quam cursus, tristique erat eget, efficitur nunc.
        //        Donec quis purus rhoncus, semper magna a, suscipit metus.
        //        Sed tincidunt erat ac ante imperdiet scelerisque.
        //        Cras porta sapien et arcu viverra ultrices.
        //        Nulla dignissim justo vitae mi pretium, ultricies mollis nunc convallis.
        //        Cras sit amet mauris tincidunt, luctus magna vitae, pharetra orci.
        //        Donec luctus risus interdum dui fringilla fermentum.
        //        Praesent tristique erat nec dolor condimentum mollis.
        //        Morbi eleifend metus at nisi dictum, id imperdiet turpis convallis.
        //        Vivamus accumsan eros dictum nulla volutpat malesuada.
        //        Pellentesque mollis mi non arcu auctor accumsan.
        //        Mauris malesuada erat nec sapien aliquet cursus.
        //        Maecenas ac dui eget ipsum vulputate ornare sit amet eu quam.
        //        Praesent in justo vel nibh ultrices interdum eget vitae eros.
        //        Donec auctor tellus ac lectus porttitor mollis.
        //        Morbi eleifend elit quis nisi aliquet euismod.
        //        Donec nec lacus imperdiet, facilisis urna vitae, auctor risus.
        //        Morbi commodo mauris faucibus felis tempus pulvinar.
        //        Nulla et mauris pellentesque, scelerisque ante ac, mollis erat.
        //        Suspendisse tincidunt dolor eget mi dictum, nec gravida libero sollicitudin.
        //        Donec a orci lobortis, tempus orci ut, lobortis justo.
        //        Aenean feugiat lacus tincidunt congue tristique.
        //        Donec a nisi quis quam lobortis hendrerit.
        //        Aenean pretium quam sodales, euismod ex nec, blandit ipsum.
        //        Aliquam scelerisque tellus malesuada augue viverra suscipit.
        //        Ut gravida risus a risus tempus, et gravida turpis pharetra.
        //        Cras viverra ipsum in augue posuere, eget blandit dui pellentesque.
        //        Fusce non libero molestie, imperdiet lorem hendrerit, mattis ante.
        //        Fusce sagittis nisi ac dignissim interdum.
        //        Cras euismod nunc et purus posuere lobortis.
        //        Proin consectetur magna at risus pharetra, quis efficitur tellus suscipit.
        //        Cras semper mauris id malesuada semper.
        //        Integer consectetur turpis sed purus porttitor viverra vel sed nunc.
        //        Mauris vel nisi sed massa vestibulum convallis.
        //        Nullam a dui in ante euismod rhoncus id porttitor purus.
        //        Nullam volutpat dui vitae efficitur rhoncus.
        //        Donec scelerisque sem quis nunc ullamcorper vehicula.
        //        In viverra est ac nibh consequat, et scelerisque arcu tincidunt.
        //        Maecenas venenatis enim in arcu convallis varius.
        //        Nunc non dolor vitae libero placerat mattis nec ac dolor.
        //        Sed ac orci mattis, tempus lacus in, tempus tortor.
        //        Curabitur elementum neque quis mi tincidunt dictum.
        //        Pellentesque laoreet tortor cursus volutpat luctus.
        //        Vestibulum feugiat arcu in nisi iaculis sagittis.
        //        Suspendisse semper mauris mollis, luctus dolor vel, posuere est.
        //        Donec vulputate dolor quis elit vestibulum porta ullamcorper sed risus.
        //        Sed interdum sapien eu dolor suscipit, at aliquet purus placerat.
        //        Nullam ac est ut odio efficitur maximus et a metus.
        //        Aliquam in nisl sit amet odio elementum aliquam et interdum arcu.
        //        Quisque eu libero lacinia, luctus nisl ac, dignissim mi.
        //        Sed in neque et dolor sagittis hendrerit at non enim.
        //        Vivamus ullamcorper lectus et leo tincidunt accumsan ut et urna.
        //        Suspendisse dignissim urna id augue dapibus, id laoreet nulla dignissim.
        //        Etiam volutpat ipsum at egestas vulputate.
        //        Vestibulum non diam ut elit iaculis facilisis non sed nisi.
        //        Nulla ut justo vitae nibh bibendum suscipit.
        //        Vivamus mattis sem eget felis sodales, eu pellentesque tortor tempor.
        //        Aliquam luctus dui non imperdiet faucibus.
        //        Proin sit amet odio hendrerit, lacinia est in, efficitur massa.
        //        Integer mollis lacus nec pellentesque luctus.
        //        Nunc interdum nibh vitae enim tincidunt, et maximus tortor ultricies.
        //        Maecenas nec purus tempor mi elementum aliquet.
        //        Aenean quis orci in dui efficitur faucibus.
        //        Quisque a tortor porta sapien eleifend consequat.
        //        In rhoncus nisi a risus posuere pharetra.
        //        Ut congue augue nec felis convallis, nec laoreet augue imperdiet.
        //        Duis et magna viverra, tempus mauris a, consectetur est.
        //        Aliquam a risus eget enim ornare facilisis vel lacinia purus.
        //        Nulla et quam et turpis tempor volutpat vitae quis dolor.
        //        Sed tempor diam a nunc scelerisque, eget aliquam lectus aliquet.
        //        Donec non sapien vitae lorem interdum tincidunt.
        //        Fusce non leo eget turpis rhoncus lacinia eu ut nibh.
        //        Ut et purus eget augue euismod consectetur quis a sem.
        //        Aliquam quis massa consequat, pulvinar metus at, malesuada ipsum.
        //        Etiam a sem eu ligula rhoncus tincidunt.
        //        Curabitur euismod est vel malesuada auctor.
        //        Aenean vitae ex a nulla finibus consequat.
        //        Mauris pulvinar turpis id mi sodales, at mollis urna tincidunt.
        //        In pellentesque nulla in feugiat mollis.
        //        Quisque mollis libero consequat condimentum iaculis.
        //        Quisque vel nunc ut nunc euismod laoreet.
        //        Morbi non dui eget ante pharetra rhoncus.
        //        Sed quis felis dignissim, ultrices tortor tempus, porttitor quam.
        //        Etiam elementum elit sit amet felis convallis, nec vulputate dolor consequat.
        //        Duis ac nunc ac leo efficitur faucibus.
        //        Curabitur malesuada ex ultrices ipsum elementum, varius porta quam convallis.
        //        Nam in dolor pretium odio vestibulum sagittis.
        //        Aliquam laoreet diam non velit venenatis faucibus.
        //        Sed in velit pharetra, fringilla magna tincidunt, aliquet ipsum.
        //        Sed in arcu volutpat, scelerisque lectus vitae, porta nunc.
        //        Morbi commodo nisl in sollicitudin commodo.
        //        Quisque vel enim ac sem auctor blandit ut vel lectus.
        //        Etiam ornare purus vitae ullamcorper imperdiet.
        //        Suspendisse id leo eu tellus pharetra vehicula sit amet at sem.
        //        Mauris posuere tellus id orci auctor malesuada.
        //        Pellentesque accumsan ligula ac orci commodo, et luctus arcu condimentum.
        //        In eget diam eu mauris mattis lobortis.
        //        Mauris pretium felis vel dolor varius, vitae volutpat justo malesuada.
        //        Curabitur volutpat felis nec metus aliquam, vitae convallis lectus vehicula.
        //        Curabitur et nibh ornare, aliquet ligula ut, facilisis nibh.
        //        Curabitur vitae est hendrerit, volutpat orci et, porttitor massa.
        //        Mauris consectetur neque at ipsum rhoncus blandit.
        //        Maecenas eu turpis eu diam bibendum facilisis.
        //        Mauris at massa non felis vestibulum efficitur.
        //        Integer accumsan leo sit amet malesuada tristique.
        //        Proin non enim ac orci hendrerit ornare.
        //        Nam pulvinar tellus sed tempus dictum.
        //        Mauris sed augue vel nibh facilisis vulputate convallis et mi.
        //        Sed vestibulum velit in libero posuere tempor.
        //        Suspendisse feugiat lectus sed ligula mattis porta.
        //        Suspendisse quis nunc ut erat vehicula scelerisque.
        //        Sed placerat ante fringilla metus pretium, vel ullamcorper ligula porta.
        //        Duis eu nunc a erat dapibus ultrices sit amet vel leo.
        //        Proin et nibh in leo commodo efficitur et et nibh.
        //        Sed sit amet tortor quis libero ullamcorper pulvinar vel sed risus.
        //        Nam nec augue eget justo vestibulum hendrerit.
        //        Curabitur auctor risus et diam venenatis vestibulum.
        //        Ut hendrerit mauris at nulla auctor tristique.
        //        Donec accumsan sapien sit amet justo viverra molestie.
        //        Mauris cursus tellus a ipsum egestas, vel dapibus risus facilisis.
        //        Donec quis sem hendrerit, dapibus quam sit amet, iaculis risus.
        //        Vestibulum eu nulla id magna congue blandit.
        //        Curabitur suscipit nunc sit amet mattis vehicula.
        //        Fusce hendrerit leo et diam malesuada scelerisque.
        //        Vestibulum ut nibh consequat, consequat leo ac, finibus neque.
        //        Suspendisse non ligula efficitur, scelerisque metus eget, sagittis odio.
        //        In tempus ligula vitae ipsum cursus, ac lobortis mauris maximus.
        //        Proin eget elit ultrices, tincidunt urna sit amet, efficitur nisi.
        //        Fusce ornare dolor vel porta feugiat.
        //        Etiam non nibh interdum, consectetur orci vel, fringilla ipsum.
        //        Sed facilisis tellus id mauris facilisis malesuada.
        //        Proin gravida quam sit amet ipsum suscipit hendrerit.
        //        Aliquam nec justo fringilla, blandit massa vel, mollis justo.
        //        Vivamus et ligula ac velit pulvinar mattis.
        //        Proin bibendum felis vitae sapien consequat, at consequat magna sagittis.
        //        Morbi lobortis purus iaculis, lacinia diam sed, accumsan nulla.
        //        Phasellus nec lectus et ligula scelerisque aliquet non nec odio.
        //        Etiam tristique nulla in nunc hendrerit, in volutpat dui volutpat.
        //        Aliquam et ligula sed odio ultrices bibendum.
        //        Cras accumsan elit in euismod maximus.
        //        Phasellus in leo laoreet purus sodales fermentum nec quis nunc.
        //        Vestibulum sit amet mi rhoncus, pulvinar nisl sed, porttitor sapien.
        //        Duis mattis nisl quis placerat hendrerit.
        //        Proin porttitor augue et semper imperdiet.
        //        Nunc quis enim eget ex ornare convallis.
        //        Aliquam et nisi vulputate, eleifend odio eu, vulputate dolor.
        //        Cras a augue et mauris ultrices fringilla id sed odio.
        //        Nunc a ex id felis laoreet ultrices.
        //        Aliquam rutrum neque in odio convallis placerat.
        //        Pellentesque sed diam dignissim nisi feugiat gravida.
        //        Nulla euismod ex a cursus efficitur.
        //        Vivamus eget diam non risus volutpat gravida.
        //        Donec vulputate ligula nec aliquam blandit.
        //        Vestibulum eu felis et nisi dapibus bibendum.
        //        Donec dapibus erat ac sagittis vulputate.
        //        Suspendisse in tortor tincidunt, lacinia elit vitae, suscipit leo.
        //        Donec molestie libero sed felis interdum, sed dictum justo dictum.
        //        Aliquam eget sem ac ipsum imperdiet luctus.
        //        Sed non augue congue, mattis velit id, fringilla lectus.
        //        Donec vel urna eget ligula imperdiet laoreet.
        //        Nam tincidunt nibh in pulvinar faucibus.
        //        Integer volutpat justo sit amet neque faucibus, sit amet mattis magna iaculis.
        //        Duis tempor ligula in lectus mollis mollis sit amet non quam.
        //        Mauris vulputate mauris eu augue sollicitudin fringilla.
        //        Donec hendrerit tellus vitae tellus consequat, a congue lectus condimentum.
        //        Phasellus et neque quis leo cursus vehicula eu dapibus augue.
        //        Sed faucibus lectus et magna finibus sagittis ut vel metus.
        //        Vivamus at odio porta, vestibulum orci in, finibus leo.
        //        Duis eget sapien at dui faucibus condimentum eget a libero.
        //        Quisque eu nulla ut dui pellentesque volutpat.
        //        Maecenas a mi vestibulum, tempor mi nec, malesuada justo.
        //        Vestibulum condimentum tellus vel augue posuere facilisis.
        //        Nunc facilisis lacus ac ligula pulvinar mattis.
        //        Curabitur blandit urna eu pulvinar tempus.
        //        Suspendisse lobortis velit ut arcu condimentum pulvinar in at libero.
        //        Aenean interdum nibh id tincidunt tristique.
        //        Nullam consequat felis a massa porta volutpat.
        //        Ut id arcu iaculis, suscipit nisi quis, finibus lectus.
        //        Donec vitae massa ut tellus rhoncus laoreet sed nec nulla.
        //        Nulla vel nisl sed turpis congue tincidunt non sed diam.
        //        Morbi scelerisque tellus ut risus bibendum tincidunt.
        //        Mauris vestibulum purus tincidunt hendrerit rutrum.
        //        Vivamus eu risus ut turpis vulputate blandit.
        //        Praesent eget mauris sodales diam faucibus feugiat a ut lorem.
        //        Morbi consectetur eros vel elementum pretium.
        //        Sed nec orci at nunc porttitor rutrum et sit amet erat.
        //        Vestibulum dignissim purus quis accumsan blandit.
        //        Aliquam vitae augue et orci viverra finibus.
        //        Nullam feugiat tortor tempus lacus venenatis porta.
        //        Aliquam egestas lacus ac dictum sollicitudin.
        //        Nunc varius quam vel odio iaculis eleifend.
        //        Praesent euismod leo ut odio auctor, non malesuada justo porta.
        //        Phasellus consectetur lectus vitae massa ultrices, sit amet imperdiet felis fringilla.
        //        Donec porta tortor a fermentum ultrices.
        //        Nam ultricies sem nec odio imperdiet aliquam.
        //        Ut tincidunt metus vulputate enim rhoncus ultrices.
        //        Morbi vestibulum sem at congue finibus.
        //        Fusce vel lacus dignissim tortor posuere porta id vel urna.
        //        Morbi sollicitudin ipsum sed finibus eleifend.
        //        In dapibus libero lacinia justo viverra, sit amet venenatis velit blandit.
        //        Maecenas tempor orci quis gravida consectetur.
        //        Donec et tellus sed lectus posuere cursus.
        //        In tristique ex a blandit tempus.
        //        Donec suscipit mi lacinia interdum accumsan.
        //        Aliquam non est quis eros blandit eleifend et ut sapien.
        //        Cras pretium turpis nec dui iaculis lobortis.
        //        Integer elementum metus in tellus maximus, vel ultricies dolor facilisis.
        //        Fusce eu erat eget eros efficitur viverra.
        //        Quisque viverra orci sed lectus vulputate, vitae rhoncus lectus ultrices.
        //        Vivamus placerat nisl eu sapien feugiat, eu hendrerit justo vestibulum.
        //        Vestibulum vel tortor ac augue tincidunt laoreet quis volutpat risus.
        //        Sed eget urna porta ipsum bibendum blandit.
        //        Maecenas ultrices est vel diam pharetra, id ullamcorper eros euismod.
        //        Quisque malesuada elit vitae nunc maximus, ut convallis massa aliquet.
        //        Integer ornare enim quis porttitor finibus.
        //        Sed id urna condimentum, ornare risus ut, fermentum est.
        //        Fusce scelerisque ex auctor, dignissim quam eu, consectetur elit.
        //        Aenean fringilla nisi sit amet nisl blandit, ultricies tincidunt odio facilisis.
        //        Curabitur vehicula elit sit amet diam semper aliquam.
        //        Curabitur at purus efficitur, vestibulum tellus et, semper sem.
        //        Curabitur nec metus et neque facilisis accumsan.
        //        Fusce nec nibh id dui congue ornare vitae eu eros.
        //        Cras quis eros eu lacus eleifend venenatis.
        //        Sed euismod metus nec est convallis, a rutrum dui porttitor.
        //        Vestibulum ac metus dapibus magna feugiat rhoncus.
        //        Sed a sapien sit amet urna posuere viverra et vel nisi.
        //        Mauris feugiat tellus sit amet interdum iaculis.
        //        Phasellus tincidunt quam ac urna placerat, non sollicitudin arcu tristique.
        //        Sed sit amet orci eget metus ornare fermentum in et ante.
        //        In at arcu nec urna rhoncus vulputate.
        //        Nulla eget ex ut quam dictum lobortis.
        //        Praesent ac enim varius, ullamcorper elit vitae, molestie sem.
        //        Donec at dui mattis, porta nisi in, condimentum libero.
        //        Maecenas in nisl ac augue vulputate dictum nec ut urna.
        //        Aenean ut mi non eros sagittis posuere id eu tellus.
        //        Ut maximus massa eu accumsan convallis.
        //        Etiam scelerisque nulla eu dolor finibus, aliquam finibus risus eleifend.
        //        Fusce vehicula orci vitae orci molestie tincidunt.
        //        Aliquam imperdiet mi sed accumsan volutpat.
        //        Sed fringilla ex sed luctus porttitor.
        //        Mauris vel sapien tincidunt dui ultricies consequat at quis nibh.
        //        Integer eget turpis mattis, finibus tellus eget, eleifend velit.
        //        Etiam tempus lorem sed nulla pretium auctor.
        //        Duis auctor sem sit amet arcu finibus consequat.
        //        Aenean finibus eros vitae nisl gravida porta.
        //        Donec faucibus ex a pretium elementum.
        //        Quisque tincidunt risus a felis ornare, eu pretium sem facilisis.
        //        Morbi efficitur sem quis finibus lacinia.
        //        Donec iaculis lorem sit amet augue congue tincidunt.
        //        Nam vitae metus cursus, dignissim massa ac, congue nulla.
        //        Vivamus eu purus eu sapien dignissim faucibus in volutpat sapien.
        //        Curabitur consequat justo sit amet sapien mattis imperdiet et eu purus.
        //        Aliquam feugiat magna malesuada ante finibus auctor.
        //        Nullam bibendum ex ut augue sollicitudin pulvinar.
        //        Pellentesque gravida quam eget est commodo, non tincidunt nulla gravida.
        //        Vestibulum in quam vel arcu sollicitudin finibus nec non felis.
        //        Vivamus tincidunt risus a sagittis tristique.
        //        Proin sed diam maximus enim ultricies malesuada ac sed velit.
        //        Donec quis odio id sem suscipit dictum et id neque.
        //        Vivamus ut tellus quis massa cursus imperdiet.
        //        Integer sed nunc sed arcu tristique cursus.
        //        Pellentesque commodo nulla placerat risus semper sollicitudin.
        //        In et ex malesuada ligula condimentum lobortis.
        //        Nam ullamcorper metus at magna elementum pretium.
        //        Nulla volutpat velit ac purus consequat posuere.
        //        Vestibulum molestie elit sed est pellentesque convallis.
        //        Fusce pretium lectus semper, rutrum ante vitae, blandit est.
        //        Integer efficitur felis id elit efficitur, non ullamcorper dolor porta.
        //        Nam finibus turpis vel libero accumsan, sit amet congue magna placerat.
        //        Nulla ut metus cursus, posuere erat dapibus, aliquet velit.
        //        Sed nec arcu et diam suscipit commodo sed ut ex.
        //        Quisque gravida orci vitae libero porta lobortis.
        //        Quisque eget odio viverra, pulvinar turpis ut, imperdiet nisi.
        //        Curabitur porttitor ante convallis lectus ornare consequat.
        //        Cras porta orci eu dictum suscipit.
        //        Pellentesque pharetra ipsum mollis eros iaculis, ut ullamcorper erat placerat.
        //        Fusce nec velit eget elit dignissim ultricies.
        //        Aliquam vel tellus non augue eleifend elementum.
        //        Fusce consectetur libero ut tortor volutpat interdum.
        //        Pellentesque eget est eu ante pellentesque sodales id quis lorem.
        //        Nulla hendrerit velit at consectetur vestibulum.
        //        Suspendisse sagittis risus maximus tortor dapibus, laoreet lobortis dolor congue.
        //        Nunc eget neque ut leo iaculis tincidunt vel nec tellus.
        //        Cras sollicitudin quam nec ullamcorper convallis.
        //        Vivamus aliquam mi id augue iaculis suscipit.
        //        Integer hendrerit nisl eget ipsum elementum, ac rhoncus metus dictum.
        //        Ut faucibus lorem id sagittis sagittis.
        //        Maecenas in ipsum posuere, vehicula felis ac, laoreet dolor.
        //        Cras mattis orci et felis aliquet condimentum.
        //        Integer id risus nec arcu vestibulum aliquet id sed sapien.
        //        Ut ac nulla in leo ultricies egestas id nec lacus.
        //        Nulla sed sem sed augue blandit tempor.
        //        Vivamus sit amet lectus a libero sagittis condimentum at vel orci.
        //        Ut porttitor mauris sed leo fringilla pulvinar non tincidunt nisl.
        //        Duis ornare nisi at tortor lobortis tincidunt.
        //        Maecenas tristique odio sed turpis tristique imperdiet vitae non mauris.
        //        Ut vel lectus non dolor lacinia mollis et vel nisl.
        //        Morbi eget tortor quis mauris efficitur blandit.
        //        Vivamus faucibus libero vitae augue viverra commodo.
        //        In tincidunt lorem id vestibulum tristique.
        //        Praesent sodales lectus ac pellentesque volutpat.
        //        Integer et ligula tempor, consectetur magna eget, fringilla sapien.
        //        Fusce commodo libero eget maximus mollis.
        //        Praesent quis risus congue, pharetra nisi ac, fringilla eros.
        //        Etiam at leo vitae nibh tincidunt sagittis.
        //        Vestibulum ut felis eget nibh hendrerit fermentum hendrerit sed ligula.
        //        Pellentesque venenatis lorem non mauris suscipit, in dapibus odio lacinia.
        //        Maecenas tristique orci sed ante congue porta.
        //        Nullam et eros molestie, blandit ante id, maximus massa.
        //        Nunc pretium ligula at ex gravida dignissim quis vitae orci.
        //        Proin faucibus sem et pellentesque eleifend.
        //        Sed vel sem mollis arcu interdum dapibus eu vitae tortor.
        //        Nullam congue urna vitae luctus finibus.
        //        Cras euismod orci at varius pretium.
        //        Maecenas at turpis lobortis, iaculis nisl sed, blandit velit.
        //        Cras ac velit non odio convallis ullamcorper in ut libero.
        //        Etiam maximus lacus semper arcu aliquet, quis consectetur justo mattis.
        //        Ut consequat eros molestie metus pharetra lobortis.
        //        Fusce ut nunc non tortor tincidunt bibendum non ac sapien.
        //        Integer a nisi semper, lobortis dolor ut, consequat nisi.
        //        Mauris sit amet justo eget ligula commodo aliquam sed non justo.
        //        Morbi vel diam non erat gravida tristique vel quis mauris.
        //        In non enim a lectus lobortis mollis id sed ipsum.
        //        Donec et nisl et tellus sollicitudin cursus.
        //        Mauris molestie orci at auctor pharetra.
        //        Phasellus vel diam sed augue faucibus tristique.
        //        Nulla interdum eros ac bibendum cursus.
        //        Integer tempor ex pulvinar quam placerat viverra.
        //        Praesent sit amet felis at est volutpat vulputate a eu ligula.
        //        Generated 150 paragraphs, 3894 words, 28473 bytes of Lorem Ipsum
        //
        //
        //        help@lipsum.com
        if indexPath.row == 0 {
            let largeCell = tableView.dequeueReusableCell(withIdentifier: "LargeTramTableViewCell", for: indexPath) as? LargeTramTableViewCell
            if let station = station {
                largeCell?.stationNameLabel.text = station.name
                if station.trams.count > 0 {
                    let tram = station.trams[0]
                    largeCell?.destinationLabel.text = tram.destination
                    largeCell?.timeLabel.text = tram.waitTime
                } else {
                    largeCell?.timeLabel.text = "No Trams Due"
                }
                largeCell?.retrievedAtLabel.text = station.retrievedAt
            } else {
                largeCell?.stationNameLabel.text = ""
            }
            largeCell?.applyAccessibility(station)
            largeCell?.backgroundColor = color
            return largeCell!
        }
        if let station = station {
            if indexPath.row == station.trams.count {
                let messageBoardCell = tableView.dequeueReusableCell(withIdentifier: "MessageBoardTableViewCell", for: indexPath) as? MessageBoardTableViewCell
                messageBoardCell?.messageBoardLabel.text = station.messageBoard
                messageBoardCell?.backgroundColor = color
                messageBoardCell?.applyAccessibility()
                return messageBoardCell!
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TramCell", for: indexPath)
                let tram = station.trams[indexPath.row]
                cell.accessibilityLabel = "next tram"
                
                cell.textLabel?.text = tram.destination
                
                cell.textLabel?.isAccessibilityElement = true
                cell.textLabel?.accessibilityTraits = UIAccessibilityTraitNone
                cell.textLabel?.accessibilityLabel = "destination name"
                cell.textLabel?.accessibilityValue = tram.destination
                
                cell.detailTextLabel?.text = tram.waitTime
                
                cell.detailTextLabel?.isAccessibilityElement = true
                cell.detailTextLabel?.accessibilityTraits = UIAccessibilityTraitNone
                cell.detailTextLabel?.accessibilityValue = tram.waitTime
                
                cell.backgroundColor = color
                return cell
            }
        }
        return UITableViewCell(style: .default, reuseIdentifier: "Cell")
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 240
        } else if indexPath.row == station?.trams.count {
            return 84
        }
        return 80
    }
}

