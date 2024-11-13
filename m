Return-Path: <linux-edac+bounces-2527-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A49A39C75DF
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 16:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB220B2C977
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 14:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CD61E0485;
	Wed, 13 Nov 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FoUsV4dX"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6291E04AD;
	Wed, 13 Nov 2024 14:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507943; cv=fail; b=EAue+379x6xWiB3w45S7Ew8Zt6GSSDQQe9MBiMkdirXstZLZYmslfvdoe8R+xRYTP/IHHtnBjxLl20A5bnR9Y1UMLS8LUSSdFvUGmZxewDo1L3jLQhrqvqnN5G2yd/rqptvzgRtEcdGL6Tl0AoW4ii/HqtPVUwAVETMmHj0oUFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507943; c=relaxed/simple;
	bh=eUU3ZLJYLLKQHbAad6NHIO9iudRZfjnOiPHenSzzY2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nYUaKQF5/Tu1ojLDQkAySFXN6rtcfxSHRgaQPdIvxuq81LtbNYEmg560v+Fw2Rnt+6U8uWQfaVY5uR33VQ0sTTbfpReMrQ9BThi/3qT9Dkpv798+RB7TZmwFjV27scXFt85TEBbsB4bP5nSmvRlmTkgkMd36O1kY1OvJl1Wy1t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FoUsV4dX; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgSOJmrjAkyOOvCPnOFbKaTTTf+e3r8FF+kvYGT1Hq1iuF/3BaZ0gNrl81eNct5hyFChIZCgDsy/DvEa7H112ctEpbLSdJdk5IEbO5bTOJp3ty02lX1PZ5bx7uwyh8ITqUjhOjKWNAbhorVmcX7k4WkpHpUADUOfu8UrV6EG6cag1VFkdZfFpS2TjrCdOVvJuS+VdY8phvdA2d0wfZdGBoVxNg9i+rvgXWMqcWpDVIOH6ZVrZp0Ayj5ANHhS310nKRZiqNlGnmA8ya8nmX9n1praOzg8mDqEheiJaGSeEVMIrM9FZnwTC8SMGrWthsc5jlvaUkgnCi+vBNjhKLiZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXVNdtIAUGYh/uIetlWtSVkPlEkuBiulr/0tH5mP/L4=;
 b=IPGATmZEoGfv3nuBrrYPH58SJKwTGN9ZFDXxipScsfWVog0vhAHxPJLFZiwFvltRkUkz7pP5cOxbaxt9+z4+aDR8K2ZOk/q6OcY1hzdeFTrPDAgz6OC7bUvYVNY1u7MrX2mkLs4ksNt/5ED+RSYpwCWqfbv8tjRRPA9J4gC2+e2gYc5UEqkPgVz5lpHOqAhz+oLvyJmwvRRRv3cBnT9MM1J0+EkGHl52MkxjKcN0pqA+AXzAJmdyzpgbFPwEDFfaoiK45svPB3kYIUefIZKvgdQoxz5v8blLc6koSQA3uhmvz21pTS4xVQKv/UjSEELKdjF5m6uViMQ11N+C0wFSrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXVNdtIAUGYh/uIetlWtSVkPlEkuBiulr/0tH5mP/L4=;
 b=FoUsV4dXdOnrB36QadTk6XJsjjW1UmZCpVIKxQdfTlGz/pJq0Qh0piWsXspcYBAQprJNRNoD3gyRpiITwg+UFprfSij9ShTH2uXZAx6YFJMHiuzF0BGIBJNeqWgaYzAIl4pV45nILrhf1zf3VznxXOEP41oq8/5hhh550uE5buM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 BN5PR12MB9487.namprd12.prod.outlook.com (2603:10b6:408:2aa::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Wed, 13 Nov 2024 14:25:38 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 14:25:38 +0000
Date: Wed, 13 Nov 2024 09:25:30 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "bp@alien8.de" <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/8] x86/mce: Convert family/model mixed checks to
 VFM-based checks
