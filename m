Return-Path: <linux-edac+bounces-2511-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D79A9C5B69
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 16:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C80283105
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2024 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C352B2003AE;
	Tue, 12 Nov 2024 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Prcy86ch"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C012003A0;
	Tue, 12 Nov 2024 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423870; cv=fail; b=nQPZyE6AymJ/mYjLn3Lcgl8/CD/rekKmcRXY/0X1egj4ETdPxvExopxjhdvzssxa0nZY2IGylA/LmRsEO1zFRJpPSeXdbL5TMrA82vmZD/9dTnjO+GM1XEWqBLN2a+3sZ5znjvVjzP201CRs48JQatxr/FsW3RjWrinjBBAY2GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423870; c=relaxed/simple;
	bh=BsMKr4DL4cL5kiDouYXMGFyCYuSKjKlVv2s8e6ncudM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rc0aI9YOXIx1THIj1KrcAHL0vbp7mPB15pCuxkvsUM4Ao4gz2hn45ZwmNn2JGUbnjAKrIKVmcxnzysaLqd6d+9ROBdAsOARYAf/qpycnl96y2zvtSHiDvwimjkAxbazRXOjLr58zZ9gI4IqK6WC1U/IMYWwBhQJdNshF+6KP9GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Prcy86ch; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eg+iKhHIvKzbJOztqmVlcnboxPTB0oxP7ctaJ2DaS+n0a6+TCwAxhqXp7y65YR/F0kpvksaFRg+XJijBqknVy6pF3VCDWDoSKW3qL6xgn7uvn+jg9K3KtZsuPLGqsrVAmW3/Fa+EVwenGvs5rKWK9K96fBQvWSdSZEHQT1gMrzjxwCZ4VwOnOkMid0c387dTdwSt9Svd6DmtBfAuOaAgjGVndHEd+AlDtylIQOnZ6q0qqvSs1mL6CzqO5SxRefwms5cLxSjUx3SvSb3A5w2BMfSwKMgM4/zf2R/WdDFacYFE5ly/DAxU8D/c+04V9g+aovRRp5zfM7SZv8E2xesNYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+pM4Ep7AagaMP8okgEq1KYvWthe6AaDuyPq3+liBCU=;
 b=Xch8FzDT4M8JjS3gZanWmlXUkm4f/N9WKs9R3A81Uj/ewMBfhlkCqiHRyhRrbv3ID3KxRHBdsjrvsF5ojjsCstKi/9Rvb8yvh1jA8hm0A+Rcogs+u4vOjkAiUl5cpLD5flVHfjV/51DbHJWO9pQtLsYRDZ3QfgwMZpWCH1nlvpAx++T4xzfAejY0ibA72gqU/faEdIEagXl9+1vnD8jSUeZpuzoudSUC2PmOCAtphBQmGB9bQ6QO2DjGnQ+51MT8/M+GPzTjY7CjFFXhWp+YU5+LuA2g94jTgkhW7vWgUZqmm+5lfkpwwy88Ty31cxzny5PkcLNeqToaHoMDrw6LbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+pM4Ep7AagaMP8okgEq1KYvWthe6AaDuyPq3+liBCU=;
 b=Prcy86chwhL5+yfxUrZFfT/DmYnjxcoC25nfAlRNd3CApmAXlBtboY6kikH4/Ur1/ggvCWMwAJtBXCStS96MIXq6Q0kuivppvWwKb0SYmvYE4LGfde8mVEP3Ghq/GX7mQmod4GiBjI8ID788VcFoppDAdfiTo9+uXt45Z/AIUMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.28; Tue, 12 Nov 2024 15:04:23 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 15:04:23 +0000
Date: Tue, 12 Nov 2024 10:04:19 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] RAS/AMD/ATL: Fix unintended sign extension issue from
 coverity
