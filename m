Return-Path: <linux-edac+bounces-2335-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C799B5471
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 21:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A834D1F24657
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 20:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86137207A22;
	Tue, 29 Oct 2024 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L5T5RK8J"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60916205ACD;
	Tue, 29 Oct 2024 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234945; cv=fail; b=t8gams5ong06snerzbdtibEWDM7PfJAV566Z4tv4IGamChWm5YCZNTMWGdhXSQoaiHjpkARcV8TCliHYv81CldN03Hdhi881t2dYWnsWP+uy9BTlTfF91ycZX0tAqhjplbA4xSTkVbOSyH4cV8jyGgUjF5dK66QZNDJBDttvKMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234945; c=relaxed/simple;
	bh=f88aDcCeJt5QxDGktbHr9+vkg622hlXjHn9tq4QWs2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mfZmOWmtUNP0uJEwcUORfh3cnWwKLj40gthW58owVobPvQo+90poUF7uBtYgJiRsyjW9/O42n8HZwRlhL3R7zC1LmMIpKiQkZAkjm2eDyOMhH2umS2db1dgVCxUdx0A63CVte78w5C+mR4pqrKui2/tr7ppgdCkdOZRmHCOFghk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L5T5RK8J; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weZU3hbIMFwvMcRf974+nFkse+pI7KZnWDkmgV4zQWVa7usewfpwynzVdZ0agG6j96VfKe7yRhsbzyTmR+6ioiGuAkqBlWnrmiczCWISbSv4My5IdMtTaNYlF00Ig84f6V14XPpP8F6FGqfQzQCA2CqSlOV0wIxdZS7VaItGPhuuy+yM/cQ8zgEciOsqv1RSg0g9/OqCBPT6r/+oE8bhhNF5MjGJ26ezEyr41jLhBBglkqIKM6AA9e0k9os1CCJj7i05f2hERV9LSYJZYvFyl0PGhbMG9n6yAykuSv+ZK+t92wK962PH3S0O4wig8IG03GcgDSlZuFS2oi+S4n1jyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qInHwAAqNtYzaKKSVw+fUPol3Luq5fQ0ijhq60N/7Y=;
 b=RK8lBGpsw1cId/Lnbg8UXhGO0rzOPhNyF1ICDEKsQQ+HwVsCsx05PJq4NAGhVYRYYuZjEwLmDsBzbIKJ2rA+1NfGeme4+q1WgCScLl5JVM+BJSnENm52135gKDdsQ9G6a+mz+BoOtLk6gQR44pZHyZy3dhXbtop5CIJfBiRFLQmumZ1k1HC3t5E2gM3TS6tGYA04dtZ8joxM0ecm0PI2VRykNh2V+Ak9ooTvWA09teV7gONpI0bgrLSAErX3nr3vUTuRuiRHNx63Io/7g5wOSOQd8/6euMdPlN6+7sfFLjRJsLoR7ACxNDUyChIdj6r2v4v7dtkBu7pt7vsgu91QFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qInHwAAqNtYzaKKSVw+fUPol3Luq5fQ0ijhq60N/7Y=;
 b=L5T5RK8JUQ9k816sH2aD5Snlwh43KCH0HGXpsAJo8eRP+BnTKeOFD0gJxEvrQRdvmcdXdt+hVGtfVHFfGNbxEcY8SF5cngLQX9q+coPlvnqerZk0uCmrxhN0/vGQGmNS3mCwmLJRJd7zOxTRHeLp6wPVqIQsYUy50j1siUSrhNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.27; Tue, 29 Oct 2024 20:49:00 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8093.023; Tue, 29 Oct 2024
 20:48:59 +0000
