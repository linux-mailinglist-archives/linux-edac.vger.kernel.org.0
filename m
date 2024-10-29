Return-Path: <linux-edac+bounces-2336-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4569B552E
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 22:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFC21C22973
	for <lists+linux-edac@lfdr.de>; Tue, 29 Oct 2024 21:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0BE207A0B;
	Tue, 29 Oct 2024 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vTJuYJ8q"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0090B1E1A2D;
	Tue, 29 Oct 2024 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730237975; cv=fail; b=Gvz/wGZeuGQQ3ZE0TLtalOguR22uv5yT6ehqAcnc7T01sOJc7lZvSX9VxgLy9Un4X5CysPKpAlmjfa/PlfmU9RUihO1B1Q6z135P/Z/AEkHnN3csmnLBBdL1N8deJmk/AVOIAHi0NYJlfFOIHB6PCLUJwOMp2WJuHcrubOiQtx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730237975; c=relaxed/simple;
	bh=P6QKilwq3VXbkAmKBjNa6SeoVWjfZrW+7xKLqd9RWus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W+uJncfVArkujWMp49cnpi9P9G8kk3895iP94gKta89kf5qk/dxulnFMMAZ8PXgfoFPc+M4BRASwtnonH8DrjEThQdJgvoTOPJjBEUzUImiQFaIUZmjDfDMX2WYo4OH5dZKBmB97LHKJn3gSrYGt6XtuKCDpozCajNvRx7zoZes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vTJuYJ8q; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvkKfRpSPZoNX/1JmqzWIJlyTT3xmWYwqpeuETmTkM1J8ZiyabaB6XpVd/QIDg0p39S3fnBrfODKwZRZB9MpOBdSvjR+WjAa7jm0wPUrRpHfgPE1LRw+Zh6CK+az33Ki/AYt1GAjfllg+gMCyX2MAND01uSGVukPzD6hqLnlOkLCdx+081x1S9i4omRVa0L2d9uhpZaKT3CjKa111pPja3JndC52uAUdW5FsHiWFuuNR/ImmiE0n1CQxZ8jmMmL0EzpfTuqhitaPNSMeDEB2WpBp1qR/7GkI9A5E0QZFIZdIZGvRrmnFIpgr12yahT5MprQ3RkyuZFigwJg/4RoSfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq3V4NaardOwRAxOGNYtZrfpOdDzO+/P8H9FQGc9I6I=;
 b=izxxWwQFOCKFv5jSW5a6EV4rSeTd+MEmJkqQ/fgy4Do09ceu/tQkI1nbwrS8UY9OGRiIuUvm4/GyJ2vA352dJVexBPZLKoSm8lp5Z9zNEjw22SBi7oGRHLMz8Frj09x+oxFABDHkNxOfSn6Dz/W+w75wh2muHy1UWw9BknOBXhy/PUpEVz4RZD4szaolD2CgLaYQi6zjN8HZcZFRMS/0YYig9LrWRT2X5GFbnXx9/Tb6TLlOk8vVKEjZJrft+3z1P2/nraCu0pRWtvb9YVjRUGxpYznIEQcRIZBwTQZ596yW4WdZkjsBxLYN+i+q7IeR4Y9PhdMl1IkuV8emUvWgEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq3V4NaardOwRAxOGNYtZrfpOdDzO+/P8H9FQGc9I6I=;
 b=vTJuYJ8qc33fyY5nYGZwzQb/DKp10XtBUW5ZHFj1oe66nTiCCFau+FPgI/Bd9WG8pfEtPqveqO2u/kllPqpVcJVkbJqll8KXsWtIqz+UUzkp2o9bNN1qS5zVCIwGDGjdiealvgOJx9L/qPH5Y9EMdz6dSIpr774frSazGpp84VU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.24; Tue, 29 Oct 2024 21:39:30 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8093.023; Tue, 29 Oct 2024
 21:39:29 +0000
