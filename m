Return-Path: <linux-edac+bounces-4606-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9528BB2C954
	for <lists+linux-edac@lfdr.de>; Tue, 19 Aug 2025 18:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA831C22068
	for <lists+linux-edac@lfdr.de>; Tue, 19 Aug 2025 16:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE38520FAAB;
	Tue, 19 Aug 2025 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylemanna.com header.i=@kylemanna.com header.b="Vkjo5JUZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TBsPLC30"
X-Original-To: linux-edac@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BC821FF3B;
	Tue, 19 Aug 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620277; cv=none; b=oQ59BGcaYdfGWACK+oIhFkdkDEx7vNjRfu/bmq0yb29lYZuS2v2kH7CaGZcdZRJDSnqmfZpRKDSFC6p3clFp2HUIYjkZp/aafhDvbf7lHWELB/4G8iwEA1GYW/6fmwvS2oh1ussAPFRMosGf60WGARR7lX+FXpFMFNKU9SjvNJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620277; c=relaxed/simple;
	bh=dqRzS3oNdNgYL1BbnRwJ8OxM6pqlbIxj70KJ4DeZB9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L1+EIMwrGZG+N9gWV/mvK23XxfTzEHjYj5lNl53xWWsD365iYHv80eQcsZukunCrOjHV9S1z2FAchag9y+X2ajPiFPfcht6XX4pNyz4QB6lGcDbltXKp4kbifrP6EJwQsAn5/lWtCbMfDKdXTl5PSZqEtvtTefWP1GLqTnOvhpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kylemanna.com; spf=pass smtp.mailfrom=kylemanna.com; dkim=pass (2048-bit key) header.d=kylemanna.com header.i=@kylemanna.com header.b=Vkjo5JUZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TBsPLC30; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kylemanna.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylemanna.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB5C97A0292;
	Tue, 19 Aug 2025 12:17:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 19 Aug 2025 12:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kylemanna.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm1; t=1755620273; x=
	1755706673; bh=KUFRKa0NYaQdqs7+7Do5S63Eu3436TXA2zyqGc8Bu+Q=; b=V
	kjo5JUZqpNvXGAirBHAMCcyeqaeosNpSULC23jZnPiAjgFoVmp9M6idl3eTHpZpv
	T3Ywz6wGhA59N0PNBN/45PBgc9/4lVyCWARb+0KcDIxFC8eoh4I5D2SpeElPGJIg
	42JoaGIF6EMg4P2lgj9e1rVRUzOOe0TSA4LeRq2hu+pu99WHw6VcnOAH3ptx8J7x
	VueaQnNipzPZ5A/McOb6XhpMmpZUemNS9pcZvM9L+fkjvqkDESdnY0XhHQANpbH4
	DP59IKbSWWAKNtFJJbm9RPaWhxL2+QXQgxx3AUgyNEm1lUJLVBT/fN+xQmOqdUmO
	wR6d4M1Avog3SnAVSOxrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1755620273; x=1755706673; bh=KUFRKa0NYaQdqs7+7Do5S63Eu343
	6TXA2zyqGc8Bu+Q=; b=TBsPLC30/SkfOO2VpT+EVdlZKDdLhOYr+0BbJCbkB1SM
	XF+rmwk8vszAzcOkDFfwqN/1X0E/r0jPss/8365hXSvm6BgGc3zz/WzJeP87JC36
	3UgZw5r+Ni6KvUcbe4kO7YnS7uXp1XSUQ2VP3pxrKqYJVfBy/qJDaxIjSv4OZM9Z
	B+sEKnYOGY00JpX75AlMQQRj7gxKpe1qY4aGhdlDvcUWp088hcMLWhD1KL8xi+8Z
	m9zWI/FSDm/G8eYAE/PshWYKdn5+4KQth+/XJ9JYmOJNjeLksWKBxSgUkSeBTukK
	QpYgKMn1411BUZyw4KAtYcms+ISO2k4QPz82llO7fg==
