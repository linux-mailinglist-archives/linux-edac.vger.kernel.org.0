Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D15694F11
	for <lists+linux-edac@lfdr.de>; Mon, 13 Feb 2023 19:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjBMSSW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Feb 2023 13:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjBMSSW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Feb 2023 13:18:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E617E3BD;
        Mon, 13 Feb 2023 10:18:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C62D6B81601;
        Mon, 13 Feb 2023 18:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D0FC433EF;
        Mon, 13 Feb 2023 18:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676312298;
        bh=plxL0IpanD4+o7p9KsPW9YVmlD3aZBjrcEcomkvSXeo=;
        h=From:Date:Subject:To:Cc:From;
        b=PVT0ltpXYv6TCBrFDg6YckuccXtr689CM3M/kU6cXPDLg+Zpv/dzxDFMWU+HwPtDx
         ZOHH9XenDy5rUV13jWfhX983Ky7+tqEN+4ZCVIMKooMwEzIygRRK0rJB/x8oBdAwun
         PaGLPvnuNMCdjgatPyuDnc8LMky8CYnkEP140S4mwZI+h8U8tLJ5t+6CXF+ugL6eeW
         jadEIrtrxpXDWCWv98FViX97xZYttCazpWnibX/afZZTqKwYM05e1E7Ssk8T0WNMjT
         SY3nWfCeLsbJ581/0p+nsmCAJEJNuU/PEAiEGjBVgiEzlm6bpoX6t/VHwirqQjLEBO
         HaF5Wv93uYPxw==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Mon, 13 Feb 2023 11:17:49 -0700
Subject: [PATCH] EDAC/amd64: Avoid clang -Wsometimes-uninitialized in
 hw_info_get()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230213-amd64_edac-wsometimes-uninitialized-v1-1-5bde32b89e02@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMx+6mMC/x2NWwrCMBAAr1Ly7UL6oBCvIiKb7NYumFSyqYqld
 zf1cxiY2YxyFlZzbjaT+SUqS6rQnhoTZkx3BqHKprNdb7u2B4w0DjcmDPDWJXKRyAprkiRF8CF
 fJnCePE2DdW5kU0selcFnTGE+WhG1cD7EM/Mkn//+ct33HxNQiE6OAAAA
To:     yazen.ghannam@amd.com, bp@alien8.de, tony.luck@intel.com
Cc:     james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3027; i=nathan@kernel.org;
 h=from:subject:message-id; bh=plxL0IpanD4+o7p9KsPW9YVmlD3aZBjrcEcomkvSXeo=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDMmv6l6uniDg8sQq4dizTbN7RG+4yPvs9VOSXNAn35Hvs
 2BxJXNpRykLgxgHg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZjInhMM/ysN/X/wLS7UlnBa
 fmhVgcJzBrb4kh5FTo05fTJuPxay1DIy9O5Yl6G8cumZG2eex159l1ryeGnwekNdr00l5kU7pfn
 ncgEA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Clang warns:

  drivers/edac/amd64_edac.c:3936:7: error: variable 'pci_id1' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
                  if (!pvt->umc)
                      ^~~~~~~~~
  drivers/edac/amd64_edac.c:3943:37: note: uninitialized use occurs here
          ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
                                             ^~~~~~~
  ...
  drivers/edac/amd64_edac.c:3936:7: error: variable 'pci_id2' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
                  if (!pvt->umc)
                      ^~~~~~~~~
  drivers/edac/amd64_edac.c:3943:46: note: uninitialized use occurs here
          ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
                                                      ^~~~~~~

This is technically a false postive, as it is not possible for pci_id1
or pci_id2 to be used in reserve_mc_sibling_devs() when pvt->umc is not
NULL, since it returns right away. However, clang does not perform
interprodecural analysis for this warning, so it cannot tell that from
the way the code is currently written.

To silence the warning, reduce the scope of the local variables and the
call to reserve_mc_sibling_devs() to the else branch, which will not
functionally change anything.

Link: https://github.com/ClangBuiltLinux/linux/issues/1803
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
I left the check for 'pvt->umc' alone in reserve_mc_sibling_devs() in
case it was ever called from a different path but if I should remove, I
am happy to do so in another revision.

Since this is technically a false positive, I did not include fixes
tags. If they are so desired:

Fixes: 6229235f7c66 ("EDAC/amd64: Remove PCI Function 6")
Fixes: cf981562e627 ("EDAC/amd64: Remove PCI Function 0")
---
 drivers/edac/amd64_edac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1c4bef1cdf28..a9dd66988b1d 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3928,21 +3928,21 @@ static const struct attribute_group *amd64_edac_attr_groups[] = {
 
 static int hw_info_get(struct amd64_pvt *pvt)
 {
-	u16 pci_id1, pci_id2;
-	int ret;
-
 	if (pvt->fam >= 0x17) {
 		pvt->umc = kcalloc(fam_type->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
 		if (!pvt->umc)
 			return -ENOMEM;
 	} else {
+		u16 pci_id1, pci_id2;
+		int ret;
+
 		pci_id1 = fam_type->f1_id;
 		pci_id2 = fam_type->f2_id;
-	}
 
-	ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
-	if (ret)
-		return ret;
+		ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
+		if (ret)
+			return ret;
+	}
 
 	read_mc_regs(pvt);
 

---
base-commit: c4605bde334367b22bbf43cbbef0d1b7c75433dc
change-id: 20230213-amd64_edac-wsometimes-uninitialized-9bdbdf40996e

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

