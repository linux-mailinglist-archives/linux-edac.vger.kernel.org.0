Return-Path: <linux-edac+bounces-2942-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A63A19866
	for <lists+linux-edac@lfdr.de>; Wed, 22 Jan 2025 19:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7C257A083A
	for <lists+linux-edac@lfdr.de>; Wed, 22 Jan 2025 18:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DF4215784;
	Wed, 22 Jan 2025 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lwTWWve4"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01422153FF;
	Wed, 22 Jan 2025 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737570291; cv=fail; b=msepKUB07uEznxNXTYB7tgrt4EKxd2FS520bk6I0iPjMjxYIYep4KpmoL4rQxi6WrXq4qRl7lid4o/lqMNCY9fsn07U4m8YY74+j+VdYKrq3Q5XdWAOgBqHB1qkVHccWsQZZdHzOm26khOAV426kJ4CdcumhcPmpHlwO8UtKdvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737570291; c=relaxed/simple;
	bh=hAizieb+0CGqmwFTQNOoVmks/27KhHRZtWShFFdp8ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TZ5cTiH2RoUYkKPoSz0Di2Fp5Qll/ivb7FackFHLAzd3BEo/4bf06cWUkBZ2ytvrW2drjRu8oflX0syTl22DEMBIqH1A1WERYsWIR2wYCA468JAAchiJX9R0pHwTGL29+0RotDwWQVZWqChdj9c+7Sx7bA6+XJSt/rILO4XOYCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lwTWWve4; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hs2yHrKdnYxiMqjK8jHN4ohgbMk489w4+tSuyFVq2fsDKviyyi0w9lEUsKW8DzAvMQqeQP9xBY6JPle8T7Y7r+F5ETzkTALpKNCQMwAZnjK/C06zPagBYkOkjVfqDcv4KFLS2vJJTrE5xzur8jprqLtJhI1vZLbcEhVH7KwJKihnutS2LyfzH0h07HIPJ6jFXXElameeV1aK1t3z6HY6ZXnIoG/1hkSxHLvi0YhUikC6TSM5ndXjKSRBCH+GSqpTNrjlXM4g/RC9uYoeyX0mL+rSkmMEKKABwO/pZ9hJb34eBIhEsFckSWE/HAnqD71BMjV6pJT/r24lq01vz/TxFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygtLdLfCy5incxE8OIBpgH/pV+BOS7S0gl6oITDqXAw=;
 b=DI0H0dks6dgPS2fNvk8xZIZZuxwp5f4tbIO84wOJ3bD/GR23wLYLUe9dK4FsDv9Qh9D8aJQKj08hSQbVFrcmo9yiBaI75x7ocDB1Z6OO8RPNxapX91M9sznrjEwfW0n1OEU7Jn2+hX/ZbaFWg0H0iVLowrNjcAAS8S6Ec/suQPqiiPHRt2uA2OGcw2nGUUftE5B4nkvVUi1zIlXPdT6fCXaex5KeycacRrSgtQ8ORG7+X11R5Q/3STnPEGzEpdCDUh+qfewIMvyb9tJUE1EHaKzc76tDqyuYmnulrAjnSQLhUxRuq4lBNa1zpemgTnaLszhL+Zy8Lhq6LWu69z9gag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygtLdLfCy5incxE8OIBpgH/pV+BOS7S0gl6oITDqXAw=;
 b=lwTWWve4AfA5W2ZeIBB0IMAB9XKXDeyssIN+VEs6lLSDVGlDcIAiAyAc+ZMINsJ6O1pkGikMJF2smjJeXU1j2NBF52RgiyduaDAgN+S2s1c0Y8S7y61Jbh/6+olrfHilmNQeUpAn+IUgR22ksb6efGb8ZxROrqJQGKIOZ4olB1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 18:24:47 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 18:24:46 +0000
