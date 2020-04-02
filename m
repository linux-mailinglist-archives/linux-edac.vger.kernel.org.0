Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4428C19C005
	for <lists+linux-edac@lfdr.de>; Thu,  2 Apr 2020 13:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbgDBLRs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Apr 2020 07:17:48 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:59732 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728803AbgDBLRs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 2 Apr 2020 07:17:48 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 032BFmUZ008645;
        Thu, 2 Apr 2020 04:17:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=krY0Zj196GF0qubofGfASf5et9umz54Lqmk63XfkOt4=;
 b=sYs6/gFvQwlW05woPoETKwqqH6cNUJu+jDIS4fjQIVjVkeqxQj5DP4Dc1xvYbYybxfm4
 fLR1QkXVI478cRRFBkxL4dPGwjf3AkTVqpEUy6Xo10XmIaSae4qsqBM4ADY212fBiDWL
 eICAAnhRtyMHo4409Aqjh+3Ww+MaB9IO0DRPemY7wBLNI0xBK8mgM+THj6MDm2j8IxA4
 rGexno4ureZUMb03MddY7d1+iKH9IKj8Ot6yQ1Faiob6UkAOPZJMKvtDS7uJ8bcTBL/G
 S7WqIYe6RSEldnMsgIDFkFz7eber6ZG2k/yumHeAo5OLXSfuUdOPIrGrelkUL+fN5QDQ Wg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 304855sh43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 04:17:24 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Apr
 2020 04:17:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 2 Apr 2020 04:17:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2RWzRv8EZrJclwgY/3N4bIkNgKXCl8KB7TLamTfiPWGODffFa9CuGtmorQ7XVWt5zi5NxXFpC2UHqsyEJko1bCp+ICjHSWCl2w9hQOoL6DYeZpMfReIeWfffOLA54nEYFQd3c+987EFpyN5uwIhMBR7G9GTTVvrrOlZinIYdg+mvhVP7q1+AdaDd3Yv12vqR4nFh8LcIRmXeVu/y1IqJyjiyUnUqKrugZYuPCKM7doJG255wvZAMHutmAVszSzQtn2LziyMZbbMXtjtGcaoRi+RyHj12uDoVnSXJbkG3pPWvAmrjgEcyt/jPHVB6ZAWq3hIhsoX6hOo2GMHl+FZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krY0Zj196GF0qubofGfASf5et9umz54Lqmk63XfkOt4=;
 b=Brgqo1sQrSTwKMZmS7Kdz7E4GM8bnU2D9Rl3M83KrOP8eT4ODA7XayFWEMFH1qd0gETWj9vhY8Ep0vEv1AsNn7RQM0Tku0fmGEE86VJBJI/sJFBCtj3lcUXXx7DgChSuxR2ALV1J0TZ/JfWFQBrlC8ag32MkuRSZWDJNsMZnyaWx1zw8/fUuTYSlWRbQ4LfI6zYwA/iRNdMTuafY8lDuA+UXzgYGGqxd1XHRM77DIMs9j57p/tAKty8gNwVhFmx/iP13kKutyat9E4r6YODvZxF0UCZ7NkxXpsPmELs9zu4ooww7emq1cRHwo2TYso6IdfMMavzkHkf9LUUX8t2mVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krY0Zj196GF0qubofGfASf5et9umz54Lqmk63XfkOt4=;
 b=oD+0VHnA2y2U3jE9Syw4G4pqd0DsqXqQWuHJXVPNgfTPfZT5gwqsINjijqvR92D5okbNiTW2WjBlHK2GcMDqdvVqmIsrvghXo3izLJBJchVaPNII/OQ/DcVX7HePKVza8RUqgWwq7sne1PelKPuzSRgiqR6YXmsff1KIvAYuZqg=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB3031.namprd18.prod.outlook.com (2603:10b6:a03:12d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Thu, 2 Apr
 2020 11:17:20 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::78a2:38df:6c52:a953]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::78a2:38df:6c52:a953%3]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 11:17:20 +0000
Date:   Thu, 2 Apr 2020 13:17:09 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Sherry Sun <sherry.sun@nxp.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "manish.narani@xilinx.com" <manish.narani@xilinx.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Frank Li <frank.li@nxp.com>
Subject: Re: [patch v3 3/4] EDAC: synopsys: Add edac driver support for
 i.MX8MP
