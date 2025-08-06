Return-Path: <linux-edac+bounces-4527-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D235B1C663
	for <lists+linux-edac@lfdr.de>; Wed,  6 Aug 2025 14:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52421188584B
	for <lists+linux-edac@lfdr.de>; Wed,  6 Aug 2025 12:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E907228BAB9;
	Wed,  6 Aug 2025 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0Y9zc5Ux"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351B328BAAE;
	Wed,  6 Aug 2025 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484752; cv=fail; b=eC02KYjssOsrce4wsfajwAkCKEa+isHtcXbUtKJVItuMW95dCttowxkgy9WeMUQl3oZv8WUb303mukkVMGk1U61rKTP7LkAxyczn2jx6IPOL5lrI9yBlmDshA1TP3OeTV+Qs7z3rsnO9TGtl1jYD5p17q54tzwBu+QRpLiq7Q9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484752; c=relaxed/simple;
	bh=qAy6yYFymLoTM8XZEef1NAHG0Svf/nCnIJ/b4Hs3Lfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YQ2t0gycI0RiF2Q+vjkjj3cZxoFhYrHue3LBMsHa3EyiCN+3z1iYol543ifu3gR9qnY+/+efVODwIO+Z7CyDMoF9X38lUECt6w1CRHmcy4YpePWIKzFr/4hEHt1c+xiFR8m3Fc0oSbhilL13ZLn7pEnYnRiV1IIy+60YB8c7mo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0Y9zc5Ux; arc=fail smtp.client-ip=40.107.95.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=en6giHvLGPbPSmfc4zvV3XWNDJJn0LGS4vGQC0NfN45Kd8FUpdQgT0Lmwv9lcKhKOslc2GfUkKGhhQ6ptmPhYOM6BWoyPp5EJBRJak5Yyt18bY0F4sdv59QOAzQgDs+bk+0+Ql/0KrQgHhQjB810f1SlMuCrphYgQkk7XDi24nESDsIzhDN8F2BPgZX8jPNFJsgbc5KLjxcMealTv9B61cFkFkN9osdMPiBLXttDVgdl9zuGAwt5LQsb72/tpqTAKLdtK1CAAQtKe07Em7ZSi+pvjecJk72TdiZINJDru1dPtsP1nc30Cg6IOhYE83Xyq23QYgh2D91BadZJPmQlDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxx03yfy0wRguPuseT9EvFDt+I6Sq0WENEyspsMHtX8=;
 b=eBG5kXNVzamFydEq5I1TnmM4k7jox/vOaN/QuZgejQQ4uB1YWSPlhlMV7aneuSU48ef5GLwqRNbJ5khZkzGmp7CpNJYuI3qUrvxwqczJqfgXiQqUCaUDR1l6/vMBHDkCJkU650lJoM6AF45C1mER50puF4piRyBpYU9fcUJLw4jZK6QFhHw7awtFW79ZbGuqT2zkACBv2WZ1mK3ijkP/ILQs45/07VSGPrM5jUEmL6rp3A25mJbBFIpt6emhgpfTAcOXUxy17eFIIAZbAntXC8YvB04KycPwJEvtK2SP+HCowjw36EaEFD7n37s0R9UPU43XraiOT4m0P8rQvXab9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxx03yfy0wRguPuseT9EvFDt+I6Sq0WENEyspsMHtX8=;
 b=0Y9zc5UxZkX5DAj12Ae1hQ8N+ZRdwGvN3S96xZ/syVsy0IVA5TaTZxVaCGTmoTGWfnrXneN96zzKpyeE/Ci21t8cuABcN5NrYoyIyFugFJAptV4/5NDcZI/yW7z1+06SliQ5ZCwElS5MIQ81ZBU9MTo5JjwwKHGnieVcr+MR3Ug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 BN7PPF0D2C72F0D.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 6 Aug
 2025 12:52:29 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 12:52:28 +0000
Date: Wed, 6 Aug 2025 08:52:20 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: x86@kernel.org, linux-edac@vger.kernel.org, bp@alien8.de,
	tony.luck@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Add support for PHYSADDRV and
 PHYSADDRVALIDSUPPORTED bits
Message-ID: <20250806125220.GA628281@yaz-khff2.amd.com>
References: <20250729204801.1044100-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729204801.1044100-1-avadhut.naik@amd.com>
X-ClientProxiedBy: MN2PR18CA0008.namprd18.prod.outlook.com
 (2603:10b6:208:23c::13) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|BN7PPF0D2C72F0D:EE_
