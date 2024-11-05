Return-Path: <linux-edac+bounces-2441-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CB69BD01D
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2024 16:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60A11F21575
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2024 15:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74881D9698;
	Tue,  5 Nov 2024 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u3Lcbkiu"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBFE1D968D;
	Tue,  5 Nov 2024 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730819401; cv=fail; b=Uv32FPBeJCpwR6miRpy45ALALfyUCKijhW2ltf0X6Ch5tHytYV0CTMPVQHAiL+YowjaFaCMOyReQuMqT5DuN/dFaNAdAKtwOao3e4wpmPu/8vS/QG0vZcDVD0vRJbapV9f1ueqOpXqab0eeTc564Q/e0s35bkK6Za3A4FeCKoLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730819401; c=relaxed/simple;
	bh=igjzuVtThuVr/QN61oxDv1fkam+AFmCHvN2xqrLtDqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sM+0Hg4ORx3TiMxkgmphmK+eO+ACtj8yQ+EDJclNmtrB0XJL9U0e1Tjwf5pBuCkuncnULFfiDUdsZNefnTWDzTYIeUvhhsJDtGjJxRMLtdct9FLQvkWmBKflzBsXjvL443gxR4zt4ztKORY3yK4vlTiVPRIdNXL2nj8pbixCdRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u3Lcbkiu; arc=fail smtp.client-ip=40.107.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfFcX2q/NYeDwIYQZN6WjXeFUZx5NCCYaCWFpi4xWN89MBL1aVrBZmC6qLt3xr5KdiZaouiPtPOd9R2BehJIRNhq4K6Vb73mJ0RrXRrNeJHnIhUBGxpbHVdM7QiWvHENF1o/RqRL3Yovjv0nfghZQlySBlKXiIZQ4qGD3LKxvVCgLlYtycie3So2lL0K6RelJ67eGdiQcMaLBT4YBmS9ZP+/RjbDBfCY7WjTGw07My8tLrpjcYf2deuCXV5fQzcz4y2L5fNsOrR3vsO8nLuinEubwyyTSmrqEJsj307r5EODU7CcDXE6aeuYzIw0FRxl+nBr5L4Zz5O37WCAwt9uZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfpFonpDcUN0W0T/RD4EjKvAzTAoy51gUL/1Iw83eFs=;
 b=BgUDIi/i50cgSM+nPBujxDf0cnGDyEj6F/AsEe/MqGCAyw1A2S1mYnkhyTFgCjGm8yuscJLQlFikuQhYQ1BjtFp3BgWXe1Oz+I3aCthpFKwsyI2lnGY5H1pNUXp4Vg2sJbxIaxe5GL42GLetsXgZK2316qsE56wx/Ja1QXnJN9rv7FZxYCj10kmKZlAkQBxQGsDx0Qn7Q1/1LWBHA3RlStESsUIwsbheeKIUXnN7P1GorBROeLlIH9ZnYfbJKpZsMj72qTYJNG5ZrqJotK70C7V8OdO12veMCaPesWFooceBrDy4vZvxr53d1xN+gZg/uyiA+bJm06d5uGPw6FxhUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfpFonpDcUN0W0T/RD4EjKvAzTAoy51gUL/1Iw83eFs=;
 b=u3Lcbkiuq6yQepPzegEEZqQv3O401UbcDXsOJxXWUTOGDmSgUA8DYZUKu9w2qQ2Ax0po+bThM0bfAIkKbXyFzuU0yVWLjW5yzD3IkU4AWyN6LS6nvqhp8sff7XKqAhjTPJYnHZU34A4+TP8H4z7Yur0nqqbfgS4/xtrm+wp9oFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.32; Tue, 5 Nov 2024 15:09:56 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 15:09:56 +0000
