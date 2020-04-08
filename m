Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9761A1BF2
	for <lists+linux-edac@lfdr.de>; Wed,  8 Apr 2020 08:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgDHGk7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 Apr 2020 02:40:59 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:17252 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbgDHGk7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 8 Apr 2020 02:40:59 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0386eEbk025019;
        Tue, 7 Apr 2020 23:40:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=hDGcXiyC8yzl06qaiguUjd4IYxJYsicva0FhSuWJOqQ=;
 b=B1o3kO3xULBWOB+QxM1DlahxFWZtWRUnHvOJPhOBGV3P/wgrAwWFCyfRGAGSWOe/MF0s
 MrR7r2UnQ83LTRqqYG048+Dws5rTZnUo6Xlc4jq/oc8GngmBlTUemnoqwBDBh/l9Kv59
 T+Bhi10BxYDxcmQKuTmIik3RcH+6mtBUiqRu59a/dGys2k/ztHgsM00b5GEQtNTHjF2h
 mActCoI1/V88cKim7WeMAEOflKqWAdShTAL/bJlDIbMFGRQ4WyDDsLuVXMZcF/3TrwB0
 JidGoBnwoTu2LyE88g1vuyltTL3lGRJukQMPAh1WkCUZAI85Cj5W1nCo/ibIdhaRjjdS VA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 3091me1y8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 07 Apr 2020 23:40:35 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 7 Apr
 2020 23:40:34 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.52) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 7 Apr 2020 23:40:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5TSypnRiIOwRYG2NPsPS75P4SAqWIa8rALEV8G+Gk5ZSy8UnGpoWxICwZ89kGNVuIqVCxLbA2k8vyr1cGXNeh1UFy54w8Uc4ieYNFbGlLny4e0p64xAT8Bg40w8vxu3iwwO797qV4rucUvzRtTAN9EezCaB9CvHRg1vjXOr69E+ISTlKHKZWvQjaek4bLmhExbIlwKXV/4VrTeOeKRaXfRqQMwJJVgxvzH7zU5Hh6EZfrLSKriZxqTJVvjRsGzzQVj9tM9NTbAOLTDvsQggy5qsrc5Nh8u8YXCaE2Bo3ZVcGYkUhWzcFamy219Gm9iMt1TqrO58lAvYm+LPRV7gqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDGcXiyC8yzl06qaiguUjd4IYxJYsicva0FhSuWJOqQ=;
 b=C8zd3bWu+9YANREmRYAa3BgAKg6qvA0WLdJEfIoBXjefZ+puEuSc8avBdPxMdrvpl8d2VUnT3WFkS8ZhcMJ1p+d4IPqVFcEppFU5aU1g1SBZ0aRfm/uWBJ5tMxDz6jfJcx+65mYYBBcuAbX4EC/Dt82iHIOOHKEtChE+UTmD1RYy7by1qT/pqMkm3I5UtotxvG+v4sv8mdnqlWnFKz+0fqeu0zmL4mZ4yGWrcTuQ1pRkQ89HPMY7fi351zylkv+sa1prcSI8fM730tfeQj3zxxbxqg09GFzFVzY36PfBWN3YPEIhUKXW9DlYcqoFPfNU+8n8zN6bxpnFfM7Ux/A6OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDGcXiyC8yzl06qaiguUjd4IYxJYsicva0FhSuWJOqQ=;
 b=m2o4MX6MP8v0h9d/FWrzrmrHoqx6LXnjf9vfG2W9dLx5F3tkozuMXD0tnXgsORkvuDHkqPiZJKkSnMAbNwydQsuF3WvogRpmkcj1i3m2370+tWNRgf6krfYoZmoEVRaePt2iPfuc3FAtXC+g0WSLp622avMpQcjB25uRB47KtkQ=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2437.namprd18.prod.outlook.com (2603:10b6:a03:13c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Wed, 8 Apr
 2020 06:40:32 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::78a2:38df:6c52:a953]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::78a2:38df:6c52:a953%3]) with mapi id 15.20.2878.022; Wed, 8 Apr 2020
 06:40:32 +0000
