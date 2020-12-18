Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A4A2DE733
	for <lists+linux-edac@lfdr.de>; Fri, 18 Dec 2020 17:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgLRQHN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Dec 2020 11:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgLRQHN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 18 Dec 2020 11:07:13 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2C9C0617A7
        for <linux-edac@vger.kernel.org>; Fri, 18 Dec 2020 08:06:32 -0800 (PST)
Received: from zn.tnic (p200300ec2f121000329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:1000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E6F51EC0453;
        Fri, 18 Dec 2020 17:06:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608307590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=ZOYYMxdbJqIF4GCE/QKh9EvhGUlUqWsvSKOhWkBM/R8=;
        b=ZOlDsR8BJ6vvrrmUt/C+B3eIAcf4WerhVGNC0exJcCq9ALeu8HUlHBBQy6lkKiAKN41mtp
        FWBviKCy08g56fXtELYw28wwHbcdHg/vmxACYzTR7kpoaJ21Ksgs7z9x8LJm/mwK+DlAzc
        sYRX7SG6cdVuGVk9r9w3r4ew4J6IKVI=
From:   Borislav Petkov <bp@alien8.de>
To:     linux-edac <linux-edac@vger.kernel.org>
Cc:     Don Curtis <bugrprt21882@online.de>
Subject: [PATCH] EDAC/amd64: Do not load on family 0x15, model 0x13
Date:   Fri, 18 Dec 2020 17:06:22 +0100
Message-Id: <20201218160622.20146-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Those were only laptops and are very very unlikely to have ECC memory.
Currently, when the driver attempts to load, it issues:

  EDAC amd64: Error: F1 not found: device 0x1601 (broken BIOS?)

because the PCI device is the wrong one (it uses the F15h default one).

So do not load the driver on them as that is pointless.

Reported-by: Don Curtis <bugrprt21882@online.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Don Curtis <bugrprt21882@online.de>
Link: http://bugzilla.opensuse.org/show_bug.cgi?id=1179763
---
 drivers/edac/amd64_edac.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f7087ddddb90..5754f429a8d2 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3342,10 +3342,13 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 			fam_type = &family_types[F15_M60H_CPUS];
 			pvt->ops = &family_types[F15_M60H_CPUS].ops;
 			break;
+		/* Richland is only client */
+		} else if (pvt->model == 0x13) {
+			return NULL;
+		} else {
+			fam_type	= &family_types[F15_CPUS];
+			pvt->ops	= &family_types[F15_CPUS].ops;
 		}
-
-		fam_type	= &family_types[F15_CPUS];
-		pvt->ops	= &family_types[F15_CPUS].ops;
 		break;
 
 	case 0x16:
@@ -3539,6 +3542,7 @@ static int probe_one_instance(unsigned int nid)
 	pvt->mc_node_id	= nid;
 	pvt->F3 = F3;
 
+	ret = -ENODEV;
 	fam_type = per_family_init(pvt);
 	if (!fam_type)
 		goto err_enable;
-- 
2.29.2