Date: Tue, 29 Oct 2024 17:39:20 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: bp@alien8.de, tony.luck@intel.com, tglx@linutronix.de,
	dave.hansen@linux.intel.com, mingo@redhat.com, hpa@zytor.com,
	x86@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/10] x86/mce: Break up __mcheck_cpu_apply_quirks()
Message-ID: <20241029213920.GB1229628@yaz-khff2.amd.com>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-7-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025024602.24318-7-qiuxu.zhuo@intel.com>
X-ClientProxiedBy: LV3P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::18) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: ad9755b2-6b20-4e71-8c99-08dcf8622b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0XXTksYZv3Ozn25CoEXCbvifMSfaMLc/Q29wjWjvin4XoubmvSt+paSKTxCL?=
 =?us-ascii?Q?T8qrCYB0ezq1jQKRiHXY9zkMVbKRQV4YDs2YiEPaOlEFlu3E/Qg7x9/quRRf?=
 =?us-ascii?Q?PGZpcy6XLn6s/bjAl4Y0vhU5eZWpavlJGjrbnsA2FjD+JK4W3kY54nvwH/K/?=
 =?us-ascii?Q?X9ydicQ+tUATyjV5us+CSBj2x6eAoawwKo8edjY6twORhiXbzAV2mareGy0b?=
 =?us-ascii?Q?3lMnVtVX2nLT3J8WsQn7zFi0skZGCMTGCgfDNrMh1SUbzkA7sNQPfrMi74No?=
 =?us-ascii?Q?DtU7L4m0Yft3TZo8kae6kY+wjE6Ea4k3aSQ/LQHhyS38kgdrFgrFtIr929LB?=
 =?us-ascii?Q?OSsOT+TetWtJTdLm0wB+XDCXXnavYwjh8MNU6tdon6K+5xQA7vytHajH9miR?=
 =?us-ascii?Q?i8s2H4YVAP683MAKkMXvcR/OPUyvo8qo0Kltjdmhkj876uo1zuO4ZIgVmXGW?=
 =?us-ascii?Q?xunfBFLqtEmfjYuPHvCxkyQgHRjgA3UdmiE1YxuKWQB3XbKTnPR5suOata0a?=
 =?us-ascii?Q?OiyZaWQdnJXiPkajivwiuuzJu4BGST+XU8sml+vOHdc7KiGKdjxgV4elmlGN?=
 =?us-ascii?Q?XBe2v3TvOumg32UX8C2M4lt46dzUI3EyrciNNhriksi8/2x30YNXQR4H0944?=
 =?us-ascii?Q?NBU+d0Q+CcLRqNZe/kWuu7hliUxPITIQFKO3BdV6I82y5Nz6UwjCKlqZ8nkd?=
 =?us-ascii?Q?1yKkxpnvFH3B/UL3B4uW+jdpmWvqEay7muVJHKIX0C8/xVZO23NRz5Pcr0R6?=
 =?us-ascii?Q?d0r92zPz/7hMBwx9IrGrOzux0L7+urRxL+/gNqGclgwsGrNoNiY09bIphskt?=
 =?us-ascii?Q?2U6Tu6bQkE+3l6Uu7IDt6NLKo2mG2hW83Lh1LaXVKWDmyO80deu0nfHW7h0J?=
 =?us-ascii?Q?NhSOoo4q2FoeaBdydJApE0+KPKdaQx1TAAw31TPUIWZ7IcP+cwpmv9fBWQpp?=
 =?us-ascii?Q?A0X34HEYJHHyg6fMvoyuVdwkg7Ear9HJ/xkmmDwaWmH/VOdtxxFG0QI1jVbk?=
 =?us-ascii?Q?DpiXJTwO/LnEDhg28rxXUrcZhbT/uRa6iAxHd5/EzCghnCxirNy6/DgyuhQ1?=
 =?us-ascii?Q?UDaObQd+gdc5jdhY8QtcP+4yFC6vWU/wYkLSf5wSZvk5k+Ru6bMMLQG7qmu4?=
 =?us-ascii?Q?/8MLA6WJikWyT2P8Az2CKiUVtjrw8mf10GlVwQpgA/Go+9fDl9z3GzFwTMod?=
 =?us-ascii?Q?fO8cWxeSdHyYEVeKRXrE6m7xdT+60mrMmcq964p3bXHfKTa00vLLErnR5jVg?=
 =?us-ascii?Q?aIxDykOfACU86/YOwaxk0ElCv2V6QoKAEZyRc49mqemL+o5vVDGKPcedTX+a?=
 =?us-ascii?Q?/tUKJ9j1oYtMMSmSX7aeGqiC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ODH7gx6H4LpBfO3zE+xQ80glTSrFxES8IfXjNBhgFSIsinc4boZaQac+1aQ/?=
 =?us-ascii?Q?Ea4ljPuYdsn/CvrIu/gzoXwR3EFhV0FzQYLObGM20yaOLXMzbAkpjCg1/qDQ?=
 =?us-ascii?Q?hPtW+Vks51YClVq9+9jsshAZ/C5jIme1lbBmtoIwkUIpB6PjctEJRkzPb4gc?=
 =?us-ascii?Q?CSqtiOT5uqN4N8NBPA/trQ1e81k1NfU5UJBvnG8E1jst7tBJLdEmDCBNtaaD?=
 =?us-ascii?Q?YYysANlYqCziDBP36FXhp2KUyJ2z+wEBGt7LzkwwFPO8yD/09Ut9RT8pXsJy?=
 =?us-ascii?Q?Klq/eaWGhjwl1pypSsy8ugStiTaPn9vCU3/d7ZcUEexfLrpmPHDJIGb2SI22?=
 =?us-ascii?Q?S4TXgtnm20GZrfgGx1PRW90Eb7yEhS7rPdjXG15Yf+lY84IBu8VswACA00cQ?=
 =?us-ascii?Q?oS7dvws1P0vjqkwkjfaSuhfVSHnBvnehAIFKKfrQrAr6ly3FqwIRaSPVMfsH?=
 =?us-ascii?Q?uo0+GvRYQpJ6dwZ18XTPfqUUpLVPOcAmtc1+ixwquHfdeohHV8Sb7tDF7Alz?=
 =?us-ascii?Q?xND5BzLfpefifyS5E8CrsKJ9GyYv/e9k3Cz39XsEBNYg7pj41zME6O32Zo9d?=
 =?us-ascii?Q?e/s5I3vdyiTOLqkJuvQf1aXiuHuKSNltonN2Dxk9dep+6QeLuJmwzLPBixSU?=
 =?us-ascii?Q?HLiqfAY8ybV6MsQOglgwsM0ZZFz550jzICiVDSdWPcPxhSg/vpQQU9WVIS0x?=
 =?us-ascii?Q?LXvjKcjiIDUcyrN9t6wVBAIg4VVZ1+6I169eLfDNr3IAnVWG3XLGzF+p5h6Z?=
 =?us-ascii?Q?1dQ3oYg0VJmmITwnF97meN7sttb8yhEwyTokVAj7DaIZ7NzQRo06OT+xa/TQ?=
 =?us-ascii?Q?+MTtzEQ3AbB6dqDB+hCyqvFIdtcXdNKuqJf6kOhbfNJRAdNmRLZhjIpRwtpa?=
 =?us-ascii?Q?dRTg54+kcjhKpVWC/iRLuCOA/XTZebTFfMi7kzlN/yuoDCR+bCR1nLVqOLjX?=
 =?us-ascii?Q?H8nf1RJvtfSNGDhAUpgB1e9DQCf4cY7Ko0E6qRym/qr5EykYXt67ZGliGudn?=
 =?us-ascii?Q?QFrFdWeedVyA7eaWNUW/PQ9KYIVnhmAMKMRSsC1G0H9bvQsNTvXlxktWAMb/?=
 =?us-ascii?Q?j/BCHOoggOg3TDjW9mU36ZfV/Wzo0lL9zh3OkwNftqHug/hMpPntFrNJjg+m?=
 =?us-ascii?Q?6F+/3pQXjny4O6y2A33zU6pCfEe3615T0EeHHCfNZy+5UerRmKH2sYsK8NiB?=
 =?us-ascii?Q?KuvKKer7nBY57vy629/2yEC+Qib1FsY78d6bgfVjLtO/Kb+Z5d7RDIzPHodK?=
 =?us-ascii?Q?1YIrJpzwYXgSzRGUkoDt3xch1sPBx7b1Gv0aRTIECkqAIf6+tPMcJYF1V42C?=
 =?us-ascii?Q?MEmIDkphS7HRYCDy20ATCQZAkss/2ShAXZuYqWNI8tytsHN1IAYl7ByerjUa?=
 =?us-ascii?Q?PUHc9UNsMCCuh8lo6WeHwfvGalUni95Foe1EXoUfYjndlTt3djLd5s9BwDpY?=
 =?us-ascii?Q?mTcwTTvC3hgVq6ep6ASH1H1YzVx9MUVoTUuDOACFUl/GsXWW48Cn1+sjc+LK?=
 =?us-ascii?Q?f8dgafoaaKPw3h9ZnSew+hmQjEyKbatKNRTRZ33HKVBu6zQz9KyJieRPNwgo?=
 =?us-ascii?Q?vgQ53niMRenkS2Nc11+jOSJ+7WTYTsJOx1D+P3yb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9755b2-6b20-4e71-8c99-08dcf8622b41
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 21:39:29.9182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMQ3GJAFWuKyATFkkyUNFNk3Bg9TPwcmOf5Z6qxHN4+vKNN88pK19LN1Bjl5TBPoX+aDoWJQwDGtRExmybwXxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319

