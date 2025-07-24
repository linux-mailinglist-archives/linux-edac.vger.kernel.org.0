Return-Path: <linux-edac+bounces-4424-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA35B10104
	for <lists+linux-edac@lfdr.de>; Thu, 24 Jul 2025 08:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C013B2096
	for <lists+linux-edac@lfdr.de>; Thu, 24 Jul 2025 06:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6B821CA1F;
	Thu, 24 Jul 2025 06:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylemanna.com header.i=@kylemanna.com header.b="nOuwXpfe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bxoElTiS"
X-Original-To: linux-edac@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125211F09B3;
	Thu, 24 Jul 2025 06:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339551; cv=none; b=PEMkqJnNHywjjCUdUDCoRBYVDsiaL1sNuuNPJjPYZJzC8VzUzMRfv822m6zAkczbkH1FAwGiQ9lXsRUfyoxa7YBiDSdbAZE+o7bjM3tY0MpQ8oU0USqYM1ZvYBGszAUj43O+tz0z/JEI9O+Nzq25kR1zsGSmYxp125AUDSAB8Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339551; c=relaxed/simple;
	bh=CNTKy5Ekwec43maVw/2PGAUTzfACs4ZdRxFkuNjagx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jtb/AdkgpufWEgDkGFCU/rSYxCenQ1MzMTfqCYY+BwV4XmpQrkZHOOra9a77Cl5nhqjP/WlxhEbIfqNKOdoiSzgbShQvuLf1jwGvfpjtK92YvGqnj6sB6qGUwOH952CnCK7GCdq3godWY65DtskybXFMCuiTTszSD78KWWC34PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kylemanna.com; spf=pass smtp.mailfrom=kylemanna.com; dkim=pass (2048-bit key) header.d=kylemanna.com header.i=@kylemanna.com header.b=nOuwXpfe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bxoElTiS; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kylemanna.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylemanna.com
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0DF26140264D;
	Thu, 24 Jul 2025 02:45:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 24 Jul 2025 02:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kylemanna.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm3; t=1753339548; x=
	1753425948; bh=Qb0coPdRXBvqznDliea1RrAC7V15frrSEXkZB1G3E/Q=; b=n
	OuwXpfe/pwyy8zfQb9i5rO1b5nnI4DV0A2CSyZqQFBgD7qP9W7tsH6ewgtUQ9XN6
	KWDLLcTXebyde7RYX7E0H8foMpPEYxY8LiRabry3ZSw2wP5hcoIjEVsnGyrimT5H
	LSeg7ZI4+ZAYobrT5fc+4K89Z8XQvwnbZuzIaF+jw2XBBYHUj78S8fP2IwBDlFuM
	VMGuyAwWbHElWQaanDIZ4BId3hnP0TpdwIrlAlQVvjumqcX+rN1Nd6CgWSfavQxy
	qrRD8+mI7boMTmnlus2nQ0xcGH/ZywZRs/WAz0Nzm0/jUXjpWGpvvN+KPtlHvMPL
	v2yej0ncA+M/LNbcNzsgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1753339548; x=1753425948; bh=Qb0coPdRXBvqznDliea1RrAC7V15
	frrSEXkZB1G3E/Q=; b=bxoElTiSnRWWpIaue1rJocr/4298DCUJHzkDCLdvkkhF
	nOxMtrsQRdXGCtPAzeUFsNK9ZdKqSLQZ+ETyjnl56Fpv9xlY3pN6ugClHDqjSFno
	L1UePtCv5zr/8mIJ+RlasSYOeuigli9VqYzI8yKbuXjZXF0MEmfyb3gBIG4KTl/G
	7JMAp9GnLTaqjh8fU/iSR3uC0PINPOM4euXJrORU++wQHWn+kHzSM6lvgkVCSTKm
	x+6aHW/EjGorORoUp2IRm2whQQcZjN+rkKVQJqETHGxq29CHNAvS0HsE7ESF7mEf
	l3Nk3zJjjoPFU7EqDpD0FERAYspEjoz6SuyXpHgPtw==
