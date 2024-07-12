Return-Path: <linux-edac+bounces-1515-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6091092FC89
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2024 16:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835211C217F6
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2024 14:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEFD171E49;
	Fri, 12 Jul 2024 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fx9LagAW"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B78417166F;
	Fri, 12 Jul 2024 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794513; cv=fail; b=lzxUOh8MxeLXJqEYVwpiRrDwgprV1kKCjjCNVDbuZzTMDU2TcNhv7k/bdryIgq3WY/s/EF5ig3zBrlx8N3dCckIbmxA50SFuueBLZP++KzmRqReR5+5ej+jqKHCtymMlTBjqcKt8QgL69rCYrBGn6zEG3Ip+rJxrnCnp/E4p+Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794513; c=relaxed/simple;
	bh=3qFRi1M7ZXq1MW3WpaE14AAgksZpLHMM+6yuNc7v/aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ODqS2tx+5JDimc0qnX63sUVOOaZatro3LYLQD4rd4xjcbNaQl0H1YAWR60zdGMMNLrQTcEa7jkVB5WA2X3bwmOXfmhUzI21upX3Kvdgs1cPlTZRC3+59xMtYARuaKwy2WOORg3NmnP8WYssJnGSgHapY33a7ABvF2C3Ac0xOPqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fx9LagAW; arc=fail smtp.client-ip=40.107.101.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhx1CsKHS7IkDKDAwzWwCv+8rnOImMCRsTHGuRFqwHyf9rAyCLvK0DVZ65i5dO7INejrjVTD4lDCx+ThRSWsH0PvxVcIuo4pO4hdzsQsmfQlVmTZvsUpc0f4tB8mDTqs9c3UW83a/Ja3M4h/tDakPZjeOn63cT36hJRgaiCa4dmorOnJFXbleH2V9JA0GJUU0/oRAxUJWgKUCm65E+QY4XxP09xeAobLn7aEVtVqgK/xHR2jy+g+TuZhH6wbxkY/6xas+pWE+fwZICwPf1b5Rf0wnmKLVdg29QrM/q1oekLHc7ResCRNMNQfUa3bMw8x6Zy0Jy7AvJeGkpp2Q50a3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iz7itMvqJMF9fmQ7U1oNPWl6KjAilTsokRSxzbOthE=;
 b=nLYZ5L5h6Mrg7DxFEx6FRvFCvHR5o6FQilPmvjZN6XYvrVGFF4bwdAxQN2wFwbqbgUGWu6De7F9B2aKrd/SnfuqpfxR1FJiefnNrol6rD2cPcXezwd6fHaNQ5hTaP0O5rVEs564C/PWs1U6tzP+BQ4U/ut0UrgjxGO7x0Dh2zSdVnJMBdwO6FDeL0k0/GOPOi1a4cDm9RHAJn/f2mdZcWVn0zGocwYBaUUIyAgI1chTta1WFt6IqSnOznVf+vUILAbUYRXw31mXdmrqD+mUQ4cTYmh90LCSqZeIxgmVyNqhpRmmJOCeZWKd/6lnfMj7E1kOC0eXrh53OdJ9WdAWDNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iz7itMvqJMF9fmQ7U1oNPWl6KjAilTsokRSxzbOthE=;
 b=Fx9LagAWl9t/9lmPXgFXc7xG+xLESTcCTP6VUq2dpXXES6AJkeSothpyhiZFp/N+RcufpxenzdKq1TuCoFKfp/CrbqHID97aUttiGETxwDWj9/hg2x3cMo8mzPL5ZfvMbCda/TxI5oWMAHOrSdcY7xtaY1tlk42ZJZCBYHgEMNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 14:28:28 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 14:28:28 +0000
Date: Fri, 12 Jul 2024 10:28:21 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	avadhut.naik@amd.com, john.allen@amd.com
Subject: Re: [PATCH v2 1/5] x86/topology: Export helper to get CPU number
 from APIC ID
