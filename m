Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95E3219A9D1
	for <lists+linux-edac@lfdr.de>; Wed,  1 Apr 2020 12:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgDAK5Q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 1 Apr 2020 06:57:16 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:20956 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgDAK5Q (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 1 Apr 2020 06:57:16 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031Ap8kj001320;
        Wed, 1 Apr 2020 03:57:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=GwXIQssCDzjW8cdZ/H1blYoVYQGnk/0Qq7aRuYxm6Og=;
 b=bM4gwuyrO+gkI0VhwZDg+jpUxJt9eCWt9ny6Vc71aSZsS5Gh8rSYZkEGfloJwptI59z5
 xWnEQ2kFO7l9CTHg5cSem2LJ5okiyKR/TGgR5O6YMvjM8S9yZjkl91kBw4woCYtXJFRK
 TPsl3mWIJLrmXMSvZKkutTlOBn6KWyj6rHBfuOD5pD7QQvQqNYFlxzpu6giMcOzxRHHd
 iiVIlYx8DqkWDAFNSKbPhG0YCdBF+nXTxBEYY6XyrodG40FmjUp5zKfX2TvoHXxSUca4
 2wYierLPUwjwwI+NJhnoUoNTO/XEjXhKZ0ezbcy3eH96BxzmP6UZuerxMRJUXvHhG53W xw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 304855mm6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 01 Apr 2020 03:57:02 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 1 Apr
 2020 03:57:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 1 Apr 2020 03:57:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2fvobyVC/0G/g0XZsyuETLuv2yOUei7BP3Qff4sTcrcDjnXPjCPY4gpjH1w3xgfRQ/4L/87gJGyjewvmtWKQUshTMDS7SsKKEOaJZFD6xi9MYf65xFJdkSHJYwlP99ESe6Qw9oihTsV15Yc0DfajLjlHOfIf83dWmfqdUpwMINLyfMPSCRyfuT7NlmymXGEyJ+EZ3H2Ei+xTi3ppZsqyVFaV9b1VEW+RDNF74FuzFKek4Xd9R9pHspD3p/hMJbgoE3MlBJZOcB9bW11tc+xw3XJcZ+eKBVMDQ6Z3gCxwDkWQc4NboyZG38++Nf6QnD+jBzt7PXNxGb34EnxAEjqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwXIQssCDzjW8cdZ/H1blYoVYQGnk/0Qq7aRuYxm6Og=;
 b=NwNeYcoOYH/kWbP0Z5HwH6EJ4h9+qw5K16DmTUA2g4OgV8GbiVJojgkUDyzmHF4juwX2SWZEtaiX48FSnT8ppXHSTBH9VUkPqPZ9A7nTWR6kw+1THOaVBMxOBE+to4LhlosNsDaVO8H3O7XhmDf00yOzV5RnBQnVJqp+85qJAeZWnsg7hHGW+jBHtMG6BQ55ph4u89P3ITSgafPzK6iF1oUAkfin2vHIUZQZd3G2PnE4Qz7MoTkrPLzT5D1Si6TAORZRFohrhykEY+zt9n7VszGc23gy8D9pAzF79CwDncwsiiBN7cSMjJatxVHX+l/PubVLDG59t17mxY/97M202g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwXIQssCDzjW8cdZ/H1blYoVYQGnk/0Qq7aRuYxm6Og=;
 b=KyxmGmpIRtIhF4JmibztbuLxpudoqENfGevUIStuKLwBnfkaiASK6CK2BUnajE2qr8otj/y5tMPPYB0x3edM1y2RuiuOEnT12/A25sRortWsF+m7PVwUUZTLfJgzzXe/CExSenCnpo5v8Ia4tFbhcrtSeLjN7WJsvQg6y6LXI4U=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB3045.namprd18.prod.outlook.com (2603:10b6:a03:112::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 10:56:58 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::78a2:38df:6c52:a953]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::78a2:38df:6c52:a953%3]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 10:56:58 +0000
Date:   Wed, 1 Apr 2020 12:56:47 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Sherry Sun <sherry.sun@nxp.com>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <frank.li@nxp.com>
Subject: Re: [PATCH v2 4/4] EDAC: synopsys: Add useful debug and output
 information for 64bit systems
