Return-Path: <linux-edac+bounces-4726-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EF2B422DF
	for <lists+linux-edac@lfdr.de>; Wed,  3 Sep 2025 16:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA79584CEB
	for <lists+linux-edac@lfdr.de>; Wed,  3 Sep 2025 14:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF8A30E85E;
	Wed,  3 Sep 2025 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zSub5RE5"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB692D9EDF;
	Wed,  3 Sep 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908032; cv=fail; b=UlHDHfCT2RtgGRYd+UYuXodeOBUy0QkjRg/AwOWxy7kCwXfG0Lax9Hc27W0tA89mWtxtNf0T5EExCvEirTyb/f2+JRQmgPXd9l8gfHEe5G3yuyup2yXjOqn6gS81OSseYmKM8G4p0g1ml1Megh+0t6OcXIMCfJFdEE3UvkBArsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908032; c=relaxed/simple;
	bh=ALHDo3hf5yn0xOCJhGyQiJdqj5xGvhjYLsu3iMtxL80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZIMJYpx3kBrR18eQ0acNCAMh0yWQa1CCEb9JFJ3UBlJx1DOmuDjMV4yHsyUYc1ON3yr0ZlObqd9/jSB1cldD1/ZjDJpcuW4GvVosnSIy6Lzn/yvcJeiz6oNooaWombPJzaqUcWJZ+eil+1fGsaCRqh/27wWeoe/PC++84GhPwVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zSub5RE5; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwgdqKHDvI2+5eocEdT8X/2Tx7HYfwNP5V5cD5E6dYZIMNMSJ8Qn4Cc1TUlbi2oZxvy4WBuy1M9Wep6uSp1jvFfRj4+b07lQ5T5o026hVwhdGnrmQR0Y6wKiisrAV0Zsswg2rEmFm09m5V2aWQjwCG1uF33fu4UHeYK4NMJ+qoGCqrAxxdHG0vE4l80enKZAUpOAAPTg0NuEHqprc9xyL224hoL/gWCibSLNdTTf3ZBnOEmi3OxrTWwyUi7KiAtQ8aIHhJz/CFIFveO98ZdDMn1XY4MSvkNx52rSgp8jjwrbJJEOYmz3o+z+qYG0KAB1PECJaWQlaHq4i+0x0DPJ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYFVCVys9WWx42nx3hxg57ya/S0Hitg+2BlLes0Fsio=;
 b=mR0WIdrDR9daq+RHRGr07u5iR5hvdWZFYNwbuhsbkMbfCadAgaghbhB3GVjspO1jtZ9TZAjGJQCpstcmQH7s8zitffz7hyEEAeN9xNaB0ySo1jLYPmkrQ6olzbsja7JfQomT2j6eKUW7R6qiurRpwF2gSIgVXW8D/+Ccan7C7i2IPPqvVv0vCH8CctBMvb06EQONVbIEA2eOyRhh/kwgNBoOyxxFUCr/YndeOMqzVs0MU9aaxG1P+HLOHxp6YDUXHxHHzMzb0bHmyb9d/nO1wDD/kyfEGn4ZEw9bnNIxMpaV7djvAdNtV4D7gB8d9z7dqydgcTDpRtfjT0exzFZTjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYFVCVys9WWx42nx3hxg57ya/S0Hitg+2BlLes0Fsio=;
 b=zSub5RE54kzKzKQSHP7nWHHhANkfLmMRBxSjDmsCqQ7onsFosvizhBCWdAv5BEiTXSd+/dBFX9rpU6NiFy4IUQNwfpIe6quz3mXpuJ++QiqsyLyzL3xQerv34luUmfS2H/O15oEihiJiyoT8IckNQWgTZ2QymzQWgRBNjpvkSJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 14:00:28 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 14:00:27 +0000
Date: Wed, 3 Sep 2025 10:00:22 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 15/20] x86/mce/amd: Enable interrupt vectors once
 per-CPU on SMCA systems