Message-ID: <20241112150419.GA3017802@yaz-khff2.amd.com>
References: <20241108-coverity1593397signextension-v2-1-4acdf3968d2d@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108-coverity1593397signextension-v2-1-4acdf3968d2d@gmail.com>
X-ClientProxiedBy: BN9P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::18) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: d81a712c-3762-481b-cf19-08dd032b4ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Y53cxxFqrvLfrVewRyKM2+7Njchc/JDaHnBIr7iJ81lp7XVcmrF92axdowm?=
 =?us-ascii?Q?cTC8NVVvldl5dWJeyPMAqhJV6o2lVvkGsz6emGqCL8SJVdIg5J9ZO29s81Fk?=
 =?us-ascii?Q?S163mTtcM+gavn0B5ItTSHsuq1GxU7TgVUdUwLfVrZUOkgb4Gy0XXch976I9?=
 =?us-ascii?Q?K6wbBK7EImBIVvjF8H2ZV35T+bmfkOWV4Z1TGyIM9hmgSln7mGdU8w+gFxYr?=
 =?us-ascii?Q?LfaU70hCRx2+xg+VKz4idgGjPqwkkdr7Jm80ZuKEDJlO5EsYS+xbYU4HY1jc?=
 =?us-ascii?Q?AO2aHFHsuPLdohmSviWgdhc9Zj7Xg6kggI+VGf7EJFDpaa0/GzPiAKVHrXXn?=
 =?us-ascii?Q?k2fo/GFdPkN+JB5E3s/2aK+82qXXb48DycIyTyvLfEY/wxQeunbqULzC5HJg?=
 =?us-ascii?Q?07ZFx1YEy3J7q394R/5NQgpopC8Z8cQAIfsNxm7hFAsAB5aKfI8tIJZzDrHh?=
 =?us-ascii?Q?aNstsLNiP+hQIrAHgiEjtai207nsKvjDdq/nPUWMYdYvndoizW7+zcJMjXIx?=
 =?us-ascii?Q?89NRsVPxBShlrTdXpOurtVOuXqEeFBX6+bogZ2byWdr4gJyyBKi6UxlvNWq/?=
 =?us-ascii?Q?EZxofPa2PkPqCBg6VCEohkvmuW/73PiDVo677/DhyZCF71Rvh97d9+2iiuzx?=
 =?us-ascii?Q?Emo7KjRg0XluswCddP8co3ulHmBtFlBfCzjdtBokwcZ1Kdpl54jYKf3kzb8w?=
 =?us-ascii?Q?ihcckdZT/N2LWq1aklQ3qDS3T5pHjdmye89sNfv4iiHJ/NZdFuhPdu/KYuy3?=
 =?us-ascii?Q?xKZqog4Zmxb7WRh5RuHYlEsQ+v+CJisGj3hyYZQ0WAo7MVozzj83Eo229JvD?=
 =?us-ascii?Q?GlLe+/KAe60jTkx2O33RJe2RRXGTejKykI70OSdo4JjmybjWl+U+C0APBycB?=
 =?us-ascii?Q?NlOXkZyFvna8jn0FTITTJIvUpxvUevAA07HOAA3gfAoWLUvjspeqYeXiKv3Q?=
 =?us-ascii?Q?t1M0mZePrGHKAucY9RAn/bm7WkqW4r1o96IHEp7U8kc/8jya5JzwSSXiiIja?=
 =?us-ascii?Q?pyFjnbcwPNZIyx++zSqahScsSQCmA5TV12/fOcDXc1zE/xG6r9t+WPwOFasY?=
 =?us-ascii?Q?K1UKPFlChxDEWlXT9sEwTVQVmBaWohbLeVKgiabhyZhv0oEOWEWglsJRtyBe?=
 =?us-ascii?Q?ZoDZnXeI3XPE/sa30nXSdPDbHx65Rlb2tCKeEaa7nnsi6CkjQcbZ6Whs0plH?=
 =?us-ascii?Q?/2rtsEzzD9K536tZV1kd8wqExY2T7DBwXTZMmjFbTlEfUTzKeSMEwfeoofIP?=
 =?us-ascii?Q?uqenZ0PEUoTcGIi94oOs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+aUHrQxAuPuMFUIPmGo3WTeqvjOl9ZVOyBym6sUzXd8Mg6Bz8KPy5iXSIELa?=
 =?us-ascii?Q?+m2pIohwfRv+TwAqyUUFGd7f7bobOBH/X8VARkjVHPO2aCc4eg1LcBzXhvlz?=
 =?us-ascii?Q?V4r+PW9s8vnVPn0p2w+Qz85SDxFEdF62156NLA2y46VD3S/FNYLhhMudc03O?=
 =?us-ascii?Q?EJDFo3ACEmP0WVwp1H1vmqTKOlx7T6s2kSrKlhLSYROsiJDX0hjVuLuJe7Nv?=
 =?us-ascii?Q?geEkPo5wdBDBR0zvuR1g5VWkYl4RN4/G8VVsJgXHjo55+/hQZTC6Y0iz5X+5?=
 =?us-ascii?Q?d+jtUQBB4IQ5ZAE5WIDb6jXlsS7RpW4k8uPB8FX6fp4cXikig0fGtllCeGtC?=
 =?us-ascii?Q?/G+n3bycZc6aWvC2xjStN6g3rZVEeR+7E8satcM6x2nUq/Ivop4fxpHvPBjJ?=
 =?us-ascii?Q?nq/U6cDQfxyg3RsExvhk15hsJVNhPUhOGzFEYdLGrbmgP4MFBJlt4tufHex0?=
 =?us-ascii?Q?A///qr3l8j8/cGyaO4AsmkSU8i9I8LZodPqhX7QKbemAhBf61dvojLJvS/bW?=
 =?us-ascii?Q?+BOCMf+EpyIeDUt4O5jRePIp5sEUskisxxRGqic0I9m040xhruyvrH2o46IX?=
 =?us-ascii?Q?Pd/0qEAT5NoQt5DfD2cx/HlWrBYWOTSfiiqXRb9czZIGKzEyVT870TPIhhKE?=
 =?us-ascii?Q?eqLd/uaDXkvTMGa/PxpwSbWqmRnzTXVLQ8Wuu1mQoLLjacQIZFD73XUrDChT?=
 =?us-ascii?Q?I/OVTiCHGw1TTWwd6PXO2kh/+SSt9MK/nlnuNtxoO1HPJQRly9Oy4B3K7m1K?=
 =?us-ascii?Q?+u/PcGoMpuPoPxUyEhoAnmTPHTacacVSomNyNyyu+gJ7EMkpVLVl5kT3whmq?=
 =?us-ascii?Q?AMZBzw+mZ5Jix4US/KMVVTm6RNbarFmsUktRUUpe5lSJsv7xw24QcFQfyM/P?=
 =?us-ascii?Q?XLdbqOVXCXGnJi+R+RCscJ2JMMbaoPtUT4899GmjBrsw8T/1ZZnakjCNL433?=
 =?us-ascii?Q?EbYep28bwFJeYcVh2jkPDYVREWuhuIW2jQaKrlYWu4PJyMox0uBgx3lKXROb?=
 =?us-ascii?Q?JzSaY7WEzqraj/1JML4Lvtb730qIkyrcA7zXZ9tfgqIspWquAN66xmwMx9IW?=
 =?us-ascii?Q?pDqwyWOlTRsJFtyntS2hCi4BQNu699Lwd3nWGQ2z5xXhGU3lBomn8a+SUgBT?=
 =?us-ascii?Q?z5c6luZpEFSZumd5ihIh5cbqxvqiuxK4i+ilYRXxvLpJUKTn6sFEpyFNictt?=
 =?us-ascii?Q?JnUVyCvTpdZV778wN1Jt4i8NBNvfA0aCG/AAYmhBFbDuUq8qQJJEmI415U7W?=
 =?us-ascii?Q?mmNn7YlQSZqcvIc4PpNTllgGBX6YHUNOSH/YF6IMa64fHMdhlvLOiQ0++E5Z?=
 =?us-ascii?Q?tWwY4PwvZ33OjpHTfl8a7mFmNOCwa9PPlB22XWBWvV/5XaMQ4LmnpgZjQUiJ?=
 =?us-ascii?Q?Lnub2ZVUcay+SVqFP/OML8BY+aZ0d4NPz8VKu7e95RifVAG56rESoCI8cBWe?=
 =?us-ascii?Q?kNpLJW2ReBNXr/eKWbYUjxRirNKmXRahedQ8D9da0mBchvJMdFz7pGeve/+t?=
 =?us-ascii?Q?JDWFQrCTLHlrfoQb1pr+jTFDD20jOs3Jr/9j/rbVfefLQBFYoarUmjcmI1FL?=
 =?us-ascii?Q?IIcIxuJori1YV5Oie8yBpaijmEDOzW4H29JLAH5g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81a712c-3762-481b-cf19-08dd032b4ae6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 15:04:23.5202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpFsPh8fJGtbs3dZC2mU8GhhiDlIh7JbEwE6O1tV6kzhmJGqXuF1zyS91aDCy9W1MxdjzpAcKiKnD6SKnzaSTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241

