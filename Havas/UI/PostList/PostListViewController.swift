//
//  PostListViewController.swift
//  Havas
//
//  Created by Jordan Liu on 2021-04-10.
//

import UIKit

class PostListViewController: UIViewController {
    private var posts: [PostItem] = []
    private var presenter: PostListPresenter!
    
    @IBOutlet weak var postsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter = PostListPresenter(view: self, router: self)
        
        navigationItem.title = NSLocalizedString("Posts", comment: "")
        
        postsTableView.separatorColor = UIColor.clear
        
        presenter.bindView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.onStart()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension PostListViewController: PostListView {
    func showPostItems(_ posts: [PostItem]) {
        self.posts = posts
        postsTableView.reloadData()
    }

    func showError(_ error: Error) {
        let alert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension PostListViewController: PostListRouter {
    func showPostDetail() {
        let vc = UIStoryboard(name: "PostDetail", bundle: nil).instantiateInitialViewController()
        navigationController?.pushViewController(vc!, animated: true)
    }
}

extension PostListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onPostItemSelected(posts[indexPath.row])
    }
}

extension PostListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! PostTableViewCell
        
        let post = posts[indexPath.row]
        cell.ups = post.ups
        cell.title = post.title
        cell.thumb = post.image
        cell.comment = post.comments
        return cell
    }
    
    
}
