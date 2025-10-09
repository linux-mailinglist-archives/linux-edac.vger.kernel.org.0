Return-Path: <linux-edac+bounces-5027-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAE0BC941A
	for <lists+linux-edac@lfdr.de>; Thu, 09 Oct 2025 15:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4489D18933B5
	for <lists+linux-edac@lfdr.de>; Thu,  9 Oct 2025 13:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D802E8B6C;
	Thu,  9 Oct 2025 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vJCH5oAV"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6052E11AB;
	Thu,  9 Oct 2025 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016071; cv=fail; b=BeIGLZY4+8WEa9/CNx9BbYo5i/NnhwcbaMdvTCXwZB2CAphMGL0CQLRQ+WMqID7EJXQ76qUpUJ89UlpWb1Zc8YIkaOYf25dg1cPKORv0MEo2LX8bjeJqlqzA26ByGaCki+yZTLvA/V81puCZJZQPdie8XefDRuqOwRqg5o2ne0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016071; c=relaxed/simple;
	bh=Rt2ioQqCKVFoQuocADeEBI/WMJZ6nqxmdpxLhwXOVZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W2mFMI9BVvqu070NO8mFIQd5lOWZm2uA0kJURfmLqSc4b7wewpiWn/F3CzWOsx/jIUrQUbZFNScH6dOgRWeAsbg2bFRr8M3VCsKcAieErGoT+FBrbP+GR7War3ZcOHwzPTOlUHGVEYQP+00+QM8FmUznpqAjYhW4qVgS6Z4vcE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vJCH5oAV; arc=fail smtp.client-ip=40.107.200.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcMT3Z4BBZidX1t4yWBRAcf3nTpspbA/qt2bKDotCop0RkLCGt2dZ1UXDeCidfaUK+TiK97aABS/phbeg0loMetKGUkbqJnxY4OW9oD6vcWn2UDKLcTno6YnS8gD0+nJvR2Frh3dIWFaRTWRoGcctYs4gA8ejjUeOHxz3vYDyIoZ91IGQorr9AYm2ZC+Iqbd8SNrU8abmDT1Rvr+qxE+gGJxZK7aQc6Uqar7OFoLYJwddniuA6FcjFH0AuFdx2FkTzsafilWeta2+ejjObjhYLAeUgB0M4yf2SwUTvmBEj6ewrH49CU0qt/cU+pGYrHduCDmp1PhwQoXUQqY4n19Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20wLG++8O4qWq79ePZtkWxzOBbu18ijyyySi8syxcQQ=;
 b=utPG1plGRgfDjMFaMIvWxnb/pRzTtYWCIAHiSK1jteBecvGiqXRGfrEOGWQgEJ/dA/1qfmciQyU3p+2TvOSIdIxp8v1CDpk+pEKdjdkOfU2bRK9MKoP5JS+bfEpTjtbyy1MekIuasViSVL+mmNExZqY7Up8qKAzpfPporShiEgRzuvD3orj3mGtPJ31FhIhcmQjZ7GTc7GjqtWLEnXZl8llm7dirQYxUKSZfDGxPXJue9dkwGmgjaV308/epFRo6ibaBgILu5bLOPu65XzKliESpLoq7JHkf42EQa7Ru2yuIfCmOqmgRy2u+qXaYF5TNgaZXqZzyppSwt1eORTNKJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20wLG++8O4qWq79ePZtkWxzOBbu18ijyyySi8syxcQQ=;
 b=vJCH5oAVFxFKGSmbL800zrSecIIK1YOVEmKBFhPHSqndo2M7ZaO8S+7w2ApMRPT0ntsd/iN5zbzFySbnz6bjTUjBeja0/Os993vqVBCnaMMxBYx4K1R2Gsg7F+X5xstQbB/r4CJyZqecXKUVCGT4TSQpq71M2Kcj+JMMRLyPUlo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Thu, 9 Oct 2025 13:21:06 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 13:21:06 +0000
Date: Thu, 9 Oct 2025 09:20:55 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Nikolay Borisov <nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, x86@kernel.org, rafael@kernel.org,
	qiuxu.zhuo@intel.com, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: spurious mce Hardware Error messages in next-20250912
Message-ID: <20251009132055.GA472268@yaz-khff2.amd.com>
References: <20250916091055.GAaMkpn72GrFnsueCF@fat_crate.local>
 <20250916140744.GA1054485@yaz-khff2.amd.com>
 <9488e4bf935aa1e50179019419dfee93d306ded9.camel@web.de>
 <be9e2759c1c474364e78ef291c33bc0506942669.camel@web.de>
 <20250917144148.GA1313380@yaz-khff2.amd.com>
 <6e1eda7dd55f6fa30405edf7b0f75695cf55b237.camel@web.de>
 <20250917192652.GA1610597@yaz-khff2.amd.com>
 <5ba955fe-2b96-429e-b2e8-5e1bf19d8e8e@suse.com>
 <20250918210005.GA2150610@yaz-khff2.amd.com>
 <67c7de1011ea7b8863051889ee2a41512fb0e044.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67c7de1011ea7b8863051889ee2a41512fb0e044.camel@web.de>
X-ClientProxiedBy: MN2PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:23a::32) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b88abc-3253-41ad-9f0a-08de0736b39a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yzutDTbO41rH7Qbo8TbSBiTFrMllufksMdPE1/uqXSFDim+nBy8Rdd3VCToA?=
 =?us-ascii?Q?tKAQzL5WpcZlABy2NAoLigVhaQP9nCqwUyi4Xf+N2Q3i6mF3bsjPqPN3Juvx?=
 =?us-ascii?Q?f+Dyl9Vo4m7rT8CenwjbT1jLYcRBETCSgx1JZ0tRhU+ij3/xwiIlcK3QNstl?=
 =?us-ascii?Q?qUONFZVdwoAbetah944Eays2TPvlMTQnMefd83fJpq5O42UE9FsMymsCdN1w?=
 =?us-ascii?Q?t7MdUpc8wW+pz8ZOaBOErhnnrWczYgdkPIP7YjSdcwKks+4OPXPxGXg/BDDv?=
 =?us-ascii?Q?3irAofPMHMuhMEny5QigRDV1Ux9uyKIgKmRgd18wophY/1VSn56LoV7glthY?=
 =?us-ascii?Q?gI+Gux7Rg0XbEAqQhu1acnN6feKoikicOezd396fTPWtQHj3ycDSbDG6Ufpl?=
 =?us-ascii?Q?qfx88+ZQMO1dXh3P+Iu6ksA1erAmYiPX4su2c8M95Zjge+IF755HuXQU9UKy?=
 =?us-ascii?Q?mtUaxOVjq1fAycQEU0Aa8S8+TG4R5THyW/7BnsgHvvi9mF2/IRccPQE/fDbp?=
 =?us-ascii?Q?e4Jsk9XdXIQ4QngNHQsilQKxcSoWBSOjMewIVItD9KA5QjFT1EONz53kDdwN?=
 =?us-ascii?Q?e6IW79wfhdNAibHZVQx6KnRA8Mw4eUvL8MUwh42pl95yNAi8nv8EJcm9hi6M?=
 =?us-ascii?Q?yz+9WzlN04IN5eUSy9kdyStMEPF53yMaHT3bzbRB+MOUwPo17GUt6XiLHotJ?=
 =?us-ascii?Q?lyoAq+WMKol2UBddtFXNSJF6MUvS/ZiHHqDTQRLEf2t7Z2xGpu36PRzB5F5n?=
 =?us-ascii?Q?UkmNRhsZSuL+i5e6ood8XM8uYA6Wv9ghEc2pMp1Ix9lyugXua+PbqQUanVMZ?=
 =?us-ascii?Q?2J2UrCvb0zTVgwBt9wl9rISpGJxQCtsiy5pUBxLZ7OAOufe/++U6kMdIqw2Y?=
 =?us-ascii?Q?7gk83bXgLJx0m03Ao3awFwaqqiyCq90h7wnzzmStCdzxxSeJezP9w5+VvgC5?=
 =?us-ascii?Q?xiq97CJ0hWrEz7BumRyr26BCT05fcaxlLbjzbkdzegziVscoZdcN4SjZYb3L?=
 =?us-ascii?Q?2/Ymts6ZpP9KvCouiPu6UkUcop90VjrDclu09n4x0yJYw8r8B2lvDqjz88A8?=
 =?us-ascii?Q?hYHgFypeqM32jWsr0CNhiuYb/XIx7dUL5rYPw34eJSORTvqNkD3BR/+Wp5jz?=
 =?us-ascii?Q?NZegeVWNXvHxqGuY2G3OOJtMaDR0g7WWkyKMVhpG1N/ojYWuuAkCgNYJEM1u?=
 =?us-ascii?Q?ddlU7hZnz+3uRQAaGWNGpD2sxC32gYFJ36X6PNX+5OgWTSr8UuZghtUQ28v1?=
 =?us-ascii?Q?cNfQcxtMwWqEa3kcWW+c+7vV4UhUn0dpqtFS3Kj9zqLfngQaWA5fJxSIrDJ6?=
 =?us-ascii?Q?5v8f3HJl6lmiLctTDjiPa/Nr3vqVJ1kYUUiYWYF0EfKgnPt7MI8CJ5gl3Xrj?=
 =?us-ascii?Q?85iH3q+YJcA1158ApRm09zHTel1ijELeGplMqBdf2spLXgnxaDM54wZvfKJq?=
 =?us-ascii?Q?hy2svDMUbbeEURyCoJ2SJUuxbaPQdFdp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/bvqGHoKuFh0IGgYn0llLPsOAlJW8U7QSlxcH8TamdDk+V2PXA0uYmGSKqqa?=
 =?us-ascii?Q?BndSi5lLoQZhoFmhRXt2LQjv3Po46AVkIZfrI1Ll6e+5as1W3vFeMTvGLY9b?=
 =?us-ascii?Q?a/YMh4187BsF7a5QGwnGUXMoUBtpIyA7wmFInxNa8Ub+N5dxJF1BxkmDnziI?=
 =?us-ascii?Q?MOyeHwxZgtvU2YxIiEsJTziB1SGfHs7JK0JXelklN8YZaqwW+XpNIjaQTPbh?=
 =?us-ascii?Q?vvK+ohmdd5+LWyqMCJUasFCAsKtfELHOhBUIV7lBSlchxtCmOzezfhDX1wqQ?=
 =?us-ascii?Q?hzo35ZfkR7DlFGUlNDIpSSN8BAOLI6m6vQDdEg4WXYJ3gC58OSnaaIdscKxa?=
 =?us-ascii?Q?X5DkwdqmViDEinTupgxQl704Tx266YyRlljD5kQnoj+fjXsO3E7zaqvEgXlF?=
 =?us-ascii?Q?pfB1lYGJ2BMTfmGi3OQl0hKm9dmXhLek4wPrqpTrv54qSISfESUAanEN6u0p?=
 =?us-ascii?Q?BUkZNj+xDAkW2y+wzh3I+pdguSWl85pzB6KkN//k8K2vvj46vjgL/0H49aQi?=
 =?us-ascii?Q?iINvweFsDBfv+iqvxq4b0+D/rQzUiHM+4ZH5rpmIqT09RBNEt54RczK7bYEf?=
 =?us-ascii?Q?8f5sBCKA2Y6fxW/o6j5+KW0KrWKsoP5dTfp5umQWj8kJJLRR0iNphXmrhJ0X?=
 =?us-ascii?Q?34r879R7A8gF8SKOjQYvV45JKHsF2Bt+NFFwelyiIAbNIfdSCTjI+ktz9N71?=
 =?us-ascii?Q?b4xckfaXvqX5qoOpz1/zllTxWtvPvqNACLzOyF9oIvAFEdvCyto/COM8nUr3?=
 =?us-ascii?Q?DU8qUAb5INZmwyvZjmS+olREAwLHIIj9r1XnMw0ClyrnMYoCtAMre2DioEEt?=
 =?us-ascii?Q?+IfT3C+sp3umdU81AWa0Q2sAsMZrygZmiYCl0QlmRuZ0WwKJRb2z8v3lEedh?=
 =?us-ascii?Q?1IC36YYMBu5So/BE6zyiBO5K4UEJtT5+tAkfLesJVdDkNGlGz6isHxBx2TI9?=
 =?us-ascii?Q?nDbHrGt68gaw64rwZJzJ24un1Sf6fPxJEJ5BWAvwpUFMUhjz/fbVbbaNm0qr?=
 =?us-ascii?Q?+Zrh9nIzQKYYLR2fo0kFrfg8fQD6vKTirPPjp3fVg9bbLgAu7GAxoHKqQU9Y?=
 =?us-ascii?Q?T+rstUMKzsP/nsjHhdQquEJy2rSgpWdwL+pvRBZtZtROFRFaTRZVAPbg94Jr?=
 =?us-ascii?Q?2ALQ+91zSSsmeu1xhBZYIaWuvL2Hb1OCvwerXQH8J4OvjV/JMbIjtfNnzExO?=
 =?us-ascii?Q?UvLVGZyJGcHUcveSfGrKvUkD5Qe+SsbrV2hnWVrzS5F+zVA2yM1bo27n/CRQ?=
 =?us-ascii?Q?nBnxtgvj3QHtqt3ZMR5YqKc23sWEB3sOYDOdK5vlDu+qKOFIGMQzlkrqibwk?=
 =?us-ascii?Q?W7/Oy5kbVKrH/0kayFw+iN9OesISPjD5K5tY8qTU1Vr4AJ/gCtaJMAeVgXKW?=
 =?us-ascii?Q?yFttcd5Hn7oPCw8thJenz7WNNoafhsiMxGoHd45Hvj5e1qWuAwSMCmUz9iSX?=
 =?us-ascii?Q?9hpkgS79rdjrtsIlDyulsFheP34bSaYMEIri/k4GZxOJwMKwHgoFx3hzWLza?=
 =?us-ascii?Q?zq2sIFVGsAED+3fQUZuXGoKei9A3nhnoqhGE6G3V+fBvZQCmdOzdO7vx0F9n?=
 =?us-ascii?Q?rIcpvHSBRcOa2NTtA/pEI+bWrpvtv6Na+EOKKUta?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b88abc-3253-41ad-9f0a-08de0736b39a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 13:21:05.9045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5mLwn4Ix7y7r5jttoradCDGyhn8Vmx5/yVhQd7kaN7Kaw624sEC2W2xdqE3Y7osRqpE1dFdR9HKGscTBKr5fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434

On Fri, Sep 19, 2025 at 12:07:15AM +0200, Bert Karwatzki wrote:
> Am Donnerstag, dem 18.09.2025 um 17:00 -0400 schrieb Yazen Ghannam:
> 

[...]

> 
> [  333.337523] [      C0] mce: DEBUG: CPU0 Bank:11 Status:0x8724aa0800000000
> [  333.337532] [      C0] mce: DEBUG: CPU0 Bank:14 Status:0x8724a98800000000

Thanks Bert for gathering the data.

We still don't have a system that shows this behavior. But I was able to
simulate it by manually writing the register values.

Can you please try the patch below?

This adds additional checks to ignore invalid values. And it addresses
feedback from Nikolay about clearing status registers later.

If this works for you, then I can squash this into another revision of
the patch set.

Thanks,
Yazen


From 11cdf1e18faa343c1786f6ac47f663937252c4d1 Mon Sep 17 00:00:00 2001
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 22 Sep 2025 20:26:06 +0000
Subject: [PATCH] x86/mce: Rework DFR handling flow

Add a flag to poll for Deferred errors similar to MCP_UC for
uncorrectable errors. This will do checks specific to deferred errors
and fallback to common UC/CE checks otherwise.

Also, clear the MCA_DESTAT register at the end of the handler rather
than the beginning.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h     |  1 +
 arch/x86/kernel/cpu/mce/amd.c  | 13 ++++++++----
 arch/x86/kernel/cpu/mce/core.c | 36 ++++++++++++++++++++--------------
 3 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 1cfbfff0be3f..9652fc11860d 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -299,6 +299,7 @@ enum mcp_flags {
 	MCP_TIMESTAMP	= BIT(0),	/* log time stamp */
 	MCP_UC		= BIT(1),	/* log uncorrected errors */
 	MCP_QUEUE_LOG	= BIT(2),	/* only queue to genpool */
+	MCP_DFR		= BIT(3),	/* log deferred errors */
 };
 
 void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9b746080351f..83fad4503b1c 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -839,7 +839,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 /* APIC interrupt handler for deferred errors */
 static void amd_deferred_error_interrupt(void)
 {
-	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
+	machine_check_poll(MCP_TIMESTAMP | MCP_DFR, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
 }
 
 void mce_amd_handle_storm(unsigned int bank, bool on)
@@ -865,10 +865,15 @@ void amd_clear_bank(struct mce *m)
 {
 	amd_reset_thr_limit(m->bank);
 
-	if (m->kflags & MCE_CHECK_DFR_REGS)
+	/* Clear MCA_DESTAT for all deferred errors even those logged in MCA_STATUS. */
+	if (m->status & MCI_STATUS_DEFERRED)
 		mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
-	else
-		mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
+
+	/* Don't clear MCA_STATUS if MCA_DESTAT was used exclusively. */
+	if (m->kflags & MCE_CHECK_DFR_REGS)
+		return;
+
+	mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e2d51609d2cb..960efee4be3e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -731,27 +731,26 @@ static bool smca_should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *
 	struct mce *m = &err->m;
 
 	/*
-	 * If this is a deferred error found in MCA_STATUS, then clear
-	 * the redundant data from the MCA_DESTAT register.
+	 * If the MCA_STATUS register has a deferred error, then continue using it as
+	 * the status register.
+	 *
+	 * MCA_DESTAT will be cleared at the end of the handler.
 	 */
-	if (m->status & MCI_STATUS_VAL) {
-		if (m->status & MCI_STATUS_DEFERRED)
-			mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
-
+	if ((m->status & MCI_STATUS_VAL) && (m->status & MCI_STATUS_DEFERRED))
 		return true;
-	}
 
 	/*
-	 * If the MCA_DESTAT register has valid data, then use
-	 * it as the status register.
+	 * If the MCA_DESTAT register has a deferred error, then use it instead.
+	 *
+	 * MCA_STATUS will not be cleared at the end of the handler.
 	 */
 	m->status = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank));
