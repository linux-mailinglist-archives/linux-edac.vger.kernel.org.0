Return-Path: <linux-edac+bounces-4836-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 210A1B8709E
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 23:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24CD3AB203
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 21:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE9F2EA47E;
	Thu, 18 Sep 2025 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DpEwqNHW"
X-Original-To: linux-edac@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8755829D297;
	Thu, 18 Sep 2025 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230056; cv=fail; b=nyVtdEBeiUHMynpiiXGn5ZkVKgvvKIVZXDl3l7R93R6DAN3x4vpxpg4hYjxkxLpcsceH8iHu1xCahme68FcfdMwEKdjgBX73eIpXXrdKIBgksG2MUK9ie1H9/shlkrp/ZTpukdCZahizMSY0lccp3CaeMysHBvxCou0iucRLUJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230056; c=relaxed/simple;
	bh=oaalE50FVo1ehbYRJVkwduC63UAf87nN4QyTZPc/Tjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CWMUpFNW4dSv94AkRbYVFLGX1JrC+69MjsgJy5utF1+4PpIkpeFKfztOm91poGqKNlouFKFO9eXJoKwVL38c+0cs2mdW6sRaFFaNWOvpurkQuKVHSt3JCMSNdX0yeEhFr/0zLu5NTMzvVPKUco7EsVOV+HeEcHx7stivYyUDF1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DpEwqNHW; arc=fail smtp.client-ip=52.101.52.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpsf9U7xNfS5nD2eYXqSWR/OeF2yuQPk2HulPEor4NomCSyXxcAFubtP3omceSG4ap794bcmmjYlkg4mJmTBbFfi4M8loN7bqsBcT4vZAjEY7dCFtcjeT6Sjqs2/FG77ywBXNpoD8BCCp9vNf3SQK+Kw1MS3ApMv1D1qhQ5ZlCh2WVmtnJQakfaKsbvy4mEKWZDvtmdYm+sqi05xxgCSidUKdtuyVag6WXwgTuD0/elks3bC73WKAxSnbU75VT95KSaxzPo/IOgjtqblVFSORB3jcd33xlKESGHIhv8gKI2pajf6UoBzi/C7LS7KGtj6iUoquJXWlNrMjyOFzln9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2NahqIcijTzBmKC4uXpwBGSXXWEzos+U+VQEkudw9I=;
 b=PVKPcUjtCxvbFD769oPvuRPcYRavLdmEjC3z1XgebmzYImyggGKDd1uK2aLgdqeJspjzQ3Kx2c/XPio3yvab6nS4fX8oCZWBAKJTbLY6weva7t2i65XpR0I5KYTTKgIqjK5+MmTpgymVP0TBYfbs/m+ByyNlJ5D+IpcB3mrpqxQS9XHHOUaPQM+rXEdl7UFAgsAT+T/lVsbiwWulmgJgSAarD1URCQ79bFLWVIZE0Qv6KF/KnDFoQhRDVS9nBkGFu1aWP4pk9lhcn1/U7lLHnb3sUtq7ktNdVk45+OPHaT3AUmowoDqQ4c08mINdRlCeFZ9WOaBKXxfwhVfvzXyDnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2NahqIcijTzBmKC4uXpwBGSXXWEzos+U+VQEkudw9I=;
 b=DpEwqNHWiZ4mDTJStQ+bqhxIGyU5sH3+Z+TJ6wF5lpqB1ErtZVco05OKIFSBtp96y55r++G72g9GwPtUSza2qlzFHdEBTNX6Cdce/SYFaL5JRcF+ErJOlTtLg5nyvnpmXUjerWCih7vIzbRFjXWx5aIeAKioq6tH1J2+XIm/DXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.22; Thu, 18 Sep 2025 21:14:09 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 21:14:09 +0000
Date: Thu, 18 Sep 2025 17:14:05 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>,
	Bert Karwatzki <spasswolf@web.de>, Borislav Petkov <bp@alien8.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: spurious mce Hardware Error messages in next-20250912
