Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9807115D78C
	for <lists+linux-edac@lfdr.de>; Fri, 14 Feb 2020 13:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgBNMkx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Feb 2020 07:40:53 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:48606 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726191AbgBNMkw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Feb 2020 07:40:52 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01ECaQYo009323;
        Fri, 14 Feb 2020 04:40:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=zE1SBVGOV3XX+hZyTHSF5xgczFQlYB+thsOJd3G+qrc=;
 b=YxD/ZHDm+880wSx3IWLYacbMXnNjrWeK8j4wAvW454uryqXvLL0+CllKB6zJp8gYZIbe
 0WWdR+3Xab6MqSdCUKkeIfo+hVeCT2cfgAwzSBGmEGqv0bubkbRRDAs5oL/KrUZu8oUb
 tSBeZfJQzwznWRm0XtfTM8a6nk4IYJEO46oLxfP9ZiQL8zB2cTUPFF5v6wmMLILRQxXY
 4qR5JcK7/nSRcssB++2Qu2F/PUoE5WAHL+PVGwLwlaHTyH4CDGsy3P4nVXnSsRtmc5+9
 eg37DxhMNH4rqJ0i9W96foNO71CqMpZwYTZ2RiWVUnLwctRMLcKZy6uR7fxrFnK7AAKr Lg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2y4be2mmru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Feb 2020 04:40:39 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 14 Feb
 2020 04:40:38 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.53) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 14 Feb 2020 04:40:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqzW8Ln1TjoZCgj7e/f34iCViICYQr6qoBhGEZwKBjSyjEkQ6wt3D6RIAVDvOxdgjIf739A4l9pSXAut8tuP6s0AtlP+QmvXgPCAYpsm2vuWtf3PA5jM7z2SPr2yDpnQQSy9byMZJm+aoswmJwI4UcvEDkFK9fpv8jVdtkt6a/SMh39jMoUBAWt7Bz9IN4YneRLjbUF9OwDY14cMOdUGXmBhOQTQa9SgfB02KyXM8wSTLK5jV28tZrtHWdm5syQ4pEOz1fNagL4+rzW5rz/ApZRe8uxFrkU0yvud4QkVWNJSLhqU411wojhvyfm2i4sH/LpyprhetLdeoTeo9+7ZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zE1SBVGOV3XX+hZyTHSF5xgczFQlYB+thsOJd3G+qrc=;
 b=Qmv6QEVdCkDunRU6/ZoKFVaeW7h3KX9nSf3rA/aqyYDwamkskTgFFKdgCb+AJvPL8T4Tyd5YFyp7CXGBjtsh0bXNvFAbe91uo3jz1OKgDhg+4bb3VX/J/j4cishJ+t74JaDzrTOy1/TevRHGWtyaZAtrgvAU9tJytcU+vHtJYkQSXvy9Dko3v4fAcTrwi/sFuBCIOGBr3YWK0+45rkNl9N5BtJx6qSt8SABfpW5Zy55CnFcTaABleI9ic6wU4Cdp0N3lTxwObZrO5fNdY1G6odiGAhTVm8M0oONN4ksNDWBlR5wlnnKpZmfRNzEBAdyiJ30XFEBWHo6MozfefiYrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zE1SBVGOV3XX+hZyTHSF5xgczFQlYB+thsOJd3G+qrc=;
 b=MKsktj4ildB07UCfuHhoUs7nnFayW8PXvwJina37FiZqrDz5Xkc7m9CNghxRm/URi4D6AZvNMLsTTKu+7CZzVkhLR6BkwWe8+oNOs/JbYwS+Mvf2wksJ4HuyjT1A6NAzPUd/EFevRVb6R/p/xAr47q/t6zsZr0xluKPUmbjUPcM=
Received: from DM6PR18MB3403.namprd18.prod.outlook.com (10.255.174.220) by
 DM6PR18MB2763.namprd18.prod.outlook.com (20.179.48.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Fri, 14 Feb 2020 12:40:37 +0000
Received: from DM6PR18MB3403.namprd18.prod.outlook.com
 ([fe80::21f1:da96:3d0d:750d]) by DM6PR18MB3403.namprd18.prod.outlook.com
 ([fe80::21f1:da96:3d0d:750d%7]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 12:40:36 +0000
Date:   Fri, 14 Feb 2020 13:40:28 +0100
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 05/10] EDAC/mc: Create new function edac_inc_csrow()
Message-ID: <20200214124028.d5tqr4zxke5elaxf@rric.localdomain>
References: <20200123090210.26933-1-rrichter@marvell.com>
 <20200123090210.26933-6-rrichter@marvell.com>
 <20200213124708.GJ31799@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213124708.GJ31799@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR05CA0210.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::34) To DM6PR18MB3403.namprd18.prod.outlook.com
 (2603:10b6:5:1cc::28)
