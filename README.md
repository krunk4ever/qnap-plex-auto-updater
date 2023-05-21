# Description
This is a guide to enable auto-updating Plex Media Server on QNAP servers

# Instructions

### Install `jq`
1. Follow [instructions on how to add QnapClub repo](https://www.qnapclub.eu/en/howto/1) to your server.
2. Locate `jq` in the QnapClub app store and install it

<img width="800" alt="plex-qnapclub-jq" src="https://user-images.githubusercontent.com/627860/138809755-20c9e1d5-608b-4807-80ba-23e69492f018.png">

Alternatively, you can install `jq` via Entware.
1. Follow [instructions on adding the MyQnap repo](https://www.myqnap.org/install-the-repo/) to your server.
2. Locate `Entware-std` in the MyQnap app store and install it.
3. SSH into your server and run `./opt/bin/opkg install jq`

### Download and test the script
1. Download the [`qnap-plex-auto-updater.sh`](/qnap-plex-auto-updater.sh) script onto your QNAP server. For this example, I've placed my script in `/share/homes/user/scripts/qnap-plex-auto-updater.sh`
2. Confirm your plex preferences are stored at `/share/PlexData/Plex\ Media\ Server/Preferences.xml`. If they're not, you'll need to update the location in the script. You can find the location of your preferences file by following [these instructions](https://support.plex.tv/articles/202915258-where-is-the-plex-media-server-data-directory-located/#QNAP)
3. Run `chmod +x /share/homes/user/scripts/qnap-plex-auto-updater.sh` so your script can be executed
4. Try running the script to ensure it works: `/share/homes/user/scripts/qnap-plex-auto-updater.sh`

### Schedule the script to run periodically
1. Edit you crontab by opening `/etc/config/crontab` directly in your text editor (e.g. `vi` or `nano`)
2. Add the following line `0 5 * * * /share/homes/user/scripts/qnap-plex-auto-updater.sh`
3. Save the file
4. Restart the crontab daemon: `crontab /etc/config/crontab && /etc/init.d/crond.sh restart`
5. Confirm the auto-updater is scheduled by locating the entry after running `crontab -l`

Note: My schedule has it checking for updates everyday at 5am. It's up to you when and how often you want to run it.

For more detailed instructions, please visit the [QNAP Wiki](https://wiki.qnap.com/wiki/Add_items_to_crontab#Modifying_entries).

# Credits
* Thanks to `fedepesca` for sharing his script on [reddit](https://www.reddit.com/r/PleX/comments/e21a0f/autoupdate_the_qnap_server/fphpgqk/).
* Thanks to [@martinorob](https://github.com/martinorob) for sharing how to enable plex pass channel / betas: [martinorob/plexupdate](https://github.com/martinorob/plexupdate)