Date: Wed, 22 Jan 2025 13:24:38 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-edac@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, bp@alien8.de
Subject: Re: [RESEND PATCH 1/3] x86/mce/inject: Remova call to
 mce_notify_irq()
Message-ID: <20250122182438.GA464145@yaz-khff2.amd.com>
References: <20250114163722.34850-1-nik.borisov@suse.com>
 <20250115073640.77099-1-nik.borisov@suse.com>
 <20250115073640.77099-2-nik.borisov@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115073640.77099-2-nik.borisov@suse.com>
X-ClientProxiedBy: BN9PR03CA0596.namprd03.prod.outlook.com
 (2603:10b6:408:10d::31) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 929280b5-4e7b-4199-ff79-08dd3b120cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y83guTVWeJsXwgu1vI2wCUmEWgEeMpSyGjmCmXSY8EXqtP61pXDkHBFWZkPI?=
 =?us-ascii?Q?Uzi7rypJa3cZ6SMxzArWib0JrtgmoD/neQUDsgCfOhRT7q03yfMPcuB+lqM+?=
 =?us-ascii?Q?GDirMBduMMJkFxJ5H+fJ12cWMRl/ZhOf3P2XN8vf6B92vzONrIl8FeTCJwzp?=
 =?us-ascii?Q?bSGgTg/UiyD3mAXddyzpsScbqpVLH3FNCgT/TML4LE6kADnZqBfupCDJ4R5t?=
 =?us-ascii?Q?ACyuDbLivL2An0UEDoY8x5bILPKeEuAeY4qycjV8A/6hNmQT3pkVad0x+ss+?=
 =?us-ascii?Q?saMAQws0Nv/YlQucQptWB3Rj/TcqwEfu+zkZYu7JypNomVkbgm6PDzTxYEQk?=
 =?us-ascii?Q?nT/uP6sCHvbJ8emT7aPxk1LfJmT1ynIEOZwLrb8224eVEfu1WsOaL4VnP7BL?=
 =?us-ascii?Q?HsqPba5ZG3uMe/K8FVEmtS6I+WlyFDqLyUgo3kqJi9liKW7b6jBHIVwVVliu?=
 =?us-ascii?Q?sjogNDslMJ2jH9FxnhxKkk5R0s+6yGC2150DL4R3ZFap5axTvvCuUMjnA2yQ?=
 =?us-ascii?Q?GUzxS1bTLOVad/Oa6w/hFLzH8gbEML7eMh/Wt4DdG8U1ZSqNqa3B0sFHZuMb?=
 =?us-ascii?Q?LCkZS5GdaSWwZgma3+QB6VE5XRqqZl7PTAApl9BTB9gfKVPXT9TN9HKhHxDa?=
 =?us-ascii?Q?nni8WX5AHHKGm1rQOttAQmMKovAiONwsZSFIh9r87QF57FEQ3Jotj6z9w7lC?=
 =?us-ascii?Q?JKvJjbhTexRony8HWVuTwhdOYf6Gm+ITqUrC2pYzbZngY39a4ZPXZLAp/m4q?=
 =?us-ascii?Q?80hAy8ujnSmKwfKrSkGqt8XByWraw3qKtwR206gyksigEp1TJU3EzG9zcDW9?=
 =?us-ascii?Q?5R9sEN8ompEBFhLFWpN8MMgsQO0OdCyKakuNQgeQ720z5yn+6FuY79WOMt83?=
 =?us-ascii?Q?zkqDCSdTn4XPbdFLCxQTDWiy3ly1DUVaXopLkmnvH8cSrSUhcstAFxe5lmt+?=
 =?us-ascii?Q?5Am3baLv2GVTAj6ILhfmN/+cGqop/lK54D0kH4kinLf+g85yd95LE7y2DRrI?=
 =?us-ascii?Q?j6/EMAquS4+sbOyu+Cs4Jib/NbzInurkj/H79n/cvlKQzoJJcVUaPsGuJdSq?=
 =?us-ascii?Q?uxcZiZ5znJsZdmwCmr5BmxmiblJKXXa31vOtUkOcRGEWGscTWLj6TrjTVgDc?=
 =?us-ascii?Q?RwlDzv1o3rwXmgRr/5XVfUM0bqbXQwyi0ZuxEQviqD502OW0PUlGVoE0lJmJ?=
 =?us-ascii?Q?5As3LB+8HEzLZpp/j4Yv4jzdfr+RR4MFB+GCFXm0/gN+io3FVzrV4+LHg+ev?=
 =?us-ascii?Q?aex1zaJEqZjjl8XimEQLp6WLlx1Ka5e5O60AFk2wdJ2pRS3MOEIfSJxbcLfc?=
 =?us-ascii?Q?FleOnO2fPMjpCm9LC6rpGLcijM9Fwf+RpYwoHGJ/8W1LxrRe1UoUobDkxGw5?=
 =?us-ascii?Q?iN7kmivHLQz5J4VjELxS0wHRLr1s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ufOcyv5kdE1tA8WBTxCbBvkiRyDm8O8f/KwDwfvVh+mapVRuda+BnZY8k0hB?=
 =?us-ascii?Q?UQ+mB39o7cPrd5TaVz6WFX5vtZvR/4U7phcZS6GXnOyin9SQtcfPifZquyhu?=
 =?us-ascii?Q?YefdUq3ASJKGO3kYIWsFGPMILs7vY+gHeJ360ukyajffpClmfmSVyUHEdFzr?=
 =?us-ascii?Q?gLJuzp8VUuk/uMhEKHkcnIdFfNY6oM5OZhsT5odB9Eyi+p2lEzNHHu8R0cUj?=
 =?us-ascii?Q?6Va6EXv9OYOu0IJG/Hd6iFgWbpUWdKXcfZqHKwqfKfOHgpspwKyL+nlrE1g2?=
 =?us-ascii?Q?r7FD+8Y1Fa+ohm+DpOtNWsBP1Ufr917GNWubC+sXua36CZ1IQPNazz59Bn9f?=
 =?us-ascii?Q?Z1DQK+KQwU0Qfuj7ayW4GfPNP9pLy5EkyinpnZ58ZandyIXhmebpHCxrcmjJ?=
 =?us-ascii?Q?8yP21Qubi/KgnbwlyshHwc6Xhx+XAYMF+dWVxEIjCeh+ePXHagD7d93x9GsJ?=
 =?us-ascii?Q?Ckmdna1no+SKNNLDiuaiPlm7Xw4xWuSNB/q0YCQPPOkjK9r/0X5Zt6yImz3i?=
 =?us-ascii?Q?mSGEqGLefrS8urcXpZ6orRLZ+97Iy7RMfeiAKes8RD4SSGvfOKfbIJuF/bdD?=
 =?us-ascii?Q?RyaYofPZ8IBGA1Ms2W5bWQNKOE/F5oQEliUF53Sjvv9q59E9ARaLQzTrIku9?=
 =?us-ascii?Q?9r/av6w4KMUJwzZMQlTL2do+01vXgWX3+w+VQAjwJz1+ySKR5cohAtpNxVup?=
 =?us-ascii?Q?Cpvj980A2Litp22cn9o4geIaIyJRI7G5Qd0Jq4NSlS8UoqjTO0/Di2YXm5VY?=
 =?us-ascii?Q?6luKMoG2Kxo/33bnCGQzUcnPlkvWFeyk7rBXKfFlzBaSJRm59G07sBXeuS8W?=
 =?us-ascii?Q?9Gd65POB4frjYohnGvT6liyDpm4v9slR4vDzxwYvc/2j6Iv9Pt/mctQKkaji?=
 =?us-ascii?Q?0njroY4lrX5/j5USDu4U5lAGyjxWj9S4Y0jooQQgqi3SQ2drKErYmoorUFof?=
 =?us-ascii?Q?dfIak5/yPUuE7U8Ll2HQeq3ysrQohA5AS81i66Uqg62am2JqRL3Ri/5Vu7Wj?=
 =?us-ascii?Q?5Xase2XPBX3j9pPnoVYpZ3GlGuE4kwNmtLflGcaYRKOjBxQjqgqgPd6mAYv2?=
 =?us-ascii?Q?fPU9+EzmH6RNASdGQztrtRsxOj+jKe6Wl+dPRN5k+UVFnT/IWb+y8mRFieDF?=
 =?us-ascii?Q?e2WuYSDswnqxVaM1OUPkBLSxkU62fAoeGZTNzrUiY83S7NZQ5Iuscp8xzTCb?=
 =?us-ascii?Q?TjLCOvIZaNDoxp0EeHOFfXsSwDoiZcZs3ajFI3ZIYBxYN2WYALm/S6TKXgV4?=
 =?us-ascii?Q?eE1RzC14znCdWtusvZNMRuuoC4cmAi2Qdl8R2ZQr9bJilLSMW8TLIuWQQX4I?=
 =?us-ascii?Q?9ecAPQoC3Cgpp7QaTlrvu0OCsh3440u3JC+uFNv8q0pXxRE8WdRyjdGpE30s?=
 =?us-ascii?Q?uGbRXoFj8CsqmD2nPQ2pq8hhvp5WX/ehSmnoWy1EnDn0U3X+rZeSm5z3SWP4?=
 =?us-ascii?Q?LW6qEsz82rGBFRL6zVEjrEdxFjQPDEDQmtVi35Zz7y1H+c6DPCyIDhCJu8fq?=
 =?us-ascii?Q?UA0GuxCfdJPBdxRewSMfPCYeaxeUfM5I78PVlySyuDeyxG5AG5b4SEXeuWpC?=
 =?us-ascii?Q?aXYPquRe5ub/X8isWpD+Zv81uNmutWOw4MLVI6wm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929280b5-4e7b-4199-ff79-08dd3b120cc0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 18:24:46.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tCXPbtedLP4a5AIjf2tt2Ku+9oPAHb50nteJyvgTDlIwHlS70ua9DDEjO/gCPfguBmMmMVabLmmBU8DUt4r7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783

