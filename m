Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502524862FB
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jan 2022 11:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbiAFKfm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jan 2022 05:35:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52278 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbiAFKfm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Jan 2022 05:35:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2A7561B40;
        Thu,  6 Jan 2022 10:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B584BC36AE5;
        Thu,  6 Jan 2022 10:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641465341;
        bh=pzYHtW7rDiBGloTUUhaQ7LQqAvbWo8l6BVRCzNEBE4c=;
        h=From:To:Cc:Subject:Date:From;
        b=xGLOTJUnMH5qNBWct+gzIT0L3UXrVPjNytYujZbbexE0z6ShbyExyw1XGDLt6/vvQ
         IHiH39DWyfOTsCxVwO+RhuQKdVuMGopcfVBjEX+Pqg5SleBBjpIRH3/2pl26KxoacC
         V4C22yGbPIADWWMO1pASo5A7+jPK7KaHM88cHQGQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-edac@vger.kernel.org
Subject: [PATCH v2] x86/CPU/AMD: use default_groups in kobj_type
Date:   Thu,  6 Jan 2022 11:35:37 +0100
Message-Id: <20220106103537.3663852-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2323; h=from:subject; bh=pzYHtW7rDiBGloTUUhaQ7LQqAvbWo8l6BVRCzNEBE4c=; b=owGbwMvMwCRo6H6F97bub03G02pJDInXjn5/5/2ii73yZtjEp707u3d62x66dLPrQtbMqOVzvnK9 VPD92RHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQATMXFgmO96bs6OCZ+2ZnaUTxMUa1 jocOak1mSGeVbWxz81LlQ0TjVQ1xXckFAicFYoEwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the AMD mce sysfs code to use default_groups field which
has been the preferred way since aa30f47cf666 ("kobject: Add support for
default attribute groups to kobj_type") so that we can soon get rid of
the obsolete default_attrs field.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-edac@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: fix up direct pointers through the kobj_type to the default_attrs
    The logic here still isn't all that nice, ideally the is_visible()
    callback for the attribute group should be used instead as that is
    what it is for.

 arch/x86/kernel/cpu/mce/amd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index fc85eb17cb6d..a165e8065e7f 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1171,6 +1171,7 @@ static struct attribute *default_attrs[] = {
 	NULL,	/* possibly interrupt_enable if supported, see below */
 	NULL,
 };
+ATTRIBUTE_GROUPS(default);
 
 #define to_block(k)	container_of(k, struct threshold_block, kobj)
 #define to_attr(a)	container_of(a, struct threshold_attr, attr)
@@ -1207,7 +1208,7 @@ static void threshold_block_release(struct kobject *kobj);
 
 static struct kobj_type threshold_ktype = {
 	.sysfs_ops		= &threshold_ops,
-	.default_attrs		= default_attrs,
+	.default_groups		= default_groups,
 	.release		= threshold_block_release,
 };
 
@@ -1279,10 +1280,10 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 	b->threshold_limit	= THRESHOLD_MAX;
 
 	if (b->interrupt_capable) {
-		threshold_ktype.default_attrs[2] = &interrupt_enable.attr;
+		default_attrs[2] = &interrupt_enable.attr;
 		b->interrupt_enable = 1;
 	} else {
-		threshold_ktype.default_attrs[2] = NULL;
+		default_attrs[2] = NULL;
 	}
 
 	INIT_LIST_HEAD(&b->miscj);
-- 
2.34.1

