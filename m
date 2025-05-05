Return-Path: <linux-edac+bounces-3833-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDB8AAB073
	for <lists+linux-edac@lfdr.de>; Tue,  6 May 2025 05:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF064E1339
	for <lists+linux-edac@lfdr.de>; Tue,  6 May 2025 03:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6143428B4FC;
	Mon,  5 May 2025 23:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFc3MNHJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14352FB2BA;
	Mon,  5 May 2025 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487407; cv=none; b=ZOv+fciPE4tD7HBiXUTR8qGTNnf3NTr+mYpQ4+nYzTfS2LDRKOq3OjI6rI1jNY72YP88D8vP0wTYHANG2+bohWaW2u/raZQsl7dUQVsseXS1Dyt8nKPC4Ku0ED9Y9XduFJxrWokrNgvNL6a+gNawPd7ngyAgq61uYVHrmxmNYiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487407; c=relaxed/simple;
	bh=dyCX6F2jPhi6g0pJYPEwuDqcq3tMWkUoLJk0fI2gYWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PAaG0RD5HdtL/qkNXOJQn7IFw2g2TwqcwYUfD4qDzISSfoOkqPiAg/I1JPWakmHI67SGJX/RQ4LfwF2IKM/HrNcp1WUXnj9tacHlXv0CauwPR37dWxY9px3JGxqFWbCMsCHsW8zzTFZB4WmkUvXPOsFlC5u43fUhfdhHbgMWLWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFc3MNHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7ADC4CEED;
	Mon,  5 May 2025 23:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487405;
	bh=dyCX6F2jPhi6g0pJYPEwuDqcq3tMWkUoLJk0fI2gYWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tFc3MNHJf9nEyhtFXlJ9WwI9zJZ3tAavU4JDtZM3pWZBA5Te3MvN95rEVPeI39vwi
	 OBIAe0guEl0McZA8Ehz2MGkACad078rJXLyszkv00UDT01qclDW4cmOT2LRbVCxr1c
	 Z2Pkx2EOoKXdFf9OSrhEQEH/mxzpbqDU7BW4yAh708UJoS+mvvdo8sluEIfCQ5B33X
	 hO0g7DY3xh3rHup33LKP/wXEKKmNF5gDEU2XXZg+ZsJY1nRc2DlGAJ17u8/xzNMolw
	 ckCSDDzIop95c3Gk+QMtbv3iNw+ty54aqAYvHY8nRtTKRledavjm0M0cLHxv2Ys/8Q
	 vXrZia38ypmGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jason Baron <jbaron@akamai.com>,
	Tony Luck <tony.luck@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	bp@alien8.de,
	linux-edac@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 52/79] EDAC/ie31200: work around false positive build warning
Date: Mon,  5 May 2025 19:21:24 -0400
Message-Id: <20250505232151.2698893-52-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit c29dfd661fe2f8d1b48c7f00590929c04b25bf40 ]

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

[Tony: Qiuxu pointed out that the "populate DIMM info" comment was left
behind in the refactor and suggested moving it. I deleted the comment
as unnecessry in front os a call to populate_dimm_info(). That seems
pretty self-describing.]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/all/20250122065031.1321015-1-arnd@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/ie31200_edac.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index d3d9916b1ba3f..f865528728d75 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -398,10 +398,9 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
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
@@ -459,19 +458,10 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 		mad_offset = IE31200_MAD_DIMM_0_OFFSET;
 	}
 
-	/* populate DIMM info */
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
@@ -482,14 +472,22 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
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
 				dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms,
 						     mci->n_layers, (i * 2) + 1,
-- 
2.39.5


