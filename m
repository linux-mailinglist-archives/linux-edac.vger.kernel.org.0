Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626F24E5849
	for <lists+linux-edac@lfdr.de>; Wed, 23 Mar 2022 19:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244643AbiCWSVu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Mar 2022 14:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245629AbiCWSVs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Mar 2022 14:21:48 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6AE890B1
        for <linux-edac@vger.kernel.org>; Wed, 23 Mar 2022 11:20:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9rq7nGiLD80+/C+qOZx9/l+beJVYLIK7UDPmKeXCzjn7yC6mNfNSrS8ypFSEKoL8gHpM3sgN18Xp5pFZNepT7AM7X6/2eavClCsO8WyxWvLs3yati8k2jOXszRsS36Sq38c49UkQ1TOZ/EzmSGMf4bIen2SP0+tpMjH5AkQCS8sPTMRWhJ8k8PSOu70/bGxdCfrHcbDDwnfHllnWQxGYj5P8EZbk2JNHknXxAFBCh1gHsy89EBHUx9+scuYu+ZlErcGVR1kwik6NCNjK020WWIdgiisyJni1iaSKMY+0qubaI1Gz2UOADXfW6u+uVHlNnOcKFk9ZZIUrbfw5f0WZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vgl+3jESJFEWJ0Yp7702XIAP7C37sg2pai/kb8x9XnQ=;
 b=E7hApV8F1IXgF891dzDyjczZjjfjtKuo4vJT9KLwsxOiv+OKBryrHwxDrzIgnJgf92RUrMQIVXoB2JPZ+BnprzWUS5XmCVKfda+jsAiVrt/Dm+XOaLdluAZaD2FNmEA2y37Wptg65BcBC3YJdBxznysKsAFHQu47iuSviepGs06Wo3D+PZ9ZEz+zgFWwOlHuIAR52+x40YPSbxGIXk/e495dGmif5EBh28Y1P5zp6BN9UNoE8noSQ1LpwsxwhSbMuBmW5U5o5j95mFMGx6Wh1sVlGv/qJcBL3i8/n8zOPTWt5sNzAV1gtIqRjoG0fX48nnc4fQC72IBHoHpDDp8NXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vgl+3jESJFEWJ0Yp7702XIAP7C37sg2pai/kb8x9XnQ=;
 b=nSOm4O4VHbd2CoO23L3s7zM29yMb6Fgc1bLEA3aoMhHVthidAe8bQcroJbviEPIOIY+kCqqoIFdsSyK3jqsW5QEKtThLPUivsxN73pNTkho55vjzclDDc92m/K1Ad7kjGSe9GdnlktgSTpupUhu1qbH32gQ7Ffdzh3xHpn9b3eY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BYAPR12MB3288.namprd12.prod.outlook.com (2603:10b6:a03:130::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 23 Mar
 2022 18:20:15 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0%5]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 18:20:15 +0000
Date:   Wed, 23 Mar 2022 18:20:11 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 04/14] EDAC/amd64: Add determine_memory_type() into
 pvt->ops
Message-ID: <Yjtk2//GmjXTnNdJ@yaz-ubuntu>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-5-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228161354.54923-5-nchatrad@amd.com>
X-ClientProxiedBy: MN2PR20CA0012.namprd20.prod.outlook.com
 (2603:10b6:208:e8::25) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bbafd3e-5b31-4aa5-4592-08da0cf9c6b2