Message-ID: <20200401105647.hszgxzt2uedqofth@rric.localdomain>
References: <1585726749-13039-1-git-send-email-sherry.sun@nxp.com>
 <1585726749-13039-5-git-send-email-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585726749-13039-5-git-send-email-sherry.sun@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:7:66::21) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR07CA0035.eurprd07.prod.outlook.com (2603:10a6:7:66::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.9 via Frontend Transport; Wed, 1 Apr 2020 10:56:55 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3a16273-8ca5-40df-75e2-08d7d62b65f8
X-MS-TrafficTypeDiagnostic: BYAPR18MB3045:
X-Microsoft-Antispam-PRVS: <BYAPR18MB3045FACE904791BCA1205C5DD9C90@BYAPR18MB3045.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(9686003)(86362001)(26005)(6666004)(16526019)(956004)(52116002)(2906002)(81156014)(7416002)(186003)(55016002)(1076003)(66476007)(53546011)(81166006)(478600001)(8676002)(4326008)(316002)(5660300002)(6506007)(7696005)(66946007)(66556008)(8936002)(6916009);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a7RU8o6lJ0hQ1fnoCa69LBJO7KQ6hSaaxD+ok8Ma8/AOvNHkhEwhNWyq+m6SMTJYBzPbgFaXXbxgiWjmLi9BFV0Mb9CEx6rihrQrERjptGunW+JUaYlM/k7Z4z0RDeyjGww5VNsclkDFweBM2nNkuxlm5abhUerCpCQVTO7dyP8WVu55MGRjEoVQTyeA97Im3L1bFUtGJX1peZJCS3exmOd6WL8RpwHR01EcyEw1tcGS7xKGj3kBsn2w5dSKQWTRq5EG1f48qgnR2oeZZ5mQICUbGpGFwZij93jV3V4VfxpXzAZoPmtk6NhOPDedg5cedskggw5/WLWm4E+zLhVBfxldv8EY1kCK+vS2iIZfygFt5MUQk36l/Rr3HFVo1feIWhJ/YiuzoUw7nts23cuHDCr33hUmpmd6iZEj2zfhvc2SszdUFbkxr/cOHdGYj50U
X-MS-Exchange-AntiSpam-MessageData: 9k1faLd2SNRl/DvseVZQPBEbboLoVKmYysh6ao17F702LtSLa5Zk1sYLbC6EdIothXSlrt9NFTgDpWDipHfgnK7EkeI9danKBUZ2nq/xyHkcqCS8OreGbkevdkb8Jg2wc9oSOJ7BaaUyErSpXwuWCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a16273-8ca5-40df-75e2-08d7d62b65f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 10:56:58.0213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSwU3umA+cicZtGU7kt08coAKlkLP5TQuK/Sr5f02XMEcsm8MwM8B/aJ0g8a5Z+TUPGpgvbGPDLYVFgYFIXamg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB3045
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_01:2020-03-31,2020-03-31 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 01.04.20 15:39:09, Sherry Sun wrote:
> Now the synopsys_edac driver only support to output the 32-bit error
> data, but for 64 bit systems, such as i.MX8MP, 64 bit error data is
> needed. At the same time, when CE/UE happens, syndrome data is also
> useful to showed to user. So here add data_high and syndrome data for
> 64-bit systems.
> 
> And in order to distinguish 64-bit systems and other systems, here
> adjust the position of the zynqmp_get_dtype(), so we can called
> this function to distinguish it. To ensure that functions of the same
> function are in the same position, here adjust the position of the
> zynq_get_dtype() too.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/edac/synopsys_edac.c | 182 ++++++++++++++++++++---------------
>  1 file changed, 102 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index bf4202a24683..e8c3631ddff4 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -278,18 +278,22 @@
>   * @col:	Column number.
>   * @bank:	Bank number.
>   * @bitpos:	Bit position.
> - * @data:	Data causing the error.
> + * @data_low:	Low bit data causing the error.
> + * @data_high:	High bit data causing the error(used for 64 bit systems).
>   * @bankgrpnr:	Bank group number.
>   * @blknr:	Block number.
> + * @syndrome:	Syndrome of the error.
>   */
>  struct ecc_error_info {
>  	u32 row;
>  	u32 col;
>  	u32 bank;
>  	u32 bitpos;
> -	u32 data;
> +	u32 data_low;
> +	u32 data_high;

Where are 16, 32 and 64 bit widths. You could handle them all the same
in a u64.

If I am not wrong, the width is fix for the whole mci. So you could
create various .get_error_info() functions depending on the data
width without run time width checks.

>  	u32 bankgrpnr;
>  	u32 blknr;
> +	u32 syndrome;
>  };
>  
>  /**

> @@ -399,7 +467,7 @@ static int zynq_get_error_info(struct synps_edac_priv *priv)
>  	p->ueinfo.row = (regval & ADDR_ROW_MASK) >> ADDR_ROW_SHIFT;
>  	p->ueinfo.col = regval & ADDR_COL_MASK;
>  	p->ueinfo.bank = (regval & ADDR_BANK_MASK) >> ADDR_BANK_SHIFT;
> -	p->ueinfo.data = readl(base + UE_DATA_31_0_OFST);
> +	p->ueinfo.data_low = readl(base + UE_DATA_31_0_OFST);
>  	clearval |= ECC_CTRL_CLR_UE_ERR;
>  
>  out:
> @@ -443,10 +511,14 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
>  	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
>  					ECC_CEADDR1_BNKGRP_SHIFT;
>  	p->ceinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
> -	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
> -	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
> -		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
> -		 readl(base + ECC_CSYND2_OFST));
> +	p->ceinfo.data_low = readl(base + ECC_CSYND0_OFST);
> +	if (zynqmp_get_dtype(base) == DEV_X8) {
> +		p->ceinfo.data_high = readl(base + ECC_CSYND1_OFST);
> +		p->ceinfo.syndrome = readl(base + ECC_CSYND2_OFST);
> +		edac_dbg(2, "CE data_low: 0x%08X data_high: 0x%08X syndrome: 0x%08X\n",
> +			 p->ceinfo.data_low, p->ceinfo.data_high,
> +			 p->ceinfo.syndrome);

You are loosing edac_dbg() here for the != DEV_X8 cases.

> +	}
>  ue_err:
>  	if (!p->ue_cnt)
>  		goto out;
> @@ -459,7 +531,14 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
>  	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
>  					ECC_CEADDR1_BNKNR_SHIFT;
>  	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
> -	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
> +	p->ueinfo.data_low = readl(base + ECC_UESYND0_OFST);
> +	if (zynqmp_get_dtype(base) == DEV_X8) {
> +		p->ueinfo.data_high = readl(base + ECC_UESYND1_OFST);
> +		p->ueinfo.syndrome = readl(base + ECC_UESYND2_OFST);
> +		edac_dbg(2, "UE data_low: 0x%08X data_high: 0x%08X syndrome: 0x%08X\n",
> +			 p->ueinfo.data_low, p->ueinfo.data_high,
> +			 p->ueinfo.syndrome);

Similar here, no edac_dbg() for != DEV_X8.

> +	}
>  out:
>  	clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
>  	clearval |= ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
> @@ -480,20 +559,27 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
>  {
>  	struct synps_edac_priv *priv = mci->pvt_info;
>  	struct ecc_error_info *pinf;
> +	int n;
>  
>  	if (p->ce_cnt) {
>  		pinf = &p->ceinfo;
>  		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
> -			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> -				 "DDR ECC error type:%s Row %d Bank %d BankGroup Number %d Block Number %d Bit Position: %d Data: 0x%08x",
> -				 "CE", pinf->row, pinf->bank,
> -				 pinf->bankgrpnr, pinf->blknr,
> -				 pinf->bitpos, pinf->data);
> +			n = snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> +				     "DDR ECC error type:%s Row %d Bank %d BankGroup Number %d Block Number %d Bit Position: %d Data: 0x%08x",
> +				     "CE", pinf->row, pinf->bank,
> +				     pinf->bankgrpnr, pinf->blknr,
> +				     pinf->bitpos, pinf->data_low);
> +
> +			if (zynqmp_get_dtype(priv->baseaddr) == DEV_X8)

This is zynqmp specific, right? but you call it in the generic
function handle_error().

-Robert

> +				snprintf(priv->message + n,
> +					 SYNPS_EDAC_MSG_SIZE - n,
> +					 " Data_high: 0x%08x Syndrome: 0x%08x",
> +					 pinf->data_high, pinf->syndrome);
>  		} else {
>  			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
>  				 "DDR ECC error type:%s Row %d Bank %d Col %d Bit Position: %d Data: 0x%08x",
>  				 "CE", pinf->row, pinf->bank, pinf->col,
> -				 pinf->bitpos, pinf->data);
> +				 pinf->bitpos, pinf->data_low);
>  		}
>  
>  		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
