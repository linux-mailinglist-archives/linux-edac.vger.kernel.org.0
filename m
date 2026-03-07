Return-Path: <linux-edac+bounces-5781-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id m4uoB/o6rGlhnQEAu9opvQ
	(envelope-from <linux-edac+bounces-5781-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Sat, 07 Mar 2026 15:49:30 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 082D022C3C0
	for <lists+linux-edac@lfdr.de>; Sat, 07 Mar 2026 15:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C97D300D57C
	for <lists+linux-edac@lfdr.de>; Sat,  7 Mar 2026 14:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27592877CB;
	Sat,  7 Mar 2026 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="COTVDuSg"
X-Original-To: linux-edac@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880B82797AC
	for <linux-edac@vger.kernel.org>; Sat,  7 Mar 2026 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772894963; cv=fail; b=bCzni/uvF2XrFsW5rhx+C7/gdEYhV/b+6K1gieLTA08/KLCAAfg/IqahghplZ2vL6BnkCBVZgeh84eLDI9Eb/mAmR+PRlxzxWmSeAKbuvqVLaiVkOsqRTscckAe94XmD1rQ2GtlSQAevq3k91/v0MEY+bHQwm+io7OpiL49pZEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772894963; c=relaxed/simple;
	bh=qsU8s98EC8qnQlt2q0coHe8goh5oHYgujFK4RdseQ60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BtIAJpOiO59wH1qGtpYk6zfQJC3BvZGQqGu41WbCOMuNziaAmdPmIH3Ek4ZdXoTFC3c7Hn9UvjBSyXvS9kSp08X5XG43AvQ88lOf67SR2eNy2jJV4mITK1PI6Pwt1kBS/ZbQYSLATc23HgtBfbGdCivB1yQvzI/3R2p/bQURCFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=COTVDuSg; arc=fail smtp.client-ip=52.101.46.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrqFWD5cB7HJOFaybBhke1JP2W7zRDGmoyu0HPSbf3vZMiTjjcp+2N9tYMDzFlILttCx3Bsys5z//UjmeRnKbzhlSI9ltfJPblnPyMINjKV1DVkZyhVoDSDtR3D94arV4ZULM9BcAtS4IZusaSpm6zYsFcvm8AnI4v/tPGhL5em5beaUqx0/u75eS9E0MOrJZ+A7sAly0pdwrvvNgQd23ncHdag2Lf123VAguFbhlIRHUhM9pNfVSwy9hQ5icCpI/XTwaaUaJdtJWJjnaSNK3WPdsODts3KdnWerOP+FPMig+LFZMP1ayHxfbcIH8Zyj066GogJnR0/dLv1IUwSyuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX4HGpDCuFKbSGHowiJB+ITJPx1pMYWrgb/eU31Ka90=;
 b=Jd7f3OABmnN0BcZ7CnZCzrkxzQ7a6M3g93Obi9jWors4E76q6MmTZGIPCkoBdGXzen0vJ1YlVY/EIxnmSwBcyVph9N4FqYdgbnbcsILFXnXSDeQ4NKA4C0U81glTpVwv5TFnxBb8eV1n4yEYeUBfo6yPw0qiC4c8oCfsN9L1ZJTv8WsfgSOx4V51tqV9xmZGQanX9Lm4subbohHEiKbkXpfTTifcedOaH7Q+qkqKlXxfzaJmMXZ5zgiVF9kIJOR5ljUeHBeFtC0uf2qhLzXIFM73NPMP1CG0NXjeOfb2olwy4f3k35HdhX0sjjnErz5dr0OXGW885eiD2Mfhnm9pCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX4HGpDCuFKbSGHowiJB+ITJPx1pMYWrgb/eU31Ka90=;
 b=COTVDuSg6MrCcyr0/T8k1oreCt9Ccf62hp1VjBN35zUmJRFgsB3tEN0J734U3vXQ/yV3R8kITCcMdnLKY+Abu+atbU1UK4bpIkgrt8urgFlclI2afHiW/E3miIC9T86UPTr3s2pClz0kfh9Q95L30REfalLpzTYg8IaGYudwSFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 BN7PPF9507C739C.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6da) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Sat, 7 Mar
 2026 14:49:20 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf%4]) with mapi id 15.20.9700.003; Sat, 7 Mar 2026
 14:49:20 +0000
Date: Sat, 7 Mar 2026 09:49:10 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Tony Luck <tony.luck@intel.com>, superm1@kernel.org,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH] RAS/AMD/ATL: Decrease message about unknown DF revision
 to debug
Message-ID: <20260307144910.GA113343@yaz-khff2.amd.com>
References: <20260305154528.1171999-1-mario.limonciello@amd.com>
 <20260306145003.GDaarpm6p8A-pFBCCf@fat_crate.local>
 <a9a4aeb8-a044-476d-845d-0368f90624f2@amd.com>
 <20260306153223.GFaarzhwApsh3Jdqdy@fat_crate.local>
 <47075497-6bb8-4da3-b8b3-63901d9f3b05@amd.com>
 <20260306154947.GGaar3mxJ1JkcC0OgV@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306154947.GGaar3mxJ1JkcC0OgV@fat_crate.local>
