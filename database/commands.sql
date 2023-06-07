ALTER TABLE `assets` ADD `hidden` BOOLEAN NOT NULL DEFAULT FALSE AFTER `super_id`;
ALTER TABLE `forms` CHANGE `asset_id` `asset_id` INT(10) UNSIGNED NOT NULL;
ALTER TABLE `forms` ADD CONSTRAINT `asset_foreign_in_form` FOREIGN KEY (`asset_id`) REFERENCES `assets`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `form_fields` ADD CONSTRAINT `form_foreign_in_fields` FOREIGN KEY (`form_id`) REFERENCES `forms`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `users` ADD `admin` BOOLEAN NOT NULL DEFAULT FALSE AFTER `updated_at`;
ALTER TABLE `user_assets` ADD CONSTRAINT `user_foreign_in_user_assets` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `user_assets` ADD CONSTRAINT `asset_foreign_in_user_assets` FOREIGN KEY (`asset_id`) REFERENCES `assets`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `user_forms_data` ADD CONSTRAINT `user_foreign_in_user_form_data` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `user_forms_data` ADD CONSTRAINT `field_foreign_in_user_form_data` FOREIGN KEY (`field_id`) REFERENCES `form_fields`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `user_sub_assets` ADD CONSTRAINT `user_foreign_in_user_sub_assets` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE; ALTER TABLE `user_sub_assets` ADD CONSTRAINT `asset_foreign_in_user_sub_assets` FOREIGN KEY (`asset_id`) REFERENCES `assets`(`id`) ON DELETE CASCADE ON UPDATE CASCADE; ALTER TABLE `user_sub_assets` ADD CONSTRAINT `user_asset_foreign_in_user_sub_assets` FOREIGN KEY (`user_asset_id`) REFERENCES `user_assets`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
CREATE TABLE `notifications` ( `id` INT UNSIGNED NOT NULL , `msg` TEXT NULL , `seen` BOOLEAN NOT NULL DEFAULT FALSE , `user_asset_id` INT UNSIGNED NOT NULL , PRIMARY KEY (`id`), INDEX (`user_asset_id`)) ENGINE = InnoDB;
ALTER TABLE `notifications` ADD CONSTRAINT `user_asset_foreign_in_notifications` FOREIGN KEY (`user_asset_id`) REFERENCES `user_assets`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `notifications` ADD `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `user_asset_id`, ADD `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `created_at`;
ALTER TABLE `notifications` CHANGE `id` `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT;