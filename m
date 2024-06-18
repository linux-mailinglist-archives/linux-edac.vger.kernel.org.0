Return-Path: <linux-edac+bounces-1306-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 956AB90DA84
	for <lists+linux-edac@lfdr.de>; Tue, 18 Jun 2024 19:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0671C22981
	for <lists+linux-edac@lfdr.de>; Tue, 18 Jun 2024 17:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D5613D8AE;
	Tue, 18 Jun 2024 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FcBGHu5f"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D859F2139DD;
	Tue, 18 Jun 2024 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718731498; cv=fail; b=Jr9n3m0zHdzeYiwjc281Cc54iNR3p3kh2uE2f6r9PTQ0UTskrv8RJtLC+IJeXttDpUMV8zMuu2c6MwhmWPQ3AYKkiVwceJrIImomB+orXciysLENu0W8/TT7SEtevVFYbys6Bpm2jwE3BOtuGLaaiDcfFKJVo8XpawmuX4AfUvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718731498; c=relaxed/simple;
	bh=XfiF+2Des4seo59mfOjd8G3WFY3I4cUDfU6N3yvYFnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SQgiRmIEJXe0dqKURxznqxmI3cWc6LeYH7/wTRm6Vg7vKxztsQfry4DP/K3YZ4btrBwCso2A45cIKTqQdGyxHz+MXPg6JKl+a2JBv3KwFO8RPJt29ayWF1JIcIIsRbGDg41ZB4M7pdYf3kg5hR/yVMBkn4G8RCtuEQl4iFu/6K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FcBGHu5f; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGIk4ztSgLhcw5oqx1ca9QDFSwkturGnp7+T5O7WXsdz2m97UolDNku5UE5HH42E0v/oCMNC/R9GPJRJvfcOytPQQrpJtAnw6wX34XIyHrkTJqq+j+nOp1HghI79bpcu1468QsHtEvP1+MRhBlW1CKFp0cNgAhMi+VKBYnoNsln6ya9XAAqzy7q+nY9t9M77LzQKys0p0OCWtVPR6+BmC/aH4R6LrDWeaHo2HrD75xXmeiYo161Ca6AYzhTrw5zHWg7+dJdCVlBtQLbENTyGnDJSADC2fRfF6wSJSSJw1CpQBBcWht6R3/PUTIUDbAcmjfTYxh1mYRgQhZl49wfDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sShbYpeDjtWA36OxYe4t/NB7WA5BNVgPxboe4UyBF40=;
 b=HQd7e8LmI+IAoesYmT7QbECOeSHFarlyvkSzcG74mnVqWJHFX37Ib0AWB2IMsqxrG8ocVHX/xQfDuOdF9hTljWPZ2XB+l4HgxOxQXelOGTDG6JKuKfH6Pw4H1OyG3h+DR8L0U/bBYOjpMVcnwZrLS2nv3r5W/iFgkugeOGwGJlKkXrLM+rH0pvr+Lw+Y4rovylCl+gQovBLK9xNBefk9KG0xa0o8eCD8DerUV6FaVtVJItZOuKk8cC5oIL3r5UlVNm5fsldB3JdR6kLyGd1O+q5jRcFyPV+8Porn0J1ElumM9w60v8YghZO89gRpAogcscAxU9U/3wLcMcxMgcSGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sShbYpeDjtWA36OxYe4t/NB7WA5BNVgPxboe4UyBF40=;
 b=FcBGHu5fDH6hSFr3JcePJcfM11Xml7qNI9G76asUSdnekWuCnehakeWB8zId/QmyJqC/VN7bG2RtV6+CqvJpDEAvXyLVFyk/LpgodNFD3TV0hxxXY49B3QFM4K4oKKrqOUhQwuAp7IbVGqptqjznarwM4sS+4FkG1Az7R+Rg0z4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH3PR12MB8210.namprd12.prod.outlook.com (2603:10b6:610:129::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 17:24:51 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 17:24:51 +0000
Date: Tue, 18 Jun 2024 13:24:47 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"Naik, Avadhut" <Avadhut.Naik@amd.com>,
	"Allen, John" <John.Allen@amd.com>
Subject: Re: [PATCH 3/3] x86/mce: Use mce_prep_record() helpers for
 apei_smca_report_x86_error()
Message-ID: <20240618172447.GA1387@yaz-khff2.amd.com>
References: <20240521125434.1555845-1-yazen.ghannam@amd.com>
 <20240521125434.1555845-4-yazen.ghannam@amd.com>
 <20240529172809.GJZldlqSr5km0frQ_o@fat_crate.local>
 <6d508036-befd-4d5c-b02e-abb228ed9144@amd.com>
 <20240603165530.GFZl31gtuABwpe1svP@fat_crate.local>
 <20240614214736.GA726880@yaz-khff2.amd.com>
 <20240614224420.GGZmzHxDEH2D2TLpjN@fat_crate.local>
 <20240618151151.GA1153@yaz-khff2.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618151151.GA1153@yaz-khff2.amd.com>
X-ClientProxiedBy: BN0PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:408:ee::30) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CH3PR12MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 05cad060-75e6-4fce-33d8-08dc8fbb8f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JxOGsQguIZ9hw70cBf1F12F2POD/Di4t+57/t4e3Q89cLAWYF2MOjpnMszl5?=
 =?us-ascii?Q?/lRth1Tlg8jub3g9yZFpOsWks00MqsXVQUzXREaz8pjx0OONzHS5J2WzORic?=
 =?us-ascii?Q?zvywofS6j4CqsnKChfDV3uNSNtIsO/og+yyIflOayzyXaLnDIJ6I9sfwdqSB?=
 =?us-ascii?Q?dCVaWZOPsy/GPhiI44oQ7Q8wE2yfohtZrDKnRouxTpqMRFzkzibqqGCGXDqv?=
 =?us-ascii?Q?2e3/XrjFE47xXt7YjodWPw8EiAaPHP4aIeHo7SG7GWeYXXB1kUMBydBCGe8+?=
 =?us-ascii?Q?XNkWtoOR76zIPMYYe9/yqXFwx+vRWpC2NrVs+Z4C9euvhf51tZcjtYb9wmA0?=
 =?us-ascii?Q?fZ31MRf9EGAiTosssTo0Rfa3qfUMiZBINyxLoeNTDvxIOxCJ92eqP8+mwci4?=
 =?us-ascii?Q?j2hes+ac9jm0PeSLG51aTPmljSE32qMzTp1tw4e+9OoTBVR+4iWfKcFHrmRR?=
 =?us-ascii?Q?atyi/2PKDZDBZ6hfkqO2IWJy6qTy4Q9eFSIb4ocPBr1Efm/IHTsNS+q4oB24?=
 =?us-ascii?Q?Z2rrPsbTZBu/zsMwPUtgAoO/v/nMjECQrSyZPJYAM7s3lUiLUy3ETnRtOSuq?=
 =?us-ascii?Q?69abPnzzt6T4U55PTbP7cvAL6yZ04+R0DbEj5kbQGqB6/S9ayYuKqrNLhZYd?=
 =?us-ascii?Q?vWFw+hIfDFP/tenitjAcldy4rOtcgpDtFD8TgLt4Ox5ysN4iI6LIvGHz7Whx?=
 =?us-ascii?Q?FNQT+dxvtGzaGWRYyoc6eumXYKCNbQ12p7LmuMudIuEKbrbbcphRid0nFUL3?=
 =?us-ascii?Q?xt1Tr0emQJrMEKqAPsYPcG+2VGpSerX+VO/31/1fgmVdwjq6R/ZywyK71rrm?=
 =?us-ascii?Q?toPlMzrdXJglvdbG9bIaAjrwTxPXP3PdmofbPstIYFCrtZWd35kDktkq6Rj+?=
 =?us-ascii?Q?0/yEq1Jn3q+91zc8Ax17qR2t7QEp3YR5NiFQE9LBo4GpRo7W6rTuDvzSdovJ?=
 =?us-ascii?Q?x7TDHaONx66XfSsfwxUneZt6FzzTtEs6NyLY7B50qaQVYH3X+csv9w/A3uN7?=
 =?us-ascii?Q?MRo8RmRpg8Dc2DgsibFPuzky8tHvCD6vHjRiH+MRyhkjnkl9NO6RW3nD4DlH?=
 =?us-ascii?Q?OvDUVKSHewadeoH9BITf1qBqnXdUl7V+9IXEhNxfiOKlJr3UlDLbmMVqmzXM?=
 =?us-ascii?Q?ajjBn665cDvOy3e7jEAkWGnjS7IVlI1tmNyojRRk0Uxp1zSoQ5TqTdOG8Oqu?=
 =?us-ascii?Q?o5joRrOCllM1BBC/qW9YZvE41HHW4zoKUgHHRIY8yfxyxZv8k15m+Hmc/oK0?=
 =?us-ascii?Q?rimR2PPHJHvK7SggKhWETUflm7ub6nT32xnPSBUD4BU7igfIfDpY8CuB1aEg?=
 =?us-ascii?Q?tcl8Cni01FhSlgThpCbJT9Zv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PvU/JmnbmZBNAKOA+zoff/+40wfJLxOugVB+58Ar4UyMH9GdnkrXJn94BaKM?=
 =?us-ascii?Q?2aU3ZcywUTveF+gZO2vkS8SZ7weYSdM02p0orXrW3+/57CMr5QBEe8kFIyPC?=
 =?us-ascii?Q?KF0EJ84vJjJWJ4VTYJ+QIhlQdgj7+hqJJDFAxkqBFxvjPr2Otvown6snDdsY?=
 =?us-ascii?Q?8rteCRJOmZ7WCAVO6tUJq6ZymONxw7ua9pgOQaseaB+wCDdH5n7hohglpXOM?=
 =?us-ascii?Q?yx0dlQGBQJ3cw027d+eSj4H+624HHeqLURGgZpW0H7k9HzAE+UcodZbN95Ok?=
 =?us-ascii?Q?empyW2W2JO1VCcui5sYIRglyM+snEofk5FZ/urY/3IEK+I2BdpaTVZSbZcpf?=
 =?us-ascii?Q?jT1eo+qUyCIJmpj9cazAH9ulhQGDFBhomfUyc8XEUYJSy4nhplFySJUKV2XB?=
 =?us-ascii?Q?hT1DnceBQ3N75hSfQvUeL7gUna+2sV5YRJH0W7CQDyk/kG7h0qIRXrbFQB3f?=
 =?us-ascii?Q?udxJUHBO/PD0BtscTF/c5BbjeYTEBTZUe6RjeXLLi/bwYGJ6k32pc/4SrPiZ?=
 =?us-ascii?Q?5FiufziWIcIds/W7Xr1KgyArnjocNk22WDz+1/pZIyu7O7R+z578ZQ0c2R3s?=
 =?us-ascii?Q?thE5D/vqO0u99ZvtEgI8M0RRpa+zwsEDaudWEQESaRCj5sYHwQI2t40Als2r?=
 =?us-ascii?Q?4lu8JrbQ6mB4ZvpDPF9JhMTCY+b+OD3J1pmqdqVcrXEthgVjWykAO91AGt+V?=
 =?us-ascii?Q?tNpwuqWip5PNCS5x5kXz51Z1iCAjzDbmBH3fxFDZmLkaLowC0jnDqTmt7f2A?=
 =?us-ascii?Q?DRWhCr1q+a5HPQDf3fpUbF6KGgq5LSsJum3s0Cjpo40UQ7ZyTP6B7gResHbh?=
 =?us-ascii?Q?UoSt3+zpNFd15RpCB9aDwan0NoUcMgDGzPLlbwtZ18RnCcF/HcBDXtK0cniN?=
 =?us-ascii?Q?RiJ/YXmELqh9A2V2Mqv+rj6A+L8q6b5RIcLKuwnfimEGyRo6T/cXYdx0KUWm?=
 =?us-ascii?Q?nghDtacGpq3mhZmrY30nCXcV2X5JdVw359oQW2MkLWBta8LqHQ6sZEnjTasu?=
 =?us-ascii?Q?Kz2A0cUv9OJ/wLuW06T/97LhbsvzSmohQa6NWjveFdHoiVuO39/iFyH9XuL9?=
 =?us-ascii?Q?1A5x3us70Tmx7dbxkslmaWLLoUcacsLVmPRfimFxG4SadgBaPy/GtZlZwtly?=
 =?us-ascii?Q?Y2I/Jme/uuliKgPR7zW3QZI0Ogg57fhQHh6va8ThwapmemMLyBOjPHqHa4oM?=
 =?us-ascii?Q?gz67w8LCbKkijYURZzon2bSzY9sCEK9WrzxDA6GG1zZrhcI1y7/bT3evzD4F?=
 =?us-ascii?Q?PAQLA5H0Ls7aD4iNpsMG8r3J/az2qMH728sBPdY2ZOBgXO08WbF90HfIoemH?=
 =?us-ascii?Q?jjuabObSRjk5/Q4MCwRMJxjhvp0vWtqDFcdL1bb/f3IyI/hRexFq2enmKGCA?=
 =?us-ascii?Q?RzOyQMQQUKf3tAk8UwqbLWkD7uZhqr914Acsd2X47N48Ykhhl9+G35VDV9uS?=
 =?us-ascii?Q?T67hj1fR07HKSZNpoe+mjT/mahlZSdlElA3HFDhFRnSIwvbJkStEVDCiqYxu?=
 =?us-ascii?Q?qGN3Fp7aAgIQ5k+fO2k3to+aw+cXdhwzS+j9iD6cOEbjeQZLpgQkuFO8HYp1?=
 =?us-ascii?Q?9kWQG935tH2Yz91HrATTLO8JQQ2RudPZZ5IMzFh3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cad060-75e6-4fce-33d8-08dc8fbb8f71
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 17:24:51.0109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hgaa2cn7F2WEMEhp2BhwZCNyto3f1ZGgOmM5PDUZ84OlKiuk1F5nivap7S4iSOnkJXw4waWYMwypXuEWmHgCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8210

