Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7511B4367BC
	for <lists+linux-edac@lfdr.de>; Thu, 21 Oct 2021 18:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhJUQan (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Oct 2021 12:30:43 -0400
Received: from mail-bn8nam12on2089.outbound.protection.outlook.com ([40.107.237.89]:40685
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229597AbhJUQan (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 21 Oct 2021 12:30:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHk1sEBlwqdxvLFSFRRwutU/kVk5dUqU7NT3Qnf74csRE30F66jKd7YUaIGTihJMVVTMJJcfdNVsLzeAFf5mfC0zKCQSAkd+3fkVTLv1vMd3j7KuM+Cx0Pkb1IzEkrtwdkDQt/3AOyYTwH1oDx5O4J+qPppe9vqy7ZlW8gakjHSzsKXbtAFFHgSupCkmF8c+1yhM2WwKlnMIGc8RDHZ2HwmFOWsAX6jVQh2OpewIhtJx84U/SF9wHw/4mz+6sTSFy8roy6kATUeycVhtixH6Ctz4y2n6gF7h/ufkkClmiSBs1zte1o4xHjub1IAjZCytoGx2j+oZzunay/Zx+8O4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4y8ZZxLj6E3BOG1YSVQqOiKrZC5IAR7VNhWrfShqx+s=;
 b=S3hnwGvPzLIMC2CJ+W3T3e31uA+yNKrwbGDbh0WJOZ8CE6dRM0iTN4OUUvRdT8xzs/DJEbz9x4QCT7VHdcNp3VzTj4OjZrxSo7FemGd94dybv6x4ZvpIRgjg/rH/Mqqh0v1GTOyfB5z74FxDd4kGDsfosaTstlT7xtt251qj7DbLpK/mpOXBK9ZnqiKwbTD9mdeoeELKrdeGDRJRL1g2JWkzmTR8Ddou1byi2gVbBX4uoR6z7DwFFqfyEMZGiGu8QMKSkpW3B/SsEpWKSCUo3ghC9GbZUJ+MTy1XO25/u9qiHeASilLwQ1PWuiDTeVgOqHeGlCzR6ZRNRdwxhtPy2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4y8ZZxLj6E3BOG1YSVQqOiKrZC5IAR7VNhWrfShqx+s=;
 b=jfSjsb/MxgZTbKBb2/Wvz0mVh99140Ej7jb9vhQnFZ6rW+1RXUD2g/PIXnnH3UwwLfl7ANLQLU4KSHC3zre4KcBz3lyIx6doGkBB7w+sOJZAXKW/d/1tyh79AZ2jyl8Jp75nnnFU1qVWRV49U8rvxy8bEg5cBWUYv2JHI3LacGs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN7PR12MB2753.namprd12.prod.outlook.com (2603:10b6:408:31::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 16:28:24 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::d075:22bc:12ee:e73e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::d075:22bc:12ee:e73e%7]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 16:28:24 +0000
Date:   Thu, 21 Oct 2021 16:27:58 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v4 3/4] EDAC/amd64: Extend family ops functions
Message-ID: <YXGVDugh1bhWytn1@yaz-ubuntu>
References: <20210823185437.94417-1-nchatrad@amd.com>
 <20211014185400.10451-1-nchatrad@amd.com>
 <20211014185400.10451-4-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014185400.10451-4-nchatrad@amd.com>
X-ClientProxiedBy: MN2PR20CA0018.namprd20.prod.outlook.com
 (2603:10b6:208:e8::31) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.25.250) by MN2PR20CA0018.namprd20.prod.outlook.com (2603:10b6:208:e8::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 16:28:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0437f006-7a38-416c-87c0-08d994afcda7
X-MS-TrafficTypeDiagnostic: BN7PR12MB2753:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2753FBF6EC54BF879D56E06BF8BF9@BN7PR12MB2753.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HDCU8MCTESQ4tYxUSvqWgArl79oIjphkrc8Ij6tpA25QF0oXpGmMaahCkfIufrZA6N+79kR/7jk3ggE+7A+hHxzeWi/AlwlCd//e/Mg1pd60/C7wY+SPo5hPDtiUw2DUxOwgfeKibjAJBN7/N3tFMp2/HWyzMI6C9KBpO+bsGgZZeYEgufMF57UVL3JcjVyzvqq+zVt94+z2K295x6qxI6XPdeUo2kKiKqRNh0RNGP8jDAmjTpz+m10whUc81F0ogSIklhD5brR7TNrVs98ffh6SocHvTnAclOGRBtEqC0dbQig5txs3zeR+TklHUKIXuSCTDfLeiF9b/1rE2eGvXoFZd7a3Wvt2j55MKjG99J2YkST+LSBJEsrw5ksZ9/5NSb2WcGsDE4k52UsMMyCz8trzye2xqtCd18D2VMiPMhMb+tYP3vin+mclNi28xekKKkcTx4yCnZv1FhvoDmEvDuAJzVfkQuPza/RZUqzXvWFt8jkIkxw7Q4gGbQ9Wihj7LeuE6tI854OnWFwP/2z9U/nCw1IeQcN4SsmgQQ7WVJYcKhMI7TV9BCaTVTbgtPuNRZvnhQc846pFigWsym+GoRDicGRnvFtDN+tVBsa2G1PUx7Fr+t93p2K729GeOvqCbbHF1jRXWDhg9vZLUWsNLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(33716001)(5660300002)(38100700002)(316002)(8936002)(86362001)(44832011)(2906002)(26005)(83380400001)(9686003)(956004)(6636002)(186003)(55016002)(6496006)(8676002)(30864003)(66946007)(4326008)(508600001)(6862004)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5vautCqwpMVjvRajLJGn6wfZg//ghfOCBETPmY2DGxmpL2/CImdPh+lHgWnh?=
 =?us-ascii?Q?zkona7n+V/Ktld7GSzJo6Bm9VbNQ/ubHg26nPM/TwBkZoAaPwIK2gQiX65Hc?=
 =?us-ascii?Q?fyETJzcaA0uLbUUW1dZoO/sy1ibyD+DoQ2nb2fzLtkkkVKTIlodCvo1QBqmS?=
 =?us-ascii?Q?8DlnrYyGDOK86hEFVK5UUciwhRmVzPg4+cn4Loa5YVH6gPjnt4x9TT+E2sKj?=
 =?us-ascii?Q?0/uak6MwFefrvQmQrux84q43d17kIgMvTKmr0yYS7T+66H1p3MBmlIzRkax+?=
 =?us-ascii?Q?WsugbR0bApUpZo2swtISQk9hk5mqoidLA8FcmHDOEU3betYrfDPHiW5DvP7v?=
 =?us-ascii?Q?eQKT18J/0d2HaCsdFV54KaLUB7VtPPRI0VgRcbuw/60bg6WgEuAASBwTBfiG?=
 =?us-ascii?Q?uJ5Xr2JODQBrwBEvU+wDFvHprPVkvQIT6wQAVdHUlEOKs+Z66Y6WYcVmVdkf?=
 =?us-ascii?Q?rqBhDbpTUum0ByVCF9k8Br3lgnIR1attrLlmx7Wg8GX/aqfTWAzWlPf+q2R2?=
 =?us-ascii?Q?qbVTKbhM8TEIy47bqj+FCzbNoSRiygWu0JJojgHsWltqiU9ibPylV7S6BUCG?=
 =?us-ascii?Q?voTKu8Cu4rCOIRR3B13OHIc11RClyt2MkB9Zgyo8O5HRGQxBYQv+UC1tEHWU?=
 =?us-ascii?Q?u1tzN8WKGw4+mL+Uafgja/XB9MUEbOEZVoezg4F0OleKq3ZmTAD4eIkvcxsv?=
 =?us-ascii?Q?AcSHtOm6mP7wgbZ0uqc+DFTId9hm2l19LicI3KOD0ZjBnRgZdYXgEE3HluAO?=
 =?us-ascii?Q?VCH2AOUvclX5ADQTDwgAnKXR8eSqi82dAb1PbxZhmE848o98F1Oig6bHWiq1?=
 =?us-ascii?Q?dRfrpSEFQtxM5ffffKb2KmPZ/cVayubP6Fj62q5CdtHHtY8wtdp2wfT4Pa8D?=
 =?us-ascii?Q?Yi1rRKzCbOcz04DUKM3XbEMHAd824/cXP+oz/hN0sBQDTM/hGJK/Gcn+h3C0?=
 =?us-ascii?Q?6ANA1iQ7+YLqh43wtP/olDJ6sKArNr1A6t61zkwB0Bv8yMUt7zjBv54Yqkkk?=
 =?us-ascii?Q?VD94qlY+e025NNfHsTMz4051pRJOdYkcq51yr8YZEUZ7Dc38WtNQSklL2LBe?=
 =?us-ascii?Q?pq5scKD9EqghdRt+Rco32kwJfyt9QRRcInZ+ZaEr+VFiwTsQ4WLurNZ8IUGS?=
 =?us-ascii?Q?wiHcWBLJn8R716rgR5eIiyJpJ//omRpAxmLY58Ip4UW0eeOW63ElVI9YG8ZZ?=
 =?us-ascii?Q?oBlrbbg70R8oiM0ms2fQIAk82VBsGPQH8NPY53ZnlgPC/rJBlS/EVmlebTlX?=
 =?us-ascii?Q?kA5RpyiwUk2y7xFpUKP73rJMY9vTWjw6W1tmJ1qt6qTfMy7BdtRBRHD/11jU?=
 =?us-ascii?Q?qGTBnKEmyJCiV+Ug43frsw+mV1VH+2ZxWW46QB9sMNB63dopSZcCVSLaZ4rR?=
 =?us-ascii?Q?+TP/+NDFX0IfHaYx45zYR4cZ4iZi9ufyFGKDU5drNayO1nEjqEyJ90EMxfkn?=
 =?us-ascii?Q?DPcgRjsJhCQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0437f006-7a38-416c-87c0-08d994afcda7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:28:24.1711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2753
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 15, 2021 at 12:23:59AM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> Create new family operation routines and define them respectively.
> This would simplify adding support for future platforms.
> 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
> Changes since v3:
> 1. Defined new family operation routines
> 
> Changs since v2:
> 1. new patch
> 
>  drivers/edac/amd64_edac.c | 291 ++++++++++++++++++++++----------------
>  drivers/edac/amd64_edac.h |   6 +
>  2 files changed, 174 insertions(+), 123 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 4fce75013674..131ed19f69dd 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -1204,10 +1204,7 @@ static void __dump_misc_regs(struct amd64_pvt *pvt)
>  /* Display and decode various NB registers for debug purposes. */
>  static void dump_misc_regs(struct amd64_pvt *pvt)
>  {
> -	if (pvt->umc)
> -		__dump_misc_regs_df(pvt);
> -	else
> -		__dump_misc_regs(pvt);
> +	pvt->ops->display_misc_regs(pvt);
>  
>  	edac_dbg(1, "  DramHoleValid: %s\n", dhar_valid(pvt) ? "yes" : "no");
>  
> @@ -1217,25 +1214,31 @@ static void dump_misc_regs(struct amd64_pvt *pvt)
>  /*
>   * See BKDG, F2x[1,0][5C:40], F2[1,0][6C:60]
>   */
> -static void prep_chip_selects(struct amd64_pvt *pvt)
> +static void k8_prep_chip_selects(struct amd64_pvt *pvt)
>  {
> -	if (pvt->fam == 0xf && pvt->ext_model < K8_REV_F) {
> -		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
> -		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 8;
> -	} else if (pvt->fam == 0x15 && pvt->model == 0x30) {
> -		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 4;
> -		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
> -	} else if (pvt->fam >= 0x17) {
> -		int umc;
> -
> -		for_each_umc(umc) {
> -			pvt->csels[umc].b_cnt = 4;
> -			pvt->csels[umc].m_cnt = 2;
> -		}
> +	pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
> +	pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 8;

This doesn't exactly match the existing code. Base/mask = 8/8 applies to
revisions less than K8_REV_F, and 8/4 for K8_REF_F.

So I think you'll still need the "ext_model" check here in
k8_prep_chip_selects().

> +}
>  
> -	} else {
> -		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
> -		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 4;
> +static void f15m30_prep_chip_selects(struct amd64_pvt *pvt)
> +{
> +	pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 4;
> +	pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
> +}
> +
> +static void fmisc_prep_chip_selects(struct amd64_pvt *pvt)

"fmisc" looks weird. Maybe just call it "default" since it was the
default/else path in the code?

> +{
> +	pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
> +	pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 4;
> +}
> +
> +static void f17_prep_chip_selects(struct amd64_pvt *pvt)
> +{
> +	int umc;
> +
> +	for_each_umc(umc) {
> +		pvt->csels[umc].b_cnt = 4;
> +		pvt->csels[umc].m_cnt = 2;
>  	}
>  }
>  
> @@ -1297,10 +1300,10 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
>  {
>  	int cs;
>  
> -	prep_chip_selects(pvt);
> +	pvt->ops->prep_chip_select(pvt);
>  
> -	if (pvt->umc)
> -		return read_umc_base_mask(pvt);
> +	if (pvt->ops->get_base_mask)
> +		return pvt->ops->get_base_mask(pvt);

The get_base_mask() pointer can be set to this read_dct_base_mask() function
on pre-Family17h systems. 

>  
>  	for_each_chip_select(cs, 0, pvt) {
>  		int reg0   = DCSB0 + (cs * 4);
> @@ -1869,37 +1872,12 @@ static int f16_dbam_to_chip_select(struct amd64_pvt *pvt, u8 dct,
>  		return ddr3_cs_size(cs_mode, false);
>  }
>  
> -static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
> -				    unsigned int cs_mode, int csrow_nr)
> +static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
> +				  int csrow_nr, int dimm)
>  {
> -	u32 addr_mask_orig, addr_mask_deinterleaved;
>  	u32 msb, weight, num_zero_bits;
> -	int dimm, size = 0;
> -
> -	/* No Chip Selects are enabled. */
> -	if (!cs_mode)
> -		return size;
> -
> -	/* Requested size of an even CS but none are enabled. */
> -	if (!(cs_mode & CS_EVEN) && !(csrow_nr & 1))
> -		return size;
> -
> -	/* Requested size of an odd CS but none are enabled. */
> -	if (!(cs_mode & CS_ODD) && (csrow_nr & 1))
> -		return size;
> -
> -	/*
> -	 * There is one mask per DIMM, and two Chip Selects per DIMM.
> -	 *	CS0 and CS1 -> DIMM0
> -	 *	CS2 and CS3 -> DIMM1
> -	 */
> -	dimm = csrow_nr >> 1;
> -
> -	/* Asymmetric dual-rank DIMM support. */
> -	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
> -		addr_mask_orig = pvt->csels[umc].csmasks_sec[dimm];
> -	else
> -		addr_mask_orig = pvt->csels[umc].csmasks[dimm];
> +	u32 addr_mask_deinterleaved;
> +	int size = 0;
>  
>  	/*
>  	 * The number of zero bits in the mask is equal to the number of bits
> @@ -1930,6 +1908,40 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>  	return size >> 10;
>  }
>  
> +static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
> +				    unsigned int cs_mode, int csrow_nr)
> +{
> +	u32 addr_mask_orig;
> +	int dimm, size = 0;
> +
> +	/* No Chip Selects are enabled. */
> +	if (!cs_mode)
> +		return size;
> +
> +	/* Requested size of an even CS but none are enabled. */
> +	if (!(cs_mode & CS_EVEN) && !(csrow_nr & 1))
> +		return size;
> +
> +	/* Requested size of an odd CS but none are enabled. */
> +	if (!(cs_mode & CS_ODD) && (csrow_nr & 1))
> +		return size;
> +
> +	/*
> +	 * There is one mask per DIMM, and two Chip Selects per DIMM.
> +	 *	CS0 and CS1 -> DIMM0
> +	 *	CS2 and CS3 -> DIMM1
> +	 */
> +	dimm = csrow_nr >> 1;
> +
> +	/* Asymmetric dual-rank DIMM support. */
> +	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
> +		addr_mask_orig = pvt->csels[umc].csmasks_sec[dimm];
> +	else
> +		addr_mask_orig = pvt->csels[umc].csmasks[dimm];
> +
> +	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, dimm);

The commit message refers to function ops/pointers, but it didn't say why this
helper function is needed.

> +}
> +
>  static void read_dram_ctl_register(struct amd64_pvt *pvt)
>  {
>  
> @@ -2512,143 +2524,168 @@ static void debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
>  	}
>  }
>  
> +/* Prototypes for family specific ops routines */
> +static int init_csrows(struct mem_ctl_info *mci);
> +static int init_csrows_df(struct mem_ctl_info *mci);
> +static void __read_mc_regs_df(struct amd64_pvt *pvt);
> +static void find_umc_channel(struct mce *m, struct err_info *err);
> +
> +static const struct low_ops k8_ops = {
> +	.early_channel_count	= k8_early_channel_count,
> +	.map_sysaddr_to_csrow	= k8_map_sysaddr_to_csrow,
> +	.dbam_to_cs		= k8_dbam_to_chip_select,
> +	.prep_chip_select	= k8_prep_chip_selects,
> +	.display_misc_regs	= __dump_misc_regs,
> +	.populate_csrows	= init_csrows,
> +};
> +
> +static const struct low_ops f10_ops = {
> +	.early_channel_count	= f1x_early_channel_count,
> +	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
> +	.dbam_to_cs		= f10_dbam_to_chip_select,
> +	.prep_chip_select	= fmisc_prep_chip_selects,
> +	.display_misc_regs	= __dump_misc_regs,
> +	.populate_csrows	= init_csrows,
> +};
> +
> +static const struct low_ops f15_ops = {
> +	.early_channel_count	= f1x_early_channel_count,
> +	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
> +	.dbam_to_cs		= f15_dbam_to_chip_select,
> +	.prep_chip_select	= fmisc_prep_chip_selects,
> +	.display_misc_regs	= __dump_misc_regs,
> +	.populate_csrows	= init_csrows,
> +};
> +
> +static const struct low_ops f15m30_ops = {
> +	.early_channel_count	= f1x_early_channel_count,
> +	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
> +	.dbam_to_cs		= f16_dbam_to_chip_select,
> +	.prep_chip_select	= f15m30_prep_chip_selects,
> +	.display_misc_regs	= __dump_misc_regs,
> +	.populate_csrows	= init_csrows,
> +};
> +
> +static const struct low_ops f16_x_ops = {

Why is this "f16_x" rather than "f15m60"?

> +	.early_channel_count	= f1x_early_channel_count,
> +	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
> +	.dbam_to_cs		= f15_m60h_dbam_to_chip_select,
> +	.prep_chip_select	= fmisc_prep_chip_selects,
> +	.display_misc_regs	= __dump_misc_regs,
> +	.populate_csrows	= init_csrows,
> +};
> +
> +static const struct low_ops f16_ops = {
> +	.early_channel_count	= f1x_early_channel_count,
> +	.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
> +	.dbam_to_cs		= f16_dbam_to_chip_select,
> +	.prep_chip_select	= fmisc_prep_chip_selects,
> +	.display_misc_regs	= __dump_misc_regs,
> +	.populate_csrows	= init_csrows,
> +};
> +
> +static const struct low_ops f17_ops = {
> +	.early_channel_count	= f17_early_channel_count,
> +	.dbam_to_cs		= f17_addr_mask_to_cs_size,
> +	.prep_chip_select	= f17_prep_chip_selects,
> +	.get_base_mask		= read_umc_base_mask,
> +	.display_misc_regs	= __dump_misc_regs_df,
> +	.get_mc_regs		= __read_mc_regs_df,
> +	.populate_csrows	= init_csrows_df,
> +	.get_umc_err_info	= find_umc_channel,
> +};
> +
>  static struct amd64_family_type family_types[] = {
>  	[K8_CPUS] = {
>  		.ctl_name = "K8",
>  		.f1_id = PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP,
>  		.f2_id = PCI_DEVICE_ID_AMD_K8_NB_MEMCTL,
>  		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= k8_early_channel_count,
> -			.map_sysaddr_to_csrow	= k8_map_sysaddr_to_csrow,
> -			.dbam_to_cs		= k8_dbam_to_chip_select,
> -		}
> +		.ops = k8_ops,
>  	},
>  	[F10_CPUS] = {
>  		.ctl_name = "F10h",
>  		.f1_id = PCI_DEVICE_ID_AMD_10H_NB_MAP,
>  		.f2_id = PCI_DEVICE_ID_AMD_10H_NB_DRAM,
>  		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f1x_early_channel_count,
> -			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
> -			.dbam_to_cs		= f10_dbam_to_chip_select,
> -		}
> +		.ops = f10_ops,
>  	},
>  	[F15_CPUS] = {
>  		.ctl_name = "F15h",
>  		.f1_id = PCI_DEVICE_ID_AMD_15H_NB_F1,
>  		.f2_id = PCI_DEVICE_ID_AMD_15H_NB_F2,
>  		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f1x_early_channel_count,
> -			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
> -			.dbam_to_cs		= f15_dbam_to_chip_select,
> -		}
> +		.ops = f15_ops,
>  	},
>  	[F15_M30H_CPUS] = {
>  		.ctl_name = "F15h_M30h",
>  		.f1_id = PCI_DEVICE_ID_AMD_15H_M30H_NB_F1,
>  		.f2_id = PCI_DEVICE_ID_AMD_15H_M30H_NB_F2,
>  		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f1x_early_channel_count,
> -			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
> -			.dbam_to_cs		= f16_dbam_to_chip_select,
> -		}
> +		.ops = f15m30_ops,
>  	},
>  	[F15_M60H_CPUS] = {
>  		.ctl_name = "F15h_M60h",
>  		.f1_id = PCI_DEVICE_ID_AMD_15H_M60H_NB_F1,
>  		.f2_id = PCI_DEVICE_ID_AMD_15H_M60H_NB_F2,
>  		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f1x_early_channel_count,
> -			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
> -			.dbam_to_cs		= f15_m60h_dbam_to_chip_select,
> -		}
> +		.ops = f16_x_ops,
>  	},
>  	[F16_CPUS] = {
>  		.ctl_name = "F16h",
>  		.f1_id = PCI_DEVICE_ID_AMD_16H_NB_F1,
>  		.f2_id = PCI_DEVICE_ID_AMD_16H_NB_F2,
>  		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f1x_early_channel_count,
> -			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
> -			.dbam_to_cs		= f16_dbam_to_chip_select,
> -		}
> +		.ops = f16_ops,
>  	},
>  	[F16_M30H_CPUS] = {
>  		.ctl_name = "F16h_M30h",
>  		.f1_id = PCI_DEVICE_ID_AMD_16H_M30H_NB_F1,
>  		.f2_id = PCI_DEVICE_ID_AMD_16H_M30H_NB_F2,
>  		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f1x_early_channel_count,
> -			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
> -			.dbam_to_cs		= f16_dbam_to_chip_select,
> -		}
> +		.ops = f16_ops,
>  	},
>  	[F17_CPUS] = {
>  		.ctl_name = "F17h",
>  		.f0_id = PCI_DEVICE_ID_AMD_17H_DF_F0,
>  		.f6_id = PCI_DEVICE_ID_AMD_17H_DF_F6,
>  		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f17_early_channel_count,
> -			.dbam_to_cs		= f17_addr_mask_to_cs_size,
> -		}
> +		.ops = f17_ops,
>  	},
>  	[F17_M10H_CPUS] = {
>  		.ctl_name = "F17h_M10h",
>  		.f0_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F0,
>  		.f6_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F6,
>  		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f17_early_channel_count,
> -			.dbam_to_cs		= f17_addr_mask_to_cs_size,
> -		}
> +		.ops = f17_ops,
>  	},
>  	[F17_M30H_CPUS] = {
>  		.ctl_name = "F17h_M30h",
>  		.f0_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F0,
>  		.f6_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F6,
>  		.max_mcs = 8,
> -		.ops = {
> -			.early_channel_count	= f17_early_channel_count,
> -			.dbam_to_cs		= f17_addr_mask_to_cs_size,
> -		}
> +		.ops = f17_ops,
>  	},
>  	[F17_M60H_CPUS] = {
>  		.ctl_name = "F17h_M60h",
>  		.f0_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F0,
>  		.f6_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F6,
>  		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f17_early_channel_count,
> -			.dbam_to_cs		= f17_addr_mask_to_cs_size,
> -		}
> +		.ops = f17_ops,
>  	},
>  	[F17_M70H_CPUS] = {
>  		.ctl_name = "F17h_M70h",
>  		.f0_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
>  		.f6_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F6,
>  		.max_mcs = 2,
> -		.ops = {
> -			.early_channel_count	= f17_early_channel_count,
> -			.dbam_to_cs		= f17_addr_mask_to_cs_size,
> -		}
> +		.ops = f17_ops,
>  	},
>  	[F19_CPUS] = {
>  		.ctl_name = "F19h",
>  		.f0_id = PCI_DEVICE_ID_AMD_19H_DF_F0,
>  		.f6_id = PCI_DEVICE_ID_AMD_19H_DF_F6,
>  		.max_mcs = 8,
> -		.ops = {
> -			.early_channel_count	= f17_early_channel_count,
> -			.dbam_to_cs		= f17_addr_mask_to_cs_size,
> -		}
> +		.ops = f17_ops,
>  	},
>  };
>  
> @@ -2900,9 +2937,10 @@ static inline void decode_bus_error(int node_id, struct mce *m)
>   * the instance_id. For example, instance_id=0xYXXXXX where Y is the channel
>   * number.
>   */
> -static int find_umc_channel(struct mce *m)
> +static void find_umc_channel(struct mce *m, struct err_info *err)

