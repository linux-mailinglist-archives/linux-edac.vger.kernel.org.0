Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB3D19BC91
	for <lists+linux-edac@lfdr.de>; Thu,  2 Apr 2020 09:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgDBHUk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Apr 2020 03:20:40 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:56880 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728234AbgDBHUk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 2 Apr 2020 03:20:40 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0327EmMO013645;
        Thu, 2 Apr 2020 00:20:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=yqa6Mt4S+VU9X1Jl955IlU2NQVCoIdpr0JJtDTApcPo=;
 b=ELQw9tr7Dl+KgUqK4CJz6nU105IGOdaBjshlQ2XkR9MjssXhb1qaG2vNyHMmuFg1fQj8
 vlAb33//4DuzCFoEp68KVll+MvkAhQIDCwioqJ64VKLvyuwN4QLLl+8U0WT2dZA2CmIj
 Wotcx4WcYHqpb7hz7Zr0T09Wb7bCIaQYvnsffrmH8Aaskxod1B/GP9W8hkVTJck7Mfaq
 wmRGG/VWJPlkHnci68cU0K1mt3ePISembEqB9tEIvxSKPu9Wr7VlPgQitsIyy/fdDLi9
 0zAODCFYV7TEfVAPbEXZRCDjFUOlbTrw00+fRMT1vbtG6UlwPna+F4u/joMSqH0RDXoc GQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 3046h618c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 00:20:20 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Apr
 2020 00:20:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 2 Apr 2020 00:20:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SM7gLcHE4ulMO4Jl+a/2+L/JX/H/S0+O9JoQhKP4jx0c1+RK/48/g3wt/e4QhaNgVUazXjYEghqC1+OZH4cdiRYVeoxPpSTr5PR77NIK+UVfUs2w+9h19FSg1fkl4b/LR/L/pWH/Oqu+r688Mj8467K2MoKY2U2V+ROTFBq0kYF3/ED09uttDoK1YsR3rAZFQeV5CLHmaMxOMtnklby6jBtENruSJ6h2BYCjY2g0JRoxt/Qlp5/+v+Od2QAF/h6ycHXcdSAiPi0CAx1npSTwf7Vmnz7C6aKyd2uzfIEqP121lm1D3jYeK9GVtViM0FpJ24p5F5/DptwjIabtZZOyLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqa6Mt4S+VU9X1Jl955IlU2NQVCoIdpr0JJtDTApcPo=;
 b=THnsOH7ZcoaSAyCUen+RCzYMHIg1s83kHGd2AFAP7OPXhvo7Qd69itJsq4P95RgsK+lk/VbaxDAXBSESerlc93t0ax/uESthJIoLUAyVjLwZI2j0vCgm9DJyZlbmG0rL/8Saif4IyYV5siyVFc33O0gSCTjepENbQL64Amgsr1uaWIDgeKGzoA4pjzVHFGxKK8sj3sALGj6OBv3BEnb3zOSDT52MALuj4xAAMX8Sc1PCzuQJ1fQYI8h2R8+NEtijTQXqZEmj4WwSQN8c0wudeFdfooTPfLXEvmaQXWM8SoPbXPkoHpx+pfgLOiMBRynaE4hxGcnLN02gQmQvRmLZqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqa6Mt4S+VU9X1Jl955IlU2NQVCoIdpr0JJtDTApcPo=;
 b=as2Apy987+hK0DCTGBMqIz+AwL7n4NngJoHD7yOdxiFUtpuzmFCTsU/Pj2esYzGcZvvD66Xj+OsXRLP7+vNfq4jxrazE4Rq6TqMcRrpcxx7vSHJElQKddcDL6x/JMvuSRzqsabSGFtP2EvBJYWwtrTTAkqnCK2BoBMteS2kvzAA=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2807.namprd18.prod.outlook.com (2603:10b6:a03:111::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Thu, 2 Apr
 2020 07:20:16 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::78a2:38df:6c52:a953]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::78a2:38df:6c52:a953%3]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 07:20:16 +0000
