Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D2340F754
	for <lists+linux-edac@lfdr.de>; Fri, 17 Sep 2021 14:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhIQMUX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Sep 2021 08:20:23 -0400
Received: from mail-mw2nam10on2086.outbound.protection.outlook.com ([40.107.94.86]:12265
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235119AbhIQMUW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 17 Sep 2021 08:20:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjNshWxuEI+4wpnq53RrZyb4c9/OcVTLsfQkvcT6nYhcoso8jQD5WD7mafk70HDji4G9PGzZEg7V5+eSTzKm0psPy+lrXnNDYbzPagU/AECJIqDAk4cwZqwRYhcB3FjtiqMagP3UiA6ymCrl6RDeKHUE3zNzRvXgHTEuFhjGOIbxOm5kxxZSmnOznK5FN5BoxymQx1IyXD8Z6ynAusYDvwlPWg/ACnrrBKctQ0BG0Tatf/pwL4oec3DUOkjAg1E780ERkO1PskU1snZi2k9tkI0TcOvFcQCPpD55dKeTqHPPY/867bTDilg2ghpL3Fa5ag9RBgjewAKcVidB6cUHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PObEHiMhYMRWpr2lwO9+OYWibr1vEcGUaryIB0BNmIg=;
 b=HFZwjYL672fQTKtITZdVw9ksAcyICU+zpO2tiwQYCTA+v8+PEaBqdKsHX0wLxdRRVumflnXZqKv4/FpKNja5QscEFUIPfLbdCbLqrzZe3s4ire/UYM6DaFWWIr2+2duZd2QcnbM7KEgh/KcgQvcRaOVPsrOg5zGiHt2RG4JkF/kct41p2tchHPKhY2NUqdCW11vc1y3IWJNtfspPFgs/S+DhOWCMAQ4ootzNhnF7rG/3GOuH9TVAQ9deYZGd95AibVvUNXapfKcE9VDsP4gUWOAADo+3y3byZLsp/Fp/k80ZaOF5flgl+p3EjZdbIPp4y1Osge9M9RrqQJOQyd+uxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PObEHiMhYMRWpr2lwO9+OYWibr1vEcGUaryIB0BNmIg=;
 b=K9aSbVhlGDSWiw20aV9UyWcsXvCIR3vSm9bnZvxfHT7G+LWmcqW+YQjboizPP9z32+iYxuw0vAmnc71z8MCzHqdXEdCZWPRTvhMYLC0Yb4RgTrkjde+iq1aebJE940EiOvuQLNhZ0vBP91OmpIdt0qmRp+U/1Zn+wWypydsSvgM=
Received: from DM5PR17CA0060.namprd17.prod.outlook.com (2603:10b6:3:13f::22)
 by SN6PR02MB5264.namprd02.prod.outlook.com (2603:10b6:805:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 12:18:52 +0000
Received: from DM3NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::a) by DM5PR17CA0060.outlook.office365.com
 (2603:10b6:3:13f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 12:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT027.mail.protection.outlook.com (10.13.5.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 12:18:52 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:18:51 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 05:18:51 -0700
Envelope-to: linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 rric@kernel.org,
 james.morse@arm.com,
 tony.luck@intel.com,
 mchehab@kernel.org,
 bp@alien8.de,
 dinguyen@kernel.org
Received: from [10.254.241.49] (port=55210)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mRCpP-0001Nb-3I; Fri, 17 Sep 2021 05:18:51 -0700
Subject: Re: [PATCHv2 1/2] EDAC/synopsys: add support for version 3 of the
 Synopsys EDAC DDR
To:     Dinh Nguyen <dinguyen@kernel.org>, <michal.simek@xilinx.com>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rric@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
References: <20210916231231.1430499-1-dinguyen@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <6ce8ffb0-8401-f09a-433b-143dad774410@xilinx.com>
Date:   Fri, 17 Sep 2021 14:18:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210916231231.1430499-1-dinguyen@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f98d8ea6-c708-4a66-3549-08d979d54fb1
X-MS-TrafficTypeDiagnostic: SN6PR02MB5264:
X-Microsoft-Antispam-PRVS: <SN6PR02MB52647FDAFCF8B53AD4D3DAB2C6DD9@SN6PR02MB5264.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjwapB35skHAaC4pIyyhZCjbS0ztrRlKEYH8gPoZ32RKxpgravdowjPiqwGx/teiG5HmQsN74MPzYEmVtaID073ksUA5oU9Y8JWNmo2Ueh3ml3eHAgx4IeO/cezFP5QNasFsml68fk1sNZABeQiLwlqpI8B4OGB9F29OQs6ZOpVkCNZaL2M+4+jYd8zs/jCEbtxzNzBT8yM+F60L7PIUdCvRNlDiLMGAE3shd15PhpR4IK/Ju7fng5o8i5O4lruGci+tnNohkUKFMNEuDVPLmHWLcx0GK3L39WazEYv6qW3IXsSyCL1dh4L5hm1v/E3nrLnpJf4YXGBTYnOHsgnmDkpW5I2h4p5jC1FmqqEvlDNho0Xlm/cwJIPXIa35jlunpsvCFjKyGlKjJ2XiLHodduGqJVGewmeH17m+6go2ILQwVig47HaUzgFLL9qtOOS7G69TkZDqFfWvgrdIRCrndAsU3oNIwf/8XgncDR5yeFFkB5in2HOTdVr1UQeuvepPaLL2B5ArGC4ElR6GrzBJjhalz9N1bg3nKzzIq9UMDs4Q/on1w9eg5pVIE0bKVRbg/JdBfS7JVvZHK9ZVegc75xntjMf+1kE3zTpiSAQM4s6Jj79mV/BZuQnczDgXwXAtLR8gNu1T0bmTpcruPvORa/kgLw8RhPfThhG0If58/saMvfvPejRM6uyRUWJa2n+vGJZHA2Cm5YPhskLL1lkWAb1ME/tGn8Pe0tub9zOOGilqvYt+jN+kc5icWw9yQV5KCSMMV/yAslvcbu2oYCQaOw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(46966006)(36840700001)(83380400001)(5660300002)(2906002)(478600001)(54906003)(53546011)(336012)(2616005)(36906005)(426003)(110136005)(356005)(82740400003)(47076005)(26005)(6666004)(36756003)(31696002)(8676002)(70206006)(70586007)(44832011)(31686004)(9786002)(36860700001)(4326008)(186003)(316002)(8936002)(82310400003)(7636003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 12:18:52.0744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f98d8ea6-c708-4a66-3549-08d979d54fb1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5264
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 9/17/21 1:12 AM, Dinh Nguyen wrote:
> Adds support for version 3.80a of the Synopsys DDR controller with EDAC. This
> version of the controller has the following differences:
> 
> - UE/CE are auto cleared
> - Interrupts are supported by default
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v2: remove "This patch" from commit message
> ---
>  drivers/edac/synopsys_edac.c | 53 ++++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 7e7146b22c16..297845e65b65 100644
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
> +#define DDR_UE_MASK			0x200
> +#define DDR_CE_MASK			0x100

Use BIT macro or genmask for these.

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
> +	 * v3.0 of the controller has the ce/ue bits cleared automatically
> +	 * cleared, so this condition does not apply.

cleared is here twice

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
> @@ -1352,8 +1387,8 @@ static int mc_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	if (of_device_is_compatible(pdev->dev.of_node,
> -				    "xlnx,zynqmp-ddrc-2.40a"))
> +	if (!of_device_is_compatible(pdev->dev.of_node,
> +				    "xlnx,zynq-ddrc-a05"))
>  		setup_address_map(priv);

would be better to create quirk for it. You have the whole
infrastructure in place that's why it should be easy to do. (In separate
patch please).

Thanks,
Michal