X-MS-TrafficTypeDiagnostic: BYAPR12MB3288:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB32889199A4658888AA7784F9F8189@BYAPR12MB3288.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3AOcjPspfqn2V9WytqVFiRKNN6s3SOe0vOJi6sIPlbAT2zj6SKgO82kjR4Jk5gv+Pn34089Y0ykpJ8GTvRNKCKGqG3lEpixwXrxXEU5jrvQUsl0HoPHdMbAlgVX+u8DfTyhUkA1bU+WmNHTxsEjuY8eEFhM+SvJZswIjN/f9p8fvyFeLegGLkUD56mC4YDwNYqh09ojQAteKiB3KxBkPOO8QwElPtJSMvSExtBfhPcYAJkutFb3CWwXABeQD1lU8UVJalmQYebS7QK7J+uLO3FXbOYG/VayjQG8T7s4HjT+7lW4NWW1W1UOvC7RPmpAsTGwbBw5iNIXgAY6TsBR/SQYBC/N35IaOMSwGBa2JxEbYpPKwve8F1fTfKHUrwLacw6nxK7wJZN5LkvmvxmAuzbLSsjgr5Qo/MfFcr1B2np9AL3dOnB5yoZeA5H2pgzg7EEOfUKFVGAHOCUNNMKVSE2/R5NIB9V2ATJ/i4/T5MoATZWv2OLTyFAhPizY2FmhzvgeCA81IkFs7muWe55RlVU/eRomOR6IRYoNw3NV8Zx/aF2cHaeX5EOjO21Hg9hISnKIykQevZYSWb/iU5a1BoxDHHDgD+ecaO+gusx/omJlgrV56MhxLe4P/3oiMHLuPITMR76sdYx6JsEOgPv0TH6wfPljGG+i7l09Dtp1vD0SnfKHhl0+5SgJQt+Vrs0yzEVKBgY9wgjEWSERyxCiQs3RQKVHgoSXC1EsSmhuEOY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(83380400001)(33716001)(6636002)(316002)(66556008)(66476007)(66946007)(508600001)(966005)(8676002)(6862004)(4326008)(6486002)(6512007)(186003)(86362001)(26005)(6666004)(8936002)(38100700002)(6506007)(5660300002)(2906002)(9686003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PH0Y090MUh8gdUnHKfnUrMPHmcj4ZBMqG+TOKzSrOHB42kkJO/Jhjk/LfGiC?=
 =?us-ascii?Q?1sF18Y6IaA1+PJNGqRPCuhBQ6yC8uSIPSSBqqUCbN8JOtrNOoBso8fQU9Nq9?=
 =?us-ascii?Q?hFM+Cx/iPD4nhHvIAKuG0hMlP9wPOuTxeioSOJZIxlUOpyXjEfXlHHkUgB3Y?=
 =?us-ascii?Q?HhMdQD1hIK+oXjOdxuQ+n5FmSuG3hbjSuasJVNm8AdvPmLgJvYTKT0vzPZWg?=
 =?us-ascii?Q?bToRm+dBgM8BQXCfEXSsfuTaKeWprgZ+4MhspULch1U9xaE/lyu+b9bVthGu?=
 =?us-ascii?Q?QvkObEHFGotyqb0urj3vVwcr6ja5AyFRZyE9/NJgZTqFPNqSpSDMUKasWrlp?=
 =?us-ascii?Q?njACHJR9i0Qm4/om5yyqL+jr8H7UqYJ4WOuEPc/SGa4z2k6d0QPVD/xWMGOk?=
 =?us-ascii?Q?zkPXqBeaZGJ63U7mbYtv2dkP113xiJtcrYgavqIWqcGpJZPeBcgKUKKHepqZ?=
 =?us-ascii?Q?LeG0M2+koF97M/rrr668Tzv+cO0hGlG21VVBNSPjUzmmdU5T3qIxI5b81g8p?=
 =?us-ascii?Q?uKcL3wWYI9vmwA9WLqFCP55+buRLpXqRb5S1v9oZz6Od4kSZXJ5TVesCMln0?=
 =?us-ascii?Q?wt7RZCk/yxsX7IYY0YwZrvcaM3Ew1/I9z0tpNgFangn9Sb3KUJ8pcwhY9+C1?=
 =?us-ascii?Q?i/bI/oLYJbTqSb6DowMqmpSNijOXX4QIBJFAUD6Fp2yJwmNRvkDyfoQk+WBc?=
 =?us-ascii?Q?YVQG//naI5UkoVJLRA+MZIyVdfP8av3CzZerjkjDChx2gizbVRNrtTfKkwsN?=
 =?us-ascii?Q?Xzhv790aE+5hi8DluZag7TnYrNIUbuYU/B6VhxG6XDgNbvdVooBmG5NvQwE7?=
 =?us-ascii?Q?Q6c6r6JaFg72YXtQE/t1VnVHtnAkFZCIX2ipHzX7Un3P4NddEeA2n5vos9l0?=
 =?us-ascii?Q?lHo1TXRqT0DFo8CpLeXtNhGwJVFmk3yCXWAyMaKXGSC/pYxswma+5+aZ/B4L?=
 =?us-ascii?Q?Fx3SydbOfgywZUII+CYopNH8vJx7owUrekIDYpmE/yAaSabIqyJ/ofD21jfD?=
 =?us-ascii?Q?743+dZJxcJqLrA6h/iKpimvyN3MBmdd5+i1WUFmQPqr+nvkMY5EHXD2QHSJV?=
 =?us-ascii?Q?pny6TRWHphOxBqTWPdjjP6JgKPUfiXruGbpJfnHJ5ZWeVRzPLo1N0zeId23w?=
 =?us-ascii?Q?aqSgSi9sLVmKk8UwkdZFBkFhdtsVS2OLwIxEtCtLo/FJ2nUxfjUYgy8fwUOO?=
 =?us-ascii?Q?hOCs4sKma/xjDYHemyiY2IrI8O1avIhKLumm5Xcwmjhbx1XKvvqbxPnQYLxJ?=
 =?us-ascii?Q?mvZ51mZxpOKvDCzxDWNToT4xjv1eq0LI7A+5UH/pVOkvp9VKLgf0rjXaases?=
 =?us-ascii?Q?Wn3wn6SPx93iUn/LGS+sANbi0ik0TlFOy3YPAJUva1Hs6mXCs+tiiPS2I/XC?=
 =?us-ascii?Q?gWlYY5kaNlM+4zSwkJMvc04iMhfgpg1S8KU+IUa9C3OMc2K168ijaxSpg3wx?=
 =?us-ascii?Q?QZicOxFXIgKFrEvVWLMbbcbf+vq/uR/S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbafd3e-5b31-4aa5-4592-08da0cf9c6b2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 18:20:14.8495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcDZxwgpKogK4lKDl/3w4kiHrJ3x8Bi9dZlKfI9P0FDdplnuB0nI3CXuTsDTFL8c0oHf6dvgFJrSAkG2KXpP+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3288
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 28, 2022 at 09:43:44PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> Add function pointer for determine_memory_type() in pvt->ops and
> assign family specific determine_memory_type() definitions
> appropriately.
>

Please include the "why".
 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
> This patch is created by splitting the 5/12th patch in series
> [v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/
> 
>  drivers/edac/amd64_edac.c | 33 ++++++++++++++++++++-------------
>  drivers/edac/amd64_edac.h |  1 +
>  2 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 708c4bbc0d1c..07428a6c7683 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -1632,20 +1632,10 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
>  	}
>  }
>  
> -static void determine_memory_type(struct amd64_pvt *pvt)
> +static void f1x_determine_memory_type(struct amd64_pvt *pvt)
>  {
>  	u32 dram_ctrl, dcsm;
>  
> -	if (pvt->umc) {
> -		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
> -			pvt->dram_type = MEM_LRDDR4;
> -		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
> -			pvt->dram_type = MEM_RDDR4;
> -		else
> -			pvt->dram_type = MEM_DDR4;
> -		return;
> -	}
> -
>  	switch (pvt->fam) {
>  	case 0xf:
>  		if (pvt->ext_model >= K8_REV_F)
> @@ -1701,6 +1691,16 @@ static void determine_memory_type(struct amd64_pvt *pvt)
>  	pvt->dram_type = (pvt->dclr0 & BIT(16)) ? MEM_DDR3 : MEM_RDDR3;
>  }
>  
> +static void f17_determine_memory_type(struct amd64_pvt *pvt)
> +{
> +	if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
> +		pvt->dram_type = MEM_LRDDR4;
> +	else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
> +		pvt->dram_type = MEM_RDDR4;
> +	else
> +		pvt->dram_type = MEM_DDR4;
> +}
> +

This will need some rework due to upstream changes.

Thanks,
Yazen
