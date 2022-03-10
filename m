Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A01E4D4409
	for <lists+linux-edac@lfdr.de>; Thu, 10 Mar 2022 10:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240968AbiCJJyY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Mar 2022 04:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241065AbiCJJyP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Mar 2022 04:54:15 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2730D43495;
        Thu, 10 Mar 2022 01:53:01 -0800 (PST)
Received: from zn.tnic (p200300ea97193878fa50b3d92789953a.dip0.t-ipconnect.de [IPv6:2003:ea:9719:3878:fa50:b3d9:2789:953a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 161DB1EC0666;
        Thu, 10 Mar 2022 10:52:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646905974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C7SYYYmumQIkxqqsiGcyl2TiH2G1lYGXE1GrXXcBob8=;
        b=Ii/dYHkpaq43SMEdSWX4MR6Z7g6ssoQ7Tx/VYrv43CcM56pDfFrklpCjuR9prAo6cz1rWr
        mZfHQ/mgz0TpIYt8vWSiaLGQw4VZOJleN8DBJOMvL0ZZYLc1g12X2kGmOp5YYt3L4O5suF
        yRtdP/RYoJIhXH6Nk4Y2K8tE+mfpC2U=
From:   Borislav Petkov <bp@alien8.de>
To:     linux-edac <linux-edac@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] EDAC/mc: Get rid of edac_align_ptr()
Date:   Thu, 10 Mar 2022 10:52:54 +0100
Message-Id: <20220310095254.1510-6-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220310095254.1510-1-bp@alien8.de>
References: <20220310095254.1510-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Get rid of it now that it is unused.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/edac_mc.c     | 55 --------------------------------------
 drivers/edac/edac_module.h |  2 --
 2 files changed, 57 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index b9b298a59f46..387b6851c975 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -170,61 +170,6 @@ const char * const edac_mem_types[] = {
 };
 EXPORT_SYMBOL_GPL(edac_mem_types);
 
-/**
- * edac_align_ptr - Prepares the pointer offsets for a single-shot allocation
- * @p:		pointer to a pointer with the memory offset to be used. At
- *		return, this will be incremented to point to the next offset
- * @size:	Size of the data structure to be reserved
- * @n_elems:	Number of elements that should be reserved
- *
- * If 'size' is a constant, the compiler will optimize this whole function
- * down to either a no-op or the addition of a constant to the value of '*p'.
- *
- * The 'p' pointer is absolutely needed to keep the proper advancing
- * further in memory to the proper offsets when allocating the struct along
- * with its embedded structs, as edac_device_alloc_ctl_info() does it
- * above, for example.
- *
- * At return, the pointer 'p' will be incremented to be used on a next call
- * to this function.
- */
-void *edac_align_ptr(void **p, unsigned int size, int n_elems)
-{
-	unsigned int align, r;
-	void *ptr = *p;
-
-	*p += size * n_elems;
-
-	/*
-	 * 'p' can possibly be an unaligned item X such that sizeof(X) is
-	 * 'size'.  Adjust 'p' so that its alignment is at least as
-	 * stringent as what the compiler would provide for X and return
-	 * the aligned result.
-	 * Here we assume that the alignment of a "long long" is the most
-	 * stringent alignment that the compiler will ever provide by default.
-	 * As far as I know, this is a reasonable assumption.
-	 */
-	if (size > sizeof(long))
-		align = sizeof(long long);
-	else if (size > sizeof(int))
-		align = sizeof(long);
-	else if (size > sizeof(short))
-		align = sizeof(int);
-	else if (size > sizeof(char))
-		align = sizeof(short);
-	else
-		return (char *)ptr;
-
-	r = (unsigned long)ptr % align;
-
-	if (r == 0)
-		return (char *)ptr;
-
-	*p += align - r;
-
-	return (void *)(((unsigned long)ptr) + align - r);
-}
-
 static void _edac_mc_free(struct mem_ctl_info *mci)
 {
 	put_device(&mci->dev);
diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index aa1f91688eb8..96f6de0c8ff6 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -59,8 +59,6 @@ extern void edac_device_reset_delay_period(struct edac_device_ctl_info
 					   *edac_dev, unsigned long value);
 extern void edac_mc_reset_delay_period(unsigned long value);
 
-extern void *edac_align_ptr(void **p, unsigned size, int n_elems);
-
 /*
  * EDAC debugfs functions
  */
-- 
2.29.2

