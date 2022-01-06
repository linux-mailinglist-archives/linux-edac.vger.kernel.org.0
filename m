Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C784862C0
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jan 2022 11:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbiAFKPV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jan 2022 05:15:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43242 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbiAFKPV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Jan 2022 05:15:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A801D61ACC;
        Thu,  6 Jan 2022 10:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B729C36AE5;
        Thu,  6 Jan 2022 10:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641464120;
        bh=Acccc+nQYIhw1wmhujPhT2Fi30D77KhYzu2eqMM2vHI=;
        h=From:To:Cc:Subject:Date:From;
        b=gqdE1X9fm8lPRpZHMl5rUKVqs6uamWqYw4J3kN6i7l3ODxldjcohD0akPTV7fB2f+
         a9noXQUHOSLFx4toY9Vv31+JeEeiYS3AIrTJny7Q1xXAM61WtlRWxerypr+lOh81a7
         GqBm7TV4x7ILJJ3Z/keyeG6AUX4L64eZVNKLznXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-edac@vger.kernel.org
Subject: [PATCH] x86/CPU/AMD: use default_groups in kobj_type
Date:   Thu,  6 Jan 2022 11:15:16 +0100
Message-Id: <20220106101516.3309908-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638; h=from:subject; bh=Acccc+nQYIhw1wmhujPhT2Fi30D77KhYzu2eqMM2vHI=; b=owGbwMvMwCRo6H6F97bub03G02pJDInXDhremXUofHt1vJxpx91svfq4c4Jsn9mEz1lP+HTjgtuV vSIrOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAin0IYFmzfwNcmysV1/fgKoYLuU8 W7inm0tjDMD9p0VHTJ0vSTeduTYxd/EA+sbfzYBgA=
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
 arch/x86/kernel/cpu/mce/amd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index fc85eb17cb6d..08c64884b0a5 100644
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
 
-- 
2.34.1

