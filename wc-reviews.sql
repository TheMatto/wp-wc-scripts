-- Compare WooCommerce review count with actual comment count
SELECT `ID`, `wp_postmeta`.`meta_value`, COUNT(`wp_comments`.`comment_ID`) FROM `wp_posts`
INNER JOIN `wp_postmeta` ON `wp_posts`.`ID` = `wp_postmeta`.`post_id`
INNER JOIN `wp_comments` ON `wp_posts`.`ID` = `wp_comments`.`comment_post_ID`
WHERE `wp_postmeta`.`meta_key` = '_wc_review_count' AND `wp_postmeta`.`meta_value` <> '0'
GROUP BY `ID`;

-- Update all WooCommerce review counts with actual comment counts
UPDATE `wp_postmeta`
SET `meta_value` = (SELECT COUNT(*) FROM `wp_comments`
    WHERE `wp_comments`.`comment_post_ID` = `wp_postmeta`.`post_id`)
WHERE `meta_key` = '_wc_review_count';
