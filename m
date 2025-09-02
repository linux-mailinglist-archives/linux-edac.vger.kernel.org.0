Return-Path: <linux-edac+bounces-4714-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE34B403AC
	for <lists+linux-edac@lfdr.de>; Tue,  2 Sep 2025 15:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF6674E3E0F
	for <lists+linux-edac@lfdr.de>; Tue,  2 Sep 2025 13:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BF6324B1F;
	Tue,  2 Sep 2025 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PHydklxd"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD1630EF9D;
	Tue,  2 Sep 2025 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819828; cv=fail; b=bS5Ad2GyZSYTgV1EgGpAXOii8VLcwf0W4/QDxaBlGWcvUJnN/v3eFg3XJJ3HP56ptSBcxQc4gLFIXT1/A2QFN375hV2HYABQnS51AjVqvleo4tn+k/zJUCHv3MYVCfVEhcKnFEwwiQgyxwkFyZ77q+mj31Br91AKYN2w2nnSWP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819828; c=relaxed/simple;
	bh=jnl2+ESe0FekxHcKfF7Hk7vsCSrbsHNMIu9lzPlmaWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rhmXNu/wgo2YemXPzvTnWre6kpXpOdApiMZ6xaBfWD/0ZUAyYj4/vBUE2PSrNi99hrJ3Xr6TUBEir6N+tZRW7Ygy9Mh4+iYcMgpSMTCFmZwjpCqok+glzCHy0qGOzVjAc+5Tox2UQAC23sCTy5qv9gVK1x4OQNUbFjscBTQMeIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PHydklxd; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C80Wf+CbYzTMQ7xdGUHDNsOELLzsBmy7IhxvL+TV0fN7CGNVeDpf9MmGSX1ps/RUXMfcnS9CukJhz8LJVIVLnTfV56dEP9nIyxyx6rLLrMLP7xO3kDdK77DuetqCExLEdOzIKvNHJ6kNiLeHlhf/NOK5ZU7NqlOlPt8kpnamJEUkxljO+byDG/ST23VZJ2CvPGnMQK3M5al/JHAfRVvLcLU1zJXMHAMcWqALYTA6hcQFi3dvcbgxyHXgacGF2w3s6FJbzDNAWhk+Z4KSvjzOwwu2r042VuJOOHkqKtpGZV72Nb3oYi9TTdO8xM1/YcO2SjCtnEl2yqBOdtRTrVXF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKkuvY41siC8q2ZgYlHko1TpxRSwhvHl+Ki004oUar8=;
 b=BcRjR2cNqoieOZZB5hMbskS/eyeotRsQ/wPTHuBFb5AR5ct6iaI/jTuvElu4nHCLwNdWj6tCH5mbN5PTmKCCxnwrBAmcptH9RlXWvx8VNNbz/v1sIS+uB+rVdL1iKNhH4YjGBsxq2Og6LfZP0wwx0nkbinaefAepdCcA1XFIR+NMxlxNaAzTI3pUPr0988WkvBMzsmkfYmwiLbkLHPjC5hh/zbwb3z7j/KV2LxUArl6oYHHN+JbQzOz1w4kMTvls0MJFAGmVgM5YHl1NQSw4zxaRQftXJRx4TZkn+FkJN9REgBksmwZis2TzIg0Zhm9DhXI3Wd3oIO9kJk3POYasqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKkuvY41siC8q2ZgYlHko1TpxRSwhvHl+Ki004oUar8=;
 b=PHydklxdBk0tMQvpXNdzVNNJem6waSH4hJ7rnOWnl/rBAriUcF6jr7+0Zc/LubdHNtgrkPGJyhyX9uDp63YrfjDjSEEPFLz6j9mSUxVrc15YMHl72CJ6ResGBh8KDoPaXpk5Z/Ut7qG9ulCSeY6qWAK07FO2ccN33noXGWbg0NE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:30:24 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 13:30:24 +0000
Date: Tue, 2 Sep 2025 09:30:15 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 07/20] x86/mce: Reorder __mcheck_cpu_init_generic()
 call
