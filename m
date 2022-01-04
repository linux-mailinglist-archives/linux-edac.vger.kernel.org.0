Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61914483FFF
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jan 2022 11:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiADKif (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jan 2022 05:38:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43128 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiADKif (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jan 2022 05:38:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 040BCB8119E;
        Tue,  4 Jan 2022 10:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025F8C36AEB;
        Tue,  4 Jan 2022 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641292712;
        bh=c04HCPShCFb5xmBx0oPpxoySMY6+yKj16CUj2MyWS7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iYXPkTr4d8WmT/YfR85eQyuIn4t3DdJDfvgRyzepJswqSawmK3NH7fFtbQ97xaB0x
         ypNZYGCG7uDRHFM4ye/u3yi2M+5wewnUoEJZEaHcQVhIqnlfyIwr6NpyRfi+Pf6G5K
         M09vVwwPbWQpsZCXCkQUWoCHKH5G1gQu7QvMtikw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Subject: [PATCH 2/2] EDAC: use default_groups in kobj_type
Date:   Tue,  4 Jan 2022 11:38:22 +0100
Message-Id: <20220104103822.1009971-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104103822.1009971-1-gregkh@linuxfoundation.org>
References: <20220104103822.1009971-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3295; h=from:subject; bh=c04HCPShCFb5xmBx0oPpxoySMY6+yKj16CUj2MyWS7M=; b=owGbwMvMwCRo6H6F97bub03G02pJDIlXlOe5rHt18kr4m98V8VHd+qyHuY+Fr011Nr706FhA6yfh W4IKHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRA9cZ5oqI752/2F9Q6sGL/RPnuu c1dyzOV2SYX/Spb7uzbde//6KvuIwmX8/UO2D1BAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the edac sysfs code to use default_groups field which has
been the preferred way since aa30f47cf666 ("kobject: Add support for
default attribute groups to kobj_type") so that we can soon get rid of
the obsolete default_attrs field.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Robert Richter <rric@kernel.org>
Cc: linux-edac@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/edac_device_sysfs.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index f4aefced2ccf..9a61d92bdf42 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -163,13 +163,14 @@ CTL_INFO_ATTR(poll_msec, S_IRUGO | S_IWUSR,
 	edac_device_ctl_poll_msec_show, edac_device_ctl_poll_msec_store);
 
 /* Base Attributes of the EDAC_DEVICE ECC object */
-static struct attribute *device_ctrl_attr[] = {
+static struct attribute *device_ctrl_attrs[] = {
 	&attr_ctl_info_panic_on_ue.attr,
 	&attr_ctl_info_log_ue.attr,
 	&attr_ctl_info_log_ce.attr,
 	&attr_ctl_info_poll_msec.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(device_ctrl);
 
 /*
  * edac_device_ctrl_master_release
@@ -217,7 +218,7 @@ static void edac_device_ctrl_master_release(struct kobject *kobj)
 static struct kobj_type ktype_device_ctrl = {
 	.release = edac_device_ctrl_master_release,
 	.sysfs_ops = &device_ctl_info_ops,
-	.default_attrs = device_ctrl_attr,
+	.default_groups = device_ctrl_groups,
 };
 
 /*
@@ -389,17 +390,18 @@ INSTANCE_ATTR(ce_count, S_IRUGO, instance_ce_count_show, NULL);
 INSTANCE_ATTR(ue_count, S_IRUGO, instance_ue_count_show, NULL);
 
 /* list of edac_dev 'instance' attributes */
-static struct attribute *device_instance_attr[] = {
+static struct attribute *device_instance_attrs[] = {
 	&attr_instance_ce_count.attr,
 	&attr_instance_ue_count.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(device_instance);
 
 /* The 'ktype' for each edac_dev 'instance' */
 static struct kobj_type ktype_instance_ctrl = {
 	.release = edac_device_ctrl_instance_release,
 	.sysfs_ops = &device_instance_ops,
-	.default_attrs = device_instance_attr,
+	.default_groups = device_instance_groups,
 };
 
 /* edac_dev -> instance -> block information */
@@ -487,17 +489,18 @@ BLOCK_ATTR(ce_count, S_IRUGO, block_ce_count_show, NULL);
 BLOCK_ATTR(ue_count, S_IRUGO, block_ue_count_show, NULL);
 
 /* list of edac_dev 'block' attributes */
-static struct attribute *device_block_attr[] = {
+static struct attribute *device_block_attrs[] = {
 	&attr_block_ce_count.attr,
 	&attr_block_ue_count.attr,
 	NULL,
 };
+ATTRIBUTE_GROUPS(device_block);
 
 /* The 'ktype' for each edac_dev 'block' */
 static struct kobj_type ktype_block_ctrl = {
 	.release = edac_device_ctrl_block_release,
 	.sysfs_ops = &device_block_ops,
-	.default_attrs = device_block_attr,
+	.default_groups = device_block_groups,
 };
 
 /* block ctor/dtor  code */
-- 
2.34.1