Message-ID: <20241113142530.GA3181969@yaz-khff2.amd.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-6-qiuxu.zhuo@intel.com>
 <20241112152716.GB3017802@yaz-khff2.amd.com>
 <CY8PR11MB71344CF097758F67C9336B85895A2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB71344CF097758F67C9336B85895A2@CY8PR11MB7134.namprd11.prod.outlook.com>
X-ClientProxiedBy: BN0PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:408:eb::7) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|BN5PR12MB9487:EE_
X-MS-Office365-Filtering-Correlation-Id: 657e65bc-e62b-4f69-9e5c-08dd03ef0b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rxC490GnqH0DQNp59VJu0iChiI4DqnZ3NhgtUOXAk43qyphLDHJf/GKKYk9r?=
 =?us-ascii?Q?/tzBa0tx0qGB3GZ8T1yulvuy0RPgnzKc5gdocVN3o3+173qMQQM/BO+443+F?=
 =?us-ascii?Q?KLSoytOJLHyCeD/1BVA7CcJry26HTq3aak/Was2q4/wd1qiv5j0n6bSUMTPy?=
 =?us-ascii?Q?pVRSagcqHC2mPFqmQJIuGg4d30uBZ1cNz9sEn9pfHomStJJKfucAXxmTwyPU?=
 =?us-ascii?Q?CEO9Sma+3RuXDetM+d7sTsQqe3LbzTiY0Dm3tQHyHnaJOg8ATCqhyVC79VRH?=
 =?us-ascii?Q?DIPHAhtqwYUS4kihDvJPWPz6GobJ7BzmCeBXGkjnP/WDG0J38R18xcoEIqx0?=
 =?us-ascii?Q?vfjQRwJGt7NrlWG4uccdysCcpEFNe+Ftvi99aN4DQsR5oKZ7xJJ0ypZBySu9?=
 =?us-ascii?Q?jmzbuAFGo1KF5TePs+AdU4bLkLdspw2mw2Z8zkgzP/kvC6tUs78ZOTe9PFmB?=
 =?us-ascii?Q?ZA51S5KCDlDyudJbeNF6EE/4lRittYXgvUxkOhqIefjnQXKj22wx8DQKFoaq?=
 =?us-ascii?Q?pOscKAMU4kFRRve6QH6pkNzQlpLSnyBQeH+3Lcu/bJmhWsoM9SWfT8BVzDH1?=
 =?us-ascii?Q?DMIRNKSx2VgDiHPVxvCBem/a+sUS3n7H5RpA3T84ngzBd/q4vufQiw/Y8zSE?=
 =?us-ascii?Q?/RcDFkg70GyZMZaGfPsmG/SZdzevJ991Mz2yYO4lbqfoQanrzebwSvtf9/cT?=
 =?us-ascii?Q?N8UxkKAG7vxzSqIUvzm7PHVlLtPKJEERanpVoU/ZHlNZMZd552qm9jDTJfPu?=
 =?us-ascii?Q?NKyL96TQe9sx2FmuepJHNkLo+uUAq5Aft1qzGDigc1IIMkHs2j95z4qPlsPL?=
 =?us-ascii?Q?pTdPy3UeEt77iQejnoUKEW2FAqpvLcWmSNiII3ElYJXGMIrXQ4z5Tj1Xdzaf?=
 =?us-ascii?Q?MUOeT45Nvi0zdPCCYXFS7GIbbHeOQiNXdCbAuLucaxVn1zEYkiOjwfJ7vRtf?=
 =?us-ascii?Q?trwoUVy7v3BZTKhd0eOQ7NORSHaXSsNHc4G/vI0DG48b7lC9lLZpvIKWKzVN?=
 =?us-ascii?Q?C5N2eH8ZpSd3myHDZkKOHiu/JJvm/clW70CD4I62j/RfhEVS7zyV49jC3ka4?=
 =?us-ascii?Q?zk8OL3wrbfC3XSSC3t2fhhy2XfJ/Ru2fgsbUw5W4o9BpulyTp8gaOe/6kTD2?=
 =?us-ascii?Q?OpH7cT+VfMyMR6TEBNkLHCPzu82vkng+Wudcvm81EA9t03BsAw/znuodjWBF?=
 =?us-ascii?Q?plUxBgiuZsXHZngqrdAt3gc9eWhbI/b3762BbPIZfuOyYotK1Z32gRHe/l5Q?=
 =?us-ascii?Q?F3BfN5KKd4e5ebfhtFqQ6ctFMAVpjPhR/etbM7ZiDLq4oOhb3UO9dsWhLnYC?=
 =?us-ascii?Q?9JoQal1xdAcRvqzkhRITXiFk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rp6y54wfarP2n/pBXeZtUvmshkqTp9cDaRr3WOHyEBm5ZBeB01oEzRxSuiIm?=
 =?us-ascii?Q?iUS7ptv3WWIYUoxnlifrlwDpJBDOiH5o4o3lMef+iaDrN7fOMmzJlMvje+XV?=
 =?us-ascii?Q?wgF5XuA3j/OpI9m7C4kc742+kpBq1rvu9VH0Pi/Byzy8mbD56Ak0NeTU3OQq?=
 =?us-ascii?Q?6RpoddT2Hvw3gfeqp5JfixfaCx8z9vK6N2ZyCu3Ge/5gYaRX/S/w17q/4vih?=
 =?us-ascii?Q?NozyoNTNGg47q+OPDoiLQZQXnAxfV6IICZj2isj9q/JuZ7l5X4TyfrEm7ToT?=
 =?us-ascii?Q?U2joVDrqkGwUlCqpwYBgUvEBVslP/paWRfexLVNY9QrKLaCo8gUjr7S3WD5p?=
 =?us-ascii?Q?5FqIEeSI5CLOqVuLfQPFhFCZh8j30uZSXI7gGZzRgRyx3WpsXraO+A+u1QcV?=
 =?us-ascii?Q?vr4MSaFS88E7dVxkjOpbwLrx4osXTMXz3+AoAIWAC2MkoN/ivPCkjtZ29qei?=
 =?us-ascii?Q?a1ODbADtipPXEr41jzgdRkO25KGLD63WHltzRaPc/EOmJnkJLRT/VRZz5IQk?=
 =?us-ascii?Q?gZuhWGt+ypD3x7Ea4fnq6G95Us3zT81Y4gIeDjYKAAke60NnLLxCvC+94NuM?=
 =?us-ascii?Q?qkXoO+3Qgg1Q7l8OUxlKbXSHmOnCgeraUhDnqyyViCYWA3TTWZquhtpsckFF?=
 =?us-ascii?Q?WsY8rMoBpZn/MHoF9ij3C0T8lF0aqDQsp5lr3MPnwwYpWFsltXg3CFDematO?=
 =?us-ascii?Q?rD2Q4PjWUgcTHldZZj91WFXWKPIpjePp6ZRmj4Uo5q6W4XCHmxqLH/Cu68LZ?=
 =?us-ascii?Q?rfOoCo6r914MLOplLvicbhv6sOLLH09pNpbgSOqkxxeRPXg7IPLCCJ5ZOTh2?=
 =?us-ascii?Q?4iwvETYTj7G6ZU4DbRVamaOQ748Fzk5DfnF7D+NhwoRNtQZEmFR7a/QdroZ6?=
 =?us-ascii?Q?HBe3hkfsWtfVTD4KZX4GVIXgsIDUKR5yOCbA2smKRlqnS+RhIT9vhx9PMwf+?=
 =?us-ascii?Q?DGpFKB6wZU/BQUA0LxEUGOAJfNjmHFAaghz8u5F48s5d98Ey1s9nVLMzXgQG?=
 =?us-ascii?Q?0RMJoI4HwTmfjMMFIPVhDT4UJpxLaLa9S84CdBPtGYULjwoHG7IwV1ESowDb?=
 =?us-ascii?Q?1vButmfTcT/v/bXig8Z3KOxMad+TLpQCgh/8hpvTXHuUH6zsF+BPlguZr3IB?=
 =?us-ascii?Q?I3WQy/Uhwuxjcbs639fP8hr5rsp8W3vl7hkQsYwRxTQWwrVF60pFY9ZOoEGP?=
 =?us-ascii?Q?EMvypme1IGUEyWq0KwcQR28ARQ8lHD3Wpp3VSngCcnU4PdG81LMQQtQs6YHj?=
 =?us-ascii?Q?yCvLBucdn8mRUQINbcDumE/j+HFDiWMNGxuhiTxny+cDM12fXMmggFHGzHtT?=
 =?us-ascii?Q?W4+gjhROux02B4Lkhyr2IBxVzI2lGh4wLdxdCgvIXTWfMQotlIlPpnL9xmYV?=
 =?us-ascii?Q?NNlYaFeQK6pR7JqBy74bxjZOGp9t4q629bxeM8t7qbm5DG1ORkwQJDgwtigg?=
 =?us-ascii?Q?cPZmvrZztWZ8n9vZyBUwOhIA6/ZZAxPMC29psaF1ICZX923ysQpptHXzwHxw?=
 =?us-ascii?Q?X1AKB8+j/u9XRX25S6FH3dA0LvhRAN1Xh21stF9K3ghuDOirX6/SBE2kui14?=
 =?us-ascii?Q?6xXOy/JEP/yKPrDXTTHGT5p67nWXEbDU9YTMjowt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657e65bc-e62b-4f69-9e5c-08dd03ef0b9e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:25:38.5961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dij3gr/cFIV+njVucsAKCnYxGW7gVKlqUbh2ukCw6DGg8RY4QsqyG47hlCSZQltwIzyEBA7pYuGkZ3ZotwQXMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9487

