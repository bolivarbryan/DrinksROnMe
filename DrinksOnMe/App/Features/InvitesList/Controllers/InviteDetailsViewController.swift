import UIKit
import SnapKit
import MapKit

class InviteDetailsViewController: UIViewController {

    var mapView: MKMapView = MKMapView(frame: .zero)

    var userNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    var coordinatesLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textAlignment = .center
        return label
    }()

    let user: User

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(mapView)

        mapView.snp.makeConstraints {
            $0.top.right.left.equalToSuperview()
             $0.height.equalToSuperview().multipliedBy(0.7)
        }

        view.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(24)
        }
        userNameLabel.text = user.name

        view.addSubview(coordinatesLabel)
        coordinatesLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(24)
        }
        coordinatesLabel.text = user.compactedCoordinate
    }

}
