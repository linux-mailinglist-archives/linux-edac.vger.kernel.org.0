Return-Path: <linux-edac+bounces-2442-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AFC9BD03D
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2024 16:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2D01F22A53
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2024 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535E91DB356;
	Tue,  5 Nov 2024 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a0ixbyoX"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC001DAC9C;
	Tue,  5 Nov 2024 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819939; cv=fail; b=Eh32/6TKahbeLEZN4rBgK20IUfCP2qRM48NShacr1rS6YOAsu9u07X9glKibWUiJDNDUOICDGx7FKmHPw3sdz6vYPdu7psVm1Gaf8MRq055Mp04xChF0J8wpIBoIPkC3LxbUbrqzbbkgo/+Wslt4tCK7VOlQZWGqu8cYzek9Oto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819939; c=relaxed/simple;
	bh=A1izzNvYawryLUJM1KpeF4TSRYwXRCsnXc3DOG9y50A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jgj5ENaLYyNqgCVzWMGmZ2k3c9KPwceHGejH2f6C+o5IDsC0xkRez897N33P+cYj0A/71mZW/jdnry0xslBMZ4aowAwiiAVi7iLJkghMRtBOU7yR73FohTUs95SnbpItsEfzVZC+vDFyZ17qehNGWh61gF8SDKB9ClZw+GDbTnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a0ixbyoX; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0yK17x6pxyCUnURXhCf+UG6TsoxNX4+ILT41gI1478xUMAvymA1h+uT14TFrIhjyeIFT7L/gmUz+oLk/Zal13F7EzRWPybf7EI2l8kuiyfX1zep3RME1LGIXs9zhJBXw7JNkkXCm4Sb7s4lcd+KPst8mfbpAQwzHbA7zXMiV5bD8qQl5qgvajgzs/nP+FupZAk0XM/7/FakDUdO/5YBkZG5ZUhYrmM6daCpAiVsYGZwMoVZ/u4P7VsMK+73S9M3rU0JLzCun3ixiW2QYtvg91TrP3eQUwOnY1kvOguGgFQLDC/cI1JndczCKM7YWO4Cl2gx1CTCCLSspDQ8B7K3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUOF8P6TNAb3T9mciJHB+R+9K9TpzeU3ZcMYIvOJBW4=;
 b=VcL3KpyskVNahYYcKTRcM0Hwak9v3TTREolPPMXQXhReS5c3ShqUSRdC73WTLcnlX1dVp1gh3oaz1eXnA7Wi+Kea/hyi3poAcrb+SAX/RiZAGfDexaRJ9vSZoCJph433zw+k44jAto1oq0fERzp+tmEJNMiWs4WtqtUP2XgkeGy/NoheR4sKKZ2lOyC0tAEPE9TS9EH1eSNzlUMZ4eWpQifxF4W1qUs+Zr9610bQaeOaDXuJYjhCRfj5rPZKZsEgHPi00+KU4TyAvbSBD/oV2xHiUEH15AdbGgoxjtrZ46dBiUmit2fKphOv5OqWvWy0wz8aqXxkrGoKSzdQIqP8ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUOF8P6TNAb3T9mciJHB+R+9K9TpzeU3ZcMYIvOJBW4=;
 b=a0ixbyoXZ62R9CiS23rtVyzgyngx7pjByc29ggCpQ20anr2gXIpPaY9NEsR0O3e5zB9WeBfFsbyHwK37ZWBATlRE1OAICqvpgYdLyfTq6iXUPdvjiSyy2JACyhP+DuGJwtpW+wsqYi7TTj+QsAyFgedFe5jMDsQSrl/AntQ7k1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.30; Tue, 5 Nov 2024 15:18:55 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 15:18:55 +0000
Date: Tue, 5 Nov 2024 10:18:47 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, mingo@redhat.com,
	robin.murphy@arm.com, Jonathan.Cameron@huawei.com, bp@alien8.de,
	rafael@kernel.org, wangkefeng.wang@huawei.com,
	tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com,
	linmiaohe@huawei.com, naoya.horiguchi@nec.com, james.morse@arm.com,
	tongtiangen@huawei.com, gregkh@linuxfoundation.org, will@kernel.org,
	jarkko@kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
	ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com, tglx@linutronix.de,
	dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
	robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v16 2/3] mm: memory-failure: move return value
 documentation to function declaration
