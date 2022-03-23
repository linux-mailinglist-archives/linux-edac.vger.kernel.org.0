Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1289C4E586D
	for <lists+linux-edac@lfdr.de>; Wed, 23 Mar 2022 19:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbiCWScL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Mar 2022 14:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiCWScJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Mar 2022 14:32:09 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2078.outbound.protection.outlook.com [40.107.101.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3849071EC3
        for <linux-edac@vger.kernel.org>; Wed, 23 Mar 2022 11:30:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdbZSgWFpoz7VUZ/gbIkCM4ppD9RM79OtczJZ1FkNR4Pz2l6i5wnstBLu1BSBcdcYO7I5Ov0/3yVUJNp+uAg4DkEN93xopnNekCucMgm1N9M8G45AIcVo8jzJqQMM/r1PUrIEMq3Qq5Sz070oFhV9o0zklaWNPSAvSJeEwD7o/+qL49Fs5WExG4T18TlqEl0lJBjoEUlbCnmqItD27vLSqHURey+J7iRM2wSZ13FvpRPf/owObix2w4FT8hPdMEd5KH2mwwkeu3jDRv+zPtzuIHe7FH3PO95YHU0WhQOtdJ2RXDHl1IgvchxQM0JBcK6zR6G5rvD3kunO97SeGUj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbY5QOfvaU6IUcOrSXR5HVEPu80gPy/diOkvUJguk6A=;
 b=I3Nmd1M4T/fRXEocfl6TOsAi4xuO9Xy/Zn9fhfglFwCz91TB9pOiZ617yY1GdzsKH4lRhL1HSVZLeyynZTkViKqjcpubjKTW284U4u89p2DFS99v7sve9lBe5vRzuigsteZUpzxK1yF1UjjHd7o8ivU+yleE7s0BQ7upc8fpDf8nw/Cy4y0kS0SX71nNS56F+S8EAFYf0/9fNh57muN4NsWfSodl4BWLkxXWh49CKAzN3boKAduObziSJt53sCg5s5gOK/b0oSp7VupRGmu2B6TIaFuPxx56x2iHbhODnT7PSkZXZgBhI4B2LaB829b96Mt0gzOsYdtc2gw5I7/9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbY5QOfvaU6IUcOrSXR5HVEPu80gPy/diOkvUJguk6A=;
 b=uXtvSSUmzVGAGAIO0EatR3LUuRwv8FRd4MNOdhTIco524I0Yt22Lolnhvyu/OaycbDKzUg5YQyylSb6iw6U2jUGe6joRkfznou6s3nNN35zBIf54gTZQEhse5pEkVxC03NWDZGa2CO9mbbtMjT/YRqjWbTB7xFhy44JAmFmyqQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SN6PR12MB4671.namprd12.prod.outlook.com (2603:10b6:805:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 18:30:36 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0%5]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 18:30:36 +0000
Date:   Wed, 23 Mar 2022 18:30:28 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 05/14] EDAC/amd64: Add get_ecc_sym_sz() into pvt->ops
Message-ID: <YjtnRHQV99cc3PIj@yaz-ubuntu>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-6-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228161354.54923-6-nchatrad@amd.com>
X-ClientProxiedBy: MN2PR22CA0015.namprd22.prod.outlook.com
 (2603:10b6:208:238::20) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df286026-7d02-45a1-2926-08da0cfb3909
