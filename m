Return-Path: <linux-edac+bounces-4719-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4CCB40BF6
	for <lists+linux-edac@lfdr.de>; Tue,  2 Sep 2025 19:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528393A1665
	for <lists+linux-edac@lfdr.de>; Tue,  2 Sep 2025 17:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CBB341ACA;
	Tue,  2 Sep 2025 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v4OKys1W"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685C1EADC;
	Tue,  2 Sep 2025 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833955; cv=fail; b=HEFjBiqzD46vSTGpOrttcXd10uMft5a2jP6nXzZM4NJU1SAA6s1y+H3jGPe3voa3uNWGt+YwPanEWm9yQ/lLlrIh+sszoVSn3fw449lh0Xvo0Tab2HIj2P24ZxKC1rqMw7QchSjNI/tW9dpLukyf5t1ulPO8COS1Mhp/gu546b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833955; c=relaxed/simple;
	bh=ReOaKoQ515auV5i/4q+Fagm3cxU7kwTJSHo04Grsk1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ijhuceVhcgvEYji8uZmuxEp/fHbofGP3Z6VEsxUtEq3dudnjgrvRwPGeKma9muct6ZhCNEUsptJeELssEnBpSu+f3EWIjsUaBFgufXglbgso7tzy1MEU7/+OFFSjdZxuYsDaETJJDA+yvX0xImjeOwq78AzcmK56DSFdwX+iWX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v4OKys1W; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqDHdeeEtcPJn/b3Pa135Ur/awodzOs4GJ0QacFOhVSDog/ysxKcENG1wMr93vpbKkPxOO5JhMd1qjtzWB2sVSleiXGDQhMcp5Fdvx0QRqFEP6Rv8vZ6wWZIqLJcahoaxrVk3hcBdH6uNy8FCb0gi7/3g4dFaGHxogTCEeYiKwPXYJU9i5cAVbHNLbtVrTq1ExyWzVZI9Xg6YJIybLtfYiJsq5y1LYVycXczLpc/vUgzXqyI7ZuAllFtN2MQfuk9u1J9kdbGdBOBKJe/8nlWgCIWz6upPo644HUY3d/2CF4xyyx+CxruR+ZuJ4Fgo9ORy31o3DQygDh5QgDwJWOxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itESOaXJr4A1250u15KK8R/OblU8EfuNJMXV9sAnV6c=;
 b=sJmuzrV7N8mXtUzBM+Rk3TngsGo5XsNsEZo1g0Vx7m5H2fPZGYbBnXCwavy+R8v+LLDrc2rYJzPayntZUNyU6hlxcI0/g7/uDa4T3IJqPPmalGTEd1+952t8iWVxSmV7CqZBZpuXaAGFvQN69bBNmttdBXGf8kwktMUtxTGeLxYt6PT3clOlnnWSMmh+5xQxYqgZIBXiUN+vGNpIUu81eh+IbDBPrEJkhMbOJTVQvAuPjMBvSp2e7dv4JsFrYgW5pmAe7//jbLiSEyIX9PFOJjN8V5z3ZH7h/bYACn6lRHWXlr5h+J1h5v9zX2wYNLw41HnXWMs7uiekYDH49OWtkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itESOaXJr4A1250u15KK8R/OblU8EfuNJMXV9sAnV6c=;
 b=v4OKys1WLisf3UUmBpuxlHzQTQsqgfdKs9ueZ3UhWpvHQiS3tWo+7xni4v88OOoJyojwQIYNoqownsjwUa9g9Ph54geDre7z16GA9uZ8ribF9mCFS8BvbnOLd6bkfTmkw8Bs26mOnvrLMIykNw717Y5hBGctusLilYCQcbgB/B8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.21; Tue, 2 Sep 2025 17:25:51 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 17:25:51 +0000
