Return-Path: <linux-edac+bounces-2744-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB5F9F6B86
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 17:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54D0188F971
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 16:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A491F8EEE;
	Wed, 18 Dec 2024 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z+af2eA+"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775341F869D;
	Wed, 18 Dec 2024 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734540829; cv=fail; b=px6JzAtKVt5r1NLkoq/ibEdO/42YTF5dtoxfEHuO8tRjra4x0agtkLFe9ILJdU88oBNxBNMohCgIIIUSn9/v3W7jCr2BPH8TJUPIUw7al0vivbp7Cp0TO0YH3no1Eq2UyyH7cOpa8PdYJoaFvjzlDd8Y2J+jqRjtMUXSri+Qudo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734540829; c=relaxed/simple;
	bh=8wqwzOR++CqnGf9kmt6scyBzhnBOTedjKu3G8BKGs4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NbD33QMyHyZScSGz5wzvzbxzypwb/GzZQ/NMvGrYCDu68YJcm28rMMPwSd5zTeLB6Qw1bIkI+ZBabStmw2owtnbAx6fJg8SrCgr5IjbuGWpaxBPbPSb0A4KE3IBeCixRsgkhIBg3XnI2CNXJyGPPT+vNQekrso2ZHoxETjUxjwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z+af2eA+; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TD8BTS70aNOdgN89LurU7VzXjih1RwKxFj1u3tldLZibDsujcNZN/PhhDr6K6ApOBWaaSX6syjQp+jR+1rnxOSTe4x/H9vwIeZPyQX10/8vG1Wgeiiyc2GAjDr6+mmgRyxR0dYFq8s4cNg9Zgf4aQoj5rxiYuP1uXabIgndz8C9RfP9qA2feQFH4deTfcWUthll7aLuiPELtdyH+luSlfSI7Y42ZS+15FdX0ET/6qrwxpaz393KOwi87glZ0yLtTzWsz54GGnOBCmrXUKgSUjR9J61C5ml13IHoPKpE2nGno4kM7cBaI5QYlmyy52OGlxJLg46GH4+m3oKPek3k3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JG2fKa2FNmn4oZDg5cG9aVgh+dB/1soDKqR8Y8eXvo=;
 b=UWgTQT3UN2zLGaXAn49VmIQx2lImfymdUSBdAbOFK6d8+NURVEdUnFKZ4qyqIRfEyufjSvl/lM91UX3NgPp7eeJ50sOqVOa2dJ2Oz+/ebhqEnrfdDC+5typKcl6aWKb7w0EDZx5ldT0qSY5uRjyoXz5wVYMo3UOn6Frbv3AWmDrmkUlXqkTwu6H08e5YTF4kJuFAtiYALU3cH00hMUe6IM4wF6EJ55NUvzTzY9L2pkL673HqF1Vwzrdax2mfdLDN1G9jZTGED1NoOlDwpYHnwvxD1rkawhG8zz7onkKb5w8FAT1PDGA8KyU3SVnHYxD+X+Vv5g6Ly5WnCRbPLuL7Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JG2fKa2FNmn4oZDg5cG9aVgh+dB/1soDKqR8Y8eXvo=;
 b=Z+af2eA+GtpwCaOMJY0TJ9q1dy8Qgi7TZJ+GJ4XJ8URdCsQKEX879WZ+XoFo10NqqvYsSlt3Rwp+jkk1/PSz67N8NuWwkkINMHazcl8b6b2jZ/dxQZH36fOc6vuGMePOYG21qL2cHaPnl7/V1o1PsVwOU5j1UFebrcVl2gO080E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 16:53:44 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 16:53:44 +0000
Date: Wed, 18 Dec 2024 11:53:31 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, mingo@redhat.com,
	robin.murphy@arm.com, Jonathan.Cameron@huawei.com, bp@alien8.de,
	rafael@kernel.org, linux-arm-kernel@lists.infradead.org,
	wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
	mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
	naoya.horiguchi@nec.com, james.morse@arm.com,
	tongtiangen@huawei.com, gregkh@linuxfoundation.org, will@kernel.org,
	jarkko@kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
	ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com, tglx@linutronix.de,
	dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
	robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v17 3/3] ACPI: APEI: handle synchronous exceptions in
 task work