X-ClientProxiedBy: SN7PR04CA0197.namprd04.prod.outlook.com
 (2603:10b6:806:126::22) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|BN7PPF9507C739C:EE_
X-MS-Office365-Filtering-Correlation-Id: f30e2de1-94d6-4866-00ee-08de7c58b6d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	JRcTeF6MR1bWta7EXPt62U/DMWYLmtl7KCmrChlaz9/QcPRIlkrTkZHJYiFT5I0gnXCukHUKbnetgx1nVFArHG10r6qhXwRb5KShVZDF2eJrnaH8krCdMRfc8rG+EpttPm9J5UdM/xLdBzhrL6LrXSZ9FJY7kodJ7pqdLuggZfMly7Du8gpX30gsFZXRaE2WYIAuGOP5lt7aaNZCcMwBsn37tkoaqdHrHH7KP9HaYuT+4QdaVecoXPeWAAoJpSWCdm5m0Ttuxn94RfL4n4/ahBPiiwXER+bv71g0DPQmrk5Zw7yChMpPvMZ/K8GZb9f34ewd+N/hU8nqvFanu/eyc/Hk4EDVB3yszbcJM19NpsQ56mUlEZus8BXDyVAfbyduxmtxbTKlP6GMEsfsrLtS7kTxR11e/MOOMgUvySHfcl04nIIBHVqRHWs6zwta6gWhFTD4F7xwbr0qq47KWwhQJ95b9DgFMkwc+f7dpMUI7sIv5ojeVDRFiw5H8yhce6OKSbxSCf/+Vk/HEa32ElmwCioP1qtgObSRs45QAhTpH2UHxhx7ABNcN/N1qpWM+rbtM/fpLB2NTl+3oSvG46075QTr3ctf9ll4sJzetySQm7COS9ui9vbCalvMZj1Xc8/qywQus0lYc458bC5AqxrEN6cGFYlZ6MPe7LCYAtkqyEfkO+Sd1fpkgyv0UP2e3G4H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pqMa9H05jVK4hBNTRVLJX8JB8OErQ/XAVxNRXnlyTBE8uxCGuMN5jBKLk8hq?=
 =?us-ascii?Q?eHKvM1Z1J/99BjjqeKQoH+M1Gaf+9DdGmgeYun8w8mGtugZN9W//G4HKqkAq?=
 =?us-ascii?Q?m4ht2uCPIJF01dG3PANBymaV/AoRRIoJKJqeITUuJ6imFo7okgkN+R0Y0BWm?=
 =?us-ascii?Q?4wlhW9PghyBJqYE5mGtaHuHW3S8MVqRssVam85PHlNFQU6julunh4RYdP0O0?=
 =?us-ascii?Q?ESn7fjqamDMkFNo4rPhEZLbORDIy3Jy1zvM+oF890lhGBp4N7Q7iGhZGidW/?=
 =?us-ascii?Q?521kQAqsYwwnw2u6b4aX76p77+gwbxSgdg1jXtKV5NaaugYiihTFXaI6VnuO?=
 =?us-ascii?Q?oyF+FB2cHEUEhRxp1wloswqHITg301s7K4b4n1WH719PaE9YzgCca7nZpJUk?=
 =?us-ascii?Q?Gr58yOmjGLjT2Iw/ixk7tOAzQQQRbZn3JuqhzQPWWJ7BQHJ4CcIrMYgk0z8Q?=
 =?us-ascii?Q?t5IQXZRETuzBwsuIBL0sWYylKk/tDF+O1x7d7yl1B2QL/LJWHhMuGccKoNHm?=
 =?us-ascii?Q?jt3FhppfNhy9HOjeVCiIfPdeGkq7LEzX7/EMTfyMrvZh0IQBG2Mt4CQpKepw?=
 =?us-ascii?Q?iNuzKkCAQyVj0UBoigdglhZFWSXzLJxDY9dS5geQTp0+cXgaSIaMT21yaMDL?=
 =?us-ascii?Q?LOs+UdJ9/D7wwV29+zz5lHKR33ogxlKVSkLm1MpylK1B/SKXhGQGHuihuBO/?=
 =?us-ascii?Q?07wa2Li23+l7zHfzCja9uXqxrr4KhQBm+bUnQqA9CQ9jNL9Pjc8ctIF/V2dv?=
 =?us-ascii?Q?VugptGsx/B8Xefog9UFFd0imKBBygYbbzKwZhFQfSEc2ijCyCIUxFFG0tF6P?=
 =?us-ascii?Q?NPMsXFdkKLUIUcvOSWLfQ5we3oUp+JEa9ezdDimK/WOhRp7CxT9LKMZVdLqZ?=
 =?us-ascii?Q?5CiwWkZu383//qZrOFSqKHrgbt+5UP/q4om4JPpYeoxMcBInr3xY3nVCfXo7?=
 =?us-ascii?Q?123YcsvR3DjVOn/SLNmg22uf0itxaASTfB6OqF/AlzEsoKM+G/7lKP14jEt4?=
 =?us-ascii?Q?HPunbd63kSAwIZ4XbUa8sdqb7yUToPf+z8qbeO94LmD5mG/2er4xNhR5fiug?=
 =?us-ascii?Q?pjUcaDMWbQxsDrhlhttcifdFOXJ/y4z8MWFDV5A37NJNJdYZVP4/U7F8Pnmm?=
 =?us-ascii?Q?raHiwfXzdtTJuV/3s3usuh2kqfdWCQeO2FvlTfB7asoxLEQh2sGJ4b8Z4F9A?=
 =?us-ascii?Q?PNdk4r1UX1l0tmRiT5i5pw3XMCyISHPSlyvlb26940ca+wM3SnA80eXG3OZM?=
 =?us-ascii?Q?hwyyGJglORlBUJWWjDpPWHeuZRqm7E2kKgCoMIstIlIC1fZLfEzOA+wZGwxL?=
 =?us-ascii?Q?SWcOruB2iVnP5DqyGiR5rKpaJa/l2aFOC1IyDYG+2NhknLZ8iB22Rq0VvOGW?=
 =?us-ascii?Q?D3yTcMo0vl+VducyEu7D6uUIRU9eNNTZ05defFi332ONP35bzej9WT+HTrYx?=
 =?us-ascii?Q?Zeww3DdWKS1bJs055klqQu3CrFljZiEx5o0Rrh4ZEnAQ2x+MCTiHTQZGH+Yu?=
 =?us-ascii?Q?v2LHCx8ENWcTlq93rziAvBs1cp78WQT7YFjc5L/FTgxaidvpu7csclr+Jps5?=
 =?us-ascii?Q?Gwl/l5OASmgcHzo43bjxzmgghnV1dZpYr7+UF3kg3BUUC06Gwd7f7r/EE9i+?=
 =?us-ascii?Q?E9LmgToS4+BY/GDRD7aQslrolKWBBgDuZOzea05kkhaPQOqHxlA8WPRgWVRY?=
 =?us-ascii?Q?4s32rcn0plHXcewj5cVl7xhyqMSj5qiUhqU8+8CHin5ACa9b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30e2de1-94d6-4866-00ee-08de7c58b6d0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 14:49:20.0593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHrueu3iMF7SoNChraV/o85ce+/pKQw3M6ZwP/+UxgZlsmHl1jpoX6/LK3v7uP9RijVAyRZlbPNIxk41pCyjfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9507C739C
