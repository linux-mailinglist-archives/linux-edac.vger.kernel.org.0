Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6842C298CA8
	for <lists+linux-edac@lfdr.de>; Mon, 26 Oct 2020 13:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770040AbgJZMET (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Oct 2020 08:04:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44290 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1770033AbgJZMET (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 26 Oct 2020 08:04:19 -0400
Received: from zn.tnic (p200300ec2f07cc003725ac6034898aff.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:cc00:3725:ac60:3489:8aff])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F164F1EC0284;
        Mon, 26 Oct 2020 13:04:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603713858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bLrpwCHVFQ6Tv/5zMXs45u3n+638KM3UEXDhTvRNR9w=;
        b=MKrTdPbvw5Rn0MlmjPuwOsQizoq/rOEUKMkEEFSVh10vzuLwUfsDXrsJtFqSkZ19qMNaEw
        HTy5lGdjH31+tFlRGaRw+gJVqZN5ZgDGjyN7Zel4bfjIWZIkBHuM+vf3zZxb6DQrJxvSs4
        8muKglKR3z0Npj1s/IWqN04ERtbor3c=
Date:   Mon, 26 Oct 2020 13:04:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jason Baron <jbaron@akamai.com>
Cc:     Raymond Bennett <raymond.bennett@gmail.com>,
        linux-edac@vger.kernel.org
Subject: [PATCH] EDAC: Do not issue useless debug statements in the polling
 routine
Message-ID: <20201026120408.GE22116@zn.tnic>
References: <CAKpodDyWSY+Wt5Q04o5EyjZZU4PFST8U9UNcjwrJZ6C=Tc744g@mail.gmail.com>
 <20201019205658.GI24325@zn.tnic>
 <e0fda286-d8e3-dabb-6cf5-fcd974e048b5@akamai.com>
 <20201020091940.GA11583@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020091940.GA11583@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

They have been spreading around the subsystem by example so remove them
all.

Reported-by: Raymond Bennett <raymond.bennett@gmail.com>
Suggested-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/edac/amd76x_edac.c     | 1 -
 drivers/edac/e752x_edac.c      | 1 -
 drivers/edac/e7xxx_edac.c      | 1 -
 drivers/edac/i3000_edac.c      | 1 -
 drivers/edac/i3200_edac.c      | 1 -
 drivers/edac/i5000_edac.c      | 2 +-
 drivers/edac/i5400_edac.c      | 2 +-
 drivers/edac/i82443bxgx_edac.c | 1 -
 drivers/edac/i82860_edac.c     | 1 -
 drivers/edac/i82875p_edac.c    | 1 -
 drivers/edac/i82975x_edac.c    | 1 -
 drivers/edac/ie31200_edac.c    | 1 -
 drivers/edac/r82600_edac.c     | 1 -
 drivers/edac/x38_edac.c        | 1 -
 14 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/amd76x_edac.c b/drivers/edac/amd76x_edac.c
index 9c6e326b4c14..2a49f68a7cf9 100644
--- a/drivers/edac/amd76x_edac.c
+++ b/drivers/edac/amd76x_edac.c
@@ -179,7 +179,6 @@ static int amd76x_process_error_info(struct mem_ctl_info *mci,
 static void amd76x_check(struct mem_ctl_info *mci)
 {
 	struct amd76x_error_info info;
-	edac_dbg(3, "\n");
 	amd76x_get_error_info(mci, &info);
 	amd76x_process_error_info(mci, &info, 1);
 }
diff --git a/drivers/edac/e752x_edac.c b/drivers/edac/e752x_edac.c
index 313d08018166..ac7c9b42d4c7 100644
--- a/drivers/edac/e752x_edac.c
+++ b/drivers/edac/e752x_edac.c
@@ -980,7 +980,6 @@ static void e752x_check(struct mem_ctl_info *mci)
 {
 	struct e752x_error_info info;
 
-	edac_dbg(3, "\n");
 	e752x_get_error_info(mci, &info);
 	e752x_process_error_info(mci, &info, 1);
 }
diff --git a/drivers/edac/e7xxx_edac.c b/drivers/edac/e7xxx_edac.c
index 75d7ce62b3be..497e710fca3d 100644
--- a/drivers/edac/e7xxx_edac.c
+++ b/drivers/edac/e7xxx_edac.c
@@ -333,7 +333,6 @@ static void e7xxx_check(struct mem_ctl_info *mci)
 {
 	struct e7xxx_error_info info;
 
-	edac_dbg(3, "\n");
 	e7xxx_get_error_info(mci, &info);
 	e7xxx_process_error_info(mci, &info, 1);
 }
diff --git a/drivers/edac/i3000_edac.c b/drivers/edac/i3000_edac.c
index 5c1eea96230c..9065bc4386ff 100644
--- a/drivers/edac/i3000_edac.c
+++ b/drivers/edac/i3000_edac.c
@@ -273,7 +273,6 @@ static void i3000_check(struct mem_ctl_info *mci)
 {
 	struct i3000_error_info info;
 
-	edac_dbg(1, "MC%d\n", mci->mc_idx);
 	i3000_get_error_info(mci, &info);
 	i3000_process_error_info(mci, &info, 1);
 }
diff --git a/drivers/edac/i3200_edac.c b/drivers/edac/i3200_edac.c
index a8988db6d423..afccdebf5ac1 100644
--- a/drivers/edac/i3200_edac.c
+++ b/drivers/edac/i3200_edac.c
@@ -253,7 +253,6 @@ static void i3200_check(struct mem_ctl_info *mci)
 {
 	struct i3200_error_info info;
 
-	edac_dbg(1, "MC%d\n", mci->mc_idx);
 	i3200_get_and_clear_error_info(mci, &info);
 	i3200_process_error_info(mci, &info);
 }
diff --git a/drivers/edac/i5000_edac.c b/drivers/edac/i5000_edac.c
index 1a6f69c859ab..ba46057d4220 100644
--- a/drivers/edac/i5000_edac.c
+++ b/drivers/edac/i5000_edac.c
@@ -765,7 +765,7 @@ static void i5000_clear_error(struct mem_ctl_info *mci)
 static void i5000_check_error(struct mem_ctl_info *mci)
 {
 	struct i5000_error_info info;
-	edac_dbg(4, "MC%d\n", mci->mc_idx);
+
 	i5000_get_error_info(mci, &info);
 	i5000_process_error_info(mci, &info, 1);
 }
diff --git a/drivers/edac/i5400_edac.c b/drivers/edac/i5400_edac.c
index 92d63eb533ae..f76624ee82ef 100644
--- a/drivers/edac/i5400_edac.c
+++ b/drivers/edac/i5400_edac.c
@@ -686,7 +686,7 @@ static void i5400_clear_error(struct mem_ctl_info *mci)
 static void i5400_check_error(struct mem_ctl_info *mci)
 {
 	struct i5400_error_info info;
-	edac_dbg(4, "MC%d\n", mci->mc_idx);
+
 	i5400_get_error_info(mci, &info);
 	i5400_process_error_info(mci, &info);
 }
diff --git a/drivers/edac/i82443bxgx_edac.c b/drivers/edac/i82443bxgx_edac.c
index a2ca929e2168..933dcf3cfdff 100644
--- a/drivers/edac/i82443bxgx_edac.c
+++ b/drivers/edac/i82443bxgx_edac.c
@@ -176,7 +176,6 @@ static void i82443bxgx_edacmc_check(struct mem_ctl_info *mci)
 {
 	struct i82443bxgx_edacmc_error_info info;
 
-	edac_dbg(1, "MC%d\n", mci->mc_idx);
 	i82443bxgx_edacmc_get_error_info(mci, &info);
 	i82443bxgx_edacmc_process_error_info(mci, &info, 1);
 }
diff --git a/drivers/edac/i82860_edac.c b/drivers/edac/i82860_edac.c
index 3e3a80ffb322..fbec90d00f1e 100644
--- a/drivers/edac/i82860_edac.c
+++ b/drivers/edac/i82860_edac.c
@@ -135,7 +135,6 @@ static void i82860_check(struct mem_ctl_info *mci)
 {
 	struct i82860_error_info info;
 
-	edac_dbg(1, "MC%d\n", mci->mc_idx);
 	i82860_get_error_info(mci, &info);
 	i82860_process_error_info(mci, &info, 1);
 }
diff --git a/drivers/edac/i82875p_edac.c b/drivers/edac/i82875p_edac.c
index ceac925af38c..553880b9fc12 100644
--- a/drivers/edac/i82875p_edac.c
+++ b/drivers/edac/i82875p_edac.c
@@ -262,7 +262,6 @@ static void i82875p_check(struct mem_ctl_info *mci)
 {
 	struct i82875p_error_info info;
 
-	edac_dbg(1, "MC%d\n", mci->mc_idx);
 	i82875p_get_error_info(mci, &info);
 	i82875p_process_error_info(mci, &info, 1);
 }
diff --git a/drivers/edac/i82975x_edac.c b/drivers/edac/i82975x_edac.c
index 6be99e0d850d..d99f005832cf 100644
--- a/drivers/edac/i82975x_edac.c
+++ b/drivers/edac/i82975x_edac.c
@@ -330,7 +330,6 @@ static void i82975x_check(struct mem_ctl_info *mci)
 {
 	struct i82975x_error_info info;
 
-	edac_dbg(1, "MC%d\n", mci->mc_idx);
 	i82975x_get_error_info(mci, &info);
 	i82975x_process_error_info(mci, &info, 1);
 }
diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index c47963240b65..9a9ff5ad611a 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -333,7 +333,6 @@ static void ie31200_check(struct mem_ctl_info *mci)
 {
 	struct ie31200_error_info info;
 
-	edac_dbg(1, "MC%d\n", mci->mc_idx);
 	ie31200_get_and_clear_error_info(mci, &info);
 	ie31200_process_error_info(mci, &info);
 }
diff --git a/drivers/edac/r82600_edac.c b/drivers/edac/r82600_edac.c
index 851e53e122aa..d0aef83dca2a 100644
--- a/drivers/edac/r82600_edac.c
+++ b/drivers/edac/r82600_edac.c
@@ -204,7 +204,6 @@ static void r82600_check(struct mem_ctl_info *mci)
 {
 	struct r82600_error_info info;
 
-	edac_dbg(1, "MC%d\n", mci->mc_idx);
 	r82600_get_error_info(mci, &info);
 	r82600_process_error_info(mci, &info, 1);
 }
diff --git a/drivers/edac/x38_edac.c b/drivers/edac/x38_edac.c
index a65e2f78a402..49ab5721aab2 100644
--- a/drivers/edac/x38_edac.c
+++ b/drivers/edac/x38_edac.c
@@ -238,7 +238,6 @@ static void x38_check(struct mem_ctl_info *mci)
 {
 	struct x38_error_info info;
 
-	edac_dbg(1, "MC%d\n", mci->mc_idx);
 	x38_get_and_clear_error_info(mci, &info);
 	x38_process_error_info(mci, &info);
 }
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