Message-ID: <20200402111709.qr7zpo5o5vrwh5kb@rric.localdomain>
References: <1585790433-31465-1-git-send-email-sherry.sun@nxp.com>
 <1585790433-31465-4-git-send-email-sherry.sun@nxp.com>
 <20200402072200.o6c6u3uim6jwopo6@rric.localdomain>
 <VI1PR04MB4960985DD2A4F0CA68063D9592C60@VI1PR04MB4960.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4960985DD2A4F0CA68063D9592C60@VI1PR04MB4960.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR05CA0249.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::25) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0249.eurprd05.prod.outlook.com (2603:10a6:3:fb::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Thu, 2 Apr 2020 11:17:17 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58a0b163-c70c-4822-892b-08d7d6f768c7
X-MS-TrafficTypeDiagnostic: BYAPR18MB3031:
X-Microsoft-Antispam-PRVS: <BYAPR18MB303134167548599A772F0B7AD9C60@BYAPR18MB3031.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(6666004)(1076003)(5660300002)(26005)(6506007)(52116002)(956004)(16526019)(7696005)(53546011)(2906002)(66476007)(8676002)(478600001)(55016002)(316002)(186003)(66946007)(4326008)(8936002)(9686003)(81166006)(6916009)(7416002)(81156014)(66556008)(54906003)(86362001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baRGp/BXag6W5j02II7j/JlFN8N8R55Jv86CVYmzA3UD8xituu3WBNNm65rQLMMUp07S+k4D39Eou5pAEfLt0iIEG0fHhut5t5YanrYC3Xle7uW8hBQq80Yc175yB7ClHr98ryz4khIABaprEA8k7xCzs/+PRnCL01fN6zFyK/+X9bUyGph4shmnjYcWduFexenlpS0Svph3rV9Dxnr4/j1oYEJToc60k7m7IQmALn8t8YKaR26iRObDbBy9tmVIN/wqONqvoeye6bNRaNXc4VTjm2tx3MLQ0tj/yPKl1LUW2faQxHGrKwzhHEWSy3UxO14rblyb1oHdDty0qAgN752QxfwNRKw98dce2Ql9B9zs0HavhT7Gl6yIYm/8AbsQRkXrtQCKOH2PgGYDMNYtR9rpw/Ri/ZaWPGWiyhfX2mYOvpy4pXVh94nEVVFTbV2o
X-MS-Exchange-AntiSpam-MessageData: vQnEfx8plaWx9aEd089mhMXpEChGK1qZ/URZ2r8OoUhwWAZ/S0s7r9g+c3HSevHen95JZJX1CSv0T5XPA3PAsYlUsHeT1iRnJA9by34vDvfm/NE8HVLItYswnkJwtVNGTk3TPzftRD9AA+Fnpxogzg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a0b163-c70c-4822-892b-08d7d6f768c7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 11:17:20.1906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtEC/bQfE1WdHbZXXqQ9+j1TvFXHv+avQ5T6hYBB1PprY9zv6WFXvjWSEu62u7mxFqNky2fWPRXTrHF7skNlcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB3031
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-02_01:2020-03-31,2020-04-02 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 02.04.20 09:06:27, Sherry Sun wrote:
> > From: Robert Richter <rrichter@marvell.com>
> > On 02.04.20 09:20:32, Sherry Sun wrote:

> > > +static void enable_intr_imx8mp(struct synps_edac_priv *priv) {
> > > +	int regval;
> > > +
> > > +	regval = readl(priv->baseaddr + ECC_CLR_OFST);
> > > +	regval |= (DDR_CE_INTR_EN_MASK | DDR_UE_INTR_EN_MASK);
> > > +	writel(regval, priv->baseaddr + ECC_CLR_OFST); }
> > > +
> > > +static void disable_intr_imx8mp(struct synps_edac_priv *priv) {
> > > +	int regval;
> > > +
> > > +	regval = readl(priv->baseaddr + ECC_CLR_OFST);
> > > +	regval &= ~(DDR_CE_INTR_EN_MASK | DDR_UE_INTR_EN_MASK);
> > > +	writel(regval, priv->baseaddr + ECC_CLR_OFST); }
> > > +
> > > +/* Interrupt Handler for ECC interrupts on imx8mp platform. */ static
> > > +irqreturn_t intr_handler_imx8mp(int irq, void *dev_id) {
> > > +	const struct synps_platform_data *p_data;
> > > +	struct mem_ctl_info *mci = dev_id;
> > > +	struct synps_edac_priv *priv;
> > > +	int status, regval;
> > > +
> > > +	priv = mci->pvt_info;
> > > +	p_data = priv->p_data;
> > > +
> > > +	regval = readl(priv->baseaddr + ECC_STAT_OFST);
> > > +	if (!(regval & ECC_INTR_MASK))
> > > +		return IRQ_NONE;
> > > +
> > > +	status = p_data->get_error_info(priv);
> > > +	if (status)
> > > +		return IRQ_NONE;
> > > +
> > > +	priv->ce_cnt += priv->stat.ce_cnt;
> > > +	priv->ue_cnt += priv->stat.ue_cnt;
> > > +	handle_error(mci, &priv->stat);
> > > +
> > > +	edac_dbg(3, "Total error count CE %d UE %d\n",
> > > +		 priv->ce_cnt, priv->ue_cnt);
> > > +	enable_intr_imx8mp(priv);
> > 
> > Why do you enable interrupts here?
> 
> Because zynqmp_get_error_info() wrote 0 to ECC_CLR_OFST, so here have to re-enable the interrupts.

This does not seem to be the right place for it.

> As said in the commit, the main difference between ZynqMP and i.MX8MP ddr controller is the interrupt registers.
> ZynqMP use DDR QOS Interrupt registers,  but i.MX8MP use ECC_CLR_OFST Register(bit8 and bit9) to enable/disable the ce/ue interrupts. 
> 
> In zynqmp_get_error_info(), Zynqmp wrote 0 to ECC_CLR_OFST register to clear CE/UE error flags and counts, it has no effect on Zynqmp interrupts. 
> But for i.MX8MP, wirte 0 to ECC_CLR_OFST will disable i.MX8MP CE/UE interrupt, so need re-enable the interrupts.

All this shows one more time there should be separate handlers. You
should get rid most callbacks in struct synps_platform_data and
instead have separate probe functions for both flavors that share
common code.

-Robert