Message-ID: <20250918211405.GA2180898@yaz-khff2.amd.com>
References: <20250916091055.GAaMkpn72GrFnsueCF@fat_crate.local>
 <20250916140744.GA1054485@yaz-khff2.amd.com>
 <9488e4bf935aa1e50179019419dfee93d306ded9.camel@web.de>
 <be9e2759c1c474364e78ef291c33bc0506942669.camel@web.de>
 <20250917144148.GA1313380@yaz-khff2.amd.com>
 <6e1eda7dd55f6fa30405edf7b0f75695cf55b237.camel@web.de>
 <20250917192652.GA1610597@yaz-khff2.amd.com>
 <5ba955fe-2b96-429e-b2e8-5e1bf19d8e8e@suse.com>
 <20250918210005.GA2150610@yaz-khff2.amd.com>
 <SJ1PR11MB608353C84F69E8EC0D6744ECFC16A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608353C84F69E8EC0D6744ECFC16A@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: SN7P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::34) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS0PR12MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7ff0ec-866d-4e27-ff60-08ddf6f84ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ED744L65BdE3+rMFXyKkbaiOof9wj5CP82sePtv1jl9PW7YwkHt3D/BtdePR?=
 =?us-ascii?Q?lguqegBtNwnD8XptCOK9RzSrTApbHLjaJ6w0w56/yPH9tq+aT359A+dF6dfH?=
 =?us-ascii?Q?s4nC+MUWeiCeslSDQJcBCuhquktO8YSaWnMVAIvD8vlkDYwB/4o552lPyvhO?=
 =?us-ascii?Q?zBb6F6XUZn4E3X2n+LcAukppgkH1mejH+3KEMs63bc52q+oOOi93v5phiMom?=
 =?us-ascii?Q?DfcuyVCWnhIawbPrMoKqDimH3eA4kxXUw+CKTDIIbE5JVlQwn+Ap5yeCiof0?=
 =?us-ascii?Q?yVJio6znE/Qp1bhLAvDIzD9PxQNdP1ES7FfdWlHKadHnk0g2MGmqWCpOjHJ3?=
 =?us-ascii?Q?wxuENaAW0rLUPqqKtEjWsToeJV+Vue9asKrJRGlpY9sr5pRpKzFo5XUXDLoN?=
 =?us-ascii?Q?M41XKtfO+RpvwzuQ4G4MJOwj5xYLTXGRZjujX1Lsskx3Ls1g82b5gwsLVtoh?=
 =?us-ascii?Q?WrWh+vVjBGyXiHHf4VYSnWbtRLRnWpAnc25WeU8QbqWO+FIRJIkq0OPegrDq?=
 =?us-ascii?Q?U0PjId/SXe4tGlA5yYFkpcGqvP5DuELDljs2nyUhRbfFwRyXNGexoqRe9Lzn?=
 =?us-ascii?Q?UWH/RR+ksvjcuFXMV/paaDluk8dOu0j0f8wZEyQVo3tPnAv6AIjkKjRLEISA?=
 =?us-ascii?Q?Fe/scqL1GbwTNXT9sKCJBFw7sojj8XAsjQNQTJ0JC0iKqp8lHDhoSIOc8WFb?=
 =?us-ascii?Q?77vLJjP7jljgFvb78ls7SkTFJWylFPZm6Mhw0u/m467L3utNb+1CfMUH1weP?=
 =?us-ascii?Q?RMMFnHmhRF0UVW4CaRAzPtgj2/tmuxhUQCZKtHAHhYdaIHNyFZ21jmKPNC7r?=
 =?us-ascii?Q?94SKw8GEkPjjxMLsLUoubFvJzHsBoSHplf+hiXpwo3IQzN2eOfbhegT9Ik+u?=
 =?us-ascii?Q?o/nnkV3Oq8am8iOVoLCxH40lHrFHUTBGGNk/VpebyISSztTXcO2qQqPRlDmK?=
 =?us-ascii?Q?vGda0easCRXFtKK3iMOvBJxgaUs/gl6W8ZN8KZ9ulUHd3SbWubn4wJryJbby?=
 =?us-ascii?Q?YfKL/QHmNH06MVYs7lf2ULcImQ86hOV5RPYTurAEwZUOOFfyIXQVVI5lFkOq?=
 =?us-ascii?Q?xvTs300MvyPcltu1dbrE6IkI4KYNKknfnhv4bco2CKCtinh/Ihufe+P+3fv/?=
 =?us-ascii?Q?nnTKMMfoImpDqyxhO1kJHNFolBdryhhdKJTLYk9pQiH6SxayjyWTm54nIYF5?=
 =?us-ascii?Q?p4YExnr+nHnGuJDS3QWcxH/+hDEIXHT4jQLdI/9aihxozrqlilMO3Xm5xrCq?=
 =?us-ascii?Q?aYq1mlcIFXADuA9v4/ZyvNdadEGgiPjKhhIT00ygwifArjsI4DMrSoyUhy3t?=
 =?us-ascii?Q?/JmKl0Ib0Xd78A3pcOzrAYpNBdlBUXZR5udKZIkPEdS7rrvq+uUzM5p2ezhZ?=
 =?us-ascii?Q?ie4KpqvBdv3OwsehNp2x8fufjSiWlLyj4Vq3ADFrK7fEBAMkx2QB8uRjwqQB?=
 =?us-ascii?Q?+s6u6GfQ+gM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oB5+tN/hC7P6/OwuP7LmorFHyC0Zib+HKka+l+Zo5Uza0TiXDSz6cnZrLliP?=
 =?us-ascii?Q?s8eFwSj2hB9te7Sk2rCm8dNhpJ2zEI4Wyzi93h8WBfr6dMAIs62bUCC7w+nT?=
 =?us-ascii?Q?dyt4cNR06CJzEhPfZLNY3DM89kx4+KEk9NfwMq4DeRH9df5fkZRknSef55n0?=
 =?us-ascii?Q?Tn3H6nltRWzrNODgwvQKzm51RsCx3KVGWh0QvMa8y9Yl46szEBOm3UIXht82?=
 =?us-ascii?Q?mXqhj3cIIuQK1l6iHKZoK7UCnFx2INqJwePBYEPFPJeKDBZjPscUyWLxPmPS?=
 =?us-ascii?Q?tXx2BSL4+E8xI3QMT9vYxExq85zmStm0813lFP02LQWpM8fVaYubM5dqo7ZT?=
 =?us-ascii?Q?GZCILSBWyBLvZsWlMHCVDAYQlrcxJbc5XeQ5FGhrV3ve3wmS/RENdnmhubB0?=
 =?us-ascii?Q?rJockCg7Iuuyd2JUjIUBRTZPLtSBB50Wg846JZKzO6bKdpw9gRJQSuAZ6/Uq?=
 =?us-ascii?Q?s/LwvXpQCkucdPTu24PUQz0n7rs9LaeQBd8XjLwMg9YtaOsfKrtbiQgmj/an?=
 =?us-ascii?Q?/tUFO1jz8bcJdGP8xtg1NV2xHQOGu77QpG39CHVD0qoBTW7eIG6rhXZb/S+s?=
 =?us-ascii?Q?FxEmMrGtCwO2SHrfsMiYeW2BbtTcu2OstTUyyqAxov2QbTRRFGIpQAlxz4cx?=
 =?us-ascii?Q?bR+/Tgfir2Jq8YD0gWe4qT62xLMuYXO7S4uW8VUlVasr/EQVlXFX2OcLhYtw?=
 =?us-ascii?Q?kzSvSdt7mkO2LGB2FoBuvuYUFQugE9K13L7Febc7GP9Q8T2OLEjKgDaoi3ja?=
 =?us-ascii?Q?WRIOXazOZdc1LgRlH1pitqZNmUVK583fBs+ZITVFP7m5mp3nF5A8Yq1xi0bj?=
 =?us-ascii?Q?knZ3EmT99+5VPT50L+JmCl8YmUSuQhXi1Fw5UulbZRxBGMKLC3ax7gPatbY6?=
 =?us-ascii?Q?7y8iWGk15V4EWGOuFHK9hW27rlIy6KDBOSxS6Ww7venvNgLNjmVxE4fgYeEi?=
 =?us-ascii?Q?EYTRsNlkjn4fN9nYFjReE512sPFeaUPV+q9hPLHEI6WHZIXEWyvlRbeW8LAt?=
 =?us-ascii?Q?VFC+DIkreczN2gPb4FAO3I3rBPLihJQ809bDpJ0j8bSaDP1FHyBueo0lI3sI?=
 =?us-ascii?Q?N7SjpDpY1xkWjiQxsf4KbA1on6v4hacTvWuaHefk0AeXnHzNWFQ0/smAAil7?=
 =?us-ascii?Q?2lywSdmgGuJ6Dn2gvDn9NzdUTKTbyYrmEEj3UiWHQZp9Xgyo3H9xui3o2lRl?=
 =?us-ascii?Q?gV7Trza1G3hqgMbo4BjGVLNIlwyz3bhCUNhEEpm2iXOzJv3gCT2e8jzIRTdd?=
 =?us-ascii?Q?t3DvSrQLWib8bemBd0JUau0qv4s7V+rQpWWLi7UajEvysFWk5X15GJIeAvsG?=
 =?us-ascii?Q?NnW1oMSO4pKwDydbwMI0D7lSAXdg3k2qwFMFKtQSXnlPP7unq8j82W7O5qRt?=
 =?us-ascii?Q?ZqjXq+rT4LwBVJSQsUPMO49UsX9HIifd+e+3hi2yKDn0i1qqs+OpqcVq8Qqd?=
 =?us-ascii?Q?UVwPsdhm7QZhryVf2CvU1SPseZTTRVODAjeusYvYx7mrDWrc0MtMSlvOggtt?=
 =?us-ascii?Q?wf1gf6FEy59eoGPYSdFsuFr/+rw5zedQIV0o6B6KUtZDAk+dwiW5U9lKKTZ6?=
 =?us-ascii?Q?sQ8MG6dRrFLJjrkOr/B6mZnG3wxfNVXl09Wkwu0z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7ff0ec-866d-4e27-ff60-08ddf6f84ee5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 21:14:09.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtxZyJSLmyphnWID9c7VQMx/9UOuo/Eg2RU50sEIzA88V2msKqZI6uPQnIYYtAEUwKzplkDowoVkrCjHADNcJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462

On Thu, Sep 18, 2025 at 09:04:53PM +0000, Luck, Tony wrote:
> > For the current issue, it does seem that the registers contain junk
> > values. And we are only now seeing this with the recent rework.
> 
> Do you try to clear these registers after logging? Or just rely on clearing
> the MCi_STATUS register?
> 

Yes, the MCA_DESTAT register is cleared in a couple of places depending
on the scenario.

> If you are clearing, then it isn't working (or new junk values appear quickly).

Right, and MCi_STATUS has junk values in some of the affected banks.
They just happen to be ignored because they don't have the Valid bit
set.

And MCi_STATUS is cleared at Linux init time, so the junk values stick
or come back by the time Bert ran the script.

Thanks,
Yazen