On Fri, Nov 08, 2024 at 04:40:41PM +0000, Karan Sanghavi wrote:
> This error is reported by coverity scan stating as
> 
> CID 1593397: (#1 of 1): Unintended sign extension (SIGN_EXTENSION)
> sign_extension: Suspicious implicit sign extension: pc
> with type u16 (16 bits, unsigned) is promoted in
> pc << bit_shifts.pc to type int (32 bits, signed),
> then sign-extended to type unsigned long (64 bits, unsigned).
> If pc << bit_shifts.pc is greater than 0x7FFFFFFF,
> the upper bits of the result will all be 1.
> 
> Following the code styleof the file, assigning the u16

styleof -> style of

> value to u32 variable and using it for the bit wise
> operation, thus ensuring no unintentional sign
> extension occurs.
>

Please make sure you use an imperative voice here. For example, "assign
the value...and use it...". This should read like you are giving
commands.

> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>

Overall, looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

> ---
> Coverity  Link: 
> https://scan7.scan.coverity.com/#/project-view/51975/11354?selectedIssue=1593397
> ---
> Changes in v2:
> - Assigning pc value to temp variable before left shifting as mentioned
>   in feedback rather then typecasting pc to u32. 
> - Link to v1: https://lore.kernel.org/r/20241104-coverity1593397signextension-v1-1-4cfae6532140@gmail.com
> ---
>  drivers/ras/amd/atl/umc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
> index dc8aa12f63c8..3f4b1f31e14f 100644
> --- a/drivers/ras/amd/atl/umc.c
> +++ b/drivers/ras/amd/atl/umc.c
> @@ -293,7 +293,8 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
>  	}
>  
>  	/* PC bit */
> -	addr |= pc << bit_shifts.pc;
> +	temp = pc;
> +	addr |= temp << bit_shifts.pc;
>  
>  	/* SID bits */
>  	for (i = 0; i < NUM_SID_BITS; i++) {
> 
> ---
> base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
> change-id: 20241104-coverity1593397signextension-78c9b2c21d51
> 
> Best regards,
> -- 
> Karan Sanghavi <karansanghvi98@gmail.com>
> 