X-MS-Office365-Filtering-Correlation-Id: 372b3fb2-ec2c-4456-7a43-08ddd4e819ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DUPg+GbIbGfUbM6JobWLrIrLuSCBTD1csfON5Mlk4p0MBYJP5SPbPI2bc2EE?=
 =?us-ascii?Q?L9byQLX2yApmckwCc14Nkx6RzQec/H6fmRrX+ItHj9FasMJ+sEMe6vR3Zftv?=
 =?us-ascii?Q?GXFTLeYYttnzjEnjDG+2S4uYQPci8hIOP1M7PvyIPwn0LIiuG7QrY2Yif26v?=
 =?us-ascii?Q?itHx7TZXsPtQoveETRi+swA9iUNFS8J6sLxpZHKzCbnN4AU4KgsQ43JR40Tv?=
 =?us-ascii?Q?TxnTZJOJpfjhIzvVkY1MtMnHF5yJm4WY5b/bsEnOtdeAtWMJKQfXFOUMzPVJ?=
 =?us-ascii?Q?RlF4a1hDJDSQ8BfHfkuBMBmBDrHbqXB6KAeDrHDpoZj0RRYZJ/TGe6XfG0iZ?=
 =?us-ascii?Q?woxedx3Tizk5fBwvfijHEwKH4+TIDArVVgC+B3uDF2lG9/Mz/15nRlPOjwR2?=
 =?us-ascii?Q?FzUSsabVMPXcvP44Gta2SFa60dLPy6f74fFbWnXItJRKr5oambqfkdq9XWuk?=
 =?us-ascii?Q?hTnl8Fi+YP8z0koW+43vwdlYzmjWpziO2ZhfQoijoR37LHF8pDnbv4g4wWvE?=
 =?us-ascii?Q?M/4bVYStQ/JKOtpjjInkRSnPdfHA6HQTHQAbfv3lhsW21wexeCYd/prQIWIG?=
 =?us-ascii?Q?Cw5fFsPPS9kLbeKqq6jqcDbQZ9BGRE02fGSIqq6K3lVVTqqShIQx3MTb48E0?=
 =?us-ascii?Q?a/caQ2QCnbJc0o8pj9sij7vFa3u36d/ZZ6t2uL0MR1L302uwmHFRc2m867ff?=
 =?us-ascii?Q?LiNbbp2UvXT5SWqYGLLdsHJ+63RvTIvyDfSEbj3jcxLuMYZo4mn1b7soYB++?=
 =?us-ascii?Q?5N4IiDNxV2ba/P2wJDAKnCVnIrO5fA4hUQY41udqhonfOxtU9vBIJJ4ycR21?=
 =?us-ascii?Q?2Z4brIJ2gfzLwsDnwISLCu3HoFj1WEYjYvPLwtg6O39fjEj3dJ5nsBPAabwZ?=
 =?us-ascii?Q?UGj5HVU/niJGWTBRH4ao89ZUUBU1PfmZEHOSuxy3jedc3hDPMWBETkz6270H?=
 =?us-ascii?Q?5sdNyS+918804TSihqKp6QU/FK5MFQFuk/SF4KFccZpa+YD4CR9g7OKAtAPO?=
 =?us-ascii?Q?Jp3bUM7qe6orkcDBFSDbUeTigrcONR97zeyDG8gsowE/OgpbSxauUJi53nVQ?=
 =?us-ascii?Q?qaw1WijF+cFafjCF/b74er4Nklrhl6VNpPeuyhkt0LBGBXEQw0AZtFoTdA3O?=
 =?us-ascii?Q?PEbwlo555f+liCpyDr2ye4iYU2J0j5F18SenEpfNy0v+iNcccxtbAoWD2Ubz?=
 =?us-ascii?Q?K73sOvfvIaiQ/9J7gRw5EQKpwIe20K/nY5eLGaYw2XVJ5BIdDHABLdvsnwG+?=
 =?us-ascii?Q?7BfgKFOQIIZLwHDx+xxSgbZ3Q9CbXgVmu44Yfmo+kGC3MGIGMJ1OEIzG0MSv?=
 =?us-ascii?Q?FHGcrLN9IuifC/8Np1gbdFiYezEyI8MCq9bltdZBOdki2RAek0DmQrbo103B?=
 =?us-ascii?Q?NyNvp7t3+HhmeuoEASM6BtapqJxOw7e2xXvVfllEznjh2Bb3AvdW+efY7HA8?=
 =?us-ascii?Q?voTP9vCMiNM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g7ZppcEd+fUxOTsEFOP+4aJXbIr694s4zk6QPsPcnj2hiV8+cVvSCnQgmsfe?=
 =?us-ascii?Q?Esjp5ylZVzhPrLYTqpCYTSUbIM73kHX5Fif0NlpmkcM3gAO6u4edyuh5DiGD?=
 =?us-ascii?Q?UgB4u05kZJCREVgx/YKDYTw1+z046/fnJjY5+Iqud5X/kAzvYnUtxrCvzW5j?=
 =?us-ascii?Q?B2YMzpydhoSSW9PYy6dvtqWlR/RNeAp+BiEaLOwJPXDELBA8g1F3tE+bld0w?=
 =?us-ascii?Q?X7fq113OSPWWLKZUHNfPkBp1m2WMNkPU1i+PwIeIpiPHLLIOtcQcE8qfS0xg?=
 =?us-ascii?Q?EvHlGippaTqRWku1DHRyKxe3waNzWfrENPgt6p8B5JbbBbt4yHOFAn8dJVZ2?=
 =?us-ascii?Q?+wZGtfkiNSgnln0m4mT17fXwIKYzEVdYw9/zIhse/Hp/kYKvrTsojyZ5ZDlP?=
 =?us-ascii?Q?ZzuRsyqQWtD66WSYskLzSfBNMQ+hygRKHNOgv5fTcwucFI1nc0WdVXNIVqWz?=
 =?us-ascii?Q?sWRh4hVIZKH36ClfNszKA5lXZH0UrbwHWc8W3xJD4jfKdvlOoGbj+w38KrYh?=
 =?us-ascii?Q?Lm7KFfyV0+t4dKdQ5YSLZ4e/okBizu6XokigJ17j5cLjZcBC5sRjZdXn6tTc?=
 =?us-ascii?Q?qIgNiFESqJsOdMgv+Q6tPJNqnmPJCPr3JnRJDKWTxal+2JT3hZNNvLcg4F3P?=
 =?us-ascii?Q?+FIH5EO8tocillXAFcgvIJ6OBU0RC2QvzblnWexc9fAfUKFymBHeSFf5SR8f?=
 =?us-ascii?Q?8J4c4YZNl7UT9yYqaEZEMr+k28sBQxFbh04Adt/T3DF51Cig63gG91RR+R6+?=
 =?us-ascii?Q?0p1rIolJvCA21n4QuezmCFuUuCGCwk3fsGnoBqntOF71U3yKw80HdYAUX9Qy?=
 =?us-ascii?Q?OiEVWMvZND7U/wMxrKyw4khhpW+5IrTBffvnBZ+yDsgV/t9kW0SfNcVwJ3By?=
 =?us-ascii?Q?Njb5agmxDUsGwotpevf4uNM/1AUefiWH0mZo2PW/bgkFy00QgnjLbjFjctXR?=
 =?us-ascii?Q?wOzUJezsWZpJO5eER+WJtqsryo8Ls9Yh3g3iY+hrQpCqGDxBpxuhjZ9zk2DW?=
 =?us-ascii?Q?K8cmrQVcCp/9GltzOmHpRaX3bwcril6xuQ52J8WW+Q2w6aDMh+sngxdsIvnc?=
 =?us-ascii?Q?Ofz9b0W4j5LwLKzi0lbCSvN94JJYbGaVq58zCrH+FheGUfHWzsYSlj9iZ5AJ?=
 =?us-ascii?Q?A0yGuqx+vaJKBy3tVzag5qeAD2PAZMqqSJuKneAvUoFSgtQ9BgHvnEJRekEs?=
 =?us-ascii?Q?fyO1k4M/30M+RHBWDBfgxRn+XJPm/tLKyJ+U0/MjlDkrac5FC0eXLl4E3jHH?=
 =?us-ascii?Q?k8m/h+ZYgRfcNE43x1mpWzrWhVfujY0iUViQJBNfBvD6ydrDCTkCTunx8HL5?=
 =?us-ascii?Q?GxMcPp12u7g0PsSdSuCZMfeA0ODSb0bcumXCnZaB+bzKLV3erfIVCshWgByW?=
 =?us-ascii?Q?vg0L0RC8jeEc5ytSAnFzdQVhgJ7lqa8RLz6K22/tG6MXAkWG/XrVMDdUxUx8?=
 =?us-ascii?Q?TMVkkcVN4DBeuKL5hO+tR3xTsARheHeICUKIUP6mrGB2recZ+sXEDLMH+9AL?=
 =?us-ascii?Q?SgQfJmdBljnkpQhDejdChE3FCLjwx2WvRPpY7Kz2BNNCMN0a1Y7CiPT9/JED?=
 =?us-ascii?Q?cBbfy5ONdhmNRVtAWXc/DJGnuuS54+cj7hKhmGGD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372b3fb2-ec2c-4456-7a43-08ddd4e819ae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 12:52:28.8378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJfZXk5J8YLj+kBlTwB6e8Fx+vXwCstlya+4X0bCHzZcTeK0anQkfCiniPz3Ih3lQplb/tsEDf54REw2qpO8JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D2C72F0D