Date: Tue, 29 Oct 2024 16:48:48 -0400
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
Subject: Re: [PATCH v15 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
Message-ID: <20241029204848.GA1229628@yaz-khff2.amd.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20241028081142.66028-2-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028081142.66028-2-xueshuai@linux.alibaba.com>
X-ClientProxiedBy: BN9PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:408:fb::23) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: a97ee17f-ed17-420c-2bb0-08dcf85b1d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wPfj8igFWmV/3cSv7hrFb8Et6DsPYQMVfRXIkBaWe/hbbF0ZfbHs8MuHsevr?=
 =?us-ascii?Q?KuWxCASCRSz5JLisJVANh35cQPapjMnziI60z3ZSJCtgJ7RnetNsJ7U84cNi?=
 =?us-ascii?Q?oQul4w4EHrQwYlK3ZgOAS5kFNiDkkAVPelNCQuR6zzRhFEo+pv9RPM51Ttan?=
 =?us-ascii?Q?iefYo2oMw4mMGO23283wNm2ZNT4vANW3vx0S/lfYL2Qv0K8Q9fqUfixv3fs/?=
 =?us-ascii?Q?ErY2T7sZj88X7ceAwfnHqL1YFRFp6yO+n5nodzKuNXRgao4alI/83wZC6Sng?=
 =?us-ascii?Q?1GVru4dAASqvsbAw2E3ngSsNTUjecS8hSGM2Z1cEOYjyP4VRs9xaPImuHBgO?=
 =?us-ascii?Q?Xw4zko6ZdDcKO3l1+RrH+gtlXx/v9absHLThbDk7fbIx/yY8WDbM2gsGZox3?=
 =?us-ascii?Q?DVh6sQKLNOttd+2YrRHSbQoTqnThFFdQu0+vpPXRXdpIbIoTYUlnhvWQ245v?=
 =?us-ascii?Q?v7gw7auxLObirPbqKJ5UNGhb42qlsvBfa38TSN9S677tFQuIFIfT15sIhRXA?=
 =?us-ascii?Q?39md/cMKf1oNZ5JJmato+h18KeOWQTTpGppX3jEU56pJFt66BRsbGTydjNHA?=
 =?us-ascii?Q?ho8WnhElZp+O6Of+U88anm3DnliqSYvUYJf418OadQNDyW78DAMfuSJDVYTN?=
 =?us-ascii?Q?8yCjJpAVX/HOr1TnogywtJLk3CRsDqXdBtN2choTGORVjaS6fhwYU3NKw+1h?=
 =?us-ascii?Q?gwIBxo5fw0eaOlAXJUUR57KIuPevHmKywLELAkd36RehlBwY1kFYg7JI6PNG?=
 =?us-ascii?Q?P+g4TVuPYgS2Js+ZtrMgT1KjDitzcCqOQK1ZUKk9RAox5Lko33YFvUYtgY1R?=
 =?us-ascii?Q?huGTD4B+xtpJxtDlEyiyGC/zfneABluSu8meSzx1RtlxijTODfS/LXQmfyjr?=
 =?us-ascii?Q?1FB6xLJgQmxZfW6gZLYUeljTrF0qeZ/40pfyO+Fr/Ospk34V2Jkb3l4Q3JUP?=
 =?us-ascii?Q?XoEwbk4TPdopriTWUQG16xg47cTlkTYsvfsllycfyf9N6WdbnktZDE+AgzRH?=
 =?us-ascii?Q?vBMBRqFUOTIQ1Sfmr/8GXQhOaZilvPd+whhbJ4qZUaY4eies9zCFa82twsC6?=
 =?us-ascii?Q?oDi5olkc6k+UcKYKjH4zp3sDVoBwVIKmdyzPeLpLVDaPq3KsliXSi1Kf8ebZ?=
 =?us-ascii?Q?gnDNqqdkV8lMkYpQWRrIAbzpFkCBajgnh/eCvoMvUo9yfkldCECLcOmMOwS1?=
 =?us-ascii?Q?NlCRRHJEKOBMR9Q3vqHaRvMdb4sCFvpULNu46JwEp4J5ZDxbyoG7+qnaJPQM?=
 =?us-ascii?Q?3vWHDP9gAnhslSFomwI4HHaQjw8GN4IDHg6mJY6BhmMkHpIMfQrmiGIVwv+4?=
 =?us-ascii?Q?pFOWGQDTLQtttM03PuVUxqBm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eSKdKHQqTkcUZ3GIbopJsgD35DOLbtlc91VAukMbZ+fyyEfmoIynctR3FMhx?=
 =?us-ascii?Q?OsZWrd7G+9K4M1YZMVNKkD2xUzAPlr+aU3RDB0f0oRTb5ReY6+OG46ypV732?=
 =?us-ascii?Q?/anxiTIxgQ2D2C5TB5NM/6CViQmV8nGOV8wSBSUk8Iiq4yg0aRR8eVFZaCCb?=
 =?us-ascii?Q?xWXRDcyYjs7dSERs7YUULB+jo9n74Oi4Ok2W357wSQ+PG/hnH5DTcZDg4UFT?=
 =?us-ascii?Q?gBqMc63OzhQWfip4gtl5N5dl0e+rRrZqECAO0wSSdPnNY3oCiCqU8z9uJ1jS?=
 =?us-ascii?Q?VPVVwxO7ytj5xTdXBD+kuxs1r5jUoJkxfxyhUl6HajLa8Vb73O3d09YXm7Nc?=
 =?us-ascii?Q?zvkdrWTYYvRBOE/SYaYnW8N61wLjJpw6ELwhnUrrqAz7TAwsdtbcCyViPfM/?=
 =?us-ascii?Q?w1G/fAvMVpcaQpMUreAE+1izmiOLxAvv9rieXnBjqN3eCRijAaPHM8KZH7N9?=
 =?us-ascii?Q?DJcpbtl8BoYoZd3bLj/KHhDfJgiMwQzJiC/CX6+tcj0+p8uGEx28Oo5rqYvj?=
 =?us-ascii?Q?Dx9xlKnXhrXtP87LjXNiKn9n4Z9F1VNqIy0O9j/UxsT8E5/r+LM3Oemav3kv?=
 =?us-ascii?Q?S2Y/sUeu7vjWaG/zKsa/+pgIXr3ZSq1psHstuYnOo2qwQk/vBql7nXkpJ6+y?=
 =?us-ascii?Q?rQVloeFNtqkWbI5FkGH8imjN8Esym2ONx1Lw0JZ1RPvqz6+uFmSVYWv3AlkK?=
 =?us-ascii?Q?XiR06lg0xXFlpVVSOWqp4H1DLxWVrXklTmp1ITGVl1qyTr5ZZ5B/ZIlB6vZO?=
 =?us-ascii?Q?gK6lRccMMNJxNgl9qhMOZh8vERydzcuKLxTei8DIl6KJo3QN3D6dRXyqtv0T?=
 =?us-ascii?Q?kICbYANWFePYQQsrWsLA9PBn1Hssz+io6ypvv5l5WSfsUCvrIHf8/Lvse3ZV?=
 =?us-ascii?Q?+d96xrwAmvio7bs/ABjpVWQZSZHg27mS3UJCMRv+/Wkzs8AN9AOd+gVuFkGK?=
 =?us-ascii?Q?iIxHWjLBNxNb+OZsDYZTqmEnRVKV4sle60IkOFahHq1dgNQCRefXq/Bd51AX?=
 =?us-ascii?Q?c979nYyvAR73KVvPUt93i2cDCyYRcjSdujOQvZSzaOTY+cJvoZXxi/o4/2aY?=
 =?us-ascii?Q?vkJT8MuI47dVbGVx99B7aNerXkHZedbzP8yYOYStmzPe7x6EkfiSgfkKh1YS?=
 =?us-ascii?Q?wSFC5xIcOTsz3p3HzLxYyGSUg7QA3cTCvbYp+rpyYyLJC3GNVzDwGzu36vra?=
 =?us-ascii?Q?WadfPHweftEuUGWDIk9wHAss8YEhmJNH/kIVOUespgS8dlNZ/YEKV/O6q3yZ?=
 =?us-ascii?Q?Lhmbtkt2VQLBdLH0o/rjb6kqS7iPLI4v0LPlJcH+D6lu9LR/tVheDK/qqD21?=
 =?us-ascii?Q?plMoa3mW8r7Bsc0W356YM/DpJM0Xt96ToilIXt0H2Y2nKrf60/VCElMSUO6I?=
 =?us-ascii?Q?Oyyi2jdQ8tfTYwGaYREuYuHcSDKX4vh87VvoFP40WIwQbUp0wr5gNj1NRUFe?=
 =?us-ascii?Q?0l00cM8+qQEVhHwL7V5Qa2gwqUKipB5M/hMuaRT8pjvVXNu4YfsIuQd2is8a?=
 =?us-ascii?Q?Ya2xuCxo4tlhLtyCoEi7z+OSN/yfTS05Pyn46310I2V9/o85jFYUpopFL8Bd?=
 =?us-ascii?Q?HOz6NstzTcMqk3b+oBii8Nt5KSvftvBmkEvzGRGg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97ee17f-ed17-420c-2bb0-08dcf85b1d3c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 20:48:59.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kwfxoBY35BUfea4+AsdhUM6taUwoGf3j2XnIQfeg1v2eoTYQZCCpmklTnQKxrC/1W1PdJyRjzdOq/t4O/3m/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413

