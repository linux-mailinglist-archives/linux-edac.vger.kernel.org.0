Return-Path: <linux-edac+bounces-5692-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHGBBLHdgGleCAMAu9opvQ
	(envelope-from <linux-edac+bounces-5692-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 02 Feb 2026 18:24:01 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A145CF8E0
	for <lists+linux-edac@lfdr.de>; Mon, 02 Feb 2026 18:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0328A301A709
	for <lists+linux-edac@lfdr.de>; Mon,  2 Feb 2026 17:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85575385538;
	Mon,  2 Feb 2026 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tzBIXpXE"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010069.outbound.protection.outlook.com [40.93.198.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEF73815F8;
	Mon,  2 Feb 2026 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770052936; cv=fail; b=MpI7jd7DTLFYsHWbtifeQL6ZF+WBnK6UuIszNUwVP+5RVf6kLTTABOV8X4iMEx4DobNNgCi8E7hW7i4ymTaM622fEMt840bbB8LPhMMdRaI3JK0e+DAvD3emPYbSNlStHFoMlk0imBBbHKYX71ofiulDN6VWo07BGN+pY9l/emM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770052936; c=relaxed/simple;
	bh=dyZ+FhHgDmr1IDON3CjegDQxWsYWyHv7jTZno/4GVIM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wnsm60/LG6sJnfskrN90Hk7hZ0arIFpJJNryU1iWU0hA9eeg8DbNDZOj4qgSe7hTaqm6qIWyLDO4P1bXvMX5hgz5mkGV1dMI5Jr2tQNwUdgtkzknJkPEEDOeoxATLyPXtfudg+ZWq01JoIyprfBCD2zE6jXuBdCcX6O608l2bhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tzBIXpXE; arc=fail smtp.client-ip=40.93.198.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCP3R4ARhtJtBfv15Lcn+quKPT69Hq3NNEn8lpLzeFjrNDrI4MIb3pI8tx7cNHN4UomImJrmV+PMT4vt+7olJ5myYnwJD9UZr/S20EizWZ+xy5gaEClEzaAwuWMgicnWaIC4Ang1JF66WZviOjmQfEC9Pym3JY3/wlg2Hjfo+efztoSJBr8aLQxNz6Bra/sg+NaeKWS0iO2BsreQK0igGA/mxuejebuw/KLCtrpJKiV00s5j43D57Z0XSWCWL+fq3B1iDZrnLG6sqJhPWoZ1Mq1YrKYopsHG+XJnRsfkjwzeNABnUGvRHfqHwH2u6lsyYupzDpSE+Irleen47iUqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SONZD8PQW+oagtN/PbH9jukmxGc/GD8RvkpoXKHKTs=;
 b=KYKjKNl2xJC5UgOAYVZBnjy+W34ahaDm0G4A7JKNh0om/8pnGYPh3Nf0K1EStn1eHwHJTimsGSi/HtnNQ40Kp75DONLUw6ES/Szb+e7Xa5IDV+kTU1t5Mbc88JlfeIJLhAfZjZNeb6RgLahoqjYQaZ6ZIlH49SMMMeK9Lp6EIh5PqkJB0hR4Deb/j0Leht0W7Uqyfj3o5p/7R3V1p+R+wPI+H11hyzmPz+VDt3zzV/Y9cIQrTER1PzViz7VCGopc1GDmfuZEljxBKX1bu67UaVLUaeLCAsiNDKgdG29JYH9hQyMv9JiAvoe0+dGrY1GeqoGCpO7qjjcN6AGObis0AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SONZD8PQW+oagtN/PbH9jukmxGc/GD8RvkpoXKHKTs=;
 b=tzBIXpXEAhLMEVe3tAM3rjLdhkIlKgQ/Oj4eAtoC9rxmdRyqU3NhHddVoPChwPMoWDQi+MJDvt7/rD8qtRebe9QVkybfZhkcqUEQJiEAoGBqvSSLrP3xiHYuEMoE9q3StJ3qEsKv9Xko/q2ZZ/0r/ylUgP/J5p4M169BgUam7KQ=
Received: from DM6PR10CA0036.namprd10.prod.outlook.com (2603:10b6:5:60::49) by
 DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Mon, 2 Feb 2026 17:22:11 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::4f) by DM6PR10CA0036.outlook.office365.com
 (2603:10b6:5:60::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 17:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 17:22:11 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 11:22:10 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] x86/mce/amd, EDAC/mce_amd: Add new SMCA bank types
