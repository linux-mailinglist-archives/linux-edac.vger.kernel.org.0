Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20E10132FD6
	for <lists+linux-edac@lfdr.de>; Tue,  7 Jan 2020 20:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgAGTt0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Jan 2020 14:49:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23351 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728364AbgAGTt0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 7 Jan 2020 14:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578426564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=HxUJDEhFNcs+hUXF2On9njjLz8dH2W+TNzkEzpt8JTo=;
        b=BfvITExUZ8fhjlJJ0N93SPC0H/O33GZ5+jziGBYJUAnVcMXnhiVmN0MsqsHUrxdzzJshPj
        HinSfSU38HP4Qyu5JzaYZVUgVB3ocKtZ0pd/B/wGE2CxaaVL2wHjv4Q+k+kiRvoRIMcnBX
        cATFs8R63oZeWmafdEf1iBCDLcVx7TM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-e7fOpscXNb-_bF6llfXdxA-1; Tue, 07 Jan 2020 14:49:21 -0500
X-MC-Unique: e7fOpscXNb-_bF6llfXdxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71DCA6DD5A;
        Tue,  7 Jan 2020 19:49:20 +0000 (UTC)
Received: from napanee.usersys.redhat.com (dhcp-17-195.bos.redhat.com [10.18.17.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 434E985EE6;
        Tue,  7 Jan 2020 19:49:20 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id D1402C1E1A; Tue,  7 Jan 2020 14:49:19 -0500 (EST)
Date:   Tue, 7 Jan 2020 14:49:19 -0500
From:   Aristeu Rozanski <aris@redhat.com>
To:     linux-edac@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH] rasdaemon: fix error handling in ras_mc_event_opendb()
Message-ID: <20200107194919.2h344xrpvammdpn3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Found with covscan that the return value from ras_mc_prepare_stmt() and from
ras_mc_event_opendb() itself aren't checked.

Signed-off-by: Aristeu Rozanski <aris@redhat.com>

diff --git a/ras-events.c b/ras-events.c
index 511c93d..5635278 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -409,8 +409,10 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 	}
 
 	log(TERM, LOG_INFO, "Listening to events for cpus 0 to %d\n", n_cpus - 1);
-	if (pdata[0].ras->record_events)
-		ras_mc_event_opendb(pdata[0].cpu, pdata[0].ras);
+	if (pdata[0].ras->record_events) {
+		if (ras_mc_event_opendb(pdata[0].cpu, pdata[0].ras))
+			goto error;
+	}
 
 	do {
 		ready = poll(fds, (n_cpus + 1), -1);
@@ -584,8 +586,15 @@ static void *handle_ras_events_cpu(void *priv)
 	}
 
 	log(TERM, LOG_INFO, "Listening to events on cpu %d\n", pdata->cpu);
-	if (pdata->ras->record_events)
-		ras_mc_event_opendb(pdata->cpu, pdata->ras);
+	if (pdata->ras->record_events) {
+		if (ras_mc_event_opendb(pdata->cpu, pdata->ras)) {
+			log(TERM, LOG_ERR, "Can't open database\n");
+			close(fd);
+			kbuffer_free(kbuf);
+			free(page);
+			return 0;
+		}
+	}
 
 	read_ras_event(fd, pdata, kbuf, page);
 
diff --git a/ras-record.c b/ras-record.c
index 318bace..549c494 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -713,8 +713,7 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
 		log(TERM, LOG_ERR,
 		    "cpu %u: Failed to initialize sqlite: error = %d\n",
 		    cpu, rc);
-		free(priv);
-		return -1;
+		goto error;
 	}
 
 	do {
@@ -730,66 +729,93 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
 		log(TERM, LOG_ERR,
 		    "cpu %u: Failed to connect to %s: error = %d\n",
 		    cpu, SQLITE_RAS_DB, rc);
-		free(priv);
-		return -1;
+		goto error;
 	}
 	priv->db = db;
 
 	rc = ras_mc_create_table(priv, &mc_event_tab);
-	if (rc == SQLITE_OK)
+	if (rc == SQLITE_OK) {
 		rc = ras_mc_prepare_stmt(priv, &priv->stmt_mc_event,
 					 &mc_event_tab);
+		if (rc != SQLITE_OK)
+			goto error;
+	}
 
 #ifdef HAVE_AER
 	rc = ras_mc_create_table(priv, &aer_event_tab);
-	if (rc == SQLITE_OK)
+	if (rc == SQLITE_OK) {
 		rc = ras_mc_prepare_stmt(priv, &priv->stmt_aer_event,
 					 &aer_event_tab);
+		if (rc != SQLITE_OK)
+			goto error;
+	}
 #endif
 
 #ifdef HAVE_EXTLOG
 	rc = ras_mc_create_table(priv, &extlog_event_tab);
-	if (rc == SQLITE_OK)
+	if (rc == SQLITE_OK) {
 		rc = ras_mc_prepare_stmt(priv, &priv->stmt_extlog_record,
 					 &extlog_event_tab);
+		if (rc != SQLITE_OK)
+			goto error;
+	}
 #endif
 
 #ifdef HAVE_MCE
 	rc = ras_mc_create_table(priv, &mce_record_tab);
-	if (rc == SQLITE_OK)
+	if (rc == SQLITE_OK) {
 		rc = ras_mc_prepare_stmt(priv, &priv->stmt_mce_record,
 					 &mce_record_tab);
+		if (rc != SQLITE_OK)
+			goto error;
+	}
 #endif
 
 #ifdef HAVE_NON_STANDARD
 	rc = ras_mc_create_table(priv, &non_standard_event_tab);
-	if (rc == SQLITE_OK)
+	if (rc == SQLITE_OK) {
 		rc = ras_mc_prepare_stmt(priv, &priv->stmt_non_standard_record,
 					&non_standard_event_tab);
+		if (rc != SQLITE_OK)
+			goto error;
+	}
 #endif
 
 #ifdef HAVE_ARM
 	rc = ras_mc_create_table(priv, &arm_event_tab);
-	if (rc == SQLITE_OK)
+	if (rc == SQLITE_OK) {
 		rc = ras_mc_prepare_stmt(priv, &priv->stmt_arm_record,
 					&arm_event_tab);
+		if (rc != SQLITE_OK)
+			goto error;
+	}
 #endif
 #ifdef HAVE_DEVLINK
 	rc = ras_mc_create_table(priv, &devlink_event_tab);
-	if (rc == SQLITE_OK)
+	if (rc == SQLITE_OK) {
 		rc = ras_mc_prepare_stmt(priv, &priv->stmt_devlink_event,
 					&devlink_event_tab);
+		if (rc != SQLITE_OK)
+			goto error;
+	}
 #endif
 
 #ifdef HAVE_DISKERROR
 	rc = ras_mc_create_table(priv, &diskerror_event_tab);
-	if (rc == SQLITE_OK)
+	if (rc == SQLITE_OK) {
 		rc = ras_mc_prepare_stmt(priv, &priv->stmt_diskerror_event,
 					&diskerror_event_tab);
+		if (rc != SQLITE_OK)
+			goto error;
+	}
 #endif
 
-		ras->db_priv = priv;
+	ras->db_priv = priv;
 	return 0;
+
+error:
+	free(priv);
+	return -1;
 }
 
 int ras_mc_event_closedb(unsigned int cpu, struct ras_events *ras)