X-Rspamd-Queue-Id: 082D022C3C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5781-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yazen.ghannam@amd.com,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.962];
	TAGGED_RCPT(0.00)[linux-edac];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amd.com:dkim,amd.com:email]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 04:49:47PM +0100, Borislav Petkov wrote:
> On Fri, Mar 06, 2026 at 09:40:06AM -0600, Mario Limonciello wrote:
> > But don't you need to use UMC to discover that?  Chicken and egg type of
> > issue.
> 
> Probably...
> 
> And we already do that in amd64_edac. So perhaps we could export an API or so.
> Yazen might have an idea...
> 

How about having EDAC load ATL when ready?

Thanks,
Yazen

---

From d4e3cdb2efb34ccb2c234a4b227d0301327ad340 Mon Sep 17 00:00:00 2001
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Sat, 7 Mar 2026 08:58:56 -0500
Subject: [PATCH] RAS/AMD/ATL, EDAC/amd64: Only load ATL when needed

The AMD Address Translation Library (ATL) will attempt to load on all
AMD Zen/SMCA systems.

However, only systems with DRAM ECC enabled will use the library. Other
systems will fail to load the library and produce an unnecessary message
to the user.

Remove the ATL module dependency table to prevent autoloading. Request
ATL to load from EDAC once all system checks are complete.

Fixes: 3f3174996be6 ("RAS: Introduce AMD Address Translation Library")
Reported-by: Mario Limonciello <mario.limonciello@amd.com>
Closes: https://lore.kernel.org/20260305154528.1171999-1-mario.limonciello@amd.com
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c  | 2 ++
 drivers/ras/amd/atl/core.c | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 8908ab881c85..7b04f7c5e2ba 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4170,6 +4170,8 @@ static int __init amd64_edac_init(void)
 		goto err_pci;
 	}
 
+	request_module("amd_atl");
+
 	/* register stuff with EDAC MCE */
 	if (boot_cpu_data.x86 >= 0x17) {
 		amd_register_ecc_decoder(decode_umc_error);
diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index 0f7cd6dab0b0..d77dacdd4f56 100644
--- a/drivers/ras/amd/atl/core.c
+++ b/drivers/ras/amd/atl/core.c
@@ -190,7 +190,6 @@ static const struct x86_cpu_id amd_atl_cpuids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_ZEN, NULL),
 	{ }
 };
-MODULE_DEVICE_TABLE(x86cpu, amd_atl_cpuids);
 
 static int __init amd_atl_init(void)
 {
-- 
2.53.0