On Tue, Jun 18, 2024 at 11:11:59AM -0400, Ghannam, Yazen wrote:
> On Sat, Jun 15, 2024 at 12:44:20AM +0200, Borislav Petkov wrote:

[...]

> > 
> > And looking at
> > 
> >   convert_apicid_to_cpu()
> > 
> > which already does that loop, we probably should talk to tglx whether we can
> > simply export that helper.
> > 
> > And better yet if he's done some more helpful caching of the reverse mapping:
> > apicid to CPU number. As part of the topology rewrite. Because then we don't
> > need the loop at all.
> >
> 
> Agreed. Here's another option: topo_lookup_cpuid()
>

What do you think of the following example?

Thanks,
Yazen

----

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index abe3a8f22cbd..d8c3c3c818bc 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -171,11 +171,17 @@ static inline unsigned int topology_num_threads_per_package(void)
 
 #ifdef CONFIG_X86_LOCAL_APIC
 int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level);
+int topology_get_cpunr(u32 apic_id);
 #else
 static inline int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level)
 {
 	return 0;
 }
+
+static inline int topology_get_cpunr(u32 apic_id)
+{
+	return -ENODEV;
+}
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 0cbadfaf2400..415cae8d69bf 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -66,8 +66,8 @@ EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
-	unsigned int cpu;
 	struct mce m;