On Tue, Jul 29, 2025 at 08:46:57PM +0000, Avadhut Naik wrote:
> Starting with Zen6, AMD's Scalable MCA systems will incorporate two new
> bits in MCA_STATUS and MCA_CONFIG MSRs. These bits will indicate if a
> valid System Physical Address (SPA) is present in MCA_ADDR.
> 
> PhysAddrValidSupported bit (MCA_CONFIG[11]) serves as the architectural
> indicator and states if PhysAddrV bit (MCA_STATUS[54]) is Reserved or
> if it indicates validity of SPA in MCA_ADDR.
> 
> PhysAddrV bit (MCA_STATUS[54]) advertises if MCA_ADDR contains valid
> SPA or if it is implementation specific.

The commit message is missing an imperative statement. You can describe
how and why these bits are helpful.

For example: "Use and prefer MCA_STATUS[PhysAddrV] when checking for a
usable address." or something like this.

> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
>  arch/x86/include/asm/mce.h    |  2 ++
>  arch/x86/kernel/cpu/mce/amd.c | 16 +++++++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 6c77c03139f7..387cf250525f 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -48,6 +48,7 @@
>  
>  /* AMD-specific bits */
>  #define MCI_STATUS_TCC		BIT_ULL(55)  /* Task context corrupt */
> +#define MCI_STATUS_PADDRVAL	BIT_ULL(54)  /* Valid System Physical Address */
>  #define MCI_STATUS_SYNDV	BIT_ULL(53)  /* synd reg. valid */
>  #define MCI_STATUS_DEFERRED	BIT_ULL(44)  /* uncorrected error, deferred exception */
>  #define MCI_STATUS_POISON	BIT_ULL(43)  /* access poisonous data */
> @@ -62,6 +63,7 @@
>   */
>  #define MCI_CONFIG_MCAX		0x1
>  #define MCI_CONFIG_FRUTEXT	BIT_ULL(9)
> +#define MCI_CONFIG_PAVALID	BIT_ULL(11)
>  #define MCI_IPID_MCATYPE	0xFFFF0000
>  #define MCI_IPID_HWID		0xFFF
>  
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 5c4eb28c3ac9..6ac222aec28d 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -748,9 +748,9 @@ bool amd_mce_is_memory_error(struct mce *m)
>  }
>  
>  /*
> - * AMD systems do not have an explicit indicator that the value in MCA_ADDR is
> - * a system physical address. Therefore, individual cases need to be detected.
> - * Future cases and checks will be added as needed.
> + * Some AMD systems have an explicit indicator that the value in MCA_ADDR is a
> + * system physical address. Individual cases though, need to be detected for
> + * other systems. Future cases will be added as needed.
>   *
>   * 1) General case
>   *	a) Assume address is not usable.
> @@ -764,11 +764,21 @@ bool amd_mce_is_memory_error(struct mce *m)
>   *	a) Reported in legacy bank 4 with extended error code (XEC) 8.
>   *	b) MCA_STATUS[43] is *not* defined as poison in legacy bank 4. Therefore,
>   *	   this bit should not be checked.
> + * 4) MCI_STATUS_PADDRVAL is set
> + *	a)Will provide a valid system physical address.

Space after "a)".

>   *
>   * NOTE: SMCA UMC memory errors fall into case #1.
>   */
>  bool amd_mce_usable_address(struct mce *m)
>  {
> +	u64 smca_config;
> +
> +	rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(m->bank), smca_config);

