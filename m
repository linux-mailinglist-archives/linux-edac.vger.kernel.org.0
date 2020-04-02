Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 464F919BC9D
	for <lists+linux-edac@lfdr.de>; Thu,  2 Apr 2020 09:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgDBHW0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Apr 2020 03:22:26 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:12440 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728425AbgDBHW0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 2 Apr 2020 03:22:26 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0327Elet013637;
        Thu, 2 Apr 2020 00:22:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=Md42puJJAFH/sBQ50npBLuwgDD07AAjSdXrTKV9uz60=;
 b=pw3j5SJYs/or+QnD/1aG6uUjh5jNtHM4pEXNBhg8xLmBJDySwYTIL2j6tFYPBaaPDjv9
 v8lGqnR+onHj43/MjliQfzxGIngwZn9eUKzGW4nKhmU3bP6Lhf/vH5+UdE8c6AFKaWiN
 zHrrOPllf4DXCme1t5X1rIvZYCyMbuAekieZwqOHV65m6hkjpBuvEXERWe7ipVqcTPhq
 MdMc3dpGeVI/VyxZXEZwsqSGo4Kkh0hIPlHExYWMJnvk0Of9gTrx2/oeHnnWFyXR68H3
 0uD83ysLxpmQrRaSqKN+KutHnyWCmkvEn21X+MVZGzKgtj4gmBLXUs+gmp/nvSZRnvKa yQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 3046h618mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 00:22:15 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Apr
 2020 00:22:13 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 2 Apr 2020 00:22:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoXA1RAUrmWtNohym00h5XfTR6YPJyrJlDCgYHOG9q+h7cjAXkt5+LpnLdZlLazMeo0Wrbp10Ys9Xnfe8siZfTk8NMnEbkatzIveJ/SgcNud1+zR8guvBSmhFK5SzVlWBId15F48mGMwHwEQw/f/9lPSA98ic6wgkN74q9tH6z4kzUJuZSTWvx8D+u8CbmmYe7NKoHqQD8IDr2CPlIsgW8LqCmcW5Nbqpjm7NWSVMN7hZ9imMDbbRB9jziOJO0DkacbT8Q96YWNZJrTYXvT1Ko8xt3Wcm8w3lDkzHKE9BB5tRBbayhqgAWd1B/x6TIU7LOyaYcxTDLeln4AH+/5NYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md42puJJAFH/sBQ50npBLuwgDD07AAjSdXrTKV9uz60=;
 b=J2DBTm+UlUmLnQ1HBJCGVq3xWQwwJPx/s6NY8qqpYCgop9Leyao13RQX++RjtnsDSYlRpiZRe+MOseMu0fZw19CUVIYfJhlbHffcy2lzScn7kAWY9uG+Vq4pYN/ipQL+0+5uV8Oe0WEJVEJCfvW+4vdmTLhar0ZJwugFMKjP5aT0DVdZ1ouJ4zGJoTwvmJ0hBjbrQ4puOUmFgWpwFdMrKNcFAYHOgECRYjHHx+ceKFMn6guH+E0QcxCAyN77js8JNEfcpL0oIA8EtaCfue7IlUroFjcqeA93LuC/VzL0kiUoBbxnWjDN2AL96p0GiYxIwcqfywHxlPLUM+AHiw8rbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Md42puJJAFH/sBQ50npBLuwgDD07AAjSdXrTKV9uz60=;
 b=aWrtaKAFajxqNeenI+8RQCMQn+tv/3xN+y1pXl27BhNVER4E+T94U8KyOgn5Tryh43lIzH/99VefEoEkEVlmea+LifzCcw8lzOPiZz0xwfo5FDzT9Ug03pnqhwzKdUJdeHg1B7QYLP/IIl9wCkb+khtXpyd3bnMEHuP6zLcwwg4=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2807.namprd18.prod.outlook.com (2603:10b6:a03:111::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Thu, 2 Apr
 2020 07:22:11 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::78a2:38df:6c52:a953]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::78a2:38df:6c52:a953%3]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 07:22:11 +0000
Date:   Thu, 2 Apr 2020 09:22:01 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Sherry Sun <sherry.sun@nxp.com>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-imx@nxp.com>,
        <frank.li@nxp.com>
Subject: Re: [patch v3 3/4] EDAC: synopsys: Add edac driver support for
 i.MX8MP
