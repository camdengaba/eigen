import UIKit
import FLKAutoLayout
import Then
import ORStackView
import Artsy_UILabels
import Artsy_UIButtons
import Artsy_UIFonts

protocol SaleOnHoldOverlayViewDelegate {
    func userDidTapDismiss(forSaleOnHoldOverlayView saleOnHoldOverlayView: SaleOnHoldOverlayView)
}

class SaleOnHoldOverlayView: UIView {
    var delegate: SaleOnHoldOverlayViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Set up dark blurring effect
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        addSubview(blurView)
        blurView.align(toView: self)

        let containerView = ORStackView().then {
            $0.backgroundColor = .clear

            let titleLabel = ARSerifLabel()
            titleLabel.font = UIFont.serifFont(withSize: 30)
            titleLabel.text = "This auction is currently on hold"
            titleLabel.textColor = .white
            titleLabel.backgroundColor = .clear
            titleLabel.textAlignment = .center
            $0.addSubview(titleLabel, withTopMargin: "0", sideMargin: "0")

            let subtitleLabel = ARSerifLabel()
            subtitleLabel.text = "You can still place max bids"
            subtitleLabel.textColor = .white
            subtitleLabel.backgroundColor = .clear
            subtitleLabel.textAlignment = .center

            $0.addSubview(subtitleLabel, withTopMargin: "20", sideMargin: "0")
        }
        addSubview(containerView)
        containerView.alignLeading("20", trailing: "-20", toView: self)
        containerView.alignCenterY(withView: self, predicate: "0")

        let button = ARWhiteFlatButton()
        button.setTitle("Got it, thanks", for: .normal)
        button.addTarget(self, action: #selector(userDidTapButton), for: .touchUpInside)
        addSubview(button)
        button.alignLeading("20", trailing: "-20", toView: self)
        button.alignBottomEdge(withView: self, predicate: "-60")
    }

    required init?(coder aDecoder: NSCoder) {
        // Required for Swift compiler.
        return nil
    }

    func userDidTapButton() {
        self.delegate?.userDidTapDismiss(forSaleOnHoldOverlayView: self)
    }
}