Date:   Thu, 2 Apr 2020 09:20:06 +0200
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
        Frank Li <frank.li@nxp.com>
Subject: Re: [PATCH v2 4/4] EDAC: synopsys: Add useful debug and output
 information for 64bit systems
Message-ID: <20200402072005.ma6etmns2pdzuqaw@rric.localdomain>
References: <1585726749-13039-1-git-send-email-sherry.sun@nxp.com>
 <1585726749-13039-5-git-send-email-sherry.sun@nxp.com>
 <20200401105647.hszgxzt2uedqofth@rric.localdomain>
 <VI1PR04MB4960BEC8A60876A543A92ED692C90@VI1PR04MB4960.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4960BEC8A60876A543A92ED692C90@VI1PR04MB4960.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR1001CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::25) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR1001CA0015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f7::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Thu, 2 Apr 2020 07:20:13 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d99c4bce-78e4-4e9d-254e-08d7d6d64ac4
X-MS-TrafficTypeDiagnostic: BYAPR18MB2807:
X-Microsoft-Antispam-PRVS: <BYAPR18MB2807671FC6FCAE592B2E3C21D9C60@BYAPR18MB2807.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(316002)(478600001)(9686003)(7696005)(55016002)(8676002)(66946007)(8936002)(66476007)(86362001)(66556008)(6506007)(54906003)(81166006)(5660300002)(6916009)(1076003)(4326008)(53546011)(2906002)(186003)(16526019)(81156014)(6666004)(7416002)(52116002)(956004)(26005);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLwIGf3u1lnwypM7Y1ALP2d5IfCWDOHzuodd0RjBkiicJvxmyTVoqKS92bw23ZpNlOpZIa7ribjL/GwYKi96DKA8gj8ekdtpaXN8FtEyjYURmHiVfKsUFvHxlcXVjDKV+u1dDHChTHze/EZY5uXIKeC0LcOXsb1qNUBn6PPX8wcEeRM0CUTmqoZ1I5f6zWZusDFJJ9MFdVgDKMszc38DhKmSim60LNfj2WFbi04SixTju1OSP/4/n2udZ3IrYBkVi/pNB5OFYTbiCM9/cBXStuEAgcaQa6G38bmkFO2LjI8PLK54+WcNcNalyZnNkiMRG9MINyjqiz+qMbq/ixHNmu1oM1kyLB4J6opiUwh72fJS0z0NzNiWnpeCrw+xXY/9JdFCKFqIjyC9kREj+jI7Z7wGhlXqTxjPtZz7bKgdxyHQNHzCeyrr+lDEB8tQKI4Q
X-MS-Exchange-AntiSpam-MessageData: XoAS5EL4OqbiRHXqxRsqlEZMob0nQErJLoUgWaWR++wV7U4CQe+pk8ULbs3mXOssMqeGSfTOVlNmaJ3qR5Me/aDqwJNw2Iq3B02/uj/dK037pniTsgrX3TBQQApEBM10gbSz+PiDXcts7/xoaua6BQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d99c4bce-78e4-4e9d-254e-08d7d6d64ac4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 07:20:16.6945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sz1y7qI2KtcXoHwF4ogwwZAwWiDN8gRDwIEWD2fNYbBPwgXGZGC1zJSvep3Igfx3Ec8WFYg4j2b4vUfnC+4SlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2807
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_04:2020-03-31,2020-04-01 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 01.04.20 14:32:58, Sherry Sun wrote:
> > From: Robert Richter <rrichter@marvell.com>
> > On 01.04.20 15:39:09, Sherry Sun wrote:

