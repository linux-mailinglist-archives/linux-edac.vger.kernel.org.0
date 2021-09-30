Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A47141D654
	for <lists+linux-edac@lfdr.de>; Thu, 30 Sep 2021 11:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349353AbhI3JaS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 Sep 2021 05:30:18 -0400
Received: from mail-co1nam11on2046.outbound.protection.outlook.com ([40.107.220.46]:26656
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235943AbhI3JaS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 30 Sep 2021 05:30:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMLVclE4UklgwemhUufpJNHRCFR2anDoIdStdYFVfm3z1a6/nzHlMrK/61PWNqbVhdYs9LiHONfqYx4cE9NKFr7KjWDLUj5DMf6+jwo035X5+/Fs5gIuMVb9axTszlspwoixnMTI89wUyEQhm6wgl41sfX9OMS60vulOrs+GQpIKow9M/OdF0BJ4cJzBte4FvclOrXHeu+HqhQ1WscFwP6nWtvraakMgd8uapBCzqKRdxkIDIdpCOJsQ+5yKh4uOh7iwOFAmZJe2+6szi+mxn8fAyC5CQGGj/ZUpGhJ6aqzJIh3iS8ZQousDvZEfZDtiujIlwZqIiT3gGW4DmmrjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1N7GA6Pz6eUuOGdJmHjuipwmowhhYzpCWRRdnJ8rw1k=;
 b=gSABPnz4ph6yILXxqbLhvtcHNhYkYuCQFnN4GH2z61/CFRfJuvObLJXMz1bsegpe1DG1L6KYJN/uAbg8whKg2HPEthOLrz9IjwrvPGukGRQKC84ijxwEnKNHLay3dsnDuAFPWb6PNPpYG2v86XMdwnbp9HvKboxCTir21F3wCXQ7LQMOKWOGyEAToM/58fDWQv2NUZtn/YugwsM5t5SMxdZBchBDydpcY6iS1VQCnESi4lMNA0u8DkTK5UsULZB79M+2I8iZD0S7R2eLK4CO8hXtVbAvomNvefJdKU/qGMsmx4w1pbG8Bphh5tnCdAGV2Gc7SmjSzGoHtHdVFsGrXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1N7GA6Pz6eUuOGdJmHjuipwmowhhYzpCWRRdnJ8rw1k=;
 b=dHTlbPclQBxCotLeN9xvKC1CvPJ1ES9EXr5urLo9ksDiAY4mh9soj9/0gVkvT0neIdqg6yw/gwx6Zp6aNVdz4j0CGuCbhg8tmRSriHH0SD6hyuMf1AC5g3QGSka6i18PbaOJ5GxxjCbftl/qA7xS8or6oBTrjHZpiGJ9AC1NCic=
Received: from BN6PR1201CA0014.namprd12.prod.outlook.com
 (2603:10b6:405:4c::24) by SN6PR02MB5215.namprd02.prod.outlook.com
 (2603:10b6:805:67::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.22; Thu, 30 Sep
 2021 09:28:32 +0000
Received: from BN1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::31) by BN6PR1201CA0014.outlook.office365.com
 (2603:10b6:405:4c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend
 Transport; Thu, 30 Sep 2021 09:28:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT037.mail.protection.outlook.com (10.13.2.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 09:28:31 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 30 Sep 2021 02:28:30 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 30 Sep 2021 02:28:29 -0700
Envelope-to: linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 rric@kernel.org,
 james.morse@arm.com,
 tony.luck@intel.com,
 mchehab@kernel.org,
 bp@alien8.de,
 dinguyen@kernel.org
Received: from [10.254.241.49] (port=35944)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mVsMf-000BQE-J7; Thu, 30 Sep 2021 02:28:29 -0700
Subject: Re: [PATCHv3 2/3] EDAC/synopsys: add support for version 3 of the
 Synopsys EDAC DDR
To:     Dinh Nguyen <dinguyen@kernel.org>, <michal.simek@xilinx.com>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rric@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
References: <20210928160423.271187-1-dinguyen@kernel.org>
 <20210928160423.271187-2-dinguyen@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <99ddd699-5fa4-068b-4648-fe6d34a36b5d@xilinx.com>
Date:   Thu, 30 Sep 2021 11:28:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928160423.271187-2-dinguyen@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75382082-b4b8-4a5a-cd9c-08d983f4ab58
X-MS-TrafficTypeDiagnostic: SN6PR02MB5215:
X-Microsoft-Antispam-PRVS: <SN6PR02MB521559E2D8712E5906F823F2C6AA9@SN6PR02MB5215.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2guwZXss0q+5+80E2rDtolz4BDq4RG+OSyt5gf4vG9zZU1UdJdoBMSB5y/KWB61Mf2hXKHrrtp3wyWzmMx7rCFgxbYr7KwC1Ipuwmc+hxS0v3gfKmbr/ZJQTKO3LwX26xwJLvyT7KDAiJ2OSoRU304RLg3OTARLFcugUq0VWODi9HiSBhpDokCbxK/yif5iGwGSfXMswWNablyq9n8Idz0kKjeVzhTgJaQbAckl/blxeSWfIbRwc9id/ivfe6IKoPu67wm6joiUgTzyXfY+6zX0XhhmhAj76DGzPBR/zUjb5VmYm09/Cs++z8dXl56uJWvOyuJQuhk85RriMN8JnNvrqVwg21qy822qATuZpLctPWqbMJqqpnozic8R+VaNi0pSFBlcy5CouF1zj+X2GBP+lFp3ORxNdYEkgjzT6T+qcoJPU+fGGy/iGLYoNmM9o4G8qeKqFt2Kvw8uKOpljFkkrk3Ojx2kCJ5vopejYI7XQl3Up0cPm6R59Pp88FynPOrfsv8J76I57a1zrFzFSTNjtUpgrBz6odSiKv9FNxL3kzLvctu0JSf+KpnE1EIgo8BljoKrfm1j0Sp6LP4JxZaxAVKT7mOSldzKzygJYCsZB8u5F8H5sc377sk3gLbfzabwOocnYphl/9rw1KMjB3b0oWYfGOZvVxTrCgxgobGSbgGD2OsFUx96QwRLWK/1tBolskEAyJyB9X6sq0yMd82HbvCVfYtvEIXHa2L5xToFFvqNCYtRspBQ4ad4jmJue
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8936002)(8676002)(426003)(4326008)(336012)(70206006)(9786002)(5660300002)(36756003)(70586007)(83380400001)(2616005)(36860700001)(53546011)(82310400003)(316002)(44832011)(47076005)(54906003)(110136005)(31686004)(2906002)(7636003)(508600001)(31696002)(356005)(36906005)(26005)(186003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 09:28:31.8219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75382082-b4b8-4a5a-cd9c-08d983f4ab58
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5215
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 9/28/21 6:04 PM, Dinh Nguyen wrote:
> Adds support for version 3.80a of the Synopsys DDR controller with EDAC. This
> version of the controller has the following differences:
> 
> - UE/CE are auto cleared
> - Interrupts are supported by default
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v3: Address comments from Michal Simek
>     use bit macro
>     removed extra "cleared" word from comment section about v3.0
> v2: remove "This patch" from commit message
> ---
>  drivers/edac/synopsys_edac.c | 49 ++++++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index bf237fccb444..66ee37ea0acc 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -101,6 +101,7 @@
>  /* DDR ECC Quirks */
>  #define DDR_ECC_INTR_SUPPORT		BIT(0)
>  #define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
> +#define DDR_ECC_INTR_SELF_CLEAR		BIT(2)
>  
>  /* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
>  /* ECC Configuration Registers */
> @@ -171,6 +172,10 @@
>  #define DDR_QOS_IRQ_EN_OFST		0x20208
>  #define DDR_QOS_IRQ_DB_OFST		0x2020C
>  
> +/* DDR QOS Interrupt register definitions */
> +#define DDR_UE_MASK			BIT(9)
> +#define DDR_CE_MASK			BIT(8)
> +
>  /* ECC Corrected Error Register Mask and Shifts*/
>  #define ECC_CEADDR0_RW_MASK		0x3FFFF
>  #define ECC_CEADDR0_RNK_MASK		BIT(24)
> @@ -533,10 +538,16 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
>  	priv = mci->pvt_info;
>  	p_data = priv->p_data;
>  
> -	regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
> -	regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
> -	if (!(regval & ECC_CE_UE_INTR_MASK))
> -		return IRQ_NONE;
> +	/*
> +	 * v3.0 of the controller has the ce/ue bits cleared automatically,
> +	 * so this condition does not apply.
> +	 */
> +	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)) {
> +		regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
> +		regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
> +		if (!(regval & ECC_CE_UE_INTR_MASK))
> +			return IRQ_NONE;
> +	}
>  
>  	status = p_data->get_error_info(priv);
>  	if (status)
> @@ -548,7 +559,9 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
>  
>  	edac_dbg(3, "Total error count CE %d UE %d\n",
>  		 priv->ce_cnt, priv->ue_cnt);
> -	writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
> +	/* v3.0 of the controller does not have this register */
> +	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR))
> +		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
>  	return IRQ_HANDLED;
>  }
>  
> @@ -834,8 +847,13 @@ static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
>  static void enable_intr(struct synps_edac_priv *priv)
>  {
>  	/* Enable UE/CE Interrupts */
> -	writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
> -			priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
> +	if (priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)
> +		writel(DDR_UE_MASK | DDR_CE_MASK,
> +		       priv->baseaddr + ECC_CLR_OFST);
> +	else
> +		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
> +		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
> +
>  }
>  
>  static void disable_intr(struct synps_edac_priv *priv)
> @@ -890,6 +908,19 @@ static const struct synps_platform_data zynqmp_edac_def = {
>  			  ),
>  };
>  
> +static const struct synps_platform_data synopsys_edac_def = {
> +	.get_error_info	= zynqmp_get_error_info,
> +	.get_mtype	= zynqmp_get_mtype,
> +	.get_dtype	= zynqmp_get_dtype,
> +	.get_ecc_state	= zynqmp_get_ecc_state,
> +	.quirks         = (DDR_ECC_INTR_SUPPORT | DDR_ECC_INTR_SELF_CLEAR
> +#ifdef CONFIG_EDAC_DEBUG
> +			  | DDR_ECC_DATA_POISON_SUPPORT
> +#endif
> +			  ),
> +};
> +
> +
>  static const struct of_device_id synps_edac_match[] = {
>  	{
>  		.compatible = "xlnx,zynq-ddrc-a05",
> @@ -899,6 +930,10 @@ static const struct of_device_id synps_edac_match[] = {
>  		.compatible = "xlnx,zynqmp-ddrc-2.40a",
>  		.data = (void *)&zynqmp_edac_def
>  	},
> +	{
> +		.compatible = "snps,ddrc-3.80a",
> +		.data = (void *)&synopsys_edac_def
> +	},
>  	{
>  		/* end of table */
>  	}
> 
Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