Message-ID: <20241105151847.GF916505@yaz-khff2.amd.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20241104015430.98599-3-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104015430.98599-3-xueshuai@linux.alibaba.com>
X-ClientProxiedBy: BL1PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::21) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2f1a90-2cae-4696-1caa-08dcfdad28fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OBnayaz9eSLyGL3RPI1KugH4YVH54FZc4cH9uUuXVA2Sx1dFvTZ7f8MFzs2m?=
 =?us-ascii?Q?tTu1hpJcHPhSS0+h9DzDV3Gs+vkU4ghwgUCWj1QT76PX7iYjergkiHdthDcI?=
 =?us-ascii?Q?N1rzXqv4CfmUO9y5J4LnMGpXaeThx23UaPo0/vm+7dspKlYQZrPgGybWizyS?=
 =?us-ascii?Q?N+Tq9wTPq3iOjWj7hXekyRuenrmB7LGqbUcgjn2vkxE7d5WkJpweWXWNk0I/?=
 =?us-ascii?Q?5VNO9SyLwZpGvkQ1C/BGAioa7hesYQrus2fwnxX4GsrEbrm7fsVKOtjoy1cn?=
 =?us-ascii?Q?YbaiIkmkVE0B+zLlGpY4h3G8sXwCdoqcK6LQu2PdUVQ8lgyylZUEYRcCMThE?=
 =?us-ascii?Q?4nC/MLoFXMGmQpm9bs9uqlZ+PeikgRf4+gSsohvQYBvU8c9v1Wpoyi50K1a0?=
 =?us-ascii?Q?Gn3wPTHfyFGmec1j8L6DIdn5PbPC3GYjorS3c2xaHVte4ifs78lj4jenRfR1?=
 =?us-ascii?Q?xXjwVKYVbr0n7p/yHMQRHoEyTGLhLXfZC2tllkR1VliNcCMh6Ka/yeGC4U3t?=
 =?us-ascii?Q?ePnrk1F7g1UBzW7kM7hNKZHhN3hJwiUhYg9XNvylaT+QXuNi5AbyOHCNFI8M?=
 =?us-ascii?Q?D0fXzZCVnK8PuMOll62glNr9HhrwbF4BmzYAcefXbTLTrWx6vVVdsjNk5Rl3?=
 =?us-ascii?Q?vVlqPw8xv5wynEmJc2LKVOrmJPUDz53advmGdR1dmknLw1+TdvNUIjVtKdDk?=
 =?us-ascii?Q?KCOpOKGa5jbR50/7GgAzPyl2QwK2xQ+ZcmTr1YhkR1cHbOqQrglHqZyDArvl?=
 =?us-ascii?Q?4UPbk4C2rhRVI1HRZgD3BgIwd3UwRchdp/uxLd/dIH2/XiZi4bdbWl08p2Jb?=
 =?us-ascii?Q?s4Jg/cAo/56GU3V5aNF+0QK6zus4zUNTYRK711v+XlVQIsJw6b0ORzvuN7Kr?=
 =?us-ascii?Q?0dSTs+6bwSMJpm7LuzYSboed3RYaGEAuPp8vG7b98uPKBryQq3nI3awJfNYe?=
 =?us-ascii?Q?oOMukyhi3D4/am8DuqN/gTwsxO+HRYOURuao2PpEiAmJSgbC18ZQr53o7wTU?=
 =?us-ascii?Q?iN8gtHSJpMGDRT5E1MvUF7D2DTZEu1IOvRdKrEo8LL3WuEP336YilW0AA3p6?=
 =?us-ascii?Q?To+sNy5ioHiPMyMnVckDomy5OdqwT0Ciq9heTPwJPcy1hjIIanduLukKvDVY?=
 =?us-ascii?Q?AYBHynOVa56kQe6xfXNw4BBAWIarRKq0S6vcVil6Y3dwxL7/6iYSjoX9s8BF?=
 =?us-ascii?Q?KBkgBJcvNdVW4VESaLR9Gveilqn8nb1HMjKbaXx2dVujiNVGdPstQ0IwWgcG?=
 =?us-ascii?Q?5AWxaZa5rvpAi58ZJ6rwglhHOsg2pJEUcVj4cLRtvIcrLCkFdEzsWt410L52?=
 =?us-ascii?Q?tYw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5WpjQO3GHwGSW45xkQ9k6fjZnyyHg8lh4zHYR3Op7tSukQ83sd6hRb9MHUNJ?=
 =?us-ascii?Q?+BS8Rjfj0TTbu4+5sOXPRMaduvd60XxaY8LrM9xOnYvrPeYKLBreLtJbrcfl?=
 =?us-ascii?Q?bAN99quBC2rOc6GGQXfCzR6Z/gSsqpS5qGZZZjLqaDgNL5NX11AV1iw0BjWC?=
 =?us-ascii?Q?ZASfr8srGwAtMSpbiwbDpqGKYW6HsDHREVXynvOMR1B/CbSVMQX9cAv2Ba5S?=
 =?us-ascii?Q?Yx8i4JKUys4WbkkDOYHm+XoqsptI0oNBVVVOJKaw8seJAABFnmv1dYx8zAzU?=
 =?us-ascii?Q?HasVuQ+EscK71vrJyzc3FnDIIK4cC/yAeeBvq2CblHkbTTtbdOSJ88sks5sO?=
 =?us-ascii?Q?lQ1qvvpPJ1JjYk2yrhe0iWjtEnmxQi9Sw1LvzSOtSUbYyJWYgNV4uvMk5Ap/?=
 =?us-ascii?Q?jqdy1diVXN5uzqlbEBbCkewZf5DFObNQSy9YJf5PH/racBg64y1Vd7YHQ5K6?=
 =?us-ascii?Q?NWIEuUewvlQW76UWyValbspLWoYP6IG3iFbr/FSsDWBZI8lNXQ6pIkP5MfG6?=
 =?us-ascii?Q?E6uQgDljhWS1ow4Z1yq3sorzlRU5YOW31Rg0JF29YIZ1bgEOXD+y5GgrISeb?=
 =?us-ascii?Q?Gl7w9SfXm+mSvjuRAFu1EknozvcG8hSVPU9DKg9ejl00ZVf0i5WNxwGliKbe?=
 =?us-ascii?Q?u4Rbqaa7ulH+J2PJELFAW1EcUJ8pkBu77602hX+kKqgOjuddQwUYUEEAPA4B?=
 =?us-ascii?Q?X3Ov5JvR2eINkRhP6ahbryVDe2/YljL3Wg93TvY8GMUjXogy1Jmw7kps9R0D?=
 =?us-ascii?Q?SIPAkxMA5rjMQuOF5L3wE+32z5w09FSpg6WrFgRFGdNRfRiYjB6+/Bpd5VoG?=
 =?us-ascii?Q?wwm1TO6ukVlc6jA6FPRveL6X61S/rghlmU5nAjAu7QJnNq89wSsQ1cBxlH1/?=
 =?us-ascii?Q?c6L0klmrSybYrxuOOHoS5vuE0CDYoQM1YrF6Q75L0QWfjqpIF65G9gAGPJx1?=
 =?us-ascii?Q?NAqofKn7WkF+CJkb587a6Wb7+hzXBUVzO4TWuZum5z0AOhOYAww2w3O3tTE6?=
 =?us-ascii?Q?iNMjN98UC+wpRlnux2zvLkWLqvV8JP1yzHUAlnTfctbt6SG0TSB5EYvy8Bax?=
 =?us-ascii?Q?Z5jBa7V/G4+5rGqtaNVXYE3SUPcATdpnIbXXGzBBwck1xy5MPtz0qVW/Uw0Y?=
 =?us-ascii?Q?/3gSrzkaBLWnrudvn90Yc64rCogEzDQ1xwu84Oc8IJknGzEPUQqCPqSypINH?=
 =?us-ascii?Q?jnYnrqCe4BaRGpra1uFRQKa3guU/a2dFzr+Lb+GSiSJcatyGZxicbaJdYL+3?=
 =?us-ascii?Q?7mJ9skEBypnQ1X2jXmsztH11UYjpMoarIqeo6RkRjcsf5XlpAiSGqRAUAvup?=
 =?us-ascii?Q?Nodrvnf+Phz5HI51CVnJr3eMpXjpsmm/RhMp9wlPSiuCc4+tdXcBv/usXKJu?=
 =?us-ascii?Q?Tj64wGPD/CKrxpc8hDu0PxVfA98LRZgxNHT01fXZ47J/BWfyQ+/8gh6EUZXZ?=
 =?us-ascii?Q?2f9f0FDYY2aAEDPDaaZj+/7zg1ZDHhG9pPoxSFoh0icRZn6dTfL1EG6d5M8B?=
 =?us-ascii?Q?QquMa3GS+Smpe4ed4M9C3ykr7pTMknao+w2+Ogm+9G1Jwwv4wdvl8qvYzwHy?=
 =?us-ascii?Q?+8yiVNAZdyZhjAzgN6qbx5tj1TGI+900X6uzCQaD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2f1a90-2cae-4696-1caa-08dcfdad28fc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:18:54.1576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaONh2hMaHYOyFe9pMFtEWY0m3VK6KdcqGhejci1EpotCxdm/qSAEMD6/3ES9GGLi3rDj1mQFhXc7t4d62D6xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462

