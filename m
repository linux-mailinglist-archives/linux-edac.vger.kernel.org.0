Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 669E1186AA7
	for <lists+linux-edac@lfdr.de>; Mon, 16 Mar 2020 13:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbgCPMMl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Mar 2020 08:12:41 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:53870 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730936AbgCPMMl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Mar 2020 08:12:41 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02GC0Oq8030475;
        Mon, 16 Mar 2020 05:12:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=7krHi2HcfoYlWB9AuUg0OJYK/vHk5kshsaaRQYgLQLE=;
 b=fhBh3QxMEpToC8hnaIYU3xioMsWpqGpk43ObfGM1TS/RXADWWPKnuBp42xsvTboqRG8K
 NSWgdcW8Ufyk5OLEmLDUifXtUw9TWyHJQoQ7LD8z1m+A3BmWd3Z1qHBpYnIsPLFR8c/O
 EGy7WxbG3MD+AkfxFZeNxJ7qVGCeIbNtv0vAVW+PXEFO8+FvKywkRbsUzNNMf4vjm34+
 OR/hF+BubXqIC7DC7F4xAp6Jx9OtNUyGhcp9e997Qcx7qmFUvDRsxEw1R+TbThH/oSAq
 d5x3KigBAOrgJmtyTtxAyjCTb9csKUTPnBVwYQsANS8VDvX7PQl2yIQD616La2fDX2Ea RA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2yrxsmek39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 16 Mar 2020 05:12:26 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 16 Mar
 2020 05:12:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 16 Mar 2020 05:12:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZmtiLo1VMYc/3/Onm8ZXn6TIGeIo4rUhqEOyPLYCdh4IPQRvEZajzAYiElA95YVo7P3nLNrssD9k9hz1krgA72NnpOQvle5E6N6ccC0GKc/5sNMD0AYW1VpSczf9z/KkFydZm7B12Fumz3zNPS7yC80it55JSl76uSGWjJACuzWP1hzzHgnL5W/AEfJ6jPfpwouzoS1Vvxp30sp8WbPA7wsDYgpBlmIyA2Sq7S4VwLgtocedmb8WxhC33WTGQvRERL6BQR6KUu1TJINdsRA8Q3cqwr13vM0hOZUcAPJlQHjNX0FS22oPwczmegaYdGTc8Cwv9f4lpFW4xm/oi4sPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7krHi2HcfoYlWB9AuUg0OJYK/vHk5kshsaaRQYgLQLE=;
 b=Vu8t++fNViZcPyGthEmmK+QefGmy06g8y643dKGj0tzNHjQ6z6CiGU7q9B4EZbsClNGKpbF9fSohk74IQokv4PjYRk5GZ0PugoKJavEj0dnQjVP71m89nWQ9rr+4gzQCPel80CkzgdVhdImpV0Q+NVWNFr00W0rLoXAsE/FWMckozYmedXhYO1t8r8exeWumcEHihQGt/6L3O3mGw4VfGgjkCXbD05W6mXMMIPHgTG/SY2nh1Jep0Ekm9sS7/uE6zZSkiBfqOJXVoGKkHaKaVI/Brb4AsPqOdBtTumi4ivvm+3nK5mUtF4w1vDsPT8eyhdfpgZWZB9f+MEx9Q7vpsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7krHi2HcfoYlWB9AuUg0OJYK/vHk5kshsaaRQYgLQLE=;
 b=WTOXTgTbHvUrvYu8JCMQS38/u9HIDvLwbv3OMcSPlkNXgym6Zpw8++IcogzevttAw1lEB7+ALG2/Ga5IHaLVHw9R+pVpmtkWa7ZWkAa3wx5uI64nE/1qHNXOKETF8N3AsZVWoFgoT8guBXQZO7r8+YkDYyYp+UPhSac/7jMR9BI=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB3054.namprd18.prod.outlook.com (2603:10b6:208:a6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Mon, 16 Mar
 2020 12:12:22 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 12:12:22 +0000
Date:   Mon, 16 Mar 2020 13:12:14 +0100
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/11] EDAC/ghes: Carve out MC device handling into
 separate functions
