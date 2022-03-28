Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9A94E9C25
	for <lists+linux-edac@lfdr.de>; Mon, 28 Mar 2022 18:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242016AbiC1QYg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Mar 2022 12:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242014AbiC1QYf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Mar 2022 12:24:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5174EA3B
        for <linux-edac@vger.kernel.org>; Mon, 28 Mar 2022 09:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwagQGSTQ/o9mYZaFC6+7qiWFViVTI2mK+LYCEHstfexzLaHriCZHnHBXmLlksvImWuAvCQxbY7cz8zcMNcm/4rRGR93b5agMJkFynRzRrUuge3LA9pPjHUjmc0gV9RgcslznTT1RAwxK3EfR2vCVcCJ58yYJwasBv2AYtktWPsE4s7vjENr1tgydrOyN8ZgTLx5Zcipv7mCIiDSn3iQE/uMzPU4Dn+C0x7F4XtOcj5rvihlOVWLfm/5D9wGToJSGLaCaldjUW2BM8X5XvyLM2Y4Oddu5PxIO/MLcxAudGxd9sFA3E6sb/s/jKAAR4XkZTItwyrWLiqmZNyRueAgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dm/ykGLWDuo2bFkD8sDnVGfpwnJg9vneu8xP+0jI+18=;
 b=IArBG/Be2ST4fsY661Wo63Bk/YDcL3aklgOXcsy7AHNPvYI7Fbxip9PuCtDfzpKTedTCAJeUgcRUyqQdMiRBVjlxl+OXa0v39oNy39ISO7uq2+JND8T65GSq2MPjRF1XmITmvPZT0ctSMkHAqxekHp8Iep5fY41cr1X7NYzB6dYnPjSAVobOh8DvD2nAYgvD4cvhCM1rwm7brQPVvYl11Uc/O6Q+4SH6D/Qu4gT+sWdfNSPWOq10VuglbPDKV2lmA95PnMOsBM7eRaZdQRw2+H0snvpMaQG3oRbyAJbpOmbSx2vAnKjz/m4yX7Lro060GCVg2VcQGelfebCM2MDnag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm/ykGLWDuo2bFkD8sDnVGfpwnJg9vneu8xP+0jI+18=;
 b=qn3lrsHNvcLx4SL3hJx9bWMr9fJAxAd9psoDaC4kJ9h+VE0vq05pKUV+neBIEnIz41nol/7+WwAmdGe6gPPgLPrOlS2xMqSfwYvKj8ZMPBrS6Eg2hdv6k71YqyIQ+PcotU9tAitsbbJhF8pSQD1SuBX6Uuk6MqKeUnWRiHDkDdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BL0PR12MB4721.namprd12.prod.outlook.com (2603:10b6:208:8e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 16:22:49 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 16:22:48 +0000
Date:   Mon, 28 Mar 2022 16:22:45 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 08/14] EDAC/amd64: Add determine_edac_cap() into pvt->ops
Message-ID: <YkHg1aVOZScc6vD9@yaz-ubuntu>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-9-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228161354.54923-9-nchatrad@amd.com>
X-ClientProxiedBy: MN2PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:208:160::14) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36995d9b-3ab7-48cc-30f9-08da10d732fc
X-MS-TrafficTypeDiagnostic: BL0PR12MB4721:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4721C7614BD628C706ACBC14F81D9@BL0PR12MB4721.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvqJGlNdP49dtWTn5b6VI6UQvHcyHe6JilxkBp+WEknknCkvfcAK7I0mkDfkTyhJbFAxminOjI/A5rV2/VrHxtqiXJrTp271qYgYlqDaC5I7tFWkB4QmxJPkx0xqUy0Lh7gfQjz9E8Y6g71iuByMofQZgEUaQ93OtZehG4jCmx77B4Tbmou21PTx+4BQAc7RwPdZljXW4zJ7DX0MW6A8/cn73v4zmbbxvTIxuxpy8UjVrJIe1E6Z7BCsT0jKKsVJ/VxXf+rPuG/vqVwll4kSF1FOA6UmPbc9q06pvPfou0VWmohNiw+8lOB3sgFjKxGEHOlW12/nGenGFyH3ly8TATATCppPpfwL3L+b914Ne5yBNvdsvdVw2fveZRoE3Dprrj3g7GhDuA35g8ez8hlxAOj86pOQolqY++7d2dl34WQH46k4kS0Jm2uCqJbV94Bu0Jm32jV0B0pbDF3XneTudDJpzOCrkWV2VM1aWX8Gn/SwHPAIz7xJ2UKe4dHd3dpjl3q3ad5AS0zzv6+z0OYJ3MrwS5qwqGxbUjMrMFTldkD8T0XDj3pqciDMMcz4Bk30yBQaj3E2T69liTYqLDhaAH3pNoLPaT/8yvg5uzPRJf+rEuGcAi0109K6hTlekXMFadGMdaDdxcSAiaVeIEYuGtKDLh8JnOvhOp4Avhd7vzoYqKAlROq0fb3vulm8Kwl0H909jN0VSRPnfiK4hG4Iqnu0UL26uqxD9e1eKWsAi1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6486002)(316002)(186003)(26005)(8676002)(66556008)(66476007)(2906002)(66946007)(9686003)(6512007)(38100700002)(4326008)(6862004)(44832011)(508600001)(6666004)(5660300002)(966005)(8936002)(86362001)(6636002)(6506007)(33716001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EVsCOuhHm/o1+L2YUuGqphTNOCu1ne59G+/1gvYW9B78tqLZ3tnKXMAANRzV?=
 =?us-ascii?Q?biNY7PoBpT6zqRqkDWaLoOc6IfrhT0FAxXWFZzqEbamyzAuLqkmh+Fk17UXV?=
 =?us-ascii?Q?cbfWzsUbyjPpUIR3UliRbDtOR5OQzHnQhkLfOYTBlDUtA8+HIjvol1zfwmGn?=
 =?us-ascii?Q?cNmr41yX5UbdqTb9VJOQbIThFUb9jUBzpg0aBrCrazaEcoMlP1itLE+iu+L0?=
 =?us-ascii?Q?/ZZ8y5Q9JkpkB0KQHzVdjYcGicpTeXPwMz7oHBAGIY94y28JPDinM3Yren73?=
 =?us-ascii?Q?djyOANi3fyaRumaW3Y+A6i11+5js0OVUkTutJJxZRUVcB4N4peunK0jICKRJ?=
 =?us-ascii?Q?+a2oIKo98Js11KSStae4QUPB1j2A8y6Rbhm2hNE94aTIFe9vgeWs55++kngt?=
 =?us-ascii?Q?Z2SDxM+DWrngCN9B+ykf0jNxXyKXs825TdlrqMixhwPlEI9EEyR8C++Lj5in?=
 =?us-ascii?Q?pTI8ozDURlmm8oZiYs9zM24P7043UTTfoFSkQ477s0QTnX6Mrz2J45FgiqRU?=
 =?us-ascii?Q?2USnLdVgD1oJ3hpYn2GnqmxAho/MB/6ByOYbQ/uOgJZNOJwYkpqjphZtX4Z1?=
 =?us-ascii?Q?QcHDPuykjCu0MzbxTTRVt0F73cG7Ru30xLLIS1JU5lElE5tASCvX0PFdVCco?=
 =?us-ascii?Q?PCYVDVgE3y85cKuocQDsvBdeoxgCKLNQwz8yC7QJcpJ9pPD3vlELHONt9bAV?=
 =?us-ascii?Q?5a4JcvM3hVdJsocJ9oEtHzzhItHzcfsiaIhTlDP4DuAOTDYao+28tqtDeOWq?=
 =?us-ascii?Q?+HT5oQej43P0LNAqJC5wF5yQDgaHpS/54thQGtcjnpZ4xQ8XGn0mwfjRulwH?=
 =?us-ascii?Q?oucu81vTs1wGs4NvxzdeC5OXK8RjZ/5VDUmirKnoVV/xIg0QruJMH5O1FIVr?=
 =?us-ascii?Q?smGIkymuqqQJGYnHoEmNUfQdrxtcgfoSWEvCgw3Nf6CSoXfpkr/eIWN26Zso?=
 =?us-ascii?Q?hJR9nCj1rG+veB1vXNLa2wxKJRCGAKxS9yM6u5Kc8BSjrIJhT3dyBQz1SMrD?=
 =?us-ascii?Q?XrzonGBBB2F+fRjBoDSysBhQAkNTmi7jSM0u3hHiqIvtEr+LauLeeSw/UE7x?=
 =?us-ascii?Q?E5qFZb13P7o6lVvs2FSj4RpVBdnNmjTRbDgY/EUWMM9COsuiFYrFili074HA?=
 =?us-ascii?Q?sAOACz4yO3OLKhlEiRmqKtzVTEVOwANO9dF5b/NIORKIj942z2QnVtxNOlWd?=
 =?us-ascii?Q?VXnux70gnF1VKYrPHPzzDMxZWNG+Senm4BjYTg2JACFAWsbfclizwy1ZVAVB?=
 =?us-ascii?Q?91NG4YjisJiZoa28KDL9Nsh4SY6MQ1DHzTKsf0jJcUMrf/QUq7AiSS5qCSmw?=
 =?us-ascii?Q?roDwR5e8UOhmAwZHuTcQcEutdSyv3d3/uL6GCpHx3pg41gi0iYRq1HiHNb9c?=
 =?us-ascii?Q?+NnuCBzJjwIcS67+k3TmHtoEEgN5MIxMQFeOaTFK5U4uH1+gdPXGBPFg58Dl?=
 =?us-ascii?Q?Dm59eo9JZAZSgeVXiHm7r8ZU0WCkQidGwd/j6oyEXlQN2TfP0sBd6f/j7bNQ?=
 =?us-ascii?Q?rFBmddSE6YMUYqA58+1PuupHLSLBsN43l0k26Kqlzj2CahjOIWd859iInU2+?=
 =?us-ascii?Q?hPiQsLgWt6lE/fcRfnA+iA4/i94a9dpmelS5z087PB2qAoWOjlQ+HCK6xxSW?=
 =?us-ascii?Q?GBocJnGXFol8H9iAPwu4TXxCTilf6PEEw/3DRwB8GXWfgJCfzOrJ+llzdnc4?=
 =?us-ascii?Q?W6a+bHrsZ4P665pEu40rSltHTapS2dV0Hy2w247d9OPX3VowUA5YfVtgxRLx?=
 =?us-ascii?Q?dz2l9a17hg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36995d9b-3ab7-48cc-30f9-08da10d732fc
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 16:22:48.7466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVX517doiMgNwgjAq3Q5d3fmMDHD5FQa5BV85szlgNCo/fEsHXopBfe9YjhfLoIuji5vNNpxU27qnx4ATulVPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4721
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 28, 2022 at 09:43:48PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> Add function pointer for determine_edac_cap() in pvt->ops and assign
> family specific determine_edac_cap() definitions appropriately.
>

Please include the "why".
 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
> This patch is created by splitting the 5/12th patch in series
> [v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/
> 
>  drivers/edac/amd64_edac.c | 37 ++++++++++++++++++++++++-------------
>  drivers/edac/amd64_edac.h |  1 +
>  2 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 15d775a9ce7e..af6711cf03e9 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -1267,13 +1267,25 @@ static int get_channel_from_ecc_syndrome(struct mem_ctl_info *, u16);
>   * Determine if the DIMMs have ECC enabled. ECC is enabled ONLY if all the DIMMs
>   * are ECC capable.
>   */
> -static unsigned long determine_edac_cap(struct amd64_pvt *pvt)
> +static unsigned long f1x_determine_edac_cap(struct amd64_pvt *pvt)
>  {
>  	unsigned long edac_cap = EDAC_FLAG_NONE;
>  	u8 bit;
>  
> -	if (pvt->umc) {
> -		u8 i, umc_en_mask = 0, dimm_ecc_en_mask = 0;
> +	bit = (pvt->fam > 0xf || pvt->ext_model >= K8_REV_F)
> +		? 19
> +		: 17;
> +
> +	if (pvt->dclr0 & BIT(bit))
> +		edac_cap = EDAC_FLAG_SECDED;
> +
> +	return edac_cap;
> +}
> +
> +static unsigned long f17_determine_edac_cap(struct amd64_pvt *pvt)
> +{
> +	u8 i, umc_en_mask = 0, dimm_ecc_en_mask = 0;
> +	unsigned long edac_cap = EDAC_FLAG_NONE;
>  
>  		for_each_umc(i) {
>  			if (!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT))
> @@ -1288,14 +1300,6 @@ static unsigned long determine_edac_cap(struct amd64_pvt *pvt)
>  
>  		if (umc_en_mask == dimm_ecc_en_mask)
>  			edac_cap = EDAC_FLAG_SECDED;
> -	} else {
> -		bit = (pvt->fam > 0xf || pvt->ext_model >= K8_REV_F)
> -			? 19
> -			: 17;
> -
> -		if (pvt->dclr0 & BIT(bit))
> -			edac_cap = EDAC_FLAG_SECDED;
> -	}
>  
>  	return edac_cap;
>  }
> @@ -3759,7 +3763,7 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
>  			mci->edac_ctl_cap |= EDAC_FLAG_S4ECD4ED;

This patch is okay overall. But I think we should audit which EDAC_FLAG values
are used to make sure they truly match the system capabilities.

Thanks,
Yazen