+	int cpu;
 
 	if (!boot_cpu_has(X86_FEATURE_SMCA))
 		return -EINVAL;
@@ -97,13 +97,9 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	if (ctx_info->reg_arr_size < 48)
 		return -EINVAL;
 
-	for_each_possible_cpu(cpu) {
-		if (cpu_data(cpu).topo.initial_apicid == lapic_id)
-			break;
-	}
-
-	if (!cpu_possible(cpu))
-		return -EINVAL;
+	cpu = topology_get_cpunr(lapic_id);
+	if (cpu < 0)
+		return cpu;
 
 	mce_prep_record_common(&m);
 	mce_prep_record_per_cpu(cpu, &m);
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 621a151ccf7d..fc74578ee3bd 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -95,7 +95,15 @@ static inline u32 topo_apicid(u32 apicid, enum x86_topology_domains dom)
 	return apicid & (UINT_MAX << x86_topo_system.dom_shifts[dom - 1]);
 }
 
-static int topo_lookup_cpuid(u32 apic_id)
+/**
+ * topology_get_cpunr - Retrieve the CPU number for the given APIC ID
+ * @apic_id:		The APIC ID for which to lookup the CPU number
+ *
+ * Returns:
+ *  - >= 0:	The CPU number for the given APIC ID
+ *  - -ENODEV:	@apic_id does not match any known CPU
+ */
+int topology_get_cpunr(u32 apic_id)
 {
 	int i;
 
@@ -106,10 +114,11 @@ static int topo_lookup_cpuid(u32 apic_id)
 	}
 	return -ENODEV;
 }
+EXPORT_SYMBOL_GPL(topology_get_cpunr);
 
 static __init int topo_get_cpunr(u32 apic_id)
 {
-	int cpu = topo_lookup_cpuid(apic_id);
+	int cpu = topology_get_cpunr(apic_id);
 
 	if (cpu >= 0)
 		return cpu;
@@ -388,7 +397,7 @@ int topology_hotplug_apic(u32 apic_id, u32 acpi_id)
 	if (!test_bit(apic_id, apic_maps[TOPO_SMT_DOMAIN].map))
 		return -ENODEV;
 
-	cpu = topo_lookup_cpuid(apic_id);
+	cpu = topology_get_cpunr(apic_id);
 	if (cpu < 0)
 		return -ENOSPC;
 

