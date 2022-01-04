Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AF8484001
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jan 2022 11:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiADKij (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jan 2022 05:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiADKij (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jan 2022 05:38:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B258FC061761;
        Tue,  4 Jan 2022 02:38:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9DB6B8119D;
        Tue,  4 Jan 2022 10:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A296C36AEB;
        Tue,  4 Jan 2022 10:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641292715;
        bh=9p28Ox9ppsrvCPiG6eCdGPXGB32/62HzV1YZDd4jkhU=;
        h=From:To:Cc:Subject:Date:From;
        b=hugZ82pK4PwqHSo21VspyRfHScV94/Kc4KJpqQfkG3urlHO99sbHUw7KoY5wTu893
         v+l0+9aibStMMKfnmiyn5puvfmJgYnE/GjESZoun9qsboZiJMFFJyJP4SkrbQbl9+0
         5QAynaFDV5uDb3XXDV/v6Ds+Ud5H7eM66Iq4x8E8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Subject: [PATCH 1/2] EDAC: use proper list of struct attribute for attributes
Date:   Tue,  4 Jan 2022 11:38:21 +0100
Message-Id: <20220104103822.1009971-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3475; h=from:subject; bh=9p28Ox9ppsrvCPiG6eCdGPXGB32/62HzV1YZDd4jkhU=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlXlOd+t3C+Gf6wzoNnaTbr6dLZB7sPcif75t26f/Q8g3Ge O9+xjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZgIfyfD/PrpHMcm6BhldyrX1yQe3r tQ3mRlKMNc6ZUXkpy4/90++bgk5unj3r2pzIJSAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The edac sysfs code is doing some crazy casting of the list of
attributes that is not necessary at all.  Instead, properly point to the
correct attribute structure in the lists, which removes the need to cast
anything and the code is now properly typesafe (as much as sysfs
attribute logic is typesafe...)

Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Robert Richter <rric@kernel.org>
Cc: linux-edac@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/edac_device_sysfs.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index 5e7593753799..f4aefced2ccf 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -163,11 +163,11 @@ CTL_INFO_ATTR(poll_msec, S_IRUGO | S_IWUSR,
 	edac_device_ctl_poll_msec_show, edac_device_ctl_poll_msec_store);
 
 /* Base Attributes of the EDAC_DEVICE ECC object */
-static struct ctl_info_attribute *device_ctrl_attr[] = {
-	&attr_ctl_info_panic_on_ue,
-	&attr_ctl_info_log_ue,
-	&attr_ctl_info_log_ce,
-	&attr_ctl_info_poll_msec,
+static struct attribute *device_ctrl_attr[] = {
+	&attr_ctl_info_panic_on_ue.attr,
+	&attr_ctl_info_log_ue.attr,
+	&attr_ctl_info_log_ce.attr,
+	&attr_ctl_info_poll_msec.attr,
 	NULL,
 };
 
@@ -217,7 +217,7 @@ static void edac_device_ctrl_master_release(struct kobject *kobj)
 static struct kobj_type ktype_device_ctrl = {
 	.release = edac_device_ctrl_master_release,
 	.sysfs_ops = &device_ctl_info_ops,
-	.default_attrs = (struct attribute **)device_ctrl_attr,
+	.default_attrs = device_ctrl_attr,
 };
 
 /*
@@ -389,9 +389,9 @@ INSTANCE_ATTR(ce_count, S_IRUGO, instance_ce_count_show, NULL);
 INSTANCE_ATTR(ue_count, S_IRUGO, instance_ue_count_show, NULL);
 
 /* list of edac_dev 'instance' attributes */
-static struct instance_attribute *device_instance_attr[] = {
-	&attr_instance_ce_count,
-	&attr_instance_ue_count,
+static struct attribute *device_instance_attr[] = {
+	&attr_instance_ce_count.attr,
+	&attr_instance_ue_count.attr,
 	NULL,
 };
 
@@ -399,7 +399,7 @@ static struct instance_attribute *device_instance_attr[] = {
 static struct kobj_type ktype_instance_ctrl = {
 	.release = edac_device_ctrl_instance_release,
 	.sysfs_ops = &device_instance_ops,
-	.default_attrs = (struct attribute **)device_instance_attr,
+	.default_attrs = device_instance_attr,
 };
 
 /* edac_dev -> instance -> block information */
@@ -487,9 +487,9 @@ BLOCK_ATTR(ce_count, S_IRUGO, block_ce_count_show, NULL);
 BLOCK_ATTR(ue_count, S_IRUGO, block_ue_count_show, NULL);
 
 /* list of edac_dev 'block' attributes */
-static struct edac_dev_sysfs_block_attribute *device_block_attr[] = {
-	&attr_block_ce_count,
-	&attr_block_ue_count,
+static struct attribute *device_block_attr[] = {
+	&attr_block_ce_count.attr,
+	&attr_block_ue_count.attr,
 	NULL,
 };
 
@@ -497,7 +497,7 @@ static struct edac_dev_sysfs_block_attribute *device_block_attr[] = {
 static struct kobj_type ktype_block_ctrl = {
 	.release = edac_device_ctrl_block_release,
 	.sysfs_ops = &device_block_ops,
-	.default_attrs = (struct attribute **)device_block_attr,
+	.default_attrs = device_block_attr,
 };
 
 /* block ctor/dtor  code */
-- 
2.34.1