Message-ID: <20241218165331.GF1155365@yaz-khff2.amd.com>
References: <20241202030527.20586-1-xueshuai@linux.alibaba.com>
 <20241202030527.20586-4-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202030527.20586-4-xueshuai@linux.alibaba.com>
X-ClientProxiedBy: BN9PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:408:f4::31) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b21d188-f1ac-42df-8549-08dd1f8488a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6iZszItc/2UjHDL91UmsDM0heIiFVGyMVSpiJ1uy67At9NQswd/Zc3d9vn2a?=
 =?us-ascii?Q?VrcznmdGTX3xvR6LW2rs6l+2HM3W5sNN0+h3kvvZpBRWIE8P0rh/a8u+Na9S?=
 =?us-ascii?Q?vc9IeZsK1q56Sc9NmfwJeOQwtwVBULFJG6rllvOcd4UO1vXWGDcUqPRKTSh8?=
 =?us-ascii?Q?vqCncuXDKb5n43tBIc5CPnAKedX9/J7aBxkiIthAWONnvB+TNtC/ehJCkYlq?=
 =?us-ascii?Q?SnRNJcjMgegd5c0MXP4SIkRo/psGcBqXk5B6wetIvlijoB96HZ9K9bIQi6zi?=
 =?us-ascii?Q?qCBreVzqktWubuyqrvJgou8zRA/0oGWVUqrBPZa8gwmdAwDLFmPeL0+IRXPX?=
 =?us-ascii?Q?WmA1pHPtgK3da8MuUBg0dpT3Qe4gutpOhyIq4Yv7q1iYRkDodf1/1aJlxP43?=
 =?us-ascii?Q?5GH/h3+yJIsmcUUI/e8CZNVy5Bvv9XdOCzR9Gi1tDtHmQwvB2NA+VTiu9Gwr?=
 =?us-ascii?Q?oG+bjHvCiKdN/MXQ1eB1nBuDadyFnFYxfnzAo7ogkQSKUgstI2ANQ0Q7a1SX?=
 =?us-ascii?Q?y2kXaNrvb9ozFw+3jPBk49k1vjwmXRYnQQZBYvXzeEp5ONItSYswnYirwAxs?=
 =?us-ascii?Q?QtA7f+yjfmmpzSEPW8jb3P5u6kAp+1U4D0+xHYyxqin8W9SUMF+YrNYUzdbn?=
 =?us-ascii?Q?7ipMztDtH1XhY8/ZGmkeMxeAXakg11XKl3vfN1BJcAiP2CEbOKWxAHgBNw45?=
 =?us-ascii?Q?+FbkpiakpKrmZh2lzrr520S/q+5mnjgNRJAYV3HgJbKUw7zhuL2Mwb05mset?=
 =?us-ascii?Q?P5Wod2p8lTDgb0XNwXbE+ohoUk9Jk7duXTPWRsB/ML48XcDbc+2FxSr/zI0b?=
 =?us-ascii?Q?lm+Gg5sT5iAFxLLA2Uea4btZCkemcn3uKkReZD1HGu2wpFKCduSBaWxsm3i2?=
 =?us-ascii?Q?/Sjg0SAAu6fWX/IpD/7yDpIqLTWF0WGGcx0+/K9JSAZa2KJHJLO3SKzmN5G8?=
 =?us-ascii?Q?oo2+iG85d+ND7jibBlCc2fZdcQEW5poXdRRvu8DVg7lle8rNrmGZst0StcyL?=
 =?us-ascii?Q?hjczrjgaLGDg7Nka4WwRGg3O2b9VH0erFBVNr6a/pX+jIVvg5cBcJbiSvvFU?=
 =?us-ascii?Q?uMpJmtpzRDJSTH+rcHPFvky8r263Jt/lQcph4SaLbrCgYu6VAgfCeM8VZhmz?=
 =?us-ascii?Q?0PIcZaB3tWuAbT/j+fF5YLS3/98ePKSEqn0bBur201hy0QuRu1XXdSfzbjAi?=
 =?us-ascii?Q?MmUdwWaxCVSzxHsxKR1tTj0CouZt2T/Tktm6ENBKPwvkt0KL/CdCCDLhwTcY?=
 =?us-ascii?Q?jjbqpddVTOxXMONk6w43HXhC9lBxTDPLvCxfoWGyteel5lyfB6a1CmDuXXxy?=
 =?us-ascii?Q?rb5nds3haf8evRg8wtxjNEuhiHk28y6gmXiV0rk/aoRAHavF7FZMxN9bgEp3?=
 =?us-ascii?Q?+AgSeXoC5ybjikVnHw3aJxSp8q5g?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5LyECBQ/wuX23ywMJvI/HyZqqrZDwggyccqBYkxoWczcQi3jpF6LVCWZoU33?=
 =?us-ascii?Q?KUMNk7LFW6wnfiNoxtz/Chl/CyDcEeGrvvqyUKxG/G1hHvhVOUpyS6FkXrTe?=
 =?us-ascii?Q?EruZDeIn+wQ5CetjuLsRXSyPt1WU+WjL1uNmflhetY8dItRooEasNszlMXce?=
 =?us-ascii?Q?pYGSpJIX3+236X7DsDFLUuBnzciiRaYZDcHMP/0h2IGqyPGU8CbjREebCrQa?=
 =?us-ascii?Q?5fGq94IfeHozvp3f9HS2dD9yQjdP3k11IUy5Bi8gbtgHJm9z/QKbMcOjfbN6?=
 =?us-ascii?Q?SlcixKEKOmFfStsSrrXodb8FZzApLJSg3iNX3C+JTrbNbG8kmEszvOfxzdWS?=
 =?us-ascii?Q?nIMPtg+KMnU7Z1pq23S75Q5DCh5c/H+BRWqJccxgnEywm5GoNs8b8A5MeMTG?=
 =?us-ascii?Q?DpHOK/vR3wOwblhbAzmcMfVBY6X7KUAhK6t/K611RaSPTYPGyp6NvAUPFTpL?=
 =?us-ascii?Q?06tV9XdfHwLsqqAZAVbWiBdHccnG8F09BelKBFp9mlKUKPHAkVZ7bMSlbWof?=
 =?us-ascii?Q?FQpEcDyHIrL6qjyPbrBmUgdtXWejn5WM+Id8H9hj8cTRRDO47UkxzZjG4ln5?=
 =?us-ascii?Q?4s4+ANOfLNOC/b54zc6jwRFiPLx79nfqUWbo1L0gxoPdiHxF+iOLSjMYcvK0?=
 =?us-ascii?Q?6jINmtdVJdIfSD3QWS5RcjH398wK+wVqjVeZ3+QZWIchC8mm4jcTaS0I9mtz?=
 =?us-ascii?Q?AEvpcEeczt7jjTFDVUB+EvJo6FQH0jESexiIJ9Z72Plg/DnvqKXH9BepICiE?=
 =?us-ascii?Q?rupioYLL0gQElpLIpuLV2tsVx9pRyNzmK9aPxw184T0WvFQFDHLR7pBSQXEe?=
 =?us-ascii?Q?2wjk+Ycw/RVGtZDRqIDZs3GiPv4qDjJMEi8jZ3P3JF/m2cde9bpZRBISLs3V?=
 =?us-ascii?Q?z8ben0bg7JIR6L6FA3UJP7bpbdtke5L8VpDaXQ2bBN0PGJZxC1xYqwv3XT0H?=
 =?us-ascii?Q?7+UCQpfbGA+HYrefluWuvjvVdqflWl8eJSZgg6y8tL+QwSUdMjTIB02fhfND?=
 =?us-ascii?Q?dLkmaRw/AQKf03r23udHxtZ6nNHbosj/wf+FpGXLPUoVgIkrQpDSzrbxYBZ8?=
 =?us-ascii?Q?3WgnVjjSWgG8QvaUk6+bHrDq9fN3JZl0qWnHgLd2uTL7ZBZutwn/CPqgew8V?=
 =?us-ascii?Q?lm+qV91KYI3wfFj5WdfRihuKtQeEcERmbZMHuzJVcyNFT8gx95KFVC47iq59?=
 =?us-ascii?Q?Di2BsCKLXPvRRp6VIb+0QofII1QkyiQvOMvotq026leoH588MkUnuUteluen?=
 =?us-ascii?Q?fTpa4uyEhOiV4y8Ft4kk4VDSMPxnIZWBGiIkbHrMYBt0nzEA5WCDSw3q9PPL?=
 =?us-ascii?Q?KaYY2mQIbuVr797cPxCP1fqBd5ekskFxf2jsKrhuJupgv/BoUGjX9JBlEhBJ?=
 =?us-ascii?Q?UzZbMuYa42vU088224fWVMkJbTVGAtLVuj0BpGv5ImoyY4phXRFRqLC9oFoS?=
 =?us-ascii?Q?d3oBDNVBqlgoZhAF2sPDrfoOMk39Eh81VFlHLVDhUrQSaQUETVLh1eucspuR?=
 =?us-ascii?Q?zx+Cipxj5cUnLmIe3dVqmgq6yHcWqRYXa0cbYzhqz94Rvvn85RMg7/o9E6vM?=
 =?us-ascii?Q?Je5Pa/cTQjsJ34MU2CnD/F5w3azw/WbVne6VMKcl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b21d188-f1ac-42df-8549-08dd1f8488a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 16:53:44.7217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57ai5LuyJJ/M5BhXhjCH7jt7NzlZ4FKGop5hxTluzxUJ6u4zJwviT2IBHoLvC1FD2r0HeWgs9J1VCMp9Cu32cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441