+	if ((m->status & MCI_STATUS_VAL) && (m->status & MCI_STATUS_DEFERRED)) {
+		m->kflags |= MCE_CHECK_DFR_REGS;
+		return true;
+	}
 
-	if (!(m->status & MCI_STATUS_VAL))
-		return false;
-
-	m->kflags |= MCE_CHECK_DFR_REGS;
-	return true;
+	return false;
 }
 
 /*
@@ -780,13 +779,17 @@ static bool should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
 {
 	struct mce *m = &err->m;
 
-	if (mce_flags.smca)
+	if (flags & MCP_DFR)
 		return smca_should_log_poll_error(flags, err);
 
 	/* If this entry is not valid, ignore it. */
 	if (!(m->status & MCI_STATUS_VAL))
 		return false;
 
+	/* Ignore deferred errors if not looking for them (MCP_DFR not set). */
+	if (m->status & MCI_STATUS_DEFERRED)
+		return false;
+
 	/*
 	 * If we are logging everything (at CPU online) or this
 	 * is a corrected error, then we must log it.
@@ -1924,6 +1927,9 @@ static void __mcheck_cpu_init_prepare_banks(void)
 
 		bitmap_fill(all_banks, MAX_NR_BANKS);
 		machine_check_poll(MCP_UC | MCP_QUEUE_LOG, &all_banks);
+
+		if (mce_flags.smca)
+			machine_check_poll(MCP_DFR | MCP_QUEUE_LOG, &all_banks);
 	}
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
-- 
2.51.0