Message-ID: <20250903140022.GA835@yaz-khff2.amd.com>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
 <20250825-wip-mca-updates-v5-15-865768a2eef8@amd.com>
 <20250903100317.GHaLgSZTPMDHrKbO7Q@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903100317.GHaLgSZTPMDHrKbO7Q@fat_crate.local>
X-ClientProxiedBy: BL0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:91::34) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: 03bf86c0-81cf-4e30-4074-08ddeaf23c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nGziZnsUgJaqM7NIsYbGUzTmAaEDkU7K0ROnYPARFN/zsqboT0AdjaBJpGN3?=
 =?us-ascii?Q?g4LQLx1AyyC8Fpmpj0hGxO/g8y48lxHSjsQ5kFvZMpVWBdYAyWRCZlddPuwW?=
 =?us-ascii?Q?SdkkxzkdRUrKxWwNvx84BpvfXdbQO75z+Nz0Cmo7hskBNHgkNnAJaxbIJqmS?=
 =?us-ascii?Q?CwehqY7+UrOJ52j2KgpDnulB+mzUpiKW6fUQvZUdw2yiLdyXIZ0qBoDBH6nY?=
 =?us-ascii?Q?n3NwBxdJECSjT1Zcwya6ie3p85DIqu57k2P1RUZo4u55NxZzHJaqwlP5Etj2?=
 =?us-ascii?Q?HfyYUsHpFINd8FDHVsoKYfO2i8rOOUU2Yp1yJztj5zn57PWdUAZhQM0N3C5o?=
 =?us-ascii?Q?skil+6H7dcIWrHH9C7qeMYM8RKzsWlOBAppabUtvKDN76ZFIUj/JZ2OKew+2?=
 =?us-ascii?Q?+sqHBBezt2p4Qg1IXYPqs6H7ef5eWbwmfdGCW76wVv2KVtie18NpMPu8QFAC?=
 =?us-ascii?Q?xWTF7BYpHE6FzPQE8xhX3kRJf/7ti2M9/bkKWDs7CKnVxUldEaClZubiP7l9?=
 =?us-ascii?Q?5TqfypaXwCM+pA+O+540Kf2A6AlLGi4ZKEXhpCasIOd211FFy9SgFTuQxuDk?=
 =?us-ascii?Q?KmBBoxj2BlkvN4PtBw0IEhndFE9rY4VTU8FA8cxZvxea5a0KAitQM0VwYzMa?=
 =?us-ascii?Q?nrcv49mvCUSc6K0P9aqc0ezDZpzOpk9f/efPo9zLCwSh9g6NNCr78ZtcVd1C?=
 =?us-ascii?Q?XQCR2BPeochRR7fyuzMVwtZ9TmHX8giCYVWa2SbrcHnKvneUFrbvr7X/NFW4?=
 =?us-ascii?Q?Ph++IxQueD/VsBjzsM4sO6wjAcOa7tuA65p8Qt8qT2Mg1JhQw5DlO5b6a9CE?=
 =?us-ascii?Q?lmMFBGyOKT8ajz9qSCsMlAKeqOFGlgovxtoqlr1kYqg1+kbZuCd0hBQGbDo2?=
 =?us-ascii?Q?Bfny73WZRpH3Y8y8krAzmNFI/EteX4wYSIPvtZgPbtl8lwVs7IAyiMWfd2Kx?=
 =?us-ascii?Q?DO+l7zdlikxhj6BHwGiLOv8gF6NDuYYQuuJOLpv+sk7OoBMF+xdhhfH+QeNf?=
 =?us-ascii?Q?jtTLLLB8NY6tmMnUpsVF/Hse4/BgTiP4ICUBaNY9eWX/Ci/I3XNK6ue4kiqB?=
 =?us-ascii?Q?mxBzsyBwT5kAFGxn946lfGRNuW0ypdz5iO/oxq8cxSHFyWaQi3sTwljRcead?=
 =?us-ascii?Q?TGyUYJK9lK4NZL07HmeWO3F6oQCROMaxJL7QDtZh9XRFsCesoyoRci8VLJL5?=
 =?us-ascii?Q?vXYF+3Ni7agYHLi/4vUQhPB7SUNwSd/phaWwzvlbYv/V9f9CxH4bsXQakVjn?=
 =?us-ascii?Q?3jOTGb2GEEi9scMI+z7h1UPJ2xN38TFFE14vYPAURqE4Ebx9Syywa6AZTssQ?=
 =?us-ascii?Q?eVQ20Hc2TczRc/gCOlv4zr8amF223GUn7hk4YiNohhQTkJboarFJBSXimth1?=
 =?us-ascii?Q?sELTH66hSuT7cSTv2xKzYqwDh+7fDkwP9NizV9rasxyKryi45NldYdq+Gr01?=
 =?us-ascii?Q?Lss4RSOAslY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cuMW3J0ZPWlAZUVw8/kLlSkG991Z7qgZ4V9PmBEbYnq4iqd7GZD2aJEYM9XY?=
 =?us-ascii?Q?iicJrwcqXXoH0h1kmTWJ2YW/ezuoqsGxQWPTzYAS26uO5cLGb9uf8eQZhPwp?=
 =?us-ascii?Q?tLgp2ius4g9RjkH07bGbHI7OJPC8TRmN7zFi2HVZHrH1r+f7rJbaO1Cy+Z2n?=
 =?us-ascii?Q?pgF3o9T0saAyYGoN8vfLly8tTq6v0UWTni85+5uRA3qWogQgkd58S+sF5w0h?=
 =?us-ascii?Q?5jGl9hJtLZDhXhmea47Iq7BwW50A2A8aLCDwEVsPL4g+To+O2KeAmLPn/yoM?=
 =?us-ascii?Q?mWGQDmruvHJAq1Yw3gOD84KdsiiR8X8nRIlmFMMRCFWnH1ryrfdcbM4GIAYD?=
 =?us-ascii?Q?7C/wykGiKfG2en6nmxZjul2ENatPBX/cf0BKqcMVkMSqnt6ryBU0g5gxE2pL?=
 =?us-ascii?Q?cDPTVtLQLWbfG7as9lq0Ucc/mSmpFlMeB+vwfJdxMFeynm+QwT+jpKJ8xWKV?=
 =?us-ascii?Q?BBNNtFlU0E97IyIliXu+Dg6bgsqRJxbfIedILjVSTROR2LcDlvVqD3QqdeVe?=
 =?us-ascii?Q?F99kiolM1wYT3/NcFmIvXBA10RhisO6leD4iHFnIinwLnTT45ls6u9P8yLSZ?=
 =?us-ascii?Q?N1+KhF+MUjV4H3LVsG+5DgKduG+lj/iW1j0Dq0SjnwrPm/rBhBDTZ0b9rFGf?=
 =?us-ascii?Q?cv+T3xQpgcTrczoHbRTxNuMjA4ZawqsBpq6QEWrbXeF6EmhVaWBNqbarBuad?=
 =?us-ascii?Q?ZjuqcytYkkmC1LXKvugBD0NDfy/EkKtg9c7BMPx8WoF97oO1CDvjbkb3JT1/?=
 =?us-ascii?Q?Vuaqa7W6OgPvq1vBRZH8i5016yQjE7NAdUwv21ZZxxYmYy+t7kRSmZJvXWgo?=
 =?us-ascii?Q?pHPx5L2/PNRakREs7ffvJKlDqJp2BL8WV95ujOzNjkG9KIRLnNzGfDqb9RAF?=
 =?us-ascii?Q?rAyXcOxc3DOjnRhpLpTNzcBXEtjlcf1PdhAekpmMDrOUq2md7rus0rw1aJcs?=
 =?us-ascii?Q?mPnIhudUyk47ddkN8axXNgYDIs3ML/D/bBIFKPnIPMWBqg0cN33umh0Rcmkm?=
 =?us-ascii?Q?u5VLCO96Rm0Ra0Y5OzKMg6sW+iL7TBUmx2CU0HdwqMm8JiLz8vVzQ7R6poqA?=
 =?us-ascii?Q?C4N+w7MRJqdQ80YkvvRh0DOWU/xznD5s6AecpiselHxaG6n6OPUGm/ngf9+K?=
 =?us-ascii?Q?UXprOMUb+pJDG4/J2C7PclYu4vedDBhweO07+9tDbRYHiEsJhN05Ld6W1sUJ?=
 =?us-ascii?Q?SL4tHiFcOWETXbhMbFuUtjrafYMe3HtYdDNYFlCXrbvwddZN4liihLEChubH?=
 =?us-ascii?Q?Yd8sSVe782iBrPzJtSTRZPMXncTXuEpEOuVjbUv7hsXHrA9vxGlw8JsG8kZ/?=
 =?us-ascii?Q?TqwN6u+9TOHLjnZzImrMLQzH9R6hI5frQ8jPiEcx4hqCjuJfMF6Q7pWEA0Gm?=
 =?us-ascii?Q?Q4/GJOCyVcF0qcrCr4AqWINQ6rG3Y/S70FpEbHdtCg/1r4rI5yT9wYDQjQQN?=
 =?us-ascii?Q?mCqp9n0/HGeYoDA3bcYyut6qZwfUERZqw3o5UYDtQ6qOmO0VXs23J/HNh07I?=
 =?us-ascii?Q?NHCj3aKwv8jPmYICQUoyfuMmEb1HNrpqJsJc7Db+pQ8RWKzaC3/ZecO0LqFd?=
 =?us-ascii?Q?a6NXFIcvqi92b3BplKnqwFBu4u1BnZLxTtPfTY4Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bf86c0-81cf-4e30-4074-08ddeaf23c86
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 14:00:27.8452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evqca6rO1DZo4LPKMuPCY00/tgA8c5M32sa98kLFBKZ7qN1mzj8kJga0Ag8xhZGwQaAIoXOaPjXKe1lV/Y8AGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378