Message-ID: <20200316121214.qb3nq22xsbiqaz3e@rric.localdomain>
References: <20200306151318.17422-1-rrichter@marvell.com>
 <20200306151318.17422-7-rrichter@marvell.com>
 <20200316093134.GB26126@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316093134.GB26126@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR06CA0142.eurprd06.prod.outlook.com
 (2603:10a6:7:16::29) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR06CA0142.eurprd06.prod.outlook.com (2603:10a6:7:16::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19 via Frontend Transport; Mon, 16 Mar 2020 12:12:20 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adbd3704-3b8b-4b85-2260-08d7c9a347b7
X-MS-TrafficTypeDiagnostic: MN2PR18MB3054:
X-Microsoft-Antispam-PRVS: <MN2PR18MB3054A7F65E40499E2A2CD8C9D9F90@MN2PR18MB3054.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(199004)(52116002)(7696005)(8936002)(6506007)(8676002)(6916009)(1076003)(16526019)(6666004)(5660300002)(186003)(316002)(26005)(478600001)(66556008)(2906002)(66476007)(53546011)(54906003)(66946007)(9686003)(86362001)(81156014)(81166006)(55016002)(956004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3054;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hifFB5vKd3a0izdniwFmtaL+Xr569KufWh832HgK2eup7cKqBPKFm9iB+V84eVPYuFWl4Eryaaf9i7JpAj6cFWP5biDBF40ewRKj8GfM+QI8+V4TvvxzH5ECgRS4wVflVtRRm3LulwfQxouU+HPlkkKCgk8JHpkaElPfQgOpq+ntuVvsat/ZLLxG8/aYonn0uhjzn/LuUcVc9Yav1gbBsbw8jT6K4c9GCAC8szGnFih2gLaLjqNq9AdwchkW9mU5gDBlPQk4ZlACL/2s2VogInl+Rt3GI+hlIwEGIUZ/xSSyD0WWZkNIgOqOkvU3YKgeSWfh9IppXo8n52az5suV33jBkxUM5ke4n6hz3W6rNbcCtx1syfAsnzAcCPjP70CKrpGnP68SWdcsTlS0feqqRGetB+s0ITcU1Wl7/iDbtu1YLsPKc5Qe/YqrPCYbdcRK
X-MS-Exchange-AntiSpam-MessageData: OlRGKyz/cM/BdKBY3zYbcRNCqISwQ8vILXuek2MAo5A2U80IAyiqfB2cPIzxsKlnzbP44gMBe+nfgXNe3tIRkFRrjpDJtIM0W0kqwEdDRdroSv1OHTEEOCrc3TrbZ1fRsDeK2RW/dFz2+ZQJaaHS1Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: adbd3704-3b8b-4b85-2260-08d7c9a347b7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 12:12:22.0648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNEfK73CcIcJq1OqkWkCodgyrjyjL9MC74G4pyhl6LPeb6CJfpqUI8dSu29orJRN0PWvVwrlL3WngxKKjexybg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3054
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-16_03:2020-03-12,2020-03-16 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 16.03.20 10:31:34, Borislav Petkov wrote:
> On Fri, Mar 06, 2020 at 04:13:13PM +0100, Robert Richter wrote:
> > The functions are too long, carve out code that handles MC devices
> > into the new functions ghes_mc_create(), ghes_mc_add_or_free() and
> > ghes_mc_free(). Apart from better code readability the functions can
> > be reused and the implementation of the error paths becomes easier.
> > 
> > Signed-off-by: Robert Richter <rrichter@marvell.com>
> > ---
> >  drivers/edac/ghes_edac.c | 133 +++++++++++++++++++++++----------------
> >  1 file changed, 79 insertions(+), 54 deletions(-)
> > 
> > diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> > index 358519e8c2e9..5a4c9694bbff 100644
> > --- a/drivers/edac/ghes_edac.c
> > +++ b/drivers/edac/ghes_edac.c
> > @@ -462,16 +462,81 @@ static struct acpi_platform_list plat_list[] = {
> >  	{ } /* End */
> >  };
> >  
> > -int ghes_edac_register(struct ghes *ghes, struct device *dev)
> > +static struct mem_ctl_info *ghes_mc_create(struct device *dev, int mc_idx,
> > +					int num_dimm)
> >  {
> > -	bool fake = false;
> > -	int rc = 0, num_dimm = 0;
> > +	struct edac_mc_layer layers[1];
> >  	struct mem_ctl_info *mci;
> >  	struct ghes_mci *pvt;
> > -	struct edac_mc_layer layers[1];
> > -	struct ghes_dimm_fill dimm_fill;
> > +
> > +	layers[0].type = EDAC_MC_LAYER_ALL_MEM;
> > +	layers[0].size = num_dimm;
> > +	layers[0].is_virt_csrow = true;
> > +
> > +	mci = edac_mc_alloc(mc_idx, ARRAY_SIZE(layers), layers, sizeof(*pvt));
> > +	if (!mci)
> > +		return NULL;
> > +
> > +	pvt		= mci->pvt_info;
> > +	pvt->mci	= mci;
> > +
> > +	mci->pdev = dev;
> > +	mci->mtype_cap = MEM_FLAG_EMPTY;
> > +	mci->edac_ctl_cap = EDAC_FLAG_NONE;
> > +	mci->edac_cap = EDAC_FLAG_NONE;
> > +	mci->mod_name = "ghes_edac.c";
> > +	mci->ctl_name = "ghes_edac";
> > +	mci->dev_name = "ghes";
> > +
> > +	return mci;
> > +}
> > +
> > +static int ghes_mc_add_or_free(struct mem_ctl_info *mci)
> 
> ghes_mc_add() is good enough. The fact that the function has error
> handling doesn't need to be in the name.

It's not just error handling here. I choose the name as the mci is
freed if it could not be added, which is different to just return an
error if it fails. Otherwise the flow would be something like:

	mci = ghes_mc_create(...);
	rc = ghes_mc_add(mci);
	if (rc) {
		ghes_mc_free(mci);
		/* do something */
	}

But we do not need mci any longer on error, so we can free it directly
which makes the code much easier, but in fact it does 2 things at a
time then:

	mci = ghes_mc_create(...);
	rc = ghes_mc_add_or_free(mci);
	if (rc)
        	/* do something */

I would rather prefer ghes_mc_add_or_free().

-Robert


