Return-Path: <linux-edac+bounces-2939-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E48DA18C4E
	for <lists+linux-edac@lfdr.de>; Wed, 22 Jan 2025 07:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE8E163A94
	for <lists+linux-edac@lfdr.de>; Wed, 22 Jan 2025 06:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E39C19259F;
	Wed, 22 Jan 2025 06:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1Iuiltr"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758C77462;
	Wed, 22 Jan 2025 06:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737528636; cv=none; b=RZe6HpGB9ZTmGvWBxmfS4EPuvNhz/v9RRibrvXGHJRVvEds1iDEBk/Eu3Y4uCYV5T5KNMVsp1lFsHoHN5TjjUpqoFjL2+/S/HVke9Y9hghD5awu/bm+7pN+wvFbvtgqPd9LZcB79DtxR4bR4GwdLTvZgXtl9FCPSMWIt5/NRrAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737528636; c=relaxed/simple;
	bh=U7CijA+fgy18RsDn2jpLRhAdMSCVhSQfEyhHKl8jRbw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sOSD3ZH8OgBKktRHv90H2td1mK90zZRNQoslcLa7hTCbDLfUTJohISQZeahrIklFxLR20lEcMk2XIFAsdB2uTH2z8y8E7ZmaNlYzzBmAE9s0DumENG2Pk4qSRYGPMzZzGllou8scF9ScCPofu24OU/KHd8cjmD4e642261eNCAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1Iuiltr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7419C4CED6;
	Wed, 22 Jan 2025 06:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737528635;
	bh=U7CijA+fgy18RsDn2jpLRhAdMSCVhSQfEyhHKl8jRbw=;
	h=From:To:Cc:Subject:Date:From;
	b=T1IuiltrtnNUQebLw/NrUmtXqCYM3HLaU4FesemlaLWVl+HBrckEHULpvcJbwsQK2
	 vfOIYsWEFoJA1MLlpZ3XE/ObiCVP4IcDQLH7nHyJph55J2k5+Raf8DPPNpYk5InGg9
	 XZCdKh5sm75CeBKhNWpiZ5LITcxABzM7fsARsyDaJLM90z5Km1Uce3xeTHbMyfgTbo
	 EVU7M5VbKll/ZRPWZOPkbT2bWces2TOfCbS+V54dwdGMSRr1tuTV19UEWLNiP+7iwe
	 YsxJKt761zs+igDzjORHO6m82ryPeiXhx8RVuYDVhqxtGf3tfZMwgzfkf7OE/FFj4x
	 EApOx9wL5bZpQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Jason Baron <jbaron@akamai.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	James Ye <jye836@gmail.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC/ie31200: work around false positive build warning
Date: Wed, 22 Jan 2025 07:50:26 +0100
Message-Id: <20250122065031.1321015-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc-14 produces a bogus warning in some configurations:

drivers/edac/ie31200_edac.c: In function 'ie31200_probe1.isra':
drivers/edac/ie31200_edac.c:412:26: error: 'dimm_info' is used uninitialized [-Werror=uninitialized]
  412 |         struct dimm_data dimm_info[IE31200_CHANNELS][IE31200_DIMMS_PER_CHANNEL];
      |                          ^~~~~~~~~
drivers/edac/ie31200_edac.c:412:26: note: 'dimm_info' declared here
  412 |         struct dimm_data dimm_info[IE31200_CHANNELS][IE31200_DIMMS_PER_CHANNEL];
      |                          ^~~~~~~~~

I don't see any way the unintialized access could really happen here,
but I can see why the compiler gets confused by the two loops.

Instead, rework the two nested loops to only read the addr_decode
registers and then keep only one instance of the dimm info structure.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/edac/ie31200_edac.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 4fc16922dc1a..b0ccc54dc66a 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -409,10 +409,9 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 	int i, j, ret;
 	struct mem_ctl_info *mci = NULL;
 	struct edac_mc_layer layers[2];
-	struct dimm_data dimm_info[IE31200_CHANNELS][IE31200_DIMMS_PER_CHANNEL];
 	void __iomem *window;
 	struct ie31200_priv *priv;
-	u32 addr_decode, mad_offset;
+	u32 addr_decode[IE31200_CHANNELS], mad_offset;
 
 	/*
 	 * Kaby Lake, Coffee Lake seem to work like Skylake. Please re-visit
@@ -472,17 +471,9 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 
 	/* populate DIMM info */
 	for (i = 0; i < IE31200_CHANNELS; i++) {
-		addr_decode = readl(window + mad_offset +
+		addr_decode[i] = readl(window + mad_offset +
 					(i * 4));
-		edac_dbg(0, "addr_decode: 0x%x\n", addr_decode);
-		for (j = 0; j < IE31200_DIMMS_PER_CHANNEL; j++) {
-			populate_dimm_info(&dimm_info[i][j], addr_decode, j,
-					   skl);
-			edac_dbg(0, "size: 0x%x, rank: %d, width: %d\n",
-				 dimm_info[i][j].size,
-				 dimm_info[i][j].dual_rank,
-				 dimm_info[i][j].x16_width);
-		}
+		edac_dbg(0, "addr_decode: 0x%x\n", addr_decode[i]);
 	}
 
 	/*
@@ -493,14 +484,22 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 	 */
 	for (i = 0; i < IE31200_DIMMS_PER_CHANNEL; i++) {
 		for (j = 0; j < IE31200_CHANNELS; j++) {
+			struct dimm_data dimm_info;
 			struct dimm_info *dimm;
 			unsigned long nr_pages;
 
-			nr_pages = IE31200_PAGES(dimm_info[j][i].size, skl);
+			populate_dimm_info(&dimm_info, addr_decode[j], i,
+					   skl);
+			edac_dbg(0, "size: 0x%x, rank: %d, width: %d\n",
+				 dimm_info.size,
+				 dimm_info.dual_rank,
+				 dimm_info.x16_width);
+
+			nr_pages = IE31200_PAGES(dimm_info.size, skl);
 			if (nr_pages == 0)
 				continue;
 
-			if (dimm_info[j][i].dual_rank) {
+			if (dimm_info.dual_rank) {
 				nr_pages = nr_pages / 2;
 				dimm = edac_get_dimm(mci, (i * 2) + 1, j, 0);
 				dimm->nr_pages = nr_pages;
-- 
2.39.5


