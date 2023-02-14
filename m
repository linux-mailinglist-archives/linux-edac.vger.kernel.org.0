Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983A8695FF6
	for <lists+linux-edac@lfdr.de>; Tue, 14 Feb 2023 10:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjBNJ4w (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 Feb 2023 04:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjBNJ4N (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 14 Feb 2023 04:56:13 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA57C24CBC;
        Tue, 14 Feb 2023 01:55:56 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 41AAC1EC08BF;
        Tue, 14 Feb 2023 10:55:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676368555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7bGRbUp7nNCsFOKn55St1JRiQ7BHq/0aoTgf8q6Qdcg=;
        b=brj3WGeQt/qR1+3ctwqUSDvLiiFOcRdh+U2yuK+3YmtuOFLRxo6Zp9gHCyWYc1dEbWf930
        fGU/A1tLO0rcqglT/GSCKj9KDA1pCuIzLd9dL30vt5PAjSJz1kPzNOhIgnUoj3t3tQfkGp
        fZkI0WvJQQvMIBqWGCW4023Od/cwuuA=
Date:   Tue, 14 Feb 2023 10:55:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, Tom Rix <trix@redhat.com>,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC/amd64: Shut up an -Werror,-Wsometimes-uninitialized
 clang false positive
Message-ID: <Y+tapzerW7h9vMvp@zn.tnic>
References: <20230213191510.2237360-1-trix@redhat.com>
 <Y+qZthCMRL1m0p4B@yaz-fattaah>
 <Y+qcU2M5gchfzbky@zn.tnic>
 <Y+qdVHidnrrKvxiD@dev-arch.thelio-3990X>
 <03b91ce8-c6d0-63e7-561c-8cada0ece2fe@redhat.com>
 <Y+q1mhrAKTobp3fa@yaz-fattaah>
 <Y+q2pXYI02qAje8N@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+q2pXYI02qAje8N@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Yeah, the code's fine even without this.

What this is fixing is a compiler which is overeager to report false
positives which then get automatically enabled in -Wall builds and when
CONFIG_WERROR is set in allmodconfig builds, the build fails.

It doesn't happen with gcc.

Maybe clang should be more conservative when enabling such warnings
under -Wall as, apparently, this has an impact beyond just noisy output.

  [ bp: Write a commit message. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/Y%2BqdVHidnrrKvxiD@dev-arch.thelio-3990X
---
 drivers/edac/amd64_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1c4bef1cdf28..5b42533f306a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3928,7 +3928,7 @@ static const struct attribute_group *amd64_edac_attr_groups[] = {
 
 static int hw_info_get(struct amd64_pvt *pvt)
 {
-	u16 pci_id1, pci_id2;
+	u16 pci_id1 = 0, pci_id2 = 0;
 	int ret;
 
 	if (pvt->fam >= 0x17) {
-- 
2.35.1


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
