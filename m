Return-Path: <linux-edac+bounces-4143-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A2DAD95F0
	for <lists+linux-edac@lfdr.de>; Fri, 13 Jun 2025 22:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA57172B59
	for <lists+linux-edac@lfdr.de>; Fri, 13 Jun 2025 20:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A7623C4F8;
	Fri, 13 Jun 2025 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ICiyLEPf"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E50F72608;
	Fri, 13 Jun 2025 20:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749845448; cv=fail; b=nyaoKaktMoyph17YspSyz+64n9JrNekmmTGvBq83GB8SOGfLTqZE1itCozL0s3NDnQkukE3IHuthpylS7MW8l7NZTIQmZhq/ipjY7IdFdy0MdCLlmrxQGurXs4A3eG4CDbnFvCJCV2ArTmf9kmH7FRu3RJwbGYMCm5Vj4sUoZKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749845448; c=relaxed/simple;
	bh=7Za2T1SV+WgznoTFphFzikdxSqC/8xhNPjXeov9f0XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hcvs2nSqKKLP3LdpzO2XvlcHKnI44RDP+acq1EWRfSrIXz1lsSbMH1UfiUCo6JFvmpkg/Ubxp7LBfvs4vpGopqnX947FpFDP9RQdhIf114SQBigxZcg9xVTGlZMQoDsKlzP7iEjNnHIVh5+LitgIrU+77ixlKRQq8JNdgOYhxus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ICiyLEPf; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/dBptB7g/qIEEnEOA1el/DDBlpNQaBmE7HHmTl1yfyECCtn3sPlkbMf1UnMCcjDGW90w6B9YRHx1Rjb0DXsptOkg4fFK6ikLdo87oHYCfyLMVayer5arp5dYgDvD6YPSa46Tl/ZoPfaZ8dHcw0fvQfnrmvU9FgyK0RW94Tkw4zIhVMW9t+E2Oh4cfeBBiNpj/lo6jzWzvCr3tLgLuLMuNeRA+H6KMwGB//1hpodKzjYlAhP58diOzjNjjjcADN2uCscUUFcEn+DATB/OiH8nShIqJ0nO4RcMY2YCEuL/Slyhy/hl6pLn7CXUBSFQSjeEvFHFpOMbQ+LgYGO3CB5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+G4ETwy8NmomOgQflad0FMk3DhrQYsxB2j2kJAJaSyk=;
 b=BKNldtdWs8yM5mHthJF863elZeJTv2Z5wLQnuz8kxoQtt0QEDQffVEWnX0+XL7CF9lEukLr2X46Y+eRUeg3agHiH3W3znpwl9puGULSKlT7764LqyUp096FVEspwC0Hnns37moR6d72UkEGszL2AGu/u1h7RPwZo0S1jrfh/q1XSDGMOyKaM/F57e2bsH/vTS000Bm5aRfssg8sqhUqWtL/9WS62L600K4juudjGzC7BMe05WJTFAJsIKyq7rLIbC/SVE2Y5hnVEbe3qju4awRts0lFCPT7SxLwkKib514tPDkhX75WHQ5NCR2Zzxm62y8RYTCAPKf75XMGE4pgkNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+G4ETwy8NmomOgQflad0FMk3DhrQYsxB2j2kJAJaSyk=;
 b=ICiyLEPfPM1Zi+qyCNOfCLtpb3NbbWHHuQD+ra9qXogQVRW4v0fPY9Fpc1AgPCOgscPX8zTw0aHjfbd62Zlpt38cQedQd2UMnQZjFAFpCHi9lFNTrcd2vFdWt437NOAiEOutwYCAZ8XgHaZTESznUusbsIIsmkg7Fkd18zJcqMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA4PR12MB9835.namprd12.prod.outlook.com (2603:10b6:208:54f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.23; Fri, 13 Jun 2025 20:10:42 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8792.038; Fri, 13 Jun 2025
 20:10:42 +0000
Date: Fri, 13 Jun 2025 16:10:34 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-edac@vger.kernel.org, git@amd.com,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>
Subject: Re: [PATCH v7 2/5] cdx: Export Symbols for MCDI RPC and
 Initialization
Message-ID: <20250613201034.GC171759@yaz-khff2.amd.com>
References: <20250529070017.7288-1-shubhrajyoti.datta@amd.com>
 <20250529070017.7288-3-shubhrajyoti.datta@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529070017.7288-3-shubhrajyoti.datta@amd.com>
X-ClientProxiedBy: SA1PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::18) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA4PR12MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0bdfeb-f7c5-4481-cf2b-08ddaab65fca
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Qyc0Fre0hnqoZUWwKwMsFhZeaXd6x8FFd61b9FLsDPmhZu+jhoZbc5E+8L9?=
 =?us-ascii?Q?1aYO7nJyyeT+OxNHmlHe3M4jkQxIMRFKe46km0uMYjpIYI/znEorUFUDhKqu?=
 =?us-ascii?Q?iSlCWdy7jxHAf1w/i/xGWvyufRMn9SaEPJYcelvVuKFLVsSW5CZlsYtNFGGH?=
 =?us-ascii?Q?V7MJNcFx25vdyZfvLMzNe//5P0O396xuqm5y0a1DF9ZBybkhE18RG4wZFYDV?=
 =?us-ascii?Q?wUPbRKutqkO5z0TwcE8X53iEpgIEEcY9mA1fSt/ZxnCd0nckDDkT5Maem6Ie?=
 =?us-ascii?Q?sDs0+SEnvVHUGTD3R6+vfFOZmOLrz1zBPHDLS44TkhvhdgytjvMu/lUfbgeW?=
 =?us-ascii?Q?D/3ze+g5uecT9X+ghgmAdaABJ8IVBMGluT3RH9e1x8+YLplBTxtAJXsGFz1A?=
 =?us-ascii?Q?9UwVko3lsslLesmhQrqMS/a51hYt7Q1db0/tv+MPkmv6lICg51+lZJTDzWBg?=
 =?us-ascii?Q?8homShSn2AiGP8FYDcWslQAQQ2mbeIW8NGiAzYNeSyBYAdqzGPPQkHCdzwwX?=
 =?us-ascii?Q?ki2evujPEH+o6N8vVe/DaAj9TErDLMKixVMEbW84bMGhweoIMN3wy8oG8xft?=
 =?us-ascii?Q?7I9OYyJEqVk2eJLYVRTAR0cFFFAoZf3k/Nvp1HW8Uaz6xKRrzLoa0jkDz147?=
 =?us-ascii?Q?XhNqX8SR77j9l7+nJMSSepz/kfamoTEli5P5Cy1Po6Bz+BbsOrLuVUA4FzUC?=
 =?us-ascii?Q?S+HIMbyp5IVGT/HURrdHCuOBSewGZpt6ihj5gsskePN5g2+rgX6qWSlM91+K?=
 =?us-ascii?Q?Nah7OzUIBCn13g285rsKXcsd48hGVwsfqALupYJz/axRpvl4+CVeiX0B2hg6?=
 =?us-ascii?Q?wj+tUPUNx4mYXEky4pb8Z1QfmuRem4EAZDMCK/+c7WwKScq1MCQum8a/HGav?=
 =?us-ascii?Q?1u1Q7bw7agUlzNd83c5fX9lgAz8L8SyXW7+3RrcfX+RJM4a2s2tR2CzEnQou?=
 =?us-ascii?Q?/hIEP/Ncgbzgl37xaxCNch0VejucoIzda98elBU2ta93SYlW+XDTOVxXosBa?=
 =?us-ascii?Q?cJPcbADdvW6NwGCiGD/Kea1hyPRxyOJn99A4DJ0zdtgKKr0tLRqA9xayHpwq?=
 =?us-ascii?Q?JEZz48mczdu1QfSARJ9VaAzRd2enVz3Ar2v0/givewP/2fSZKafLTz6rMfEX?=
 =?us-ascii?Q?KsGUEKxigR/lAej+vH7khMKtWhYAQ6EHsBpcW3qaya+1ASxXdmNcUyqrPa1h?=
 =?us-ascii?Q?1iqVyLi5JIEk9FewbhUgU9CchWe/QpMTSUX1tLdZBxxALjv0hhI9ODMGC8Oc?=
 =?us-ascii?Q?9iREGqD6qjPe1/7B0XY85dw7QQ4cy7Rem+LNpgmADd645bZqAb8pfcBmP/Z4?=
 =?us-ascii?Q?SSx3k3t0fuGbOnWmvJPBjMjMvb/g9LOqeDO2sDLzacpInhP211A1LYigYRFy?=
 =?us-ascii?Q?XPQLMx23BPPzVZye0vWRNbIf85OOMrMToaJG6hWhudmHaCPlMxil0QykFTDQ?=
 =?us-ascii?Q?RQNyPW4udko=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KzuJb7YI7/CfSpskMhzP+NiONsCFvpD6moPxBWlfTUbg9GQz0MQaFhjq6ybo?=
 =?us-ascii?Q?j07NxJWygQTqfnCegv3sPpdoDW4VCfd2JvYo1Zs87zfnPapxshKmEMrvV6u/?=
 =?us-ascii?Q?wPX1noT2oHDUaOhpwniKSv4KkfeiSu/2o638mr5cYAwlI1eLnLOAQo9UNLKe?=
 =?us-ascii?Q?x9/WDMmtB3V9AHychXSgdmsKOUWG0r7pY4R/sxhjgfKTBx8ydolBe3rh40Xi?=
 =?us-ascii?Q?j+VqgQnk3le8Emy0aJt2yOMG8gdzT/FQuEx8Qf5plsrVs5b36EOHInO5/nWT?=
 =?us-ascii?Q?ncL9iOYD2DYKQ5wHX3c2BkynXEdQgfIpxhXo1s7R5jDqEJO2so+SNZ8CBQAc?=
 =?us-ascii?Q?vowuxtmpZIzF++yhNyXYjbqQB8vkN4LvWGXLJTQzqE7GhK7gNtt6VjSI86fJ?=
 =?us-ascii?Q?W5pwHUfWcDDzS9cP6P0MylTTic2WOzCqUzjlF+hq5XQkrIU5mS2wDLBk/Xef?=
 =?us-ascii?Q?d+O8sPliTXYg9d+9CejLRfRW3WNziesQ7Qe84Xwu18m4RxjmjReJP/Ts1XKX?=
 =?us-ascii?Q?sQY4crRdWnEmdkcRlV0n1J+2a3z3mPtcKOWhPEA+pc3QnrfVMsRJEuaTHvRX?=
 =?us-ascii?Q?843uyaShmndwBuRUQUlnbxY21JqgtG2xB/FSeWQqHThIUvR/qKfnz9ja4wYA?=
 =?us-ascii?Q?bL9UphSd4pAC3V1xIAVe674Jk+JI7kq/Q7d+iUGaJd938zk8qnHgC5jFGvO7?=
 =?us-ascii?Q?LyjLWQ7VQslu+MxFwxlxY0vjYwTVRVDsdqPvJn7zPHXykpUzpJ4YCCx/ALGM?=
 =?us-ascii?Q?4RSFvVco4W46xpfp7AfAsWqtpJPDl8DahBsxKZFTRZX0f6EB7B+X86upyrTl?=
 =?us-ascii?Q?HpMOj2cw0L7qRiYcUoGhOj2oPqM8yuSiUgYnHk5/RxOb1D8F1NCME5/BltBh?=
 =?us-ascii?Q?Ofu0a4htRuyMmW2kimmC/krO9ltQhvJo9BiOhf+3EYX7/3PMzlpQXv1tsH6c?=
 =?us-ascii?Q?B/Njwp0lcNKu0H7+/7l8tW/kKNXoIPeT74jSNklTup68zY50PeySCcUzQNba?=
 =?us-ascii?Q?UnvpZLMmR9XXlbU2wznKcQQa1eHCYwoKierEk8htY6O6jI0Xv+ctkkUDkE83?=
 =?us-ascii?Q?4rP9ji4ELYpbPo675Mn/o9xJMTjy6+EJNznKmqTuhRZBo4V+/sWYLTVn1DqN?=
 =?us-ascii?Q?MlmoH1RH1hV5GqKhY0cFfGomfOfIgKqgkiFmZKe5AXlGEo2uuZ9gEMtmLdg+?=
 =?us-ascii?Q?MoIh+TBV/zosbyQRYMt+gL0s3wmqw7njXG27/S8jQSAvNbY2R/W0ndsP37d4?=
 =?us-ascii?Q?kNxxzWs8LS0MnM5jFr/298OuwWuqNWFcq4aztyyfmOJ4nb5y10mu5CgC5oPm?=
 =?us-ascii?Q?teKDPEf+dm90tHSiVdVHPrltuLDLaWQo+LPSbLypc7Rw7d7sB3iYUZFI806n?=
 =?us-ascii?Q?KvqOl2iu0bzxJKwhyb4bL2a6xiruLcz0TFv4Y7zO8fpVt38VumasmXNa49xe?=
 =?us-ascii?Q?EsQ2nnujC2qZM/ygmwsmGUgNxC9945oCvmND1Su52u1oJ+fBnMktpjBCDYNE?=
 =?us-ascii?Q?RVd4/Jv4APUAx6n6S8W1et4lFjOPDebdrojWxkkd9ww4H8Yf/imNTRoDtwXE?=
 =?us-ascii?Q?khz6ebjnlbqql7Zgx3CPIV0WXSOtX+lUagjjZDeW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0bdfeb-f7c5-4481-cf2b-08ddaab65fca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 20:10:42.7673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /63UdLHbMnLJeAQo0HBuvNxx6j9BISZ60KphQp2S/EwYUxeMSAu3sdHQGDjP11E4z1XCGiEEFQqJMeSoqHx4YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9835

