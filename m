Return-Path: <linux-edac+bounces-4825-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E46DB81E91
	for <lists+linux-edac@lfdr.de>; Wed, 17 Sep 2025 23:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 537F77B9522
	for <lists+linux-edac@lfdr.de>; Wed, 17 Sep 2025 21:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E5630C10C;
	Wed, 17 Sep 2025 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dzZYdfTh"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010001.outbound.protection.outlook.com [40.93.198.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B972430BF6B;
	Wed, 17 Sep 2025 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143726; cv=fail; b=pw8p2UE1Ek3LfFz+rEXuOY4BZVErBEoTft9qliHgNsi188SjvoG3w24rB7+c6YtO0ioDQZR9gZWJpyuAvYFDi35h1ZDvBJysRJ+A1bDi83eaDgdnbLRkCXIwf8sMKBa23HE1GKjaB5ohi9jaNolHaLHcB6K3Hxaar7ceDS6pIdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143726; c=relaxed/simple;
	bh=foGnFFjYMb7QVnOg1/MXC2SSm+edRp1VpbVF6+yWwpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MPtyHWp52FPmtB43/0nr3LZVI95GBmYtfLdcX3HNSFNAGrhsBDXVs/T3YMTZLCwRuk42pZZcGI8TTXDLIW5+vtKT0pqWUxBRGwuJSa8b+JU6U3DfkGwIlQycI7o9Bwkhc1JVs/mRZXxPM5C2xyFylpKh6hy9UN2LhOVp2Zf8CbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dzZYdfTh; arc=fail smtp.client-ip=40.93.198.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSGL2aiJiHhjihq4aIR7Jclcjyf7GP7rELknMEYiHFhTeRCLkyugLz5jotzYppEdzK7YKUJNW42hcRctIbHwgl5Tr5IdJEMMXEByALUAcdN17X+mNCyybN8Q1xrWY76eNtgi7tNIK7EEV6lU/hvkh5NYMK28TxlDg3wRbJVRzFugL2wSvq0dJT7WsS7EALSrcZqW6k33+UemywJFsUlCP19qDxsVX/2U7SEyIF20kS0AzOAWR9EkdbGMh2rxyEcGR3yqQOJSc+fsEM/mFO0e5DNp/5AiESkTfwZpXpNpnQDopSp4kozDPDxfEOIm5Scv8AfdoCXPyWbn40LcXDn2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUJ7ZqJa9JiU1bTTVXc6fxffxoHPgw2v+VWonIJq/ks=;
 b=OA9k3PVnnaZfwESw3GfgSIb9oHyoUGXMXo0aM9M8jl2y1CDutRWWlnzrFVNtUqYSkFhajNpOpQUFTyYm0n1drpyH4sDkiU7jkHbRiac3ljmcfEfyHOePWH9uFVYtZxVmgckZdD6qBN+l+/fmZrKHyfEg4QFZ9A0R3tMMEbMiAuJOTZJuQdnckB5o+/XAJNVsA5PMgjpZQehBL0i2OOoqTipDZ1uq7kHYBavoBYlqfKJolMAVM1KUAmGx3WVfqevcCedjBadh5YZLnJevqF1QjhkDQ2fhhQ7e6AjMN06GV/3xQwTScONHGHOFd5dm9U/wvi62z/SHdAyvz0cvESX5WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUJ7ZqJa9JiU1bTTVXc6fxffxoHPgw2v+VWonIJq/ks=;
 b=dzZYdfTh63SSIadoojNz0jD4Js4Cgl1n8ooZG4c9ZaP1SCE0P24Kt528Ay4O8HiAjaZuP/nyVU3E8BAJ+7Hq082iFTyOJCLQEXiFAKuqXe6+C3yUe6Q9qHXRpU4M7UcJsShYms+Mg1ffjTPdH//cZqqn8lBkyogsWuj8CQuCWzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 21:15:22 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 21:15:22 +0000
Date: Wed, 17 Sep 2025 17:15:09 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
	x86@kernel.org, rafael@kernel.org, qiuxu.zhuo@intel.com,
	nik.borisov@suse.com, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: spurious mce Hardware Error messages in next-20250912
