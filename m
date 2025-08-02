Return-Path: <linux-edac+bounces-4503-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E08FB18ADB
	for <lists+linux-edac@lfdr.de>; Sat,  2 Aug 2025 08:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D611AA0A7C
	for <lists+linux-edac@lfdr.de>; Sat,  2 Aug 2025 06:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75D072615;
	Sat,  2 Aug 2025 06:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylemanna.com header.i=@kylemanna.com header.b="HS9KuVFn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bsW+X0GN"
X-Original-To: linux-edac@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1322EB10;
	Sat,  2 Aug 2025 06:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754114588; cv=none; b=LFRACig9hrMiNN5SBFWELWMoEGz8EoCMIpubxx/SXk5EwuaSKIg1CZ7fEktbjA24EF9yMA3m7jUFV0jZMYxV+2rCwJ/9Pu6z9zUZJhwHF4uq8toNIl6Mm9mmlbShZGOCg+yYu7J8xwDMkks4gWezeKYY2OGK1tv8NJ5hCIkdQ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754114588; c=relaxed/simple;
	bh=dqRzS3oNdNgYL1BbnRwJ8OxM6pqlbIxj70KJ4DeZB9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HhHqJ2++3tFdOhAKFo1FIOvQIOr8WWzJNJDM+UJGfcsikNgpDKquose8m3q4h6rjihuRQPRkYrSKE+ZUUvg05MhnHeTt5RLZyPXox5xWJ2CpVu9CvW80ZoJNL01tKA/UyUGtgl+b4cVYk8adHCMpz0Neky4X85UrAcxo1kvKK3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kylemanna.com; spf=pass smtp.mailfrom=core.frozenliquid.net; dkim=pass (2048-bit key) header.d=kylemanna.com header.i=@kylemanna.com header.b=HS9KuVFn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bsW+X0GN; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kylemanna.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=core.frozenliquid.net
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7C0B21400265;
	Sat,  2 Aug 2025 02:03:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 02 Aug 2025 02:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kylemanna.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm3; t=1754114585; x=
	1754200985; bh=KUFRKa0NYaQdqs7+7Do5S63Eu3436TXA2zyqGc8Bu+Q=; b=H
	S9KuVFnYV56buZDC6SBCRcPQheNK5Wd88QjwerhF1NeRUDmvDcdcVm2Dp+hWopI0
	fIwkDYtCHUqSenUzWl/pQMPQrXB0CiASrapS2FjNvH1Tl8YvDR1OoRXHNvIXEacF
	tt/YS7emRHDZoQ7pKE0HB4foLtnzqFZsDewrGOF7mg1QNGv8z1j2QHo27gRXWE9O
	Tgoa6CgursVsZF2acZkW1WHOZBgWoTPX5x1dZQV0NndIkYercCqsRYnTZD5RFUwr
	eTKlXXCaaY6b7oPLMJlJzvcRbtaNzjxuIhsdql67d0saZubMsnmvHJ7+OqUVpJHV
	ZaSWzrfYl1DaMFmazB5GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754114585; x=1754200985; bh=KUFRKa0NYaQdqs7+7Do5S63Eu343
	6TXA2zyqGc8Bu+Q=; b=bsW+X0GNmE1UuDLQOMX6O79V/L40sMRRGSvE4m7O//Ez
	IZaD3mwovDG2XqDH9Eg25+oTizB6KXshruh8OypTWpy0dsMG5sVkNXX+kjppZUzs
	EeQ7/gfOB509YchAkvA1xOSkJZfaGDpye1BGtfNWM45YNKII1KaohUIIXRirq+mV
	sC2PlE3WcOuoM2Qdjyj3XeYc7u9F8/fKywW3UUgbmz3cLQ2N2qNth3qvTa7BiabK
	Bq5IcPrnmwd1DG1UraqJYH1PLD8vz7NUCO52+o0YJw1xhcMZnMmfX9vc1NYKaEF7
	LdSBdmmysApt3nN6FTZEfLudtwckfCNXRIr88kJW3Q==
X-ME-Sender: <xms:GKqNaJfXdBa2E9VUhz3csxzd97bMklCcpaGq8Egu9h8pSD6C-76ozA>
    <xme:GKqNaMsLMIEAKAmCk0ToV0HdfH0--TcZvb-faxj8YrKLXeAZZd-et3CWrqa6FUWS1
    CpORmKmskRcItL18g>
X-ME-Received: <xmr:GKqNaBk5MED6UIGuMk0MMyPKMB2qRUxKnDVn0A89YdZP4z6OrYw3cVuVS3przITJonkHlhCKpT2VLZC1m6PlNufMtLKpIqO6MlnrmFEY8D3nPh6qIi8ofr9szvxuKRjBmgo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdehkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefmhihlvgcuofgr
    nhhnrgcuoehkhihlvgeskhihlhgvmhgrnhhnrgdrtghomheqnecuggftrfgrthhtvghrnh
    eptdfhhedvveegudettdejvdejudelleegtefgtdejtdelhefhvdejgfejvdevueefnecu
    ffhomhgrihhnpehinhhtvghlrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepnhhithhrohestghorhgvrdhfrhhoiigvnhhlihhquhhi
    ugdrnhgvthdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehjsggrrhhonhesrghkrghmrghirdgtohhmpdhrtghpthhtohepsghpsegrlhhi
    vghnkedruggvpdhrtghpthhtohepjhgrmhgvshdrmhhorhhsvgesrghrmhdrtghomhdprh
    gtphhtthhopehjrghmvghsfigvshhtohhnjhgvrhhnihhgrghnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepqhhiuhiguhdriihhuhhosehinhhtvghlrdgtohhmpdhrtghpthhtoh
    epthhonhihrdhluhgtkhesihhnthgvlhdrtghomhdprhgtphhtthhopeihihdurdhlrghi
    sehinhhtvghlrdgtohhmpdhrtghpthhtohepmhgthhgvhhgrsgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhhrihgtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GKqNaHTTecK6LqmzQLlj8kqNH4cHwYfP0QWJxM6bRoPyjvjpjY0g0A>
    <xmx:GKqNaPK-MxvUF-SCiFDscr7KpUye5LQphK6WF2N93py8d56kha9aQQ>
    <xmx:GKqNaJHanXK5T41cveU9lA2BOIaKbNChYDxY5OGHIu2QlDT3TaZnWw>
    <xmx:GKqNaE31rUAlT1zvwgonGT_-_qXaTSaNAGRthng2STOXTag-ezJToA>
    <xmx:GaqNaNdFWSDjZeNUwBxbZUUQdaSSfe2f3A3CDWM9Mzz5XqO4cGVNtneD>
Feedback-ID: iac74403c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Aug 2025 02:03:04 -0400 (EDT)
Received: by core.frozenliquid.net (Postfix, from userid 1000)
	id 98EF61ECB7E3; Fri, 01 Aug 2025 23:03:03 -0700 (PDT)
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
Subject: [PATCH v2] EDAC/ie31200: Add two more Intel Alder Lake-S SoCs for EDAC support
Date: Fri,  1 Aug 2025 23:01:12 -0700
Message-ID: <20250802060112.363506-1-kyle@kylemanna.com>
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


