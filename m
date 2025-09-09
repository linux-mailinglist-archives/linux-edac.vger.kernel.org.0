Return-Path: <linux-edac+bounces-4762-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CC4B4FD81
	for <lists+linux-edac@lfdr.de>; Tue,  9 Sep 2025 15:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC211C638AC
	for <lists+linux-edac@lfdr.de>; Tue,  9 Sep 2025 13:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C35340DB6;
	Tue,  9 Sep 2025 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3LHXIGTv"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B0832C33E;
	Tue,  9 Sep 2025 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424999; cv=fail; b=Y0X+6wyCZ1UCSzzdY+xvk6s7i4sQnIndQ0T2tyus08LpX6TP8KMcY7rZ1YR8TmJqa4rMsOzVIrV9ipvJWDrLHb0qHadiZKf6h8fzw3mNXiYZcE7jS2AVF7xaq+ZC7CCGxcUjR8uhoHC+wueS/SUCit34fohV5ijNcJ7GFrgQ9Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424999; c=relaxed/simple;
	bh=grnv5npyCF84e0SkbYpb2XVYfBf6ILG2ON62cmZhMIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U1MH45uJgrtjmOZCAK/Vr/TXbc7sPVTtHrKLr2YHNEmhBazNMrxclPC3riLOAe9lgyT3QkE3N+zlJS7jZt9gr1TmvpJnYdXH+V8RzVYo5rtlsBL3wIDWN9kMR87z7ykmiza2/9/qSRfid1NnsawzcXIqrw2yrA6G2MVXS8ot6js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3LHXIGTv; arc=fail smtp.client-ip=40.107.100.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtIkoi+S7kkjq1oPDCclfxkSSHrO/bstSOidQ3TdHrBT1KZHDij0uZTzKJb2nuvtdjv7b5U4MhcDJpT1gnIOss2pAS7a1YZ7jUw77qT496wfu+xCLNZUZohAq50VG1++DX0Wv+FfuT3uvYmAK1AqzXg5HViYe2GKIR8LpFxrxvGCPf0A62Q6PObbxmd2HZ5nLMyqhnsTy3Tyij4W0cTQT+TlIYOEwQ0XXdRwbDIJnnDhAG0kEc+FFtedOVhdcHr13HnWh3I9yJsjWRKmcM3GS6xHp9SMDxPPSsNfzybfGttlvYad7lKcv69SHWruDKu+KtlwaLd0ZsUaX4HpnKiWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDgVO7PXh7nLS74CD+47EQ9Rjbmyx2AtFswoXzYHROo=;
 b=h+xdWSXezi3CaHVH3Xeu+LR1DPTyXjXHDQEEnrTVetvoSxlQlw94OJuHqrQrXKAl8+O/JRqEyDGOeVKK4J/u3rtsB0b3jmzMOi7idzhM200hqny+RfRVhY0NLIl+oyc5ZLW7C5/wqCkU5SgtZTyNh45TMyG6nBn0A6xMr4dGfiCWMnLMgn2qAtZ6X4Fe4xkfXDElJxsSrxLORza8BLJyiXURejP1cxYgQTaRRZhAgwZi1fYk3hZXIrYhwgnYCjGGAK4hDWhDz41kv+qwlr2OnjsMq1bGv+itAxKSVFpCFqdDIEpEADqJgaUkNRvfuwTsOJlBfxdEx85ncFCWvQTCfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDgVO7PXh7nLS74CD+47EQ9Rjbmyx2AtFswoXzYHROo=;
 b=3LHXIGTvO9Z4W2ULcu5u7JTGc4TdmEPYegUx9uHkjQIXhKk5WWsCMExPuMWcexD70ZeRBko/Lxh8NeMcSoe2XypsLYZj68FPb3s5jYYY20oD6nx1KFmY68RNj9TiyGl7ACZKG4RB3CA33d1ULT+eilPy1zz2bsXjluDrlBxXZcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 13:36:34 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 13:36:34 +0000
Date: Tue, 9 Sep 2025 09:36:29 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"Smita.KoralahalliChannabasappa@amd.com" <Smita.KoralahalliChannabasappa@amd.com>,
	"Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v6 00/15] AMD MCA interrupts rework
