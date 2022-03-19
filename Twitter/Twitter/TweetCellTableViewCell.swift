//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Federico Marti Garro on 3/12/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBAction func retweet(_ sender: Any) {
        let toBeRetweeted = !retweeted
        if (toBeRetweeted) {
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
                self.setRetweeted(true)
            }, failure: { (error) in
                print("Error in retweeting: \(error)")
            })
        }
        else {
            TwitterAPICaller.client?.unretweet(tweetId: tweetId, success: {
                self.setRetweeted(false)
            }, failure: { (error) in
                print("Unretweet did not succeed: \(error)")
            })
        }
    }
    
    @IBAction func like(_ sender: Any) {
        let toBeLiked = !liked
        if (toBeLiked) {
            TwitterAPICaller.client?.likeTweet(tweetId: tweetId, success: {
                self.setLike(true)
            }, failure: { (error) in
                print("Like did not succeed: \(error)")
            })
        }
        else {
            TwitterAPICaller.client?.unlikeTweet(tweetId: tweetId, success: {
                self.setLike(false)
            }, failure: { (error) in
                print("Unlike did not succeed: \(error)")
            })
        }
        
    }
    
    var liked:Bool = false
    var tweetId: Int = -1
    var retweeted:Bool = false
    
    func setRetweeted(_ isRetweeted:Bool) {
        retweeted = isRetweeted
        if (retweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
//            retweetButton.isEnabled = false
        }
        else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
//            retweetButton.isEnabled = true
        }
    }
    func setLike(_ isLiked:Bool) {
        liked = isLiked
        if (liked) {
            likeButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            likeButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