X-MS-TrafficTypeDiagnostic: SN6PR12MB4671:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB46718403B6B2678ADD5D8474F8189@SN6PR12MB4671.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B18gOWxG3XGQHuhBswSEMSaEuEo59Gu2eUaK/KRX4EKAfuyzn7AZEj/IsHWP+DqtGyVQxbCG24pltviTJdWthX9vXlZNwqqRj7C5vFeVpGc6H9KJ9JZodoAsc+6IXw4JFtHmsjmgEsjH7zccnxCpVoFlkuhswJdSbHaHA9bOBT197BOQw9MsP9YNW8cUR6VHZkMHDoPuOi+b/zhntLG551w1g9yIV21tPLJsNhHgFLDRQHxYqCoHSler4v0tSiNRvbi81etHw+I/HQhGGXvo4WL80x9xZ9i9XnH77NoSUMec8c2pFoc5T3pL8nSAiGmRZSX6UMkn6Hv8oiCrjE0TN3yB7aOoSA4Nhw13ha9Qlghm2trfZLZznDp4WoPlMYRlZpRsxVOV/v6TUMosfrEFTvZ4EB4l0ZBOEJiiPw2ZeMtcbehcCdY4TBCxJm2Uzyo+UoePnZlHV1i/4T49rR+RpS6lVl+ueKkRN0YTlv+I5AV5qZj1ELwAYBLXws7DBxKAZ7vWZ68NuNq1vRBMJV5a+nABCFh2DaOcU8P+5Gg/YHK3BYPUVwAvlunMBvnBZFJeYZGffBE1ukCUsR5v0eWrGHgEuEjmvpqCD5DxP5Hhwc+7mW5rS6iH/xHrt2OC7Bsq6S5uShbX4u3T5BgX9SzaQBNqZYDKdDdAIThoXV2GjNl/en2GEBkD1/gFcEYLdX8n0Xs7dBWaUu5GeUCX740OOHVoXokzWghVLjN8HCBGQns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(5660300002)(8936002)(44832011)(6506007)(508600001)(6486002)(966005)(38100700002)(26005)(186003)(83380400001)(2906002)(6666004)(6512007)(6636002)(9686003)(86362001)(8676002)(4326008)(6862004)(66476007)(66556008)(66946007)(33716001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2MOj7uosaBzqSZ128y+C1Oueh6aa84ijQnSWl1o0EJ3ubsMoJs5keOHoB/fw?=
 =?us-ascii?Q?3hyeaN86c6xZSRpiXC8kLkotwhZkc9DMytr0jRDp4McQknT3PDZaH7BWjXCB?=
 =?us-ascii?Q?ISaGEXUOf597w++F5aqnMTLiyWbbOPlGut8eOd7vNsCZQhJ9xDcUSXZiDL+r?=
 =?us-ascii?Q?eMq4sXaH/+wtGhCOVKoCv02BYcof8HkQCjh2usF+IsGimJ1YUE/m4bMutGJi?=
 =?us-ascii?Q?7K5BVoh+XiNu29G5xCZ92fBlVoe3p9L/RTbfOAdDzrBL1OJEt0PDzmKieD4R?=
 =?us-ascii?Q?bI4FN+R3kBOWl6IMHdRdD9lyF1cY71HF9X7r2LnwQYWY7kh2FyTgXd2+6M4Q?=
 =?us-ascii?Q?1kIRGGb/wkcgYDQNUF0mlx4Y3Fu4TEzUjyTQJb1C3daNPRw7rXt1g3kWBRJV?=
 =?us-ascii?Q?wqJ4Xy2DLKXyYgvO+3xA8jeqf4VX+D0fbe4o3eu7pE4xr8kcGEvaDRlirzFW?=
 =?us-ascii?Q?S9WzHjyjA5Y4fnwyY+N0VZmSBLpUi7mamzTjtb8qSt3fKei5ocjaUKoQE6TP?=
 =?us-ascii?Q?6i8O3qz6psIbDg64F8d3ktqeaJKsVQQ8+U1u1mhYk8HnhyM0W444r9irb3TG?=
 =?us-ascii?Q?rtqMs9ZV5FllPcXQbItlMKlzzNpvA4frvLhVeETUPZTG3f4Blb/mU7mm4FUI?=
 =?us-ascii?Q?l00YpPM9S5gW2raC/yI8qHAFfd3KKwvJuRkCyulVdvbHuyW1SmK8ixo4RM9v?=
 =?us-ascii?Q?7Iyc3K1xW+PONUMg7aobjiWzujhDjmhIizfvPTofeO31FRc66MXRPxAQR+wg?=
 =?us-ascii?Q?AUkRJc0DCFglVpl27olJvA0hdCoq4B7CXkF2PwrWeT0bSfn546/rHvf8ONBP?=
 =?us-ascii?Q?+MmfQnL3z6s/9etiaI6+vPLjMZYSqlJhzItONyHOX2JG7+zid8mdhtvwG0ML?=
 =?us-ascii?Q?O9ByP2lO/BCmKtaqrohK05Gy4QA2nKxOgUj5VofNVDu2WftMGHq13D7pFUJL?=
 =?us-ascii?Q?eDKBl6IkdTY2eCdXwGundzwQ4fPwDi2zXqIPf7etK7EbYUcZKO84hWSbh4ec?=
 =?us-ascii?Q?qQ9spw/WRSCGozMk8KkmSSxTaNPTCs4ik4+e0JKsJYmO+y29OQqLQj6FDXV1?=
 =?us-ascii?Q?CISa3je/KVEJoL6sACBbA3OA2M3oyqK6e2UlvhE3sDD73EeDO2IzRlNuqpM5?=
 =?us-ascii?Q?oZpgrqmsaE26QVAzXKdCnIGXEEfv4MAYbpNMqeLVLyZH+YI2vM/DFbpF1SdV?=
 =?us-ascii?Q?T0GPVujxB2fzzF792jkhtypy0z8vB7S/+U37bPhIIXYwZJJC21sVLIVhXH72?=
 =?us-ascii?Q?beSRaZUSId0pQA2h7Vd9MN4f4meKEwiq+oYLbuHPukkyw04+RAOq1yCR0j9B?=
 =?us-ascii?Q?iCWqukuh3wb/5GzV1hk0uVyyKKe0qRAnExlgCSjGLww4Z+cFU7l1WmVnaN+S?=
 =?us-ascii?Q?J88l6Z9ctTu7BY4I9y4oRVa4j8WwwfYJ4aU/x7y79E/xviyC8oWDoFS96Xi/?=
 =?us-ascii?Q?/TxKMtku8EAwh5HAbiKYRu22VKp8y0wh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df286026-7d02-45a1-2926-08da0cfb3909
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 18:30:36.0978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: juW2/GNUmTUbNwNrK3LbjooHWuwPAeOBQ9ekXmh3XXWt3k/o5BqF9+GUGJf4CS9RxVUFUX09b4moFV6Ld3jJuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4671
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 28, 2022 at 09:43:45PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> Add function pointer for determine_ecc_sym_sz() in pvt->ops and assign
> family specific get_ecc_sym_sz() definitions appropriately.
>

Please include the "why".
 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
> This patch is created by splitting the 5/12th patch in series
> [v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/
> 
>  drivers/edac/amd64_edac.c | 49 ++++++++++++++++++++++++---------------
>  drivers/edac/amd64_edac.h |  1 +
>  2 files changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 07428a6c7683..69c33eb17e4f 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3176,26 +3176,11 @@ static void free_mc_sibling_devs(struct amd64_pvt *pvt)
>  	}
>  }
>  
> -static void determine_ecc_sym_sz(struct amd64_pvt *pvt)
> +static void f1x_determine_ecc_sym_sz(struct amd64_pvt *pvt)
>  {
>  	pvt->ecc_sym_sz = 4;
>  
> -	if (pvt->umc) {
> -		u8 i;
> -
> -		for_each_umc(i) {
> -			/* Check enabled channels only: */
> -			if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
> -				if (pvt->umc[i].ecc_ctrl & BIT(9)) {
> -					pvt->ecc_sym_sz = 16;
> -					return;
> -				} else if (pvt->umc[i].ecc_ctrl & BIT(7)) {
> -					pvt->ecc_sym_sz = 8;
> -					return;
> -				}
> -			}
> -		}
> -	} else if (pvt->fam >= 0x10) {
> +	if (pvt->fam >= 0x10) {
>  		u32 tmp;
>  
>  		amd64_read_pci_cfg(pvt->F3, EXT_NB_MCA_CFG, &tmp);
> @@ -3209,6 +3194,26 @@ static void determine_ecc_sym_sz(struct amd64_pvt *pvt)
>  	}
>  }
>  
> +static void f17_determine_ecc_sym_sz(struct amd64_pvt *pvt)
> +{
> +	u8 i;
> +
> +	pvt->ecc_sym_sz = 4;
> +
> +	for_each_umc(i) {
> +		/* Check enabled channels only: */
> +		if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
> +			if (pvt->umc[i].ecc_ctrl & BIT(9)) {
> +				pvt->ecc_sym_sz = 16;
> +				return;
> +			} else if (pvt->umc[i].ecc_ctrl & BIT(7)) {
> +				pvt->ecc_sym_sz = 8;
> +				return;
> +			}
> +		}
> +	}
> +}

We should reconsider if this is needed. The ECC symbol size was needed on
legacy systems to decode the syndrome. The MCA_SYND register includes the
syndrome on Zen-based systems, so the symbol size is only used for a single
pr_info().

Thanks,
Yazen