On Mon, Nov 04, 2024 at 09:54:29AM +0800, Shuai Xue wrote:
> Part of return value comments for memory_failure() were originally
> documented at the call site. Move those comments to the function
> declaration to improve code readability and to provide developers with
> immediate access to function usage and return information.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 7 -------
>  mm/memory-failure.c            | 9 ++++++---
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 2a938f429c4d..c90d8fcd246a 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1373,13 +1373,6 @@ static void kill_me_maybe(struct callback_head *cb)
>  		return;
>  	}
>  
> -	/*
> -	 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
> -	 * to the current process with the proper error info,
> -	 * -EOPNOTSUPP means hwpoison_filter() filtered the error event,
> -	 *
> -	 * In both cases, no further processing is required.
> -	 */
>  	if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
>  		return;
>  
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 96ce31e5a203..1c5098f32d48 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2209,9 +2209,12 @@ static void kill_procs_now(struct page *p, unsigned long pfn, int flags,
>   * Must run in process context (e.g. a work queue) with interrupts
>   * enabled and no spinlocks held.
>   *
> - * Return: 0 for successfully handled the memory error,
> - *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
> - *         < 0(except -EOPNOTSUPP) on failure.
> + * Return:
> + *   0             - success,

One more obvious one from this function:

	-ENXIO        - memory not managed by the kernel

> + *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event,
> + *   -EHWPOISON    - the page was already poisoned, potentially
> + *                   kill process,
> + *   other negative values - failure.
>   */
>  int memory_failure(unsigned long pfn, int flags)
>  {
> -- 

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