Message-ID: <20250902133015.GA18483@yaz-khff2.amd.com>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
 <20250825-wip-mca-updates-v5-7-865768a2eef8@amd.com>
 <20250901170741.GCaLXS3bUdUPksnMs8@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901170741.GCaLXS3bUdUPksnMs8@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0908.namprd03.prod.outlook.com
 (2603:10b6:408:107::13) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CH2PR12MB9541:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d10233-5bbc-4445-7c36-08ddea24dee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+7vtuUCkFW43gNzXHE2mhw2MxWHkacT8emkXeKbwA0l4yGKbSRE7pRHG2BXq?=
 =?us-ascii?Q?WCHD0EAzM+aSIhhFWkd/+AZs3jyXUSYP9RWyMSFQKhKw1PTvws92RgaGzXII?=
 =?us-ascii?Q?Z4b9rb3nwF+v0D6wx8zUWwuwB9dYC47UtFf+vQQPPnxq+dEuya4l5uzLcxRy?=
 =?us-ascii?Q?q5y/a+juVcNreNTgJEJgyh0HW7ND9Vq1RazZAzL7G/n8s6Ttiidd4J3FsbZR?=
 =?us-ascii?Q?07MItTAEWDchudmxuPtmL91kQ5jnSOt154gz9+hyYhfbbPazXrAPLSr8PL3k?=
 =?us-ascii?Q?STn2TYHZy2u4rO73FCbWMRScT9mOCbq34nClSXdCavt0KWZuvxNpJFkXmmu3?=
 =?us-ascii?Q?ePlnK7BFL8yDJGEYsMg2FjFWLOAR5WxUBO5GVX3eZnFhjHJfNVu8RMF51lJN?=
 =?us-ascii?Q?saiVBCaLW0ewlK8PpFXeTX4jU7eByLzTV6x2nKc6AnpPhh2dd1X+PtuByyrB?=
 =?us-ascii?Q?vE0cg4d3BM5SquyccnxgX/qhX6HVv1nDjO4m3b2vgtK2rJYLgQBim/8Z6G6L?=
 =?us-ascii?Q?+A656HiAPugG8ZuxmhjaHPeCsc7oO8ax3w18OiVucIzMKNSip/lZxWM+FxEV?=
 =?us-ascii?Q?9iALrxVisy16fvFL8ZzOOveiQJ2/hSDbg45HGs4+wg3v7f7PWLhuKsDdwrc6?=
 =?us-ascii?Q?KL8dYY0yf8XelrFzKvzvFfZGfwChr3/r5hTRQCXEoydS3Xyev3corE0l89gG?=
 =?us-ascii?Q?lhxruuA9BiXEs/Q4WaFMof0Sm0nfOptUg+iOv7u/Tc1nkE3KHuZcFuoMKxzc?=
 =?us-ascii?Q?MuKnsuLNwIiy9IonAQGbg1qv8WwXNNFmnt6diWeJie1DQOUpYDNbFCGy3d6n?=
 =?us-ascii?Q?Onv3QB3+oMyPjK1paGl4MON39aErgNotrNjVPu6dGsgPH2g4rpRw/lb/JIzh?=
 =?us-ascii?Q?n8jJ5QAmk35UgvNgUA/6q7qVQjgedMjlf9PB8jXmB4f/yrYElRVZbWaeI/o/?=
 =?us-ascii?Q?sxyAFxN/A3+cPnqgMhr851KN+90ce12K95qOo+6pwHhzpnw6Hr0eKCdggY7H?=
 =?us-ascii?Q?oEnbCjXv31czgiKxJH9Le6WoX9TIFr807KwKcwyWgIfU23qyrhVlVQF01aKo?=
 =?us-ascii?Q?SwE7MmL/X308xm7XwtZqHxleE9nD20OLMdIlbK0ZP9PQ0aG4SOkzMuHtT4XX?=
 =?us-ascii?Q?7Lci280pmsXFNDhoUgtMKMELkb79LgMQesP3Lpe/0GJ7xFgClT9fGECVGLtp?=
 =?us-ascii?Q?GeYOdJzK5g+Z8CpwRVAwnfyF/iYv+OmSj5k8NnH5Soq6Mqzl0T8stx7E3WJ1?=
 =?us-ascii?Q?3yByszFWR5SuOIVu16P7vk+kLzIfIOOw7c73NZzYpFANcoOR9gOU6/NBZtuI?=
 =?us-ascii?Q?RO3r/dlQmIYQlBN0jXyD2azRThEqocisXRmPUdCbhRAM4OcvdSci5tWY0BKQ?=
 =?us-ascii?Q?kIjQYqc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mFU/7I/er4LG727Owr8cJS0UNViW0n3ptzgLCgtSN+Qqpm2JjSCF972QxzpH?=
 =?us-ascii?Q?lcyO2aDNxCj34LKADWegtHpZnfR6kWmkRKWcM57q6EusoBBdXKY5SfW2Pig8?=
 =?us-ascii?Q?96r1crZ9r7emDiYnTrzhXgZ7y4O6hXhefMTNIAnUHrq5mr9BAC/txr96ie9x?=
 =?us-ascii?Q?KnPfq8ORU0zxMD/k7cD/H7t4ojfGFMyeZrwJSgV9GzmhvAxD73zK5xgISKHG?=
 =?us-ascii?Q?J48FqdRFU6211GpyIK0+LRVpzFmtNc3nNEAK/mj9mSgNxyUfSYm97G0ZZAu4?=
 =?us-ascii?Q?QM8JReuoh/JcvylARWtzigp5ksvehWaUGEitjtWSx7Ipr/PxKv9TgDmGD9b8?=
 =?us-ascii?Q?W8t7k3IQlHsmUciqsqQs6kfQOSVAQvwKweJl5/znNofuAqaGsBZcWFTr2OT6?=
 =?us-ascii?Q?3QbGKhC9lZPiWm+RaTWdnV3AAqxiLco6k0nhvYDgNzLYDwOfjuusRHPihO1P?=
 =?us-ascii?Q?3fNSgmltyTf07Z9vD1WgWVPi3I+z8gvgBcwp5ODjauKyiNU+ouJIQFKbike0?=
 =?us-ascii?Q?yvk4cXFyltakBqJc/BV4iV8XU3vlPiO1Pr0MEMcxKsGA76a6A7mJJqDjf1Ev?=
 =?us-ascii?Q?xE2ITd1XDs5PMPGxPjKt/MK7kMkMUDTaMyTLPDUn77W9if1nZcTAnCEavZXc?=
 =?us-ascii?Q?hp9my0gvNzbJIehx+MFrLIu0xnC2RsITP7e9P2OQTqafCEzTn20xLeS9yFN/?=
 =?us-ascii?Q?tP8A4tz5ypgN0jc7MpwEmvVCNgzBB/RdRzHb/0pbNh5+N8Io9Qcfx8ooJM8x?=
 =?us-ascii?Q?7N5Nmt21JBiyKqg/1iq2BhAn7noO3IQWCVFoRV0ucZ7jZdDLgVo5m1Xuu0gq?=
 =?us-ascii?Q?a3lkchc1V/OZMdhlKxJyDWp5VtYDTu3HEiOxSbBYwqLkZlXs6MkYTCT9ZYXK?=
 =?us-ascii?Q?Qzbjf3DzkCNBfw1IGSuP8Mrd7rq1+ffi8bxh0JcivHYvbcKlLaRtNrrkw0PL?=
 =?us-ascii?Q?emBNbLhtXCSYadwRpuMEukO4ZyZRG4qrJGVuWqicwOd9LpgFFd3tkzyFr+zY?=
 =?us-ascii?Q?7ZqEfWGPWtl9ZeyxnvNmAwAUaTZZ1ocCdNhG4f/K8Q/5wqWg3cLH8Bvf8C7t?=
 =?us-ascii?Q?ravL4k8WmH3bvraJ2WwfpLlshVdCMRDU7de0hTvOEwX6rDLqqtjH3FRO3y3d?=
 =?us-ascii?Q?dH0rBhilAqicIVZkIh0Quinj09ZsDDEVNt0iz0v1eaKBdMvkQdw7G9y7wUsq?=
 =?us-ascii?Q?W2Oyz8HzRFOm1eH4+qGlX2EDPjQ8PXP2hV4KUvLQUhmwPReCiWgaB1lWinSp?=
 =?us-ascii?Q?tUJCEHv374tI1tfKwUcPa4GgabXqbFAF8pRqoedvIgzczRH9ilmkBeBfOi6K?=
 =?us-ascii?Q?zTK5EpbURFGCvWFg1MP9/HCK29zVdzbeWKGoQwyPcRdfgxn4486B1/kRE94E?=
 =?us-ascii?Q?TpU0HBRbkiu+vIzov8JE9bFUODtOTrEJzyPNbnbM+ycpz0UMk4++Id72dCib?=
 =?us-ascii?Q?XqmsqoYOkNAQiE88PRMRykB03CCpMg96DN/KO8ionIucHTr9hSmVSSoGKTXr?=
 =?us-ascii?Q?94U8xDef2cwtoNnrGiinevjKWmuqRmRjcR8wRxkmNkcQILycSElXb3EzadmM?=
 =?us-ascii?Q?94i/nxLCq6lvogvF4oszfhYkkpEpEs0nBQ9sZo+r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d10233-5bbc-4445-7c36-08ddea24dee5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:30:23.9791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqKvR6RbEnzhH6qLOVdEniucPHNKaLqZ+ngNp7ScQax/7xaoJROsqtH5CX+G/1p5UWnQTsYYohb0+ENwK4tNHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9541