Date: Tue, 2 Sep 2025 13:25:43 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 13/20] x86/mce: Unify AMD THR handler with MCA Polling
Message-ID: <20250902172543.GB273005@yaz-khff2.amd.com>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
 <20250825-wip-mca-updates-v5-13-865768a2eef8@amd.com>
 <20250902111052.GDaLbQvA2A0b8Ii26k@fat_crate.local>
 <20250902133712.GB18483@yaz-khff2.amd.com>
 <20250902170438.GGaLcjpoEhdfAGtBph@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902170438.GGaLcjpoEhdfAGtBph@fat_crate.local>
X-ClientProxiedBy: BN8PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:408:d4::23) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS7PR12MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ae376f-cae4-4a33-6463-08ddea45c38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ctp8aLsWLucdZopjX5yUR0pmsbCLq/azZNilV+UAZ/MmK4kKtYb09aLQSZ/1?=
 =?us-ascii?Q?GHa6WJl0uZlxHAC0yqTA6roKYXlNByEqnUld7iTrgmWbfw05YHoFC796THvb?=
 =?us-ascii?Q?DfAkOBNBrIDlSHeoMVITxYz8wnoWvcAhSRE5o1/KLVCatEpv9ApRWwMe0CcW?=
 =?us-ascii?Q?6SldLRnkeITPqFKyLKotuYGqeOSYbgasNIeo3tFWo7EXsaiHi91/XTqo2lbA?=
 =?us-ascii?Q?XteOQNoyFIp8fQORoreSxjgwKk8U40rf6exhB9Esi6G/OwgHQiLDpcvbK+Hi?=
 =?us-ascii?Q?zR1jRk9hXzhndoNlK0wrBodiaYNJJj2p50XKYMZx7Yzqof/BUSuvwKIFrkYc?=
 =?us-ascii?Q?GKvVenFWXg73AcxmjJyfb+bSDpmpVAxbU064W/XlG4+dzSkuXIZXKEzq3Sgy?=
 =?us-ascii?Q?Ly8CLVfh15hnlVeO03FEYT55mC1t/RPjO9gOMsmhMJn0M6E+9SaUIZPhHTQY?=
 =?us-ascii?Q?jqR0PluKsRr0icSqIBJmtAtAcV6MYbZzuRAoyT6qBD20KP+CfxM6gtFpbldG?=
 =?us-ascii?Q?k6kr4KioJlDIDTipd9U1ML/syf1J9AbxHSegTNF/ogQ/Iwq1vYzyqUhfn4DP?=
 =?us-ascii?Q?10smzL4V8h+OxGsdKH38SJ9Q9jA3yaX4G4eBY9Z95dNVyHFLebLV6b9QNmAD?=
 =?us-ascii?Q?xHRRTJAw6UDw3TL0Io6+STMwCZKvgnFg1Yp8SF8WVHa0UsfZ1yqVgrj+RLrt?=
 =?us-ascii?Q?PwnM6w5hryiWsXzUkKWBdBRdwTQaqYIE37L3SKufSJR/kiYnzah7TDeU4OC1?=
 =?us-ascii?Q?ge9XMLyuObPV/78JjdOTQMFEfOHmzn93h9FqbaKjpbm0vUAlc6xLB0uaPBsY?=
 =?us-ascii?Q?BWNKTKItlBI/MIESL+PMYXooK3Z2rG3h7GjNsHKsC9kI6XocEYYTK6C9dNDm?=
 =?us-ascii?Q?jEK8O4sRD8eAaVS4mhuCuEmMnf5MDIA8/vhKuPzEBp1wLUt2M5bOS+GR5Ehb?=
 =?us-ascii?Q?q0Wte3EJwS97P8NoQ0f2lEGmklS8r9dr/1yMwt5m7fqIAI3/1jOHXfEr7Qjd?=
 =?us-ascii?Q?tArsWeEQBM0DlRkMyb5A2ot+juBHaSYiHZTvlyCF82jYU7ahC+9wTWlelWjH?=
 =?us-ascii?Q?5qq9xMc1EO39jWa2Z+Ss26NaqzeLBuUPLbodAqcDDrlL0WmcgPJIIW8vk7Me?=
 =?us-ascii?Q?NKOyvfbSW7xCPlnSAdtIweHjSzAxTGwnBa9nID5+47bsKLaiE41uHHTNRw9+?=
 =?us-ascii?Q?wFdJlLQ3jhRs8px+YASUGbjANdv1zv4MV22xFUhYKspjZsnydEx2xo4YdbWF?=
 =?us-ascii?Q?jqpc7rKSxXPCE2qOLjec2dT8D2HC1xD542WdIc5Bo4GLeUL5M/5rRjR+cppQ?=
 =?us-ascii?Q?h11nBPZmeETbTANhJ5aKlHGMJ/xhdUeZ+c4LXsrm3xrPFE8kOP3OoGDIcgVS?=
 =?us-ascii?Q?JiFtV7dOEU3cA+aGSfPoBC+/hGfZezphRZZZidjxQzvCTt9YhZO2HscrkHJp?=
 =?us-ascii?Q?JTcZXC5nyp0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S4F/w4i2pvyDnpVl45dC2zw4Y5pz1BYgCtWbxVE5n5YsAAh9jbhOhEGG8RNH?=
 =?us-ascii?Q?iAUx/eB5waWa8Lx8IK2hfJtqvXA/sEWAbIF3mTtdG7MKGuwemTZCAd2vMayL?=
 =?us-ascii?Q?D3t8qh+iAAT3Njz5Y2Yc1/SR2vHQhT+fh9jPpKGlUKji4GmySWbqzTXWGEs0?=
 =?us-ascii?Q?xcurB9dhzb7i9jXxqova5CJ4kXPZSevbZlvYeZlMoQ8vLYYC51NMTjid+46d?=
 =?us-ascii?Q?hZjO7JNc2/1L/XiLdjUPkW/gG8RSdPwD/4gA00jwWEjHcUpgKSOHpEFinMIq?=
 =?us-ascii?Q?tC+xp1QM6ED4jze7MvnOIlirItnBqQSKlh95Uha0E57aMAn0Tu68a7a8sRIC?=
 =?us-ascii?Q?TpzcizDJV8tNy573lttnaN73TebTOcdny5PCP2wzZVwd8iBuSCSwL72YBbiH?=
 =?us-ascii?Q?VeFMaYzFq0rrkrtLXoXp3/OJRHRLmP5HdjYTYymKmOrwtTD+D37y7m3ESvuA?=
 =?us-ascii?Q?r7JFNKIdmEqz4rRi1YTqQBmlCOW8OrkiLhLAwxAWDtevXkWqm3TtFyHyYPKq?=
 =?us-ascii?Q?iBFvzGpaUOryzRvTyUPKAa31o8VMydA2vKkmofR0kX1+O9LRZVoNr7T7hlJt?=
 =?us-ascii?Q?oFa/DYRvWSeEhvRM6oPSiaSXQJKaSq5rNpXY2D9mO4YMAXCAAQY4KnjynLJh?=
 =?us-ascii?Q?ljf9oNLX2NUdw7yU5S7S4QUdbctgs5z8yfV703ZsCjOgmXg5RX5m72q/s7ug?=
 =?us-ascii?Q?Dmjm+mSkqIO92qGx2zxan7OZrnYMi1COXmzobqktIUcvqg8GbuuYlK8DHepU?=
 =?us-ascii?Q?EYn8PsPigZOG4ZF1O0CdUxFYPAWOV+4C2eAqmlinwkAyMxHW+VBvsV3grUCC?=
 =?us-ascii?Q?2P7OrpAh8b3TeaUZdtPuBku92iaqa1P1Z1fAv1yVr9XQV9ehp0IQZCaBWvfJ?=
 =?us-ascii?Q?XX0Q/MkaB3hO14yU7AxgM18yI+8NMVRJVzqsLz9brYb0J63XaHLKDfn2MEMd?=
 =?us-ascii?Q?7ZUASzSSR872SRzLwF9qTq6ynMWX2dRr0kHSYkwdrGSwVnlNwKQDILj1Qx1X?=
 =?us-ascii?Q?FiOnBtDKwnKoHml9hqnWa8aYHs8MAYSIwnDWsSf3Kak52FEpBb2X/pE+3/m+?=
 =?us-ascii?Q?hSKYkReij93G9JJUAaTOJ13nBl3tPl/gFWZUdTyMTPTOl5/p+a3oKBJYrO1I?=
 =?us-ascii?Q?oZ+mHs/2ZS4fUqRFMFNOBi4s3BnAU90X/XHzOSo2Vj0vobZG6ewTkjuALoWV?=
 =?us-ascii?Q?IfGEVzDtbfulm1H8SHUtv50WTYppGaYjHaXavF8BwIPjiy90ZTusl1Z7Op0x?=
 =?us-ascii?Q?JSyr18VnN80xDPZywF9aJVWwaxG28CkPy27x/3+fJP2UIId8gsicjopXKVK8?=
 =?us-ascii?Q?pWuF2Wxu7AIwnUkc/t1awOY0XkD7Rw8M5s3uOthnUz49GyP4KwuqYo8joUcQ?=
 =?us-ascii?Q?pyUl4OVlxAIKSJiZiL38uMNpapx+dS19XEaqcmgorEIZArZDJUYxOit8HWJr?=
 =?us-ascii?Q?enjEJ8fO5Nfhs+qc/IDWpA8P7nc08dIMCZf/CYKQbB1PLlfDZZkZCyCDD63n?=
 =?us-ascii?Q?Q4GlN/GTRnT6M5Sr/VMYOc35U5pjF3R1iW8UHy3D1oCCGhFzzTuBZdJ+KPyL?=
 =?us-ascii?Q?LuIYMC2nASHBMCg7UqMKM2szIKJJK8DE9FWaiLCY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ae376f-cae4-4a33-6463-08ddea45c38a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 17:25:51.2341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80MqZ9m52HMOTkg4a0Kfeu+6EvkoPWXSzT2QVjseNPCqiJHEgopz0nMDiix2lEP5sYWLBtH7SqHSGaGhXvQUdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8420