Message-ID: <20250909133629.GA11602@yaz-khff2.amd.com>
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <SJ1PR11MB60835A037ACBB309D3FBE7BAFC0CA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60835A037ACBB309D3FBE7BAFC0CA@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: YQBPR0101CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::31) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SN7PR12MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4f6850-1ef5-4fa9-00d3-08ddefa5e484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b/GXK7uToxIx/QqIk9tF7KQwa85NV6Ji2iJpXMu9Go4SHF8c3tMIlpIDZyN9?=
 =?us-ascii?Q?VIT83whT0wf29S6fClxusYBjGpiC1aLj4no/R/b0oQodrIK3NN9punsDL6Fk?=
 =?us-ascii?Q?l+drLlE+DEshGPI7mzLVtvRBnv044kJ4y961hhubG4cPjlLUQvqBCoYNDz83?=
 =?us-ascii?Q?+23DvYQqVVoDrpMCRuV5n2wNh4oKBd8jj696+3dBQ5ad0sP/H4MVOYHsN7HR?=
 =?us-ascii?Q?Z7brJXZ8JKU9joQXaZD3UBD10CTeZdyYyLS9KKzsBbSdWv4qePdS2sH0mgpz?=
 =?us-ascii?Q?/R+J9fJZx29mtYc+lDcakRkTEVgXstmvDYLvSW9uhdk0qDkDML1KcH4nyDdE?=
 =?us-ascii?Q?uyV/TsetLMwr9+YBKouLimmvSE4kRhcEOl3IG94z7qfNnrfCjIjlPeDwKbLI?=
 =?us-ascii?Q?LJwxX5zDVJcNNdqvT6S5sSOxx4ivKQNFG2ZZXg/JjlbBr5TI3G/r31i2T7/Y?=
 =?us-ascii?Q?6Kwv+oFlxXK529rBDziShoSNdo97QrjRuinGEsaEQ18ymvJJYxmy0mYFAw1D?=
 =?us-ascii?Q?pfMOu5uihm2RYku7edS52qLs0levl7R8A06nzi6Pd0qJ4uqrgFBSrvtOfDiy?=
 =?us-ascii?Q?/9MXpO7f8JfNc+1Z9UU9nCL5eMzOcQqoiEyjnNbglzwJKsx6Y8K281u/RFjE?=
 =?us-ascii?Q?vwSfLW0VMem9C7W0wT816TSSKGp/sZ74G69LR6WS+QzC9s72KjBoizisxPKN?=
 =?us-ascii?Q?TQcpOuwlxI1gxNrRw38fNQXOk4SApjXiLEp7jfGrug2LmCJd+9vNLFACG9ww?=
 =?us-ascii?Q?3mHqS/r29qs8Vi+c9/YFAcHfWniUx901fFWbvueqDuIR1tuVq0o7OZ8xK+RU?=
 =?us-ascii?Q?t6LRmACgadQtoliGOIUOYlygDKSs6jDoohKzaNLyaWMoK7ZsmLig85fGoych?=
 =?us-ascii?Q?Vp2AW/lhN+dl9a6Br6gUJ2tvPN7V7kYxcXAm5Jrhk45rqHuei4UjomvFeBK0?=
 =?us-ascii?Q?V6czXQcPiD41tMiMWLBtOlNXdZrzGd0lPteeqpsa2HMWv9u/9paQWaVK8nLT?=
 =?us-ascii?Q?24x6UjG57vJyel+qJUZ9s5zaiUlSiqEhS/Kg9AgySvycbC2/hjuKTC1uKWbB?=
 =?us-ascii?Q?DWA9vX4LVgUoPHClQir/XwYrfmVUSeO9DRsmrapD3Ah+yEI17EWyUm1T9Iia?=
 =?us-ascii?Q?cjz7CBXEpKZPmRGoepVYCVYRUcEFd//PrkkD0W1qJbWGr871zj6pp6NgW6uv?=
 =?us-ascii?Q?1SK+8MYMbMpLuWz3E4rkrCzZ/T2PkEtg0JHHX7IJ3gsjCNqIjHusc0fmaSf9?=
 =?us-ascii?Q?bPZJHoEhKbap3kFtHLcGMe2Uw+dSPp/kxSqr5KHgBMl+n/YmB2Va2W6BdpWU?=
 =?us-ascii?Q?oSmF3fvu/nBI3Y+PNSo7jBRLLLbKcsxcXHSna6/ZPkZzmPH6D+pcVVqs2BkP?=
 =?us-ascii?Q?P7ffCeIyTr7kGwPVBvp50oL2wchtcoBSoj6okXgEWXo/KJiU72aAoYoKEWNB?=
 =?us-ascii?Q?LjI/hnvNdDs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/L12CmooYCwcHUF45CwSDiiywrgHlhuZ6Pt1GagmN1PZvp/7Zm1wKr/xF80T?=
 =?us-ascii?Q?EDOyDlZwxpEkvgTjzsUcCU1XR0emGtPaCcz19EC8txD8LrS7aUTE82Z9dmQQ?=
 =?us-ascii?Q?L38b9af9Sk9jeVlCDc8axC4PcOjhGM4cbA7CWOmBBkqqNqZZBNmwnyN6C8DI?=
 =?us-ascii?Q?RmCqY1ZeEnh9PDiuyQlNPNgggHJuDowFIoPHuZKvhvAUuHAq0+Tpnu6C5to8?=
 =?us-ascii?Q?yioks+JPN6hLrFREm0USSxW2YU81DO7u6TU7Yj+rrJlUpDi6DRBGDwaaep71?=
 =?us-ascii?Q?MMUPqKgM1q1eXciZiFBKw2vrQJY1HjPPOIi2yfPp3kTcv6GApQYJy4UBW0jZ?=
 =?us-ascii?Q?LDO6OI6z5gjyMGZiSpAt2lz9hcIkrElkIkjxPsD+JeA92zgo5lQN0e4npS0r?=
 =?us-ascii?Q?M6BX3GjxuL4DykW4eq8h7c78N1wuLz6I8WwlFJKbm0RFJ7Yh6Y5Goyzx5GwK?=
 =?us-ascii?Q?rcJyYLjf8mFGTDkE+ngRYfgzcxLSp9Jl3qd9biDw24wuZH3S/vojpD+ikPyi?=
 =?us-ascii?Q?JIayI7g1ExQI7b23nsZo5V1BpOEE8E/u27S4R+C27+2uZEDDpalEzE6gb18k?=
 =?us-ascii?Q?KFgNK4MumInwk7v0457KeSlWBbReiJOduDPYSnTzob6uEr4Lth8kW43gJEG1?=
 =?us-ascii?Q?FnikDIIHEWljZzKI12CryTt90gEAX5Bl+C4ojzstnIMR6ni3mBuuEdWKkJzb?=
 =?us-ascii?Q?lc9MteetG1VOtexugikRUN2tQvFe4kmlnu0JL+ga8BphNuKoVOjZPdd26io2?=
 =?us-ascii?Q?EXtr5/ZwlCvM0PIlmNfHEuhnOg+nh8q3xJueFocLj5Dr9h+nI8Wxw81Y/xdG?=
 =?us-ascii?Q?uU8xdayf1qdD/dQuTrV5hRiPGx1vQblNwNtikbM8RfhtFF0R8wr9Ov0sZt5o?=
 =?us-ascii?Q?XPORkpIqHjGcVdtO7R2kMrgovdd/sYA803+zeRLdvEwrA3sRdRLdCiNmalMD?=
 =?us-ascii?Q?RJnrOTVc1UhaQGYhRtl0/rKnbMlzbFV9ieu7nccPbr4yerABJQkznxIEe2Pv?=
 =?us-ascii?Q?j8RQYRkdDrSTzfqRQUWPJv+y1k+bi3UNfBHIAVje/z/2bumTpqVDrhtwd7E8?=
 =?us-ascii?Q?3EuYWK/SP+1obWP4xO2uwcWO8xhSjTKx9lAnvRxVIUZtDFp3Ft5dVuPtA7Ag?=
 =?us-ascii?Q?skRq1cZ6kuVh4/LIsHY3xib3ieauOVkAaC5O3h4Cjt+M5RG5UQhdp1Dzk0Eg?=
 =?us-ascii?Q?XlWIp+KBYKR3RDVVJMx9N9FN870C8VzOjlhO9MecSKx07YNn0kOZzfhYSOxl?=
 =?us-ascii?Q?vimdQR0gK/ile64rSzYOFqratq+4aDsFGa5ej5bTgn4KboJ3WaPU7kjt97cJ?=
 =?us-ascii?Q?inPM1cHpwrMBcJHbq/6c1aVqg3Ni+3tHxWrjMtxMJW5sch383pqPM1H4/mKQ?=
 =?us-ascii?Q?caHODxKOzIiqjwYmCh36E9Rma97uBaAW7/PZC9C8d1LlhIU2HRpnHl3VEbpA?=
 =?us-ascii?Q?kuW3t9OeDXbailKM9MV7hqKJ7k/fEyHtAYZRvp2BZqqlNDsHh4+3xmF5obfu?=
 =?us-ascii?Q?cQc3lo8CS57rlVjFxt//acK16P4Fje+5Ov0cxuLzEoQIT79+2d8jDWaqbox7?=
 =?us-ascii?Q?fjsDuxdcH/4k4m+NOkjb9aB08udHLKeRNZ1Y7kUF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4f6850-1ef5-4fa9-00d3-08ddefa5e484
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 13:36:34.3235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: US+pC+vEIdPlskpa4ZcEEaIujNqRmM2ULxj7eVFoOb/iZeZ4AHvIZl7fNw/5g+2pTETUOCjHJJTohYv2VkOVYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715

On Mon, Sep 08, 2025 at 04:10:30PM +0000, Luck, Tony wrote:
> > This set unifies the AMD MCA interrupt handlers with common MCA code.
> > The goal is to avoid duplicating functionality like reading and clearing
> > MCA banks.
> 
> Still works fine on Intel Icelake system. Tested poison recovery, and CMCI
> storm handling.
> 

Thanks for testing!

-Yazen