On Mon, Sep 01, 2025 at 07:07:41PM +0200, Borislav Petkov wrote:
> On Mon, Aug 25, 2025 at 05:33:04PM +0000, Yazen Ghannam wrote:
> > Move __mcheck_cpu_init_generic() after __mcheck_cpu_init_prepare_banks()
> > so that MCA is enabled after the first MCA polling event.
> > 
> > This brings the MCA init flow closer to what is described in the x86 docs.
> > 
> > The AMD PPRs say
> >   "The operating system must initialize the MCA_CONFIG registers prior
> >   to initialization of the MCA_CTL registers.
> > 
> >   The MCA_CTL registers must be initialized prior to enabling the error
> >   reporting banks in MCG_CTL".
> > 
> > However, the Intel SDM "Machine-Check Initialization Pseudocode" says
> > MCG_CTL first then MCi_CTL.
> > 
> > But both agree that CR4.MCE should be set last.
> > 
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> > 
> > Notes:
> >     Link:
> >     https://lore.kernel.org/r/52a37afe-c41b-4f20-bbdc-bddc3ae26260@suse.com
> >     
> >     v4->v5:
> >     * New in v5.
> > 
> >  arch/x86/kernel/cpu/mce/core.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
 > index 0326fbb83adc..9cbf9e8c8060 100644
> > --- a/arch/x86/kernel/cpu/mce/core.c
> > +++ b/arch/x86/kernel/cpu/mce/core.c
> > @@ -2272,9 +2272,9 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
> >  
> >  	mca_cfg.initialized = 1;
> >  
> > -	__mcheck_cpu_init_generic();
> >  	__mcheck_cpu_init_vendor(c);
> >  	__mcheck_cpu_init_prepare_banks();
> > +	__mcheck_cpu_init_generic();
> 
> With that flow we have now:
> 
> 	1. MCA_CTL
> 	2. CR4.MCE
> 	3. MCG_CTL
> 
> So this is nothing like in the commit message above and the MC*_CTL flow is
> not what the SDM suggests and CR4.MCE is not last.
> 
> So what's the point even here?
> 

The main point is to initialize MCA after polling for leftover errors.

You're right that this change doesn't bring the code in sync with the
docs. I'll work on it more.

Moving CR4.MCE last should be okay, but deciding when to do MCG_CTL
needs some more thought. Maybe we can have an early call for Intel and
a late call for AMD?

Thanks,
Yazen