On Tue, Sep 02, 2025 at 07:04:38PM +0200, Borislav Petkov wrote:
> On Tue, Sep 02, 2025 at 09:37:13AM -0400, Yazen Ghannam wrote:
> > This means we'd need to do another loop through the banks. Their
> > MCi_STATUS registers would be cleared. So they could log another error
> > before the limit is reset.
> > 
> > Overall, the goal is to loop through the banks one time and log/reset
> > banks as we go through them.
> 
> Is there anything special about keeping this looping once? I might've missed
> the reason if there were any particular one...
> 

Mostly for code reuse and so that user settings for polling will apply
to AMD systems.

Also, MCi_STATUS should be cleared as the last step. So it'd be more
efficient to do any logging/clearing/resetting of an MCA bank all
together.

> In any case, it sounds to me like you want a wrapper called
> 
> 	clear_bank(i)
> 
> which executes at the end of machine_check_poll() and hides in there all
> the possible MCA banks that need to be touched when done with the bank.
> 
> It'll still call back'n'forth through the code but at least all will be nicely
> abstracted and concentrated.
> 

Right, I had a similar idea earlier:
https://lore.kernel.org/all/20240523155641.2805411-7-yazen.ghannam@amd.com/

The callback function still referenced "threshold limit" so it wasn't
totally abstracted.

I can go back to this idea and make it more abstracted like you suggest.

Thanks,
Yazen