This function now gets more than just the channel. Can this be reflected in
the name?

>  {
> -	return (m->ipid & GENMASK(31, 0)) >> 20;
> +	err->channel = (m->ipid & GENMASK(31, 0)) >> 20;
> +	err->csrow = m->synd & 0x7;
>  }
>  
>  static void decode_umc_error(int node_id, struct mce *m)
> @@ -2924,7 +2962,7 @@ static void decode_umc_error(int node_id, struct mce *m)
>  	if (m->status & MCI_STATUS_DEFERRED)
>  		ecc_type = 3;
>  
> -	err.channel = find_umc_channel(m);
> +	pvt->ops->get_umc_err_info(m, &err);

Because the "csrow" value is derived from the MCA_SYND value, this function
call should go after checking SYNDV below.

>  
>  	if (!(m->status & MCI_STATUS_SYNDV)) {
>  		err.err_code = ERR_SYND;
> @@ -2940,8 +2978,6 @@ static void decode_umc_error(int node_id, struct mce *m)
>  			err.err_code = ERR_CHANNEL;
>  	}
>  
> -	err.csrow = m->synd & 0x7;
> -
>  	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
>  		err.err_code = ERR_NORM_ADDR;
>  		goto log_error;
> @@ -3106,8 +3142,9 @@ static void read_mc_regs(struct amd64_pvt *pvt)
>  		edac_dbg(0, "  TOP_MEM2 disabled\n");
>  	}
>  
> -	if (pvt->umc) {
> -		__read_mc_regs_df(pvt);
> +	if (pvt->ops->get_mc_regs) {
> +		pvt->ops->get_mc_regs(pvt);
> +

I think this is okay for now. Maybe we can break up this function in a future
patch.

>  		amd64_read_pci_cfg(pvt->F0, DF_DHAR, &pvt->dhar);
>  
>  		goto skip;
> @@ -3277,9 +3314,6 @@ static int init_csrows(struct mem_ctl_info *mci)
>  	int nr_pages = 0;
>  	u32 val;
>  
> -	if (pvt->umc)
> -		return init_csrows_df(mci);
> -
>  	amd64_read_pci_cfg(pvt->F3, NBCFG, &val);
>  
>  	pvt->nbcfg = val;
> @@ -3703,6 +3737,17 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
>  		return NULL;
>  	}
>  
> +	/* ops required for all the families */
> +	if (!pvt->ops->early_channel_count | !pvt->ops->prep_chip_select |
> +	    !pvt->ops->display_misc_regs | !pvt->ops->dbam_to_cs |
> +	    !pvt->ops->populate_csrows)
> +		return NULL;
> +
> +	/* ops required for families 17h and later */
> +	if (pvt->fam >= 0x17 && (!pvt->ops->get_base_mask |
> +	    !pvt->ops->get_umc_err_info | !pvt->ops->get_mc_regs))
> +		return NULL;
> +

Can you please add an EDAC debug message for these? I think that'll help track
down any coding bugs.

Also, all the "|" should be "||" right?

>  	return fam_type;
>  }
>  
> @@ -3786,7 +3831,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
>  
>  	setup_mci_misc_attrs(mci);
>  
> -	if (init_csrows(mci))
> +	if (pvt->ops->populate_csrows(mci))
>  		mci->edac_cap = EDAC_FLAG_NONE;
>  
>  	ret = -ENODEV;
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index 85aa820bc165..ce21b3cf0825 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -472,6 +472,12 @@ struct low_ops {
>  					 struct err_info *);
>  	int (*dbam_to_cs)		(struct amd64_pvt *pvt, u8 dct,
>  					 unsigned cs_mode, int cs_mask_nr);
> +	void (*prep_chip_select)(struct amd64_pvt *pvt);
> +	void (*get_base_mask)(struct amd64_pvt *pvt);
> +	void (*display_misc_regs)(struct amd64_pvt *pvt);
> +	void (*get_mc_regs)(struct amd64_pvt *pvt);
> +	int (*populate_csrows)(struct mem_ctl_info *mci);
> +	void (*get_umc_err_info)(struct mce *m, struct err_info *err);

Can you please align all the parathenses?

>  };
>  
>  struct amd64_family_type {
> -- 

Thanks,
Yazen