Message-ID: <20240712142821.GA10846@yaz-khff2.amd.com>
References: <20240624212008.663832-1-yazen.ghannam@amd.com>
 <20240624212008.663832-2-yazen.ghannam@amd.com>
 <87ed8l7byy.ffs@tglx>
 <20240626014212.GA1086@yaz-khff2.amd.com>
 <20240628083722.GFZn52QnltR_2gjuO5@fat_crate.local>
 <20240628141542.GA124261@yaz-khff2.amd.com>
 <20240628144535.GAZn7Mj4jofP3Vz2xf@fat_crate.local>
 <20240701175142.GA4681@yaz-khff2.amd.com>
 <20240701190704.GKZoL-WBZ19-z8s7UR@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701190704.GKZoL-WBZ19-z8s7UR@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0609.namprd03.prod.outlook.com
 (2603:10b6:408:106::14) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DM6PR12MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d249b60-b426-4d93-8399-08dca27ee568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wLDJL2xp0gEdbjtBSjJBj/ZTLmHZd+Vfmx1LApzdChGEqwyOsnaZ3JG/l5hi?=
 =?us-ascii?Q?xJN4rN+FuB2xPeBX+tBYisQxlTKeTwlhIkLhLdRqDOuEnGr6QIzHVHok+rp2?=
 =?us-ascii?Q?qNvWV6gPPA5pwsJHhQ+EJjiMPcs/PFPzexqLoEmBnMPjTusZwWoR5M4SCEcF?=
 =?us-ascii?Q?z4GkiM3fyJv0XW3NYwrq+sT2ou+15AK1GBsA2FWXcZWFrFGBI5Tx4o0LMbAc?=
 =?us-ascii?Q?dIymuzHxnxXU7zeEg68/OTCdaanJiLsH+GISNdLp0Pu3A+dv/qHg6pLWxxSZ?=
 =?us-ascii?Q?AMMnv92LgSDuHH2EZHUVlDkaUbzb5UTl72kEEPRFBgkaYduLhmzgfigbPdkJ?=
 =?us-ascii?Q?T9qkm5Q4CBkHCxfSIogNpGDQm6qQ9GGCfzLY5AEfAiMHrnliKTLUq0OcqWW6?=
 =?us-ascii?Q?YsDMe21/WEAQnNmtyDWWlJCowLY+p2Qzb00vMI0rD/MeMG4vjbxzJyRyW9Js?=
 =?us-ascii?Q?KK4MDXZDZJisgnmgRMF+94zgAXgwDSN+WUHhpYneZH8BLBC7uWC5bAcJsmPJ?=
 =?us-ascii?Q?N1XdTqc8JI77Wavl35exutvl1NvI5gT49I5p1s1P1gDeZU4BCujxE/4OPNjC?=
 =?us-ascii?Q?AP52zgZiVk/qkwUkSZ0tokEDUk4iXGBvBVqXj6a+6sr+fKgrGUIK3cdxWAG4?=
 =?us-ascii?Q?M5Z3R5EwCaDd04tSMagX3xYhzB8Gxxkf+8Psp88hH8NF9GZDSV3PjwgDe+AC?=
 =?us-ascii?Q?71MuhtbdxCRb06kAUI/rk2+T1ko6PwtAZqHSPuZfuOlAov6X3JuW8uAOm6Dx?=
 =?us-ascii?Q?feZMIdn9WAhm2l8KpkCfCDUR5XLFwGBD+qF7jUiXHsQjr/5bjSoOiVghq3d2?=
 =?us-ascii?Q?r8QSzmN995LHFslIH8cJkPrWrXQ5tvCQTxhpzRnhx1XbF0NiSqRT2OyN+/zG?=
 =?us-ascii?Q?aORJq5VvyDlSPjRGJcG5ZxvK6jYkQM+Tv26DiTv7eSSFzA5CZ7XuV/r6J2mS?=
 =?us-ascii?Q?zEPoTS/2ITlcIgzdzQphH4ox/WPpxS+ih0BRGeWZGQTF+RBBxwXx0/GjlwHF?=
 =?us-ascii?Q?2S6J6/v4U++FvnraWXvZu9xuyJgDRRVYG12c9kr50T9YluJRM9kVrwZY4xTT?=
 =?us-ascii?Q?RpoYiIRZKST8kGLJIdFp7QC272t9gY2spkapjlYOKjLcyYUvlwHpXxVTCOjk?=
 =?us-ascii?Q?BjBKKz9ZUN3Hi1kwjgT0TUlezGox4gDyEI6b6ei5s229nYzAbeweNhg2ZByb?=
 =?us-ascii?Q?Kv58kKJpzPQk6+ePGnBzkM0iHnHHxe7DWoDQICM3am5avGr5oDnaiJvIhVAj?=
 =?us-ascii?Q?WpogJlLL2H3Jw/3Ww8y09xhYrGilBNafPjM5pgAozyCQpKms/NqvCWws/BDh?=
 =?us-ascii?Q?KLCxCK/CA1hOAXdVGMRbMwrdjReleFBtoLFv2yfDLUWCbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qL1UVLQ0dCdMITH2mtM9xKyOodtojdXHezE0WDJ3pr7Hnsg8laydWAqbBc/A?=
 =?us-ascii?Q?+eR4SmDYHgoXaTEp2lhBbTvrQyTapZ2PEhXKFekU/X7REa6+HpCtiN1I1TC2?=
 =?us-ascii?Q?X6mlC5RzkbHDMndKLQTbs1X0qe2fwSfV6QI3pdDbefyXhEoM/yai9DEu8b7V?=
 =?us-ascii?Q?m7p2mKXKC3BOFWIjjVotrcnL8EL48ZIgUgued61XCtRUswvwQZj6LtxhzFje?=
 =?us-ascii?Q?B5C8mlpAibAQKNa6nfSeqVhAOc7WFY9sS42FDrrgpzV1o3JA9iXnXNr2wHaw?=
 =?us-ascii?Q?5qFgWFliDZkUZVnT357x6MJnawD355cAItUcyc9RWXxE1zsS2kzEpKEyC2fc?=
 =?us-ascii?Q?Bqwf8sFZDCO6r2NAFdQXet7eT77RCg5wQig9++iYlW5KMSS8KgRKQO0Ym+jA?=
 =?us-ascii?Q?aMlxHT7ieH+9QyocgfZwhTDNjeOZoGbEmLcGCdLUEaIYFrqOoTMwsO054SxK?=
 =?us-ascii?Q?3GHeF3o0pqn/kXIyOR9Q4Xa9zeXASRBhWXeegYJXKlKQu3BVRg5YYPOHBPId?=
 =?us-ascii?Q?Ft2gwr59djBB0sxfYDKNth5HCOBZQnoWV/wctXapOHyg9UbiJpZKFlNHbWYG?=
 =?us-ascii?Q?kfNrNoUQVIpdHhlcWbJqZCTM1J+D0pV49nPxWIpgXXlg7oD3ePIhSzTjkKpv?=
 =?us-ascii?Q?3D92eImVj11VyMVVpLXkKIjrOfsW1JWEr+3ypS99CSXviaYnV4U0Rw/VNxnt?=
 =?us-ascii?Q?6s4w/6fu2iY2Me7VNhqaEctwAAZU+UrEpJATfPPaIopaMwF1vm2LVRwyevbk?=
 =?us-ascii?Q?60GfaG7nPDkbTUHlmJBrJKVmZJAnzk6NtO0FeJA792c9FT/8pQSPOYarNMg7?=
 =?us-ascii?Q?KYK5NZZKy8NlanmOlxQQ7HgbeFswOTcqn0txIMCzQNwW8wJ9Y+fZx7kTDQfp?=
 =?us-ascii?Q?pCRg0+C2QKhLlRGcguoNKp9TLbK2D2GFKWGlijuxlohbYHxDoIEb2iGpbwlj?=
 =?us-ascii?Q?2ig06JOeAupbDRJcAW/anpZAKWwumFIII4C9DMsRpwd/gjUGpqf4J9OFYYw2?=
 =?us-ascii?Q?cYc6VHK2+eAm71PKUT3hCdyeCCd8NlW2WeUMvR2FcQkfxscrzofI0p6g7iHZ?=
 =?us-ascii?Q?YVCADGFi4Dq+avMnft0ZBYT73Ozz/6/vo0a7SqcTbmonLi7XN8tJUvOPSwcV?=
 =?us-ascii?Q?Hn2R9QQIficiYYTaUpIj3iukJh1832jPy8v6M3yultFHkGJagl8bql5jqnHu?=
 =?us-ascii?Q?LTMWpUZBASQcKe9OgSl+biud09h1dFIJGvANeSSBqaFxM+4TR9NVefb/AYRj?=
 =?us-ascii?Q?UW/o1hvjpDJOWWam9ra4X3u2tkELLxNGld85fr1NRkKaLa/rmrkckpYY/VgV?=
 =?us-ascii?Q?WNKGkM1C0qqlea3Nut2rPmQXoTIDt+DqoCmaBYYzmjc7AdXa6z/Scgoallxd?=
 =?us-ascii?Q?TfzwVMyOUz7/7h6wx26XB5a9h226XN5IykuaW42M8cAbSbK9cpUco+9XXOoM?=
 =?us-ascii?Q?/RRONuzWig92FYir5ZHo42PJWV4BkvIPJmxVcStWp1N920kkXvntrcPAnxmg?=
 =?us-ascii?Q?ASEDZGeFVO224MCPFgkSXBw0y9TB/X1nEKXMZaRlUYACA8FOsol6UceSJ2co?=
 =?us-ascii?Q?s4b6xGk9tQx7x4NxrVEVo5b40zvk9oXmXVGU/50+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d249b60-b426-4d93-8399-08dca27ee568
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 14:28:28.0626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ke/fygVCJwD+aeTLrEpGb19TfvjLsq8fKV8xp2ciA31XEw7HXnAG3KLZ7kUHO78vHNza+pmxZ3O6LAUgF+nQMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156

On Mon, Jul 01, 2024 at 09:07:04PM +0200, Borislav Petkov wrote:
> On Mon, Jul 01, 2024 at 01:51:42PM -0400, Yazen Ghannam wrote:
> > X86_LOCAL_APIC depends on the logical OR of a bunch of options. So it
> > depends on "any one" of the options to be enabled. But it doesn't need
> > all of them.
> 
> Yes, I can see that.
> 
> How does any of that info answer your initial question?
> 
> IOW, if you don't have LAPIC support in the kernel, what CPU number should we
> return for any APIC ID serving as input, and why?
>

I still think it should return an error code, because theoretically
LAPIC can be disabled and SMP can be enabled.

But I spent some time trying to see if this would work in practice, and
it looks like you can't disable X86_LOCAL_APIC without hitting a bunch
of build errors on x86_64. It seems like a lot of common APIC and SMP
code implicitly depends on X86_LOCAL_APIC. This was true even for a tiny
config. However, this worked for an i386 build (with SMP=n).

I think the most practical option is to keep the local search routine in
mce/apei. I don't think all the additional complexity is worth it for a
simple for-loop.

Regarding the X86_LOCAL_APIC=n build issues, should these be
investigated?

Thanks,
Yazen