On Mon, Oct 28, 2024 at 04:11:40PM +0800, Shuai Xue wrote:
> Synchronous error was detected as a result of user-space process accessing
> a 2-bit uncorrected error. The CPU will take a synchronous error exception
> such as Synchronous External Abort (SEA) on Arm64. The kernel will queue a
> memory_failure() work which poisons the related page, unmaps the page, and
> then sends a SIGBUS to the process, so that a system wide panic can be
> avoided.
> 
> However, no memory_failure() work will be queued when abnormal synchronous
> errors occur. These errors can include situations such as invalid PA,
> unexpected severity, no memory failure config support, invalid GUID
> section, etc. In such case, the user-space process will trigger SEA again.
> This loop can potentially exceed the platform firmware threshold or even
> trigger a kernel hard lockup, leading to a system reboot.
> 
> Fix it by performing a force kill if no memory_failure() work is queued
> for synchronous errors.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/acpi/apei/ghes.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index ada93cfde9ba..f2ee28c44d7a 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -801,6 +801,16 @@ static bool ghes_do_proc(struct ghes *ghes,
>  		}
>  	}
>  
> +	/*
> +	 * If no memory failure work is queued for abnormal synchronous
> +	 * errors, do a force kill.
> +	 */
> +	if (sync && !queued) {
> +		pr_err("%s:%d: hardware memory corruption (SIGBUS)\n",
> +			current->comm, task_pid_nr(current));

I think it would help to include the GHES_PFX to indicate where this
message is coming from. The pr_fmt() macro could also be introduced
instead.

Also, you may want to include the HW_ERR prefix. Not all kernel messages
related to hardware errors have this prefix today. But maybe that should
be changed so there is more consistent messaging.

Thanks,
Yazen