On Fri, Oct 25, 2024 at 10:45:58AM +0800, Qiuxu Zhuo wrote:
> From: Tony Luck <tony.luck@intel.com>
> 
> Split each vendor specific part into its own helper function.
> 
> Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
> Changes in v3:
>   - Newly added.
> 
>  arch/x86/kernel/cpu/mce/core.c | 194 ++++++++++++++++++---------------
>  1 file changed, 106 insertions(+), 88 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 57c05015f984..bb8b1000fa0a 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1880,101 +1880,119 @@ static void __mcheck_cpu_check_banks(void)
>  	}
>  }
>  
> +static void apply_quirks_amd(struct cpuinfo_x86 *c)
> +{
> +	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
> +	struct mca_config *cfg = &mca_cfg;
> +
> +	/* This should be disabled by the BIOS, but isn't always */
> +	if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
> +		/*
> +		 * disable GART TBL walk error reporting, which
> +		 * trips off incorrectly with the IOMMU & 3ware
> +		 * & Cerberus:
> +		 */
> +		clear_bit(10, (unsigned long *)&mce_banks[4].ctl);
> +	}

Newline here please.

> +	if (c->x86 < 0x11 && cfg->bootlog < 0) {
> +		/*
> +		 * Lots of broken BIOS around that don't clear them
> +		 * by default and leave crap in there. Don't log:
> +		 */
> +		cfg->bootlog = 0;
> +	}

And here.

> +	/*
> +	 * Various K7s with broken bank 0 around. Always disable
> +	 * by default.
> +	 */
> +	if (c->x86 == 6 && this_cpu_read(mce_num_banks) > 0)
> +		mce_banks[0].ctl = 0;
> +
> +	/*
> +	 * overflow_recov is supported for F15h Models 00h-0fh
> +	 * even though we don't have a CPUID bit for it.
> +	 */
> +	if (c->x86 == 0x15 && c->x86_model <= 0xf)
> +		mce_flags.overflow_recov = 1;
> +
> +	if (c->x86 >= 0x17 && c->x86 <= 0x1A)
> +		mce_flags.zen_ifu_quirk = 1;
> +}
> +
> +static void apply_quirks_intel(struct cpuinfo_x86 *c)
> +{
> +	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
> +	struct mca_config *cfg = &mca_cfg;

Is there a benefit to this pointer? We use mca_cfg.FIELD in most other
places.

Thanks,
Yazen