On Mon, Dec 02, 2024 at 11:05:27AM +0800, Shuai Xue wrote:
> The memory uncorrected error could be signaled by asynchronous interrupt
> (specifically, SPI in arm64 platform), e.g. when an error is detected by
> a background scrubber, or signaled by synchronous exception
> (specifically, data abort exception in arm64 platform), e.g. when a CPU
> tries to access a poisoned cache line. Currently, both synchronous and
> asynchronous error use memory_failure_queue() to schedule
> memory_failure() to exectute in a kworker context.
> 
> As a result, when a user-space process is accessing a poisoned data, a
> data abort is taken and the memory_failure() is executed in the kworker
> context, memory_failure():
> 
>   - will send wrong si_code by SIGBUS signal in early_kill mode, and
>   - can not kill the user-space in some cases resulting a synchronous
>     error infinite loop
> 
> Issue 1: send wrong si_code in early_kill mode
> 
> Since commit a70297d22132 ("ACPI: APEI: set memory failure flags as
> MF_ACTION_REQUIRED on synchronous events")', the flag MF_ACTION_REQUIRED
> could be used to determine whether a synchronous exception occurs on
> ARM64 platform.  When a synchronous exception is detected, the kernel is
> expected to terminate the current process which has accessed poisoned
> page. This is done by sending a SIGBUS signal with an error code
> BUS_MCEERR_AR, indicating an action-required machine check error on
> read.
> 
> However, when kill_proc() is called to terminate the processes who have
> the poisoned page mapped, it sends the incorrect SIGBUS error code
> BUS_MCEERR_AO because the context in which it operates is not the one
> where the error was triggered.
> 
> To reproduce this problem:
> 
>   #sysctl -w vm.memory_failure_early_kill=1
>   vm.memory_failure_early_kill = 1
> 
>   # STEP2: inject an UCE error and consume it to trigger a synchronous error
>   #einj_mem_uc single
>   0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>   injecting ...
>   triggering ...
>   signal 7 code 5 addr 0xffffb0d75000
>   page not present
>   Test passed
> 
> The si_code (code 5) from einj_mem_uc indicates that it is BUS_MCEERR_AO
> error and it is not the fact.
> 
> After this patch:
> 
>   # STEP1: enable early kill mode
>   #sysctl -w vm.memory_failure_early_kill=1
>   vm.memory_failure_early_kill = 1
>   # STEP2: inject an UCE error and consume it to trigger a synchronous error
>   #einj_mem_uc single
>   0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>   injecting ...
>   triggering ...
>   signal 7 code 4 addr 0xffffb0d75000
>   page not present
>   Test passed
> 
> The si_code (code 4) from einj_mem_uc indicates that it is a BUS_MCEERR_AR
> error as we expected.
> 
> Issue 2: a synchronous error infinite loop
> 
> If a user-space process, e.g. devmem, accesses a poisoned page for which
> the HWPoison flag is set, kill_accessing_process() is called to send
> SIGBUS to current processs with error info. Because the memory_failure()
> is executed in the kworker context, it will just do nothing but return
> EFAULT. So, devmem will access the posioned page and trigger an
> exception again, resulting in a synchronous error infinite loop. Such
> exception loop may cause platform firmware to exceed some threshold and
> reboot when Linux could have recovered from this error.
> 
> To reproduce this problem:
> 
>   # STEP 1: inject an UCE error, and kernel will set HWPosion flag for related page
>   #einj_mem_uc single
>   0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>   injecting ...
>   triggering ...
>   signal 7 code 4 addr 0xffffb0d75000
>   page not present
>   Test passed
> 
>   # STEP 2: access the same page and it will trigger a synchronous error infinite loop
>   devmem 0x4092d55b400
> 
> To fix above two issues, queue memory_failure() as a task_work so that
> it runs in the context of the process that is actually consuming the
> poisoned data.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/acpi/apei/ghes.c | 77 +++++++++++++++++++++++-----------------
>  include/acpi/ghes.h      |  3 --
>  include/linux/mm.h       |  1 -
>  mm/memory-failure.c      | 13 -------
>  4 files changed, 44 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 106486bdfefc..70f2ee3ad1a8 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -467,28 +467,41 @@ static void ghes_clear_estatus(struct ghes *ghes,
>  }
>  
>  /*

The "kernel-doc" format needs an opening "/**".

> - * Called as task_work before returning to user-space.
> - * Ensure any queued work has been done before we return to the context that
> - * triggered the notification.
> + * struct ghes_task_work - for synchronous RAS event
> + *
> + * @twork:                callback_head for task work
> + * @pfn:                  page frame number of corrupted page
> + * @flags:                work control flags
> + *
> + * Structure to pass task work to be handled before
> + * returning to user-space via task_work_add().
>   */
> -static void ghes_kick_task_work(struct callback_head *head)
> +struct ghes_task_work {
> +	struct callback_head twork;
> +	u64 pfn;
> +	int flags;
> +};
> +
> +static void memory_failure_cb(struct callback_head *twork)
>  {
> -	struct acpi_hest_generic_status *estatus;
> -	struct ghes_estatus_node *estatus_node;
> -	u32 node_len;
> +	struct ghes_task_work *twcb = container_of(twork, struct ghes_task_work, twork);
> +	int ret;
>  
> -	estatus_node = container_of(head, struct ghes_estatus_node, task_work);
> -	if (IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
> -		memory_failure_queue_kick(estatus_node->task_work_cpu);
> +	ret = memory_failure(twcb->pfn, twcb->flags);
> +	gen_pool_free(ghes_estatus_pool, (unsigned long)twcb, sizeof(*twcb));
>  
> -	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
> -	node_len = GHES_ESTATUS_NODE_LEN(cper_estatus_len(estatus));
> -	gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
> +	if (!ret || ret == -EHWPOISON || ret == -EOPNOTSUPP)
> +		return;
> +
> +	pr_err("%#llx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
> +			twcb->pfn, current->comm, task_pid_nr(current));

This is basically the same as the message in kill_proc(). Was there any
consideration to have a shared function? Maybe this could be a future
patch.

> +	force_sig(SIGBUS);
>  }
>  
>  static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>  {
>  	unsigned long pfn;
> +	struct ghes_task_work *twcb;

Minor nit: A common preference I've seen is to order variable
declarations from longest->shortest line length.

But overall, looks okay to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