Date:   Wed, 8 Apr 2020 08:40:21 +0200
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
Message-ID: <20200408064020.fjg55j7vvcvsqxgb@rric.localdomain>
References: <1585790433-31465-1-git-send-email-sherry.sun@nxp.com>
 <1585790433-31465-4-git-send-email-sherry.sun@nxp.com>
 <20200402072200.o6c6u3uim6jwopo6@rric.localdomain>
 <VI1PR04MB4960985DD2A4F0CA68063D9592C60@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20200402111709.qr7zpo5o5vrwh5kb@rric.localdomain>
 <VI1PR04MB4960DF2EF1961DCF74655BF592C60@VI1PR04MB4960.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4960DF2EF1961DCF74655BF592C60@VI1PR04MB4960.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR05CA0258.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::34) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0258.eurprd05.prod.outlook.com (2603:10a6:3:fb::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20 via Frontend Transport; Wed, 8 Apr 2020 06:40:29 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91430619-17dd-4069-1fb2-08d7db87bc37
X-MS-TrafficTypeDiagnostic: BYAPR18MB2437:
X-Microsoft-Antispam-PRVS: <BYAPR18MB2437429A6C12F50D196CA24AD9C00@BYAPR18MB2437.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(956004)(6506007)(16526019)(55016002)(478600001)(186003)(1076003)(6666004)(81166007)(9686003)(6916009)(66476007)(4326008)(5660300002)(66556008)(7416002)(81156014)(8676002)(53546011)(66946007)(54906003)(52116002)(2906002)(26005)(316002)(8936002)(86362001)(7696005);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9Cc6VhFuFrLmt4ZYBz1JZsjdGW/yAVLvweWJCPRw3RIqF9YNOksWRONyJL149VDEtr7xwOPsIa6bAt2hBGicPnElFxBV/OXtb7AIBU1JlSpBABOxDJ67AfisilMP8BagdUofxc5WLQr/DX7yqe0h7hXgvGM+gjZmNbajWeDzDQVqX8FMNG5lrJ0M374VZlkpsjHYecIDHSZTooRNg+WGom5z1kjKOI8xlG89BqzQuPMuTJDSxrNDVh/XSpB8oGsCIvW/EenTVSrS2fsLFfySIkwxJFdlwl3YBHdHKLAude6x+xsz7hL4qIg6gYHghCtzi1VrR6I2THfzo7zRoSjsacX7PmAK5GeNuhAkCKwgP2wYokiIxIBENnJLdMkEQd50Jo0PQP4wQqi8YnGjvRzx4NzeiBdwLUoM7rvhV0+vGRjDWHifb/AVtMO4Cbmc+14
X-MS-Exchange-AntiSpam-MessageData: l+JGBovwtLVoOwRftUPfLBN8P3KWL3H9gJ69MiofOHe73HzRjLqzSbbWSWQOXlw84ZJbTlwYtIarzPHtdIwxrsWKIqizlifvDYfmQ+hoXC+xt3suwYUpp+9Z7eqQjhN4nSBPxjHzTkUHi0MuiP95Bg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 91430619-17dd-4069-1fb2-08d7db87bc37
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 06:40:32.5968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6pWsoaEvBXzQCr3GtdHB3GMmLA2IdU/5VOL3u+ZFnDxKP9A7RE+y0CUkxaeilDpoGW50WCpZSgIm3pqb/qjRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2437
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-07_10:2020-04-07,2020-04-07 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 02.04.20 13:09:57, Sherry Sun wrote:
> > From: Robert Richter <rrichter@marvell.com>
> > On 02.04.20 09:06:27, Sherry Sun wrote:
> > > > From: Robert Richter <rrichter@marvell.com> On 02.04.20 09:20:32,

> > > > > +/* Interrupt Handler for ECC interrupts on imx8mp platform. */
> > > > > +static irqreturn_t intr_handler_imx8mp(int irq, void *dev_id) {
> > > > > +	const struct synps_platform_data *p_data;
> > > > > +	struct mem_ctl_info *mci = dev_id;
> > > > > +	struct synps_edac_priv *priv;
> > > > > +	int status, regval;
> > > > > +
> > > > > +	priv = mci->pvt_info;
> > > > > +	p_data = priv->p_data;
> > > > > +
> > > > > +	regval = readl(priv->baseaddr + ECC_STAT_OFST);
> > > > > +	if (!(regval & ECC_INTR_MASK))
> > > > > +		return IRQ_NONE;
> > > > > +
> > > > > +	status = p_data->get_error_info(priv);
> > > > > +	if (status)
> > > > > +		return IRQ_NONE;
> > > > > +
> > > > > +	priv->ce_cnt += priv->stat.ce_cnt;
> > > > > +	priv->ue_cnt += priv->stat.ue_cnt;
> > > > > +	handle_error(mci, &priv->stat);
> > > > > +
> > > > > +	edac_dbg(3, "Total error count CE %d UE %d\n",
> > > > > +		 priv->ce_cnt, priv->ue_cnt);
 > > > > > +	enable_intr_imx8mp(priv);
> > > >
> > > > Why do you enable interrupts here?
> > >
> > > Because zynqmp_get_error_info() wrote 0 to ECC_CLR_OFST, so here have
> > to re-enable the interrupts.
> > 
> > This does not seem to be the right place for it.
> > 
> > > As said in the commit, the main difference between ZynqMP and i.MX8MP
> > ddr controller is the interrupt registers.
> > > ZynqMP use DDR QOS Interrupt registers,  but i.MX8MP use ECC_CLR_OFST
> > Register(bit8 and bit9) to enable/disable the ce/ue interrupts.
> > >
> > > In zynqmp_get_error_info(), Zynqmp wrote 0 to ECC_CLR_OFST register to
> > clear CE/UE error flags and counts, it has no effect on Zynqmp interrupts.
> > > But for i.MX8MP, wirte 0 to ECC_CLR_OFST will disable i.MX8MP CE/UE
> > interrupt, so need re-enable the interrupts.
> > 
> > All this shows one more time there should be separate handlers. You should
> > get rid most callbacks in struct synps_platform_data and instead have
> > separate probe functions for both flavors that share common code.
> 
> Do you mean that I should create specific callbacks in struct synps_platform_data for i.MX8MP instead reuse the ZynqMP functions?
> But except this operation of write 0 to ECC_CLR_OFST in zynqmp_get_error_info(), 
> the other callbacks in struct synps_platform_data are all the same between ZynqMP and i.MX8MP.

Most callbacks in struct synps_platform_data will become obsolete if
there are either device tailored functions or if the width parameter
would be stored in private data and used by a common function.

-Robert