Date: Tue, 5 Nov 2024 10:09:45 -0500
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
Subject: Re: [PATCH v16 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
Message-ID: <20241105150945.GE916505@yaz-khff2.amd.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20241104015430.98599-2-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104015430.98599-2-xueshuai@linux.alibaba.com>
X-ClientProxiedBy: BN9PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:408:f8::7) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DM4PR12MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f20cf62-7250-46df-78d2-08dcfdabe848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KW9SfkW75w2JWT1RmfvIM2wFeN4ehmXSwOBDiUJM0rIXZvS0Xe0lCuAq7PKd?=
 =?us-ascii?Q?ABIZF12zLv8v42c11hR9KWwriHbZTxAFJBMbvtJ9fvjf288aGdJbsvSSiPMS?=
 =?us-ascii?Q?9MAggkCJVPptNqjFZrDsJDsWDdAygUANPth1Lr0X9sFk/xyv54A2vBEjG0Nc?=
 =?us-ascii?Q?J3YLJ3nyVLm6mJI+zVBWt61uU1eGvt7qB+vT4Vk6m7fZDpAau3qwM88vTHn9?=
 =?us-ascii?Q?f85axB0yyA/G+Ac+6PTzrpEBd2WT43kDrXZDNVi2ZagylWx8m9NCHGR2aIUh?=
 =?us-ascii?Q?71It/FretdmJlw02Rylbfmcgtowa+IQZ12SMr4lFIjRATmGW8KgxTtyIbzLu?=
 =?us-ascii?Q?EzuDBtGQpnbhnA+CWblPPBBlpROPs+T6rtNSeqiGr4CTgYKaelu9MUK4OESd?=
 =?us-ascii?Q?fDIn+39a4emuZ2Y2QbnHSBmtGcQsVwBoymdrW1kKyfoLDfgBj5rnoAKqX3HW?=
 =?us-ascii?Q?oJEGScLL6yqrKoWmDuYsn851GEL0Hhq2oH+sLh5PflWijRTGL8Ad3fhz2FSf?=
 =?us-ascii?Q?UjXkASQScHTHn5ptpJchTgyXQsWU5Mum28ed4EixOUeT5eW4MPujF/osTcET?=
 =?us-ascii?Q?OKEWHOK7nLTfc1bX3w7so0m3YLB1/3uCASxI1JNnsxn08NShIS0KXXT4KKkJ?=
 =?us-ascii?Q?WxF7pYhSAnD8IZktiHcEUdGtzPXpTfVynxeN85xE+NtCgZf6QXsKplM6VUrY?=
 =?us-ascii?Q?11QLS8MpNaXYLZnl3/Oq8aJDnvHQsAlgnHsKNhP1K1ckOrPUHWnCXP2ZnTON?=
 =?us-ascii?Q?lfPJMiY72SMEbuvyrSKsHhCZMuA1bb+KH6IIbdbMg5wX9ynvkno1KUc75zp6?=
 =?us-ascii?Q?5VNrFhxGtDQgHAMR/QkPBK6H+BLNmmjwpLR6657CIKQjOPSHj6MGgkXgG2AJ?=
 =?us-ascii?Q?OPBGfM+YmogJWnVRszV8AyKmXV4RbBYLebkzRgATLrCee3C4xgfnTx3Dhnu4?=
 =?us-ascii?Q?OZjNmHJdMKQg9L6qDuEuVtEB8D3mk279a99sgMY37Tdg++DMgmWl4qKeOLxT?=
 =?us-ascii?Q?QKvvy5ADQ6+Voog1e8/Rx2QD9x64X6mm/ptSD+9DnYrgP73zd/+pu1PLtJ6r?=
 =?us-ascii?Q?E38JmvyDnNpZTiisdB9HQqG7JwfE5tepneB/CU3t/lVYacODglW7pNyvAVxk?=
 =?us-ascii?Q?38ii51+WOOZi0X5i3qv/WottJNNtxMiS2yKnoXbjeLdBtQnJtAoWQBmvmIih?=
 =?us-ascii?Q?q8fuiolYrHS0O2COU97rz8Rbd7sDgjyHyaFlZJZgjtBnZJ9GyYcvu9MlRCOV?=
 =?us-ascii?Q?iwDI2YkHzUaGaO81W1AgE6vcNxhdiNd+9zy5JCPVpIq//11jeLnFNHmU9YCe?=
 =?us-ascii?Q?b9Uzm7pBrk397humuGWz3M36?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6AlNywCxqUJCNpDBZNgun4NrKz5lnhmIutLLJh5VFg7xRd4y2V1XEPOb8/vu?=
 =?us-ascii?Q?Gemh3FhqNbtHEHEp0R0zHQ25GGzuKvupuaSWIDKTO4m250b6evHxVwtsOilU?=
 =?us-ascii?Q?IdzSG5ywxln4odnUK9dfeDS3O3nZgjijgvtRMLf5sVC2yatUZ04mWHlkdK7L?=
 =?us-ascii?Q?oHV4wVm4pRq3Q4Q4hsbmX7PQUzrLz0INmYlyagjWOIfNhX4C7f2ZS1C5KdG0?=
 =?us-ascii?Q?0CtgbF/QileOOC8Oit3kNm3JpFzyu4qQz1piy6GmkV0OhgWJpk5U8Bk57L1+?=
 =?us-ascii?Q?ZOYqwxPENyE3hLYJDEAUezOmnqJ2X+yNo/OFq0DnYf6uAXxqZ/mRqnd4I7KM?=
 =?us-ascii?Q?LuIk9aI+T1N7Q3gDRllfRxC28Fc6GRcWZxWi2b/l3Ujr6Gyy9xBu3OQFMRj5?=
 =?us-ascii?Q?sIUpumHOCqVI/LpdqE4FBHVlGbCXc+Alvv7ll5oJ589aGRI/Nn9v2Czy78YM?=
 =?us-ascii?Q?6Hjqm3HkCEaY58Z2W/FVpzPdTTy9L2sHu3zoTTK9o1lgzpSCfMXktuk0hV+p?=
 =?us-ascii?Q?YwkWXg0NjR2VOxZnOKABzXNw88rd7cr7vtEvghoRVL2W9wAjVKU/CNB0sNbY?=
 =?us-ascii?Q?EzgkMSL/p0nq0McJRhLxYdU7AtYRWqg1mGZqAK60iKwlL+a+SwwL1lKj+b+M?=
 =?us-ascii?Q?GQfqYhZyysuu/6q3pj8VUygz7gKaq2Vr+i80j9qL4qcL8wrNK5pThxWPiaNv?=
 =?us-ascii?Q?jNhzJgFWlsZuGC+YWHsj0BpnoiIjXSTmh9y9/VidN+dLanAAo4PkFBupI3D/?=
 =?us-ascii?Q?0vHxEgtbLu463jX86AE5vxYR6CzhLDFSVHYCejM3DRRvoCeaFSiv9zrvc3hn?=
 =?us-ascii?Q?MQ8VfzMpjKn57QRsM0cGoJAZzhbqDj3NWlBEXCVnlR4uq/wXRaT99Asurp9y?=
 =?us-ascii?Q?BFcZi/569Jca2mDHQCb6CxlATr4F9GcAFZUZxylXqn66FL/PzIByffLx5vDo?=
 =?us-ascii?Q?KaqZ4PPHghyBvnwrrTBIZvLwkOmqpYs+jDadZHcWAZxVf112RAAuEIxH7C9b?=
 =?us-ascii?Q?MTtF3XkppZyVoGQWJ0dlprF9rvimw/YmQXUICZmGKE6eNC11q3MsrmtJ2LpK?=
 =?us-ascii?Q?UHgz7fHgR+veGlPnpQPz9H2aOYM+Mk6FC19iZSc1vvh6GjUNtPpb3A71etpl?=
 =?us-ascii?Q?MqfFpfFYkTnrbY4Rp8OXW2tw/QukmHkTGGMgDiGAFwlp6fS/wd8n4f7MLBFF?=
 =?us-ascii?Q?NTpxIr/7tnkueHokqonNZVYeWJLnsWXhg6FS/Lmq0R26Du2vQZ5krCmniD35?=
 =?us-ascii?Q?SLXVCp3MXaBYUxe+JQWRqHaNdyMo+gpBRGccP4OSjGjtOHUlP/aqkOtcMnth?=
 =?us-ascii?Q?SCmQDC1Ahf1TJ56lovo6t1HHuIC55Q7FQ3AgUk7XsXjXe22i2VvY1U9Cmu6W?=
 =?us-ascii?Q?DTS+AxgrTqdwbUB6tE43UdlU/6q6vQzdFhXo+8aZYN9gtdOqxkFEJz9N4mB2?=
 =?us-ascii?Q?xW+FZn/DnmxVFmAcs0dbntj9bJDMfu1cp04q+9uWVxvUkcN/meOmxru+7T+O?=
 =?us-ascii?Q?jHOSnESXaaZ+tKHQzISkISniNA/EJxPkYskoAzKDTB0doxO5j7TskhEQxV9+?=
 =?us-ascii?Q?wmvrwHGtTeHW4K27sisdOm4N4pCwjlXYk1xOc+A5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f20cf62-7250-46df-78d2-08dcfdabe848
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 15:09:56.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h71RGwvFVtamQKPDRe1gTqaMcpWcRa+jchgXjnn+aU/DyjDVqeKHYV1KxvOyqheVhmjOnHAja6RPYsqwWsirZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741

On Mon, Nov 04, 2024 at 09:54:28AM +0800, Shuai Xue wrote:
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
> index ada93cfde9ba..af3339dd3817 100644
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
> +		pr_err(HW_ERR GHES_PFX "%s:%d: hardware memory corruption (SIGBUS)\n",

Is this always a memory error? The code flow above implies that an
unrecoverable ARM processor error can all be !queued. So should the
message be more generic like "synchronous unrecoverable error" or
similar?

In any case, this is just a minor nit if this is not an issue in
practice.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

