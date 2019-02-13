import UIKit

class InvitesListViewController: UIViewController {
    let viewModel = InvitesListViewModel()

    @IBOutlet weak var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchUsers()
        title = Language.appName.localized
    }
}

extension InvitesListViewController: InvitesListViewModelDelegate {
    func usersDidFetch() {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
}

extension InvitesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = InviteTableViewCell.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath) as! InviteTableViewCell

        let data = viewModel.groupedUsers[indexPath.section][indexPath.row]
        cell.textLabel?.text = data.detailedName
        cell.detailTextLabel?.text = data.compactedCoordinate
        return cell
    }

}

extension InvitesListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.groupedUsers[section].count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedUser = viewModel.groupedUsers[indexPath.section][indexPath.row]
        let detailsVC = InviteDetailsViewController(user: selectedUser)
        navigationController?.pushViewController(detailsVC, animated: true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.groupedUsers.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return Language.invitedUsers.localized + " (\(viewModel.groupedUsers[section].count))"
        case 1: return Language.notInvitedUsers.localized
        default: return nil
        }
    }

}