Message-ID: <20250917211509.GB1610597@yaz-khff2.amd.com>
References: <20250915175531.GB869676@yaz-khff2.amd.com>
 <45d4081d93bbd50e1a23a112e3caca86ce979217.camel@web.de>
 <426097525d5f9e88a3f7e96ce93f24ca27459f90.camel@web.de>
 <20250916091055.GAaMkpn72GrFnsueCF@fat_crate.local>
 <20250916140744.GA1054485@yaz-khff2.amd.com>
 <9488e4bf935aa1e50179019419dfee93d306ded9.camel@web.de>
 <be9e2759c1c474364e78ef291c33bc0506942669.camel@web.de>
 <20250917144148.GA1313380@yaz-khff2.amd.com>
 <6e1eda7dd55f6fa30405edf7b0f75695cf55b237.camel@web.de>
 <20250917192652.GA1610597@yaz-khff2.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917192652.GA1610597@yaz-khff2.amd.com>
X-ClientProxiedBy: MN2PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:208:236::8) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 678a0f20-fa7e-41d4-bfe5-08ddf62f4fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H9N6+jialJXqLs2SBgb4u5jEwNo/CAkT/j8W8J/U3V3W3yyZ2Mcp5L0crANA?=
 =?us-ascii?Q?gKrUr7PVw9noH/ROVSz4m21bfUVqSjY0Bia8qE9Luf86T/0M9N5UGpml4tUD?=
 =?us-ascii?Q?unxwvYrObUnMK7DkberdpGMZaydnDCQZV3svDrKQwxCeyc7+RiC/gDjzzP92?=
 =?us-ascii?Q?T+uW1zxOAwPO1DfApRuspi1hVSbgUEp8Z24eHJ3cQKWsI7k1+DCbXfwR07Q5?=
 =?us-ascii?Q?auEswtaDQB6I+KSNPXUxiH02i/QuWnMdz4lS9afsW2RBEpli1BZmrKC7dDPZ?=
 =?us-ascii?Q?ZixKcojb+qEjbpOj1u7Y3LsNLbyNUGkycYJ3ms1LKipCB8LXoYfQvkUnRJ4D?=
 =?us-ascii?Q?167CfacX+EeZAs9sNVV6agIc00rXQWrnTHlUn8NPI6lMYhQriv7YYSbySnBs?=
 =?us-ascii?Q?KzQQOjIe/ZWkCN3PdiXz4Ths3XHh31QN9neHEMiy0GhsjfIULpRaPqkPBpmZ?=
 =?us-ascii?Q?mDSLTqtscoNL/R1sJv9RJ1mb3J8egJSDqD2WNnFJi28FDtlgjz8QqJs33TE5?=
 =?us-ascii?Q?rPkngv20FCDmyit+Wu7Q5FVkPf2HgdkLojhDaonmhGY7w76wWiAYOepPT6YQ?=
 =?us-ascii?Q?XvlU8lx9eBuwuxd32q3xjWdtkUigC0/SwfqAPDnT6gjqLSKJewRtEBeMbcWu?=
 =?us-ascii?Q?++c5DvoP93KS2Jrk/y8uC+QfGK6bYhih/gULrb+r4kWkpRPVW4OS5dtnMvuu?=
 =?us-ascii?Q?lyx+P28zLj3tWhdmhCA1VvtIlQfgEvFbAsKKRfbbSG6TwFoMkK9BFK1+8M5m?=
 =?us-ascii?Q?75Igij+HE3gOswRUYMJakK6GlovEO3h/xrkkGnQTsIT+gvx3bafE0lamPoxK?=
 =?us-ascii?Q?e2nw5ot9R9vtDbGv4B06Rp5M1FSL1y/QMG1deRTTajh4BeAwxfJBfYoCz3nB?=
 =?us-ascii?Q?dpFc40N23C887q4hiKb0gPvwZVoxISCVkLZZrHmFcmZ+djApLkglG2YopWPS?=
 =?us-ascii?Q?wZnfoLJ9ZECIY4eob6dZeLRBGkG96RN6TMc/YIpzVx4i2+BFSNZHdW/ak77e?=
 =?us-ascii?Q?GicHhljGeq6XdnwgKQeszzqLGHiVRxtH0LJrOImr7Eww1X19AGB96Uv4KGeF?=
 =?us-ascii?Q?CEWksyPYWp+lI/k8s9n2afKZzQtuZFq/RVzkNahOFiH9I22l7GrZprs96sK9?=
 =?us-ascii?Q?tz2DJWsfq5XEopB0XShWgELSkFRlV+l9UM92J0WMNFcd5crUSzl1MtSbOQQK?=
 =?us-ascii?Q?k6Fy18EsDmnPPfngy1mISn+c9gV6r+na4m4nWC5vucnM6Z79LAUqGtvsneNr?=
 =?us-ascii?Q?5GlzXAyBPC5Kw6NCZ8/RZiL+hAP8O88J3OYvInlDl639Zeaj2H7sztcdj8Jd?=
 =?us-ascii?Q?Trwz2eC6pdynjXe2LZo/G6Agg25KBBx1LeI1nW7myPG1dekQL3duo25F+28/?=
 =?us-ascii?Q?aBQ0Rz5zyQMzL7jMH5eBZuFuGUiOVfkCpf0qsBxGpHi1tfhd80EUBuy4ENy2?=
 =?us-ascii?Q?+dzr9XNkkGw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RXi/Q8B5JuU2vAhYHPBRlhx9BsgjyojquYxf9UJ72WWzzlh+4tEsJQmdWlFs?=
 =?us-ascii?Q?Ims75O9nHYsO75wdeTuctziomBNNPMNzjQhuqZatpqb7XQr25wZwSr+ozn2G?=
 =?us-ascii?Q?DixL7CJlJ18eew2vWuDvuXzGkjecoGgvEKAtENxw3zU1eS2z4ha+H6HeaF0p?=
 =?us-ascii?Q?uOR+63+gdDqN6ajIJoMXzKqrYsjvQ4VChcehJTPqn86Djf6sAKn6Gmhv/9NO?=
 =?us-ascii?Q?wu1nGKXuYYJlQfmPAVelhU1iB4Em7Rvk+CogAmF40TBxcgB6BIfYCDBuACr7?=
 =?us-ascii?Q?uinAN0A4EyF3iJRsTPLfANkgXjYekc3NvXIMgiuHFaY/QsM6P9dUVg57SCcb?=
 =?us-ascii?Q?Obeb2mkNbZRbyDTMPvKy+zASNkVZximrDYB9EbwZJn/MAfzmGZj1vLxsQfbe?=
 =?us-ascii?Q?xgh2LIpD1gIosJvNNLVBjuLl1ol4f8MWwWgDvRlzjPSPE40hY4nIp3Zsmje6?=
 =?us-ascii?Q?5kd+eiS/JxO7O9cdnMq0jSobHPIDy7d2N2vWm3BPh8xEGmplPuaVSjY+HcQJ?=
 =?us-ascii?Q?nB6Et1yNcNB7eeSEFb3O4VohjjO7yDlefUrYJSGFpZxPoYkTyKG4S1c8hZRl?=
 =?us-ascii?Q?5YgQTQAd5drnRabvJIqI68nNEkNvnYIB/CiZHhKs54HxdHg+qIasccTjXWhP?=
 =?us-ascii?Q?BWN7/Au6XS9DM7KmwE864i22jhXImM3OCYVM0roOx1mkDqfbuYIyyS/ueKmH?=
 =?us-ascii?Q?0CZIoweqlYewWM/T8RswD4dJjCy6zvtuaBcXVoQIiUjp+3m6d4FEVEXh8Xou?=
 =?us-ascii?Q?KHb3z2glcE6vN6lIAHLe6H8BiV7w7m31RiRg9aIrmTgkHh6i1fNmHhCzVO+b?=
 =?us-ascii?Q?LR07qZKMq5FpmuAyT3MVbyJKJK36x6sA1umLSgF9sdR2Y7/lnVS4WnWlrwa5?=
 =?us-ascii?Q?cszfm27vIcSoadG15SP7otwdz2dlmu8R6s19utquq0NxCOnz2/FTVk6xfHkI?=
 =?us-ascii?Q?O29qdEbMNWzpdmGr1visaMggSGT4XzaPphkkXTYFSmDVcQPqIYXyr97m04Sy?=
 =?us-ascii?Q?LCB4wmSkasYuS0OlZbEf/MmtUjcRtzDo4otNg0CqLq0VsyLecmgo/gHZRd/i?=
 =?us-ascii?Q?tSRvzpAKRZaZPz8eXAmdmLId10yGSbnkYTO8pkMd1zeTzPnNBmvYb5fnrq9v?=
 =?us-ascii?Q?mRttamKKfemKQGeJZpy8VeILlBo2xb0XMB1T4CDzAlSNQe6PAyugtj4ixcVv?=
 =?us-ascii?Q?CMMc2fq62A/omWbZ/TI84aukyQOedYe7/tx0d+pd/F95Qq8LYMmRsBauQnPR?=
 =?us-ascii?Q?CJsd5KDtFSs/wl823S7eGIAEZKpJA/IhjRjaJpd16NYt3idJqjCvNNZynDlz?=
 =?us-ascii?Q?W1waYAKB7pHjbqD9iKW6CFVsfjKGy6KZkvV7j3K+mmmBOwqC3rQw/doTj5rS?=
 =?us-ascii?Q?49vpPs6mwRHvhduL6xHIoWqEJiC0VaswBDhRwnLVFTr0PZWoU9ahUIR/Kh6i?=
 =?us-ascii?Q?H86fhZf970BtFgF/vB5LhmKA4wuLhAPX2cQ7k+k7f3eVoW6qhERBD8CrYHSk?=
 =?us-ascii?Q?oHP5jwfgz4aSz/kY/g91ARYcEwEGwtQgCeUDaP4NmDUYHHmNbw3RcwXpxR0y?=
 =?us-ascii?Q?QFD09FxsMukycGFXac6cqQ+BrPlkC2rZ6Xs+5rvF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678a0f20-fa7e-41d4-bfe5-08ddf62f4fb8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:15:22.0133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82oaIgnoWu0yFkOkgZaCSogg3zW2f9HiAy4L9F6PSh0re7BxDNmsJqFLMiEOt/qnzHX3THHt702PRfDjE42yhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699