On Wed, Jan 15, 2025 at 09:36:38AM +0200, Nikolay Borisov wrote:

Hi Nikolay,

There is a typo in the $SUBJECT.

> The call is actually a noop because when the MCE is raised the early
> notifier is the only call site that correctly calls mce_notify_irq()
> because it also sets mce_need_notify. So let's just remove this call,
> which allows to unexport mce_notify_irq.
> 

The commit message should be in passive and imperative voice.

"So let's just remove this..." -> "Remove this..."

> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c   | 1 -
>  arch/x86/kernel/cpu/mce/inject.c | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 0dc00c9894c7..23e5e7f7c554 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1793,7 +1793,6 @@ bool mce_notify_irq(void)
>  	}
>  	return false;
>  }
> -EXPORT_SYMBOL_GPL(mce_notify_irq);
> 
>  static void __mcheck_cpu_mce_banks_init(void)
>  {
> diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
> index 313fe682db33..06e3cf7229ce 100644
> --- a/arch/x86/kernel/cpu/mce/inject.c
> +++ b/arch/x86/kernel/cpu/mce/inject.c
> @@ -229,7 +229,6 @@ static int raise_local(void)
>  	} else if (m->status) {
>  		pr_info("Starting machine check poll CPU %d\n", cpu);
>  		raise_poll(m);
> -		mce_notify_irq();

With this change, there are no users of mce_notify_irq() outside of
mce/core.c. So you could go further and make the function static to
core.c.

In other words, you could squash the second patch into this one.

Thanks,
Yazen