Newline here.

> +	if (smca_config & MCI_CONFIG_PAVALID) {
> +		if(m->status & MCI_STATUS_PADDRVAL)
> +			return true;
> +		return false;
> +	}

Newline here.

Also, the entire hunk above should go after the !SMCA case below and
before the other SMCA cases.

Furthermore, the hunk can be simplified to this:

	if (smca_config & MCI_CONFIG_PAVALID)
		return m->status & MCI_STATUS_PADDRVAL;

Also also, the bit names are uncannily similar. I think they should be
the same (except for the prefix) or clearly different.

MCI_CONFIG_PADDRV/MCI_STATUS_PADDRV

MCI_CONFIG_PHYS_ADDRV_SUPP/MCI_STATUS_PADDRVAL

>  	/* Check special northbridge case 3) first. */
>  	if (!mce_flags.smca) {
>  		if (legacy_mce_is_memory_error(m))
> 
> base-commit: d69139008b6dcd9c18483e956f61d187b0c214a2
> -- 

We should revisit saving MCA_CONFIG during logging. We end up reading it
multiple times during error processing.

I realize this came up before in a previous patch set. IIRC, the point
of contention was exposing MCA_CONFIG to userspace. We don't necessarily
have to do that. We can just use it in the kernel data structures.

Thanks,
Yazen