On Wed, Sep 17, 2025 at 03:26:52PM -0400, Yazen Ghannam wrote:
> On Wed, Sep 17, 2025 at 05:33:29PM +0200, Bert Karwatzki wrote:
> > Am Mittwoch, dem 17.09.2025 um 10:41 -0400 schrieb Yazen Ghannam:
> > > On Wed, Sep 17, 2025 at 09:13:11AM +0200, Bert Karwatzki wrote:
> > > > Am Dienstag, dem 16.09.2025 um 22:27 +0200 schrieb Bert Karwatzki:
> > > [...]
> > > > 
> > > > I ran a test for 10h and got one real deferred error, I also looked through
> > > > older logs (which only go back to 2025-08-17) and they do not contain any
> > > > mce Hardware errors. Here's the output of
> > > > 
> > > > $ dmesg | grep -E "mce|Hardware Error"
> > > > [...]
> > > > [10163.739261] [   T9326] mce: [Hardware Error]: Machine check events logged
> > > > [10163.739265] [   T9326] [Hardware Error]: Deferred error, no action required.
> > > > [10163.739267] [   T9326] [Hardware Error]: CPU:0 (19:50:0) MC14_STATUS[-|-|-|AddrV|PCC|-|-|Deferred|-|-]: 0x8700900800000000
> > > > [10163.739275] [   T9326] [Hardware Error]: Error Addr: 0x0095464100000020
> > > > [10163.739276] [   T9326] [Hardware Error]: IPID: 0x000700b040000000
> > > > [10163.739278] [   T9326] [Hardware Error]: L3 Cache Ext. Error Code: 0
> > > > [10163.739279] [   T9326] [Hardware Error]: cache level: RESV, tx: INSN
> > > > [...]
> > 
> > This seems to be a real deferred errror.
> 
> The "Deferred" status bit is set, but that seems to be coincidence. This
> error code shouldn't have this bit set. Likewise, in previous examples
> we saw the "Poison" status bit set when it shouldn't be.
> 
> > 
> > > 
> > > Summary so far:
> > > 1) Errors are found on CPU0 banks 11 and 14.
> > > 2) Errors are found during MCA timer-based polling.
> > > 3) The data is coming from MCA_DESTAT register.
> > > 4) The status bits are not consistent with documentation.
> > > 5) Likely these errors are not generating a deferred error interrupt.
> > > 
> > > Bert, can you please collecting the following data?
> > > 
> > > 1) Output of "/proc/interrupts".
> > >   a) The MCE, MCP, THR, and DFR lines are of interest.
> > >   b) We should verify if any other notification types occur besides
> > >      "MCP" (MCA polling).
> > 
> > This is from next-20250916 (without the debug patch), unfortunately I've
> > already rebooted after the testrun with next-20250912 and your debug patch.
> > 
> > $ cat /proc/interrupts | grep -E "DFR|THR|MCE|MCP"
> >  THR:          0          0          0          0          0          0          0          0          0          0          0          0          0          0
> > 0          0   Threshold APIC interrupts
> >  DFR:          0          0          0          0          0          0          0          0          0          0          0          0          0          0
> > 0          0   Deferred Error APIC interrupts
> >  MCE:          0          0          0          0          0          0          0          0          0          0          0          0          0          0
> > 0          0   Machine check exceptions
> >  MCP:         39         39         39         39         39         39         39         39         39         39         39         39         39         39
> > 39         39   Machine check polls
> > 
> > 
> > 
> > > 2) Using an older kernel, read the MCA_DESTAT registers for L3 cache.
> > >   a) CPU0 bank 11: "sudo rdmsr -p 0 0xC00020b8"
> > >   b) CPU0 bank 14: "sudo rdmsr -p 0 0xC00020e8"
> > >   c) If these are non-zero, then I think we can confirm that the
> > >      spurious data was always there.
> > > 
> > > Thanks,
> > > Yazen
> > 
> > This is from 6.12.43+deb13-amd64 (the stock debian trixie kernel, currently the
> > oldest version I have installed):
> > 
> > # rdmsr -p 0 0xC00020b8
> > 8700aa0800000000
> > # rdmsr -p 0 0xC00020e8
> > 8700a28800000000
> > 
> 
> Right, so it seems we have bogus data logged in these registers. And
> this is unrelated to the recent patches.
> 
> We have some combination of bits set in MCA_DESTAT registers. The
> deferred error interrupt hasn't fired (at least from the latest
> example).
> 
> There does seem to be some combination of bits that are always set and
> others flip between examples.
> 
> I'll highlight this to our hardware folks. But I don't think there's
> much we can do other than filter these out somehow.
> 
> I can add two checks to the patch to make it more like the current
> behavior.
> 
> 1) Check for 'Deferred' status bit when logging from the MCA_DESTAT.
> This was in the debug patch I shared.
> 2) Only check MCA_DESTAT when we are notified by the deferred error
> interrupt.
> 
> Technically, both of these shouldn't be necessary based on the
> architecture.
> 
> So there's a third option: add this error signature to our filter_mce()
> function.
> 
> As I write this out, I feel more inclined to option #3. I think it would
> be better to stick to the architecture. We may get error reports like
> this. But that may be preferable so that any potential hardware issues
> can be investigated sooner. If there's a real problem, better to get it
> fixed in future products rather than implicitly mask it by our code
> flow.
> 
> Any thoughts from others?
> 

Bert, can you please run the following script to print all MCA
registers? We'd like to see if there are any other unusual values.

Also, can you please share the complete dmesg output from any boot?

Thanks,
Yazen


#!/bin/bash

regnames=(
		"CTL"
		"STATUS"
		"ADDR"
		"MISC0"
		"CONFIG"
		"IPID"
		"SYND"
		"RESV"
		"DESTAT"
		"DEADDR"
		"MISC1"
		"MISC2"
		"MISC3"
		"MISC4"
		"SYND1"
		"SYND2"
	 )

for bank in $(seq 0 31)
do
	echo Bank ${bank}
	for reg in $(seq 0 15)
	do
		echo -n "${regnames[$reg]}:	"
		rdmsr -p 0 -c0x $(printf 0x%x $((0xC0002000 + 0x10 * bank + reg)))
	done
	echo
done