Date: Mon, 2 Feb 2026 17:21:58 +0000
Message-ID: <20260202172158.2455749-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 887ba477-ddf2-469b-14e0-08de627f99d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rcifVeZE//GAbiiSpa9mNV7DyzBw+rsgo3TkBIXkj5DAUi6D7n+YbIEhg0uU?=
 =?us-ascii?Q?8WhouvJx8xbkjnCjFD4D1qN1u1nwtrlYHyW/chmfKl1lNnHq8wx0EL/sLilh?=
 =?us-ascii?Q?dNDiKpElrf99Tv78RTrh7k4pidx/pmyac2/FsGSBfLiATCB4bCnaNOT3Qc19?=
 =?us-ascii?Q?bcrbOUArbFx//6IR4EU0ZYSndG1K6S7fm5mHJoYD10PNFW1vl5+BOR2UB6Eh?=
 =?us-ascii?Q?aYb65kmv4dEw0CXDz9rZ79rywnPWLARouBcMTpwLF3syRKPUVuq3NuJdP7kC?=
 =?us-ascii?Q?Ocv3mlSl91gk0pFEb05PDJqmme7ME5d7UpOLkgie++l1k/xbbQk6pvg1pfpj?=
 =?us-ascii?Q?R6Bvlhf5yTl0Tb34IGEJhSyWyHnihR3bc0IRcZA5c7HwlpYs3YHmSswWcEwH?=
 =?us-ascii?Q?JcvXdmLluK6rMghqMPXVlaahC/esFGshSLMKxB4rOKuGkq1oplnydT9rBKir?=
 =?us-ascii?Q?8Rw5G4S6iCnIagN9TeaxO0XTpgBPPxdPdwK+r9jYWES6jLRBGd8T9vKpAio/?=
 =?us-ascii?Q?wdTFRVdPaMfx5mikHpblb5hP/Q1e5kLbeHQaoH8YWXecNlLXexehf9pTokgi?=
 =?us-ascii?Q?Q0Ntee3c7rNwAjrKKtgD0Rf1TYKi8RBFwoU5z1mOnk/CBHuzhiRP7uwlvpZk?=
 =?us-ascii?Q?safenyJ4c2I+aLL7yX+9XxBE2HBn7mk96lJEbJCE0/64jMg4LVmXslnZVAI1?=
 =?us-ascii?Q?1kcpqIORFIYEjoBoxMquUK4QiJko2gQHRtphi7WDp+CmDjLarRhr4WYkS5ID?=
 =?us-ascii?Q?1NUH7JlYlorjCOBViydpNvj35VbX/tHPYreTbwNQhTss4chsweyYrlE2Q3c3?=
 =?us-ascii?Q?cdxrW8l1+8vX7O/oUKlG3gXAXkgIc/vholVm8/fLJ0nVT2B55Pk2mlr1uIIY?=
 =?us-ascii?Q?7mY4lGbjIU7jBp9NaUOdABdQHhP8QXoHZD3xWUPiukf/sANKbh7j+fP9QX/8?=
 =?us-ascii?Q?9jKmKPsqgaulCR6R+Hly6OWaLEcHOqFGDiG74BlZ5ZD18OOwRzSoNd98P/Zh?=
 =?us-ascii?Q?SgZimz+1G0oQ7O4tr+MoJk3rQc+l+3NBm40WkosTKnfRNXX/AEfk2X693IYt?=
 =?us-ascii?Q?2FWeVahJ8swc6SZO6AtbFmcM03Q1rb/eWIihDTci7ju+NHDC+MELhGGQBuWI?=
 =?us-ascii?Q?zYUnfwPcaY72hn/1JpAYAQesYoU2jtpdjwxt+5e49dVj+GUD1w6UmZo1kDJO?=
 =?us-ascii?Q?2Md7+FFWKAhSYFlYqBWmzANo/ShIkPGVoSf4uArW0bV/a4HuPFTJkDKtkLhy?=
 =?us-ascii?Q?lBlQ9Wb96dWZTbxVFUcAYe0Pph+tSjibes8aBTzNFpDQlSg4ZH8u1vYgpzp6?=
 =?us-ascii?Q?5eTk0w/ZxEUGP/OI0bujCx9hxgsVj7X/NBn0pAJ37QWpcALQm6ZQgBUNN/kf?=
 =?us-ascii?Q?Nm4JhU2gROgdkYv87EuroFNaGt0u/TvX5wFn08G/Zfv5Xfl1C5EvjywCA2yC?=
 =?us-ascii?Q?WV+oEhYn/xPQSq+G1rJOQ+nItnGiL9E7EDTFaIxB4jFTaNmKrUxzSSmY5OJq?=
 =?us-ascii?Q?3zHhP71aDN4CamANlD6RIHSRfB4OtYt7f9946+X7EuistdGCxxDIcwLp7sJ0?=
 =?us-ascii?Q?6MT/w/ZeOXUe5y9Nur3ThqRCSQo7vDHaXz8pRDq3E3f8rPbdJeaspv2sk+Yd?=
 =?us-ascii?Q?N5yn3g8WZfx310l/LBsMa5PWavwAT5cVUqqhlu07FrBebVHZ/zhe9vHR16sY?=
 =?us-ascii?Q?YgvXsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oOzih62DUdHqMB0qBmAJ8Yz7cUXIQlk48A9R6YHkX9tooAXUA4jxT42VwsFJxjRzcodO8V4xrwzOVcAvEPmSqmZLqqkrNd8P2cgYnQgBXfMxcjGvZSAhZLX0HQBM0xkMxKtYVD4wD55/LjVJLv8TXboJDv9/DjC1H0Q5KR6zU6I57vjf6/5rF4kVaPtueRYLkdv3ZNXxwf3I4zuV5a2tO/0njqc+qO+MiG3FznXkFPRw0p6mghIAvrlumMgeKA1LQL5jH1ZhbOjb+mFpgxUaD4BTc9vnTR5iBbiDF4oHE4xsi0F1MHdbkKrJyJLyVULXDMr4hm5wXZf8Oc/u53Ek9eL0s5oR47Osrm538xv9PhQS9Oa1x6Cb3A6wvduDh/Oz6JWQgFkrcTY8kLYhRPH7fVejfaQ001WchIepVoMg7sTIKMpLJgRyCCKtW+kJGwjF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:22:11.4001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 887ba477-ddf2-469b-14e0-08de627f99d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5692-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yazen.ghannam@amd.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	TAGGED_RCPT(0.00)[linux-edac];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6A145CF8E0