X-ME-Sender: <xms:mtaBaL8OkIO1_RV4ZQGaRlEyHDlR8_eUcxZ9971736aRiZcjcO3h-Q>
    <xme:mtaBaNN3NPIzAQxneLvV5qsrUDatKWyW5SY_43urosG43-J10qBkNhBJfIh7h7QjG
    lPPqLbpuaCJtTE4hg>
X-ME-Received: <xmr:mtaBaIFogd8N9yy_PYFUedruuslwn6ZJMgWjYioZJ85set4Yxd-Nu9v5xZRkeApyoje_3O7avT0RFDT7rN3f6DuhaAEeAPb2UBrC8Za8oUHc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejleeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepmfihlhgvucforghn
    nhgruceokhihlhgvsehkhihlvghmrghnnhgrrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dthfehvdevgedutedtjedvjeduleelgeetgfdtjedtleehhfdvjefgjedvveeufeenucff
    ohhmrghinhepihhnthgvlhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehkhihlvgeskhihlhgvmhgrnhhnrgdrtghomhdpnhgspghr
    tghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhnhidrlh
    hutghksehinhhtvghlrdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhr
    tghpthhtohepjhgsrghrohhnsegrkhgrmhgrihdrtghomhdprhgtphhtthhopehqihhugi
    hurdiihhhuohesihhnthgvlhdrtghomhdprhgtphhtthhopehjrghmvghsfigvshhtohhn
    jhgvrhhnihhgrghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrmhgvshdrmhhorh
    hsvgesrghrmhdrtghomhdprhgtphhtthhopehmtghhvghhrggssehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihiud
    drlhgrihesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:mtaBaLxygmytz7VC-GvuV40hfsLHKeIwf2cdQE1kvP6nR3uMnsJIoA>
    <xmx:mtaBaJpAWobihGkQWSM5eVyprLwye42PKQXlpccaU7256TuvG9iN0g>
    <xmx:mtaBaBn_X-GNavQ8JFIaF22FRPgxlELXaHhctvSv9biHn4sE-0C2Wg>
    <xmx:mtaBaDWziXNlephSsWL8YzpRpKj5hmjvY-a9w0YdU3zYVVlfvPS9Dg>
    <xmx:nNaBaC5Yr5QaxJGCFcpGVLbTF1AMPMUqKiz3L0t4KR5PwOixKA7oPP-j>
Feedback-ID: iac74403c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 02:45:45 -0400 (EDT)
From: Kyle Manna <kyle@kylemanna.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Jason Baron <jbaron@akamai.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Jernigan <jameswestonjernigan@gmail.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kyle Manna <kyle@kylemanna.com>
Subject: [PATCH 1/1] EDAC/ie31200: Add two more Intel Alder Lake-S SoCs for EDAC support
Date: Wed, 23 Jul 2025 23:44:15 -0700
Message-ID: <20250724064415.1134574-1-kyle@kylemanna.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Host Device IDs (DID0) correspond to:
* Intel Core i7-12700K
* Intel Core i5-12600K

See documentation:
* 12th Generation Intel® Core™ Processors Datasheet
    * Volume 1 of 2, Doc. No.: 655258, Rev.: 011
    * https://edc.intel.com/output/DownloadPdfDocument?id=8297 (PDF)

Signed-off-by: Kyle Manna <kyle@kylemanna.com>
---
 drivers/edac/ie31200_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index a53612be4b2f..2078c12bbed2 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -94,6 +94,8 @@
 
 /* Alder Lake-S */
 #define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1	0x4660
+#define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_2	0x4668
+#define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_3	0x4648
 
 #define IE31200_RANKS_PER_CHANNEL	8
 #define IE31200_DIMMS_PER_CHANNEL	2
@@ -741,6 +743,8 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_3), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_4), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_ADL_S_2), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_ADL_S_3), (kernel_ulong_t)&rpl_s_cfg},
 	{ 0, } /* 0 terminated list. */
 };
 MODULE_DEVICE_TABLE(pci, ie31200_pci_tbl);
-- 
2.50.1