MIME-Version: 1.0
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0210.eurprd05.prod.outlook.com (2603:10a6:3:f9::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Fri, 14 Feb 2020 12:40:35 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04e7693b-da59-4427-235a-08d7b14b1712
X-MS-TrafficTypeDiagnostic: DM6PR18MB2763:
X-Microsoft-Antispam-PRVS: <DM6PR18MB2763C2339B478D6A98261EB7D9150@DM6PR18MB2763.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(189003)(199004)(478600001)(53546011)(81156014)(6916009)(81166006)(9686003)(1076003)(8676002)(6506007)(8936002)(86362001)(26005)(55016002)(5660300002)(66476007)(16526019)(66556008)(4326008)(2906002)(186003)(956004)(66946007)(6666004)(52116002)(316002)(7696005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR18MB2763;H:DM6PR18MB3403.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ApMFC49NrtEQvo52XtVHXnA88DcYc9tKIbR2f5GOw+/yPMwYf9wvcK47PTiTK2dXEyP8QFPnymLwIoAgXmV27JAm2AcFq+GTJNEouIpvJyoXXsY6aVVDUNQlhTnbv77pg8nPElkyuzfzyy+HunIvCTm1giLNpVmzANimQ03L42u9kstBPaGa7ePQJtiCR3HMI9nnjwOjch6hEvAyoC+1aSvxDp63/461/tOwtdSU6z+KqV80FUkMYvh2ysicWeDZMGxG7Psego2ry9qxtXni3A9G9rV8xy1z+kQCT8fzPpO2OWJUdQzeoKueHV+9xxYIrv3So1I+VgyVYFvkaQ33ccxu6n/N8/i1f2KJz7ct4HMYTTVbfdl66spqkT6ozs5e/XtHgWpSU3EVFY21k74OCqgtq8jU30tUWLxykE44cka5oLZc4aYCsTjp17x/MO0p
X-MS-Exchange-AntiSpam-MessageData: CBxjFnGWilkB7qxnNDirqPntu7XmDXEk3oBoL1WpM866hy7C3Jm6R5sThgCTjOmufb/hO2EMQFKVqSlXnPKea7aQMFYLYg1+6OHdIEiBM7ss4fyU886HGBP5iFIkHNNiX9D/iHa8zBw1fgoJaCIKTQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e7693b-da59-4427-235a-08d7b14b1712
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 12:40:36.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmH+s83gon4LXp4I/jXIpm5mNzEVwTRKynJDN2Dx4bnwOBQVluLvMqVRFYSNGXLmwBRsOlx2Yn+vCbfil7SD/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2763
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-14_03:2020-02-12,2020-02-14 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 13.02.20 13:47:08, Borislav Petkov wrote:
> On Thu, Jan 23, 2020 at 09:02:58AM +0000, Robert Richter wrote:
> > Have a separate function to count errors in csrow/channel. This better
> > separates code and reduces the indentation level. No functional
> > changes.
> > 
> > Signed-off-by: Robert Richter <rrichter@marvell.com>
> > Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> > Acked-by: Aristeu Rozanski <aris@redhat.com>
> > ---
> >  drivers/edac/edac_mc.c | 40 +++++++++++++++++++++++++---------------
> >  1 file changed, 25 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> > index 3c00c046acc9..e75cb7a9c454 100644
> > --- a/drivers/edac/edac_mc.c
> > +++ b/drivers/edac/edac_mc.c
> > @@ -1091,6 +1091,26 @@ static void edac_ue_error(struct mem_ctl_info *mci,
> >  	edac_inc_ue_error(mci, enable_per_layer_report, pos, error_count);
> >  }
> >  
> > +static void edac_inc_csrow(struct edac_raw_error_desc *e, int row, int chan)
> > +{
> > +	struct mem_ctl_info *mci = error_desc_to_mci(e);
> > +	u16 count = e->error_count;
> > +	enum hw_event_mc_err_type type = e->type;
> 
> Please sort function local variables declaration in a reverse christmas
> tree order:
> 
> 	<type A> longest_variable_name;
> 	<type B> shorter_var_name;
> 	<type C> even_shorter;
> 	<type D> i;

I can change this. Does variable name length include the assignment?

Generally I prefer to sort it by size_of() to avoid holes due to
padding, though the compiler uses probably registers here anyway.
It's just a flavor.

If it's just this change, could you edit the patch to avoid respin?

> 
> > +
> > +	if (row < 0)
> > +		return;
> > +
> > +	edac_dbg(4, "csrow/channel to increment: (%d,%d)\n", row, chan);
> > +
> > +	if (type == HW_EVENT_ERR_CORRECTED) {
> > +		mci->csrows[row]->ce_count += count;
> > +		if (chan >= 0)
> > +			mci->csrows[row]->channels[chan]->ce_count += count;
> > +	} else {
> > +		mci->csrows[row]->ue_count += count;
> > +	}
> > +}
> > +
> >  void edac_raw_mc_handle_error(struct edac_raw_error_desc *e)
> >  {
> >  	struct mem_ctl_info *mci = error_desc_to_mci(e);
> > @@ -1258,22 +1278,12 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
> >  			chan = -2;
> >  	}
> >  
> > -	if (!e->enable_per_layer_report) {
> > +	if (!e->enable_per_layer_report)
> >  		strcpy(e->label, "any memory");
> > -	} else {
> > -		edac_dbg(4, "csrow/channel to increment: (%d,%d)\n", row, chan);
> > -		if (p == e->label)
> > -			strcpy(e->label, "unknown memory");
> > -		if (type == HW_EVENT_ERR_CORRECTED) {
> > -			if (row >= 0) {
> > -				mci->csrows[row]->ce_count += error_count;
> > -				if (chan >= 0)
> > -					mci->csrows[row]->channels[chan]->ce_count += error_count;
> > -			}
> > -		} else
> > -			if (row >= 0)
> > -				mci->csrows[row]->ue_count += error_count;
> > -	}
> > +	else if (!*e->label)
> > +		strcpy(e->label, "unknown memory");
> > +
> > +	edac_inc_csrow(e, row, chan);
> 
> Err, but this has functional changes: the !e->enable_per_layer_report
> case sets only the e->label and the else branch only does increment
> ->ce_count.
> 
> Your change gets ->ce_count incremented in both cases.

No, there is a check in edac_inc_csrow(): if (row < 0) ... In the case
of "any memory", row is also < 0, so nothing is counted. This is
reasonable since no dimm is found and row/channel is still set to the
setup value of -1.

-Robert