On Thu, May 29, 2025 at 12:30:14PM +0530, Shubhrajyoti Datta wrote:
> The cdx_mcdi_init, cdx_mcdi_process_cmd, and cdx_mcdi_rpc functions are
> needed by VersalNET EDAC modules that interact with the MCDI (Management
> Controller Direct Interface) framework. These functions facilitate
> communication between different hardware components by enabling command
> execution and status management.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
> Changes in v7:
> - Add the kernel doc description
> - Add the prototype from first patch to here
> 
> Changes in v6:
> - Update commit description
> 
> Changes in v2:
> - Export the symbols for module compilation
> 
>  drivers/cdx/controller/mcdi.c | 29 +++++++++++++++++++++++++++++
>  include/linux/cdx/mcdi.h      |  6 ++++++

You've added the function prototypes to this new global header.

But you didn't remove them from the local header.
  drivers/cdx/controller/mcdi.h

Also, you haven't included the new global header in the cdx/controller
code.

Even though this does compile, it doesn't seem proper.

I expect you would want to do the following:

1) Add the common code to the global header.
2) Remove the common code from the local header.
3) Include the global header everywhere the common code is needed.

Keeping the diff below for reference.

Thanks,
Yazen

>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
> index e760f8d347cc..f3cca4c884ff 100644
> --- a/drivers/cdx/controller/mcdi.c
> +++ b/drivers/cdx/controller/mcdi.c
> @@ -99,6 +99,19 @@ static unsigned long cdx_mcdi_rpc_timeout(struct cdx_mcdi *cdx, unsigned int cmd
>  		return cdx->mcdi_ops->mcdi_rpc_timeout(cdx, cmd);
>  }
>  
> +/**
> + * cdx_mcdi_init - Initialize MCDI (Management Controller Driver Interface) state
> + * @cdx: NIC through which to issue the command
> + *
> + * This function allocates and initializes internal MCDI structures and resources
> + * for the CDX device, including the workqueue, locking primitives, and command
> + * tracking mechanisms. It sets the initial operating mode and prepares the device
> + * for MCDI operations.
> + *
> + * Return:
> + * * 0        - on success
> + * * -ENOMEM  - if memory allocation or workqueue creation fails
> + */
>  int cdx_mcdi_init(struct cdx_mcdi *cdx)
>  {
>  	struct cdx_mcdi_iface *mcdi;
> @@ -128,6 +141,7 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
>  fail:
>  	return rc;
>  }
> +EXPORT_SYMBOL_GPL(cdx_mcdi_init);
>  
>  void cdx_mcdi_finish(struct cdx_mcdi *cdx)
>  {
> @@ -553,6 +567,19 @@ static void cdx_mcdi_start_or_queue(struct cdx_mcdi_iface *mcdi,
>  			cdx_mcdi_cmd_start_or_queue(mcdi, cmd);
>  }
>  
> +/**
> + * cdx_mcdi_process_cmd - Process an incoming MCDI response
> + * @cdx: NIC through which to issue the command
> + * @outbuf:  Pointer to the response buffer received from the management controller
> + * @len:     Length of the response buffer in bytes
> + *
> + * This function handles a response from the management controller. It locates the
> + * corresponding command using the sequence number embedded in the header,
> + * completes the command if it is still pending, and initiates any necessary cleanup.
> + *
> + * The function assumes that the response buffer is well-formed and at least one
> + * dword in size.
> + */
>  void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword *outbuf, int len)
>  {
>  	struct cdx_mcdi_iface *mcdi;
> @@ -590,6 +617,7 @@ void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword *outbuf, int le
>  
>  	cdx_mcdi_process_cleanup_list(mcdi->cdx, &cleanup_list);
>  }
> +EXPORT_SYMBOL_GPL(cdx_mcdi_process_cmd);
>  
>  static void cdx_mcdi_cmd_work(struct work_struct *context)
>  {
> @@ -757,6 +785,7 @@ int cdx_mcdi_rpc(struct cdx_mcdi *cdx, unsigned int cmd,
>  	return cdx_mcdi_rpc_sync(cdx, cmd, inbuf, inlen, outbuf, outlen,
>  				 outlen_actual, false);
>  }
> +EXPORT_SYMBOL_GPL(cdx_mcdi_rpc);
>  
>  /**
>   * cdx_mcdi_rpc_async - Schedule an MCDI command to run asynchronously
> diff --git a/include/linux/cdx/mcdi.h b/include/linux/cdx/mcdi.h
> index 46e3f63b062a..1344119e9a2c 100644
> --- a/include/linux/cdx/mcdi.h
> +++ b/include/linux/cdx/mcdi.h
> @@ -169,6 +169,12 @@ struct cdx_mcdi_data {
>  	u32 fn_flags;
>  };
>  
> +int cdx_mcdi_init(struct cdx_mcdi *cdx);
> +void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword *outbuf, int len);
> +int cdx_mcdi_rpc(struct cdx_mcdi *cdx, unsigned int cmd,
> +		 const struct cdx_dword *inbuf, size_t inlen,
> +		 struct cdx_dword *outbuf, size_t outlen, size_t *outlen_actual);
> +
>  /*
>   * We expect that 16- and 32-bit fields in MCDI requests and responses
>   * are appropriately aligned, but 64-bit fields are only
> -- 
> 2.34.1
> 