X-ME-Sender: <xms:saOkaDiUG52LSfZc-DNHU7Q46gOsOayCoh_HZcDnD9-yY4864VU0Dw>
    <xme:saOkaFgCEyYxNM3rdKnGS_5ySTwXRa-turCkF8RxBB8dVDycUSB5RUKcsgbyW1q8L
    NMs1fkM7m03N86cfw>
X-ME-Received: <xmr:saOkaCLhUe7mPST2X9XTnfykwfVNHKw1wUc3adrWE2dsMlURL-N1pEzIs4EIGGjP9yfrGFmeMu0jIhv2G5-RBcziaEN3gYIGluEFST5GpWxb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefmhihlvgcuofgr
    nhhnrgcuoehkhihlvgeskhihlhgvmhgrnhhnrgdrtghomheqnecuggftrfgrthhtvghrnh
    eptdfhhedvveegudettdejvdejudelleegtefgtdejtdelhefhvdejgfejvdevueefnecu
    ffhomhgrihhnpehinhhtvghlrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepkhihlhgvsehkhihlvghmrghnnhgrrdgtohhmpdhnsggp
    rhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihiuddrlh
    grihesihhnthgvlhdrtghomhdprhgtphhtthhopehtohhnhidrlhhutghksehinhhtvghl
    rdgtohhmpdhrtghpthhtohepjhgrmhgvshdrmhhorhhsvgesrghrmhdrtghomhdprhgtph
    htthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehkhihlvgeskhihlhgvmhgr
    nhhnrgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehjsggrrhhonhesrghkrghmrghirdgtohhmpdhr
    tghpthhtohepqhhiuhiguhdriihhuhhosehinhhtvghlrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqvggurggtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:saOkaEl1EtrdQJg-j-d0vWbQvIReq9zziI0eEiM-PVNp-Xf19pU5Fw>
    <xmx:saOkaKME8i4QQ3F30tfIvQGEvTqS6A1OytQ4ZskTaUCWsmTQiIaHXg>
    <xmx:saOkaO6MaoqnhgFDHS5jqYh0nwowRYIfoIBJcpJc4GatSTj3wIbQ5Q>
    <xmx:saOkaOZ00V4xYodMU3WfZA-rzD7Bw43xj--thr6-kBQVqyGpjCKfbw>
    <xmx:saOkaOQwiYvE5FGHQ7N_wdc7ZniMOzKiNy5XsvQBrRYaZn820z-TjuuW>
Feedback-ID: iac74403c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 12:17:51 -0400 (EDT)
Received: from localhost (core [local])
	by core (OpenSMTPD) with ESMTPA id ae6d3953;
	Tue, 19 Aug 2025 16:17:50 +0000 (UTC)
From: Kyle Manna <kyle@kylemanna.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Jason Baron <jbaron@akamai.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: James Jernigan <jameswestonjernigan@gmail.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kyle Manna <kyle@kylemanna.com>
Subject: [PATCH v2 RESEND] EDAC/ie31200: Add two more Intel Alder Lake-S SoCs for EDAC support
Date: Tue, 19 Aug 2025 09:17:39 -0700
Message-ID: <20250819161739.3241152-1-kyle@kylemanna.com>
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
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v2:
- Rebased on top of a6923c06a3b2e2c534ae28c53a7531e76cc95cfa
- Added comments to Device ID definitions as requested
- Added Reviewed-by tag from Qiuxu Zhuo

 drivers/edac/ie31200_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 5c1fa1c0d12e..5a080ab65476 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -99,6 +99,8 @@
 
 /* Alder Lake-S */
 #define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1	0x4660
+#define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_2	0x4668	/* 8P+4E, e.g. i7-12700K */
+#define PCI_DEVICE_ID_INTEL_IE31200_ADL_S_3	0x4648	/* 6P+4E, e.g. i5-12600K */
 
 /* Bartlett Lake-S */
 #define PCI_DEVICE_ID_INTEL_IE31200_BTL_S_1	0x4639
@@ -761,6 +763,8 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_6), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_HX_1), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_ADL_S_1), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_ADL_S_2), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_ADL_S_3), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_BTL_S_1), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_BTL_S_2), (kernel_ulong_t)&rpl_s_cfg},
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_BTL_S_3), (kernel_ulong_t)&rpl_s_cfg},
-- 
2.50.1