X-Rspamd-Action: no action

Recognize new SMCA bank types and include their short names for sysfs
and long names for decoding.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h    | 11 +++++++++++
 arch/x86/kernel/cpu/mce/amd.c | 21 +++++++++++++++++++++
 drivers/edac/mce_amd.c        | 10 ++++++++++
 3 files changed, 42 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 2d98886de09a..6e1f10ca053f 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -370,13 +370,24 @@ enum smca_bank_types {
 	SMCA_NBIO,	/* Northbridge IO Unit */
 	SMCA_PCIE,	/* PCI Express Unit */
 	SMCA_PCIE_V2,
+	SMCA_MPRAS,	/* MP for RAS */
 	SMCA_XGMI_PCS,	/* xGMI PCS Unit */
+	SMCA_SSBDCI,	/* Die to Die Interconnect */
 	SMCA_NBIF,	/* NBIF Unit */
 	SMCA_SHUB,	/* System HUB Unit */
 	SMCA_SATA,	/* SATA Unit */
 	SMCA_USB,	/* USB Unit */
+	SMCA_MPDACC,	/* MP for Data Acceleration */
+	SMCA_MPM,	/* Microprocessor Manageability Core */
+	SMCA_MPASP,	/* AMD Secure Processor */
+	SMCA_MPASP_V2,
+	SMCA_MPART,	/* AMD Root of Trust Microprocessor */
+	SMCA_DACC_FE,	/* Data Acceleration Front-end */
+	SMCA_DACC_BE,	/* Data Acceleration Back-end */
 	SMCA_USR_DP,	/* Ultra Short Reach Data Plane Controller */
 	SMCA_USR_CP,	/* Ultra Short Reach Control Plane Controller */
+	SMCA_EDDR5CMN,	/* eDDR5 CMN */
+	SMCA_PCIE_PL,	/* PCIe Link */
 	SMCA_GMI_PCS,	/* GMI PCS Unit */
 	SMCA_XGMI_PHY,	/* xGMI PHY Unit */
 	SMCA_WAFL_PHY,	/* WAFL PHY Unit */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 3f1dda355307..662d86a6bda4 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -117,13 +117,23 @@ static const char * const smca_names[] = {
 	[SMCA_MPDMA]			= "mpdma",
 	[SMCA_NBIO]			= "nbio",
 	[SMCA_PCIE ... SMCA_PCIE_V2]	= "pcie",
+	[SMCA_MPRAS]			= "mpras",
 	[SMCA_XGMI_PCS]			= "xgmi_pcs",
+	[SMCA_SSBDCI]			= "ssbdci",
 	[SMCA_NBIF]			= "nbif",
 	[SMCA_SHUB]			= "shub",
 	[SMCA_SATA]			= "sata",
 	[SMCA_USB]			= "usb",
+	[SMCA_MPDACC]			= "mpdacc",
+	[SMCA_MPM]			= "mpm",
+	[SMCA_MPASP ... SMCA_MPASP_V2]	= "mpasp",
+	[SMCA_MPART]			= "mpart",
+	[SMCA_DACC_FE]			= "dacc_fe",
+	[SMCA_DACC_BE]			= "dacc_be",
 	[SMCA_USR_DP]			= "usr_dp",
 	[SMCA_USR_CP]			= "usr_cp",
+	[SMCA_EDDR5CMN]			= "eddr5_cmn",
+	[SMCA_PCIE_PL]			= "pcie_pl",
 	[SMCA_GMI_PCS]			= "gmi_pcs",
 	[SMCA_XGMI_PHY]			= "xgmi_phy",
 	[SMCA_WAFL_PHY]			= "wafl_phy",
@@ -204,13 +214,24 @@ static const struct smca_hwid smca_hwid_mcatypes[] = {
 	{ SMCA_PCIE,	 HWID_MCATYPE(0x46, 0x0)	},
 	{ SMCA_PCIE_V2,	 HWID_MCATYPE(0x46, 0x1)	},
 
+	{ SMCA_MPRAS,	 HWID_MCATYPE(0x12, 0x0)	},
 	{ SMCA_XGMI_PCS, HWID_MCATYPE(0x50, 0x0)	},
+	{ SMCA_SSBDCI,	 HWID_MCATYPE(0x5C, 0x0)	},
 	{ SMCA_NBIF,	 HWID_MCATYPE(0x6C, 0x0)	},
 	{ SMCA_SHUB,	 HWID_MCATYPE(0x80, 0x0)	},
 	{ SMCA_SATA,	 HWID_MCATYPE(0xA8, 0x0)	},
 	{ SMCA_USB,	 HWID_MCATYPE(0xAA, 0x0)	},
+	{ SMCA_MPDACC,	 HWID_MCATYPE(0xBE, 0x0)	},
+	{ SMCA_MPM,	 HWID_MCATYPE(0xF9, 0x0)	},
+	{ SMCA_MPASP,	 HWID_MCATYPE(0xFD, 0x0)	},
+	{ SMCA_MPASP_V2, HWID_MCATYPE(0xFD, 0x1)	},
+	{ SMCA_MPART,	 HWID_MCATYPE(0xFF, 0x2)	},
+	{ SMCA_DACC_FE,	 HWID_MCATYPE(0x157, 0x0)	},
+	{ SMCA_DACC_BE,	 HWID_MCATYPE(0x164, 0x0)	},
 	{ SMCA_USR_DP,	 HWID_MCATYPE(0x170, 0x0)	},
 	{ SMCA_USR_CP,	 HWID_MCATYPE(0x180, 0x0)	},
+	{ SMCA_EDDR5CMN, HWID_MCATYPE(0x1E0, 0x0)	},
+	{ SMCA_PCIE_PL,	 HWID_MCATYPE(0x1E1, 0x0)	},
 	{ SMCA_GMI_PCS,  HWID_MCATYPE(0x241, 0x0)	},
 	{ SMCA_XGMI_PHY, HWID_MCATYPE(0x259, 0x0)	},
 	{ SMCA_WAFL_PHY, HWID_MCATYPE(0x267, 0x0)	},
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index af3c12284a1e..43051aab72ba 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -710,11 +710,21 @@ static const char * const smca_long_names[] = {
 	[SMCA_MPDMA]			= "MPDMA Unit",
 	[SMCA_NBIO]			= "Northbridge IO Unit",
 	[SMCA_PCIE ... SMCA_PCIE_V2]	= "PCI Express Unit",
+	[SMCA_MPRAS]			= "MPRAS Unit",
 	[SMCA_XGMI_PCS]			= "Ext Global Memory Interconnect PCS Unit",
+	[SMCA_SSBDCI]			= "Die to Die Interconnect Unit",
 	[SMCA_NBIF]			= "NBIF Unit",
 	[SMCA_SHUB]			= "System Hub Unit",
 	[SMCA_SATA]			= "SATA Unit",
 	[SMCA_USB]			= "USB Unit",
+	[SMCA_MPDACC]			= "MPDACC Unit",
+	[SMCA_MPM]			= "MPM Unit",
+	[SMCA_MPASP ... SMCA_MPASP_V2]	= "MPASP Unit",
+	[SMCA_MPART]			= "MPART Unit",
+	[SMCA_DACC_FE]			= "DACC Front-end Unit",
+	[SMCA_DACC_BE]			= "DACC Back-end Unit",
+	[SMCA_EDDR5CMN]			= "eDDR5 CMN Unit",
+	[SMCA_PCIE_PL]			= "PCIe Link Unit",
 	[SMCA_GMI_PCS]			= "Global Memory Interconnect PCS Unit",
 	[SMCA_XGMI_PHY]			= "Ext Global Memory Interconnect PHY Unit",
 	[SMCA_WAFL_PHY]			= "WAFL PHY Unit",
-- 
2.52.0