Message-ID: <20200402072200.o6c6u3uim6jwopo6@rric.localdomain>
References: <1585790433-31465-1-git-send-email-sherry.sun@nxp.com>
 <1585790433-31465-4-git-send-email-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585790433-31465-4-git-send-email-sherry.sun@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR0802CA0002.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::12) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0802CA0002.eurprd08.prod.outlook.com (2603:10a6:3:bd::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Thu, 2 Apr 2020 07:22:08 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85aa5aaa-defd-40c2-7a53-08d7d6d68f4f
X-MS-TrafficTypeDiagnostic: BYAPR18MB2807:
X-Microsoft-Antispam-PRVS: <BYAPR18MB280733AAD6D098B533D14219D9C60@BYAPR18MB2807.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(316002)(478600001)(9686003)(7696005)(55016002)(8676002)(66946007)(8936002)(66476007)(86362001)(66556008)(6506007)(81166006)(5660300002)(6916009)(1076003)(4326008)(53546011)(2906002)(186003)(16526019)(81156014)(6666004)(7416002)(52116002)(956004)(26005);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CcaogxsmyksOKoLHiHmQ/tN6yCLW6+4ikUzAId/iS+dn9M97+qazzBCuR5Na1GslpsdLBqdqPLh7YwHAlSuqZ2+dqJoXdh+DOGWBxHc7nNe/RQ5yhgUIq3WF/eeUVkhEbRy67nJB9CR1DQI0atbNu6pgEGl7RpKEkdDrxcR1C7cA3EC1MOHyO8Obla4l05DlIYPLJ8xY6q5LwDKKnjKYybMcuAJpXxFV4h7MidRScKiphhwWs4dLkA9XguL4q76uNM75+yDUaTun5Tih5Au/tEgFeGzI1W6duSTq7mhH16sgSU6BjQd7fbMlZMxm7txDZBbGOyErbsvgftaw4I2Ucy8IfaadXgHNhOrgLPvC9plURo+64WXUC2fAQ/JtSp4gWbnEN9gpt8pefvxSI1SEhfhbNkozaZ83vQStFsY/u8fRtlP7/97E7a8WX6asS98
X-MS-Exchange-AntiSpam-MessageData: typb0a36701QNo3spn4jMhaLkjsCCoqAAIgB1b9sifHv+CwBsJVTvUoiVeDMNKbRzd1THUC/B4Vskdy8FG6mQdfTf7tkPNfLiEEoekuPb1UZpP+g0U/ayZKj3yr5pdVGm0o4kDSJ1wF32PaakT2Wjg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 85aa5aaa-defd-40c2-7a53-08d7d6d68f4f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 07:22:11.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReEx4lJsEdcZZpjk3fW1YXnlyb9k9GUCvWbTRTl3CJeE4I15a8sTm5ObwZuAPUhUnfsUo3g1cuHOWd4RiH3ZLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2807
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_04:2020-03-31,2020-04-01 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 02.04.20 09:20:32, Sherry Sun wrote:
> Since i.MX8MP use synopsys ddr controller IP, so add edac support
> for i.MX8MP based on synopsys edac driver. i.MX8MP use LPDDR4 and
> support interrupts for corrected and uncorrected errors. The main
> difference between ZynqMP and i.MX8MP ddr controller is the interrupt
> registers. So add another interrupt handler function, enable/disable
> interrupt function to distinguish with ZynqMP.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/edac/synopsys_edac.c | 77 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 1 deletion(-)

> +static void enable_intr_imx8mp(struct synps_edac_priv *priv)
> +{
> +	int regval;
> +
> +	regval = readl(priv->baseaddr + ECC_CLR_OFST);
> +	regval |= (DDR_CE_INTR_EN_MASK | DDR_UE_INTR_EN_MASK);
> +	writel(regval, priv->baseaddr + ECC_CLR_OFST);
> +}
> +
> +static void disable_intr_imx8mp(struct synps_edac_priv *priv)
> +{
> +	int regval;
> +
> +	regval = readl(priv->baseaddr + ECC_CLR_OFST);
> +	regval &= ~(DDR_CE_INTR_EN_MASK | DDR_UE_INTR_EN_MASK);
> +	writel(regval, priv->baseaddr + ECC_CLR_OFST);
> +}
> +
> +/* Interrupt Handler for ECC interrupts on imx8mp platform. */
> +static irqreturn_t intr_handler_imx8mp(int irq, void *dev_id)
> +{
> +	const struct synps_platform_data *p_data;
> +	struct mem_ctl_info *mci = dev_id;
> +	struct synps_edac_priv *priv;
> +	int status, regval;
> +
> +	priv = mci->pvt_info;
> +	p_data = priv->p_data;
> +
> +	regval = readl(priv->baseaddr + ECC_STAT_OFST);
> +	if (!(regval & ECC_INTR_MASK))
> +		return IRQ_NONE;
> +
> +	status = p_data->get_error_info(priv);
> +	if (status)
> +		return IRQ_NONE;
> +
> +	priv->ce_cnt += priv->stat.ce_cnt;
> +	priv->ue_cnt += priv->stat.ue_cnt;
> +	handle_error(mci, &priv->stat);
> +
> +	edac_dbg(3, "Total error count CE %d UE %d\n",
> +		 priv->ce_cnt, priv->ue_cnt);
> +	enable_intr_imx8mp(priv);

Why do you enable interrupts here?

-Robert

> +
> +	return IRQ_HANDLED;
> +}