On Wed, Nov 13, 2024 at 12:10:31PM +0000, Zhuo, Qiuxu wrote:
> Hi Yazen,
> 
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > [...]
> > > @@ -1954,6 +1954,10 @@ static void apply_quirks_intel(struct
> > > cpuinfo_x86 *c)  {
> > >  	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
> > >
> > > +	/* Older CPUs (prior to family 6) don't need quirks. */
> > > +	if (c->x86_vfm < INTEL_PENTIUM_PRO)
> > > +		return;
> > > +
> > 
> > Is it possible for pre-"family 6" to get here?
> > 
> > Family 5 is "ancient" which has its own MCE init path. And I assume anything
> > older doesn't support MCE/MCA. Is this correct?
> 
> Yes, there is an early return in __mcheck_cpu_ancient_init() for Family 5. 
> However, this code explicitly indicates that "prior to families 6 don't need quirks"
> and addresses concerns like:
> 
>    https://lore.kernel.org/all/dcfdba92-7004-413d-8011-12771636d11f@intel.com/
>

Right, but my point is that this check would never be executed, since
the older systems would not get here during init. So this seems like
dead code.

> > >  	/*
> > >  	 * SDM documents that on family 6 bank 0 should not be written
> > >  	 * because it aliases to another special BIOS controlled @@ -1962,22
> > > +1966,21 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
> > >  	 * Don't ignore bank 0 completely because there could be a
> > >  	 * valid event later, merely don't write CTL0.
> > >  	 */
> > > -	if (c->x86 == 6 && c->x86_model < 0x1A &&
> > this_cpu_read(mce_num_banks) > 0)
> > > +	if (c->x86_vfm < INTEL_NEHALEM_EP &&
> > this_cpu_read(mce_num_banks) >
> > > +0)
> > 
> > The "> 0" is not needed, since mce_num_banks is unsigned int.
> 
> I don't get your point here. 
> But it needs to check for the case where mce_num_banks == 0.
>

The check is "mce_num_banks > 0", and mce_num_banks is an unsigned int.
Therefore, the check is reduced to "mce_num_banks != 0". In this case,
you can just do "if (mce_num_banks)" to the same effect.

Thanks,
Yazen