On Wed, Sep 03, 2025 at 12:03:17PM +0200, Borislav Petkov wrote:
> On Mon, Aug 25, 2025 at 05:33:12PM +0000, Yazen Ghannam wrote:
> > Scalable MCA systems have a per-CPU register that gives the APIC LVT
> > offset for the thresholding and deferred error interrupts.
> > 
> > Currently, this register is read once to set up the deferred error
> > interrupt and then read again for each thresholding block. Furthermore,
> > the APIC LVT registers are configured each time, but they only need to
> > be configured once per-CPU.
> > 
> > Move the APIC LVT setup to the early part of CPU init, so that the
> > registers are set up once. Also, this ensures that the kernel is ready
> > to service the interrupts before the individual error sources (each MCA
> > bank) are enabled.
> > 
> > Apply this change only to SMCA systems to avoid breaking any legacy
> > behavior. The deferred error interrupt is technically advertised by the
> > SUCCOR feature. However, this was first made available on SMCA systems.
> > Therefore, only set up the deferred error interrupt on SMCA systems and
> > simplify the code.
> > 
> > Guidance from hardware designers is that the LVT offsets provided from
> > the platform should be used. The kernel should not try to enforce
> > specific values. However, the kernel should check that an LVT offset is
> > not reused for multiple sources.
> > 
> > Therefore, remove the extra checking and value enforcement from the MCE
> > code. The "reuse/conflict" case is already handled in
> > setup_APIC_eilvt().
> > 
> > Tested-by: Tony Luck <tony.luck@intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Some touchups ontop:
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index c05d9c6f07d1..5722806ccaa5 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -54,8 +54,10 @@ static bool thresholding_irq_en;
>  struct mce_amd_cpu_data {
>  	mce_banks_t     thr_intr_banks;
>  	mce_banks_t     dfr_intr_banks;
> -	bool		thr_intr_en;
> -	bool		dfr_intr_en;
> +
> +	u32		thr_intr_en: 1,
> +			dfr_intr_en: 1,
> +			__resv: 30;
>  };

Thanks, I'll include these.

But any reason to use u32? Why not u8? Alignment or something?

The u32 is double the two bools that it replaces.

Thanks,
Yazen