> > > --- a/drivers/edac/synopsys_edac.c
> > > +++ b/drivers/edac/synopsys_edac.c
> > > @@ -278,18 +278,22 @@
> > >   * @col:	Column number.
> > >   * @bank:	Bank number.
> > >   * @bitpos:	Bit position.
> > > - * @data:	Data causing the error.
> > > + * @data_low:	Low bit data causing the error.
> > > + * @data_high:	High bit data causing the error(used for 64 bit
> > systems).
> > >   * @bankgrpnr:	Bank group number.
> > >   * @blknr:	Block number.
> > > + * @syndrome:	Syndrome of the error.
> > >   */
> > >  struct ecc_error_info {
> > >  	u32 row;
> > >  	u32 col;
> > >  	u32 bank;
> > >  	u32 bitpos;
> > > -	u32 data;
> > > +	u32 data_low;
> > > +	u32 data_high;
> > 
> > Where are 16, 32 and 64 bit widths. You could handle them all the same in a
> > u64.
> > 
> > If I am not wrong, the width is fix for the whole mci. So you could create
> > various .get_error_info() functions depending on the data width without run
> > time width checks.
> > 
> 
> Yes, here we can use u64. Will correct it in v3.
> For the zynq, it's 16-bit bus width, for imx8mp, it's 64-bit bus width.
> But for zynqmp, it's optional between 32-bit and 64-bit bus width,
> So we had better run time check the bus width, what do you think?

I am wondering a bit here. *get_dtype() is used only in init_csrows()
which sets up the mci. So it will be a fix value all the time after
init. With that you easily can setup functions depending on the width,
alternatively the width could be stored in struct synps_platform_data
or struct synps_edac_priv.

> 
> > >  	u32 bankgrpnr;
> > >  	u32 blknr;
> > > +	u32 syndrome;
> > >  };

> > @@ -480,20
> > > +559,27 @@ static void handle_error(struct mem_ctl_info *mci, struct
> > > synps_ecc_status *p)  {
> > >  	struct synps_edac_priv *priv = mci->pvt_info;
> > >  	struct ecc_error_info *pinf;
> > > +	int n;
> > >
> > >  	if (p->ce_cnt) {
> > >  		pinf = &p->ceinfo;
> > >  		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
> > > -			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> > > -				 "DDR ECC error type:%s Row %d Bank %d
> > BankGroup Number %d Block Number %d Bit Position: %d Data: 0x%08x",
> > > -				 "CE", pinf->row, pinf->bank,
> > > -				 pinf->bankgrpnr, pinf->blknr,
> > > -				 pinf->bitpos, pinf->data);
> > > +			n = snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> > > +				     "DDR ECC error type:%s Row %d Bank %d
> > BankGroup Number %d Block Number %d Bit Position: %d Data: 0x%08x",
> > > +				     "CE", pinf->row, pinf->bank,
> > > +				     pinf->bankgrpnr, pinf->blknr,
> > > +				     pinf->bitpos, pinf->data_low);
> > > +
> > > +			if (zynqmp_get_dtype(priv->baseaddr) == DEV_X8)
> > 
> > This is zynqmp specific, right? but you call it in the generic function
> > handle_error().
> 
> Yes, although handle_error() is a generic function, 
> but this operation is checked by priv->p_data->quirks,
> so here is zynqmp and imx8mp specific.

Naah, this is a bit hacky, just make 2 variants of handlers and set
them up during init. Storing the width in some private data would be
an alternative.

Thanks,

-Robert

> 
> Best regards
> Sherry Sun
> 
> > 
> > -Robert
> > 
> > > +				snprintf(priv->message + n,
> > > +					 SYNPS_EDAC_MSG_SIZE - n,
> > > +					 " Data_high: 0x%08x Syndrome:
> > 0x%08x",
> > > +					 pinf->data_high, pinf->syndrome);
> > >  		} else {
> > >  			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> > >  				 "DDR ECC error type:%s Row %d Bank %d
> > Col %d Bit Position: %d Data: 0x%08x",
> > >  				 "CE", pinf->row, pinf->bank, pinf->col,
> > > -				 pinf->bitpos, pinf->data);
> > > +				 pinf->bitpos, pinf->data_low);
> > >  		}
> > >
> > >  		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
