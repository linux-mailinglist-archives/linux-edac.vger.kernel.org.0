Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3958869A43C
	for <lists+linux-edac@lfdr.de>; Fri, 17 Feb 2023 04:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjBQDUQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Feb 2023 22:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBQDUP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 16 Feb 2023 22:20:15 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF14523C65;
        Thu, 16 Feb 2023 19:20:14 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1676604013;
        bh=/5qX+O9A1tp723FkL8bmd+mqzvEraJrhq1RUbF5f4Zk=;
        h=From:Date:Subject:To:Cc:From;
        b=RT5/sTKKIPKFzsLMDpwoYW3/Q0uYuFW4C8jx1s7Z/7TwBlfnn+TTYwj79V4fqH4lO
         xLzIPJZ6lt7IuXQL1nkbxx7vRAiUQRkNUl/Up3kWZvUJgV7Ew0K1Gl5j6u0jA15tL3
         UypcFI9i9xasdky7UPAMi0qWDsdvXmVM+eL+zg24=
Date:   Fri, 17 Feb 2023 03:20:05 +0000
Subject: [PATCH] x86/MCE/AMD: Make kobj_type structure constant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230217-kobj_type-mce-amd-v1-1-40ef94816444@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAGTy7mMC/x2N0QrCMAwAf2Xk2UDXOaX+ioikbeaiWzdaFWXs3
 xf2eAfHLVA4Cxe4VAtk/kqRKSnUhwpCT+nBKFEZrLGNsfUZX5N/3t//mXEMjDRGbKi1/hSPzhk
 H2nkqjD5TCr2W6TMMKufMnfz20fW2rhv/aW0ReAAAAA==
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676604011; l=1099;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=/5qX+O9A1tp723FkL8bmd+mqzvEraJrhq1RUbF5f4Zk=;
 b=ePhLtMxHENtY23qr3U+8I6Vtbur9rOSzaQzSpvNcMm5jY9GJfl7xp7VeJA6caJxKhzjwcDvPV
 2N4cst2ug48AyBcBZ5XifzYIOic2gF49rVGEk8Lrgf6rX41A4ifwcIg
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
the driver core allows the usage of const struct kobj_type.

Take advantage of this to constify the structure definition to prevent
modification at runtime.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/x86/kernel/cpu/mce/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 10fb5b5c9efa..1eb2905ac211 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1035,7 +1035,7 @@ static const struct sysfs_ops threshold_ops = {
 
 static void threshold_block_release(struct kobject *kobj);
 
-static struct kobj_type threshold_ktype = {
+static const struct kobj_type threshold_ktype = {
 	.sysfs_ops		= &threshold_ops,
 	.default_groups		= default_groups,
 	.release		= threshold_block_release,

---
base-commit: 3ac88fa4605ec98e545fb3ad0154f575fda2de5f
change-id: 20230217-kobj_type-mce-amd-3a52b6d49909

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

