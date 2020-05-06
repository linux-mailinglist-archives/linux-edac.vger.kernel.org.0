Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877AA1C6C2C
	for <lists+linux-edac@lfdr.de>; Wed,  6 May 2020 10:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgEFIrD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 May 2020 04:47:03 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:15360 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728884AbgEFIrC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 6 May 2020 04:47:02 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0468kGr3031586;
        Wed, 6 May 2020 01:46:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pfpt0818; bh=dBTOW3f0vsEBWRIQe6VCsZG/5V9FTbaADDOzPgfm+aU=;
 b=pbtp9UUQFq1MTCzLyrIn0/c9xYzviZz++ichUTYS1TxL2osProRSqJ5Pb2Hi2K3jHnwz
 zFIGez3u3J9xsBtvPF5611R5ONXNcBw7Ahd/Oy/0iG0oHqPXdrCL9n99EikdhNxSKvBR
 smLTlmYTDJXtxq1272YMSfvaNBD3x9ftb9GmkDGI40dBAUHkTxFhf6syuLeoRFIT8CDn
 PuGWrLexgrQRKG1fi8xUmEsUAssEICQ0ebLl/ybJgbPUurubhRWYXAr62XjHy2h4MS2d
 peTQRq8VvhkQbSnp6RuHZ+hfBIeiblBn3ylPZT/Bjy4zwn1EJPrfbCInF0Z0e4DsbB6F fA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 30uaukv6ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 01:46:45 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 6 May
 2020 01:46:44 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.50) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 6 May 2020 01:46:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8YtXKfn5qsM2b4xo46e9MxRimOKHlN7H286wnLDFZLk56I7Ejrxcx3xVUdRGLB1hxqSFR7romweDoAqbQ0UOj4Rlexh3CqMp1KsoRsCvoWdU3QPw5tWJC4lI7qd/6BkUPJ6YYwbDtB5Vfmb2L1T83zaRTjFrthSbQDt8QhSqO8yh+YFBHxucnSsz91HpviuT0y1yariB6TKzpLShIxuLx2KTXJLah5CP0iPwwhpKc86dYyZGNLTeF0ve4qF6U8jcH+1JNqEzYapFek4YQRFN6/4AuFsCazV6sPEiB8WTbhdd+B7J3unnFf13FAns2GuR1qe5PNsC56YkAitTbyOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBTOW3f0vsEBWRIQe6VCsZG/5V9FTbaADDOzPgfm+aU=;
 b=V3ixoJmcYCX8PcwPcLTeTwboLvwZf6M71GGLZOs7HlMGuhEb4mLP0PBNyG22MMub1DzimL7+y1+KbeVRj3mTcuMQ+gOsjiIQeaCietum5OPONisOE07VE4RIk40nylDddoq6YwOtq+7f8VEnBqe4yLigjxzzjJsz5bCti7P8l0i7Sj9NiRJ04e61zVsxUckHglb8ufgtxZ9fPCqktSDPkvcXGodvQ3KIBoRD36z3gr6s+XoIH3V6cHEUTbcji+dgztSH/hdESVPj5iUXoO7ylUwMWhjBjOBX3fnxVCC8pxB9sA7Xyc14FqyYQ9q88LUDRn2S4pNZ6AiFIPa4LQkPJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBTOW3f0vsEBWRIQe6VCsZG/5V9FTbaADDOzPgfm+aU=;
 b=rKDcVWcaI/EdO0cg8eUkmBjwHyCvDpON7KsqGqkQ9aidIZlSO22plPjqCcFWt91DBiQqv0Kido5hgf1qPTNgXj6hEXN/89D55BYv8KA1b+lSXUOSE/Tv2Jh61GRbJRlPym+lw0OvsMDKoRgfoK/JSw0aaRm8G2EEOtukGHjav50=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2408.namprd18.prod.outlook.com (2603:10b6:a03:12f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Wed, 6 May
 2020 08:46:43 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 08:46:43 +0000
Date:   Wed, 6 May 2020 10:45:59 +0200
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/10] EDAC/ghes: Carve out MC device handling into
 separate functions
Message-ID: <20200506084558.tcayd2fuzoe6rsfm@rric.localdomain>
References: <20200422115814.22205-1-rrichter@marvell.com>
 <20200422115814.22205-9-rrichter@marvell.com>
 <20200427163856.GG11036@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427163856.GG11036@zn.tnic>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: HE1PR05CA0198.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::22) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR05CA0198.eurprd05.prod.outlook.com (2603:10a6:3:f9::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 08:46:41 +0000
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4a11c9a-d28f-41d8-e6bf-08d7f19a0058
X-MS-TrafficTypeDiagnostic: BYAPR18MB2408:
X-Microsoft-Antispam-PRVS: <BYAPR18MB2408ED404D27CC14ED24F411D9A40@BYAPR18MB2408.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aiEwEoY/EvZLiqYJCCSiBlx8I/D4fpTq/+DDEmXfsYYOrqpT1v15WgczTNwWM10YJzik4ZAwB9pgaR+rlcEDm/ZOS8Mkyr8bVDsFuNm8Oe6y4bp1UPDbPZECZkDibkx8YiiiQtBaFYg63omP8SAePpAyPvySlFe0KH2Zrnbii9VxlA+2RP+lqyrBxKXaBYXEeRJJLjnNTuQby2AVaY/uwvWZ65v/tVXyIa9zH0kLPfsh2T/NJ6n1VDR+yY6xLSMJg9JaU/li6TkvS53IknEsz8NH0s6xjpxMUDcE1veFD6KgH0gfmsBGLIERGagpSJu2iVEp2cHP266VdsjXnIfXbmLevdq8OsZzRKn3uLTuUMVE7AhqjyxthhpKyfVDziXUpzf+meFVn7Qgb0Uky+wQWeQ0sgMUF32UGczWqXK32mJGKdwAa+ImRW9N5TjJllKDhRef/OdbgxAcuaNKhwrEDOnIZoXaI3WVjr0wKElnw7tSrZGIWdXgZeqpajWapm4CyynPHGwwA6oCn6IcewO9UA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(33430700001)(55016002)(9686003)(8676002)(86362001)(1076003)(8936002)(52116002)(26005)(6506007)(186003)(7696005)(53546011)(316002)(54906003)(6666004)(956004)(33440700001)(16526019)(6916009)(5660300002)(66476007)(66556008)(66946007)(478600001)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: g8X+GbdSg45KnXyQr7GJ9a207kYQT28+f1rftFITakl3E1bXpqr4dn0n8UkoXkVxwPIAQp3bZQWD+MPooGYZOiVfUuWto3Q/b+7Fsg3LN0qFONMeiYJRFs12zBJls4yo27XmFK2z3S1JMiWppG7vg+icyW0q9Hy4oPbLawzjQtoxsn7G3vTDtE+5rJjO+VFbCZgpft6ejXQE4lZzkH6O3+TlTnvJA/rzjFZII895/I+yih/Rj6eoMfHmyDxxdwLqmWPLuz8NPihHCFxDi8GjkZ/tUBlt/NCKQ84IC8u1tRacDxTOxpygttYBbLI3AQRwNFHb57zEI4qzLj7oGBUAWJxxBR7t3IDoQGPuaSGbrjjLr9fOfHfyokfaVe+h1HpGbqLOvG3BX4tbDuMHtJA5cvHceUCzA5cJSvxXJGqdAUStXYadzCBvc9MPVSH0FFb+Cb27Hx3DPoq3i8CQ0uwOglCITASI+wNMKXknZ7B7W/l0QUQVplj8iE+MFMuellHQaFQJzpxnU8ZF49SAWE+Mqc/tt8xWZwwXt7hLYxwr8Nv31oEZjQNgtjd8ffICiDhvk5g7CxzQy2O5Dpzyo7LJ4IZFhUREyYM9L5w6SR2NNfoE74+mg3r/N37U798GjLSAjcb60hPY9q7rbB8AAYjs+lEoKX3psunIfaJg1+26uCKZuijecovVPe/iW+MUBGlbNY5vQhFZ5GMWbae18Lf/+yXBrS/iqi8P4gK4jEY2X4ohZKdMnnDYenfDnSKCbBZAn/bYEeyFMwLXS8hUpgfbwQGO89sCwE4lP3s4Hwk4VkE=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a11c9a-d28f-41d8-e6bf-08d7f19a0058
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 08:46:43.3206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDHg4dTlPaKd/wuBC2wc8K5B7F5dWbeJrfsexjqcPPEx4B/tTNg/hfZYBJ3F2qEERukymyntlby+i7w+YtbQvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2408
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-06_03:2020-05-04,2020-05-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 27.04.20 18:38:56, Borislav Petkov wrote:
> On Wed, Apr 22, 2020 at 01:58:12PM +0200, Robert Richter wrote:

> > +static int ghes_mc_add_or_free(struct mem_ctl_info *mci,
> > +			struct list_head *dimm_list)
> 
> No, I think we talked about this already. This function should be
> called:
> 
> 	ghes_mc_add()
> 
> and should do one thing and one thing only in good old unix tradition:
> add the MC.
> 
> > +{
> >  	unsigned long flags;
> > -	int idx = -1;
> > +	int rc;
> > +
> > +	rc = edac_mc_add_mc(mci);
> > +	if (rc < 0) {
> 
> > +		ghes_dimm_release(dimm_list);
> > +		edac_mc_free(mci);
> > +		return rc;
> 
> Those last three lines should be called by the *caller* of
> ghes_mc_add(), when latter returns an error value.

These direct operations are nothing a caller should deal with.

The caller does now:

	mci = ghes_mc_create(...);
	... /* prepare dimms */
	return ghes_mc_add_or_free(...);

To shut it down we just use:

	ghes_mc_free();

Pretty simple.

Now, lets look at your suggestion to put it out of the function. A
caller always needs to free the mci and dimms, so we will get:

	int rc;
	mci = ghes_mc_create(...);
	... /* prepare dimms */
	rc = ghes_mc_add(...);
	if (rc < 0) {
		/* free mci */
		/* free dimms */
		...
	}
	return rc;

We loose the tail call and simplicity here. Note this duplicates code
as there are 2 users of ghes_mc_add().

Now, the caller does not know the implementation details, so we need
to provide another release function (let's call it *_release() here):

	mci = ghes_mc_create(...);
	... /* prepare dimms */
	rc = ghes_mc_add(...);
	if (rc < 0) {
		ghes_mc_release(mci);
		ghes_dimm_release(dimm_list);
	}
	return rc;

Ok, now there is another function needed to release everything.

This design also impacts ghes_mc_free(). So the shutdown
implementation would turn to:

	struct mem_ctl_info *mci;
	...
	mci = ghes_mc_del();
	ghes_mc_release(mci);
	...

I don't see any benefit. See also below for the delta of an
implementation of the suggested changes.

> 
> > +	}
> > +
> > +	spin_lock_irqsave(&ghes_lock, flags);
> > +	ghes_pvt = mci->pvt_info;
> > +	list_splice_tail(dimm_list, &ghes_dimm_list);
> > +	spin_unlock_irqrestore(&ghes_lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static void ghes_mc_free(void)
> > +{
> > +	struct mem_ctl_info *mci;
> > +	unsigned long flags;
> > +	LIST_HEAD(dimm_list);
> > +
> > +	/*
> > +	 * Wait for the irq handler being finished.
> > +	 */
> > +	spin_lock_irqsave(&ghes_lock, flags);
> > +	mci = ghes_pvt ? ghes_pvt->mci : NULL;
> > +	ghes_pvt = NULL;
> > +	list_splice_init(&ghes_dimm_list, &dimm_list);
> > +	spin_unlock_irqrestore(&ghes_lock, flags);
> > +
> > +	ghes_dimm_release(&dimm_list);
> > +
> > +	if (!mci)
> > +		return;
> > +
> > +	mci = edac_mc_del_mc(mci->pdev);
> > +	if (mci)
> > +		edac_mc_free(mci);
> > +}
> 
> This function needs to do only freeing of the mc. The list splicing and
> dimm releasing needs to be done by its caller, before calling it.

ghes_mc_free() is the counterpart to ghes_mc_add() and thus needs to
also handle the dimm_list here. This cannot be left to the caller.

Considering all the above, I don't see how your suggestions to the
interface could improve the code. Hmm...

Below an implementation that illustrates the changes.

Thanks,

-Robert

---
 drivers/edac/ghes_edac.c | 41 +++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 7f39346d895b..896d7b488fc2 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -576,18 +576,14 @@ static struct mem_ctl_info *ghes_mc_create(struct device *dev, int mc_idx,
 	return mci;
 }
 
-static int ghes_mc_add_or_free(struct mem_ctl_info *mci,
-			       struct list_head *dimms)
+static int ghes_mc_add(struct mem_ctl_info *mci, struct list_head *dimms)
 {
 	unsigned long flags;
 	int rc;
 
 	rc = edac_mc_add_mc(mci);
-	if (rc < 0) {
-		dimm_release(dimms);
-		edac_mc_free(mci);
+	if (rc < 0)
 		return rc;
-	}
 
 	spin_lock_irqsave(&ghes_lock, flags);
 	ghes_pvt = mci->pvt_info;
@@ -597,7 +593,7 @@ static int ghes_mc_add_or_free(struct mem_ctl_info *mci,
 	return 0;
 }
 
-static void ghes_mc_free(void)
+static struct mem_ctl_info *ghes_mc_del(void)
 {
 	struct mem_ctl_info *mci;
 	unsigned long flags;
@@ -614,10 +610,14 @@ static void ghes_mc_free(void)
 
 	dimm_release(&dimms);
 
-	if (!mci)
-		return;
+	if (mci)
+		mci = edac_mc_del_mc(mci->pdev);
 
-	mci = edac_mc_del_mc(mci->pdev);
+	return mci;
+}
+
+static void ghes_mc_release(struct mem_ctl_info *mci)
+{
 	if (mci)
 		edac_mc_free(mci);
 }
@@ -627,6 +627,7 @@ static int ghes_edac_register_fake(struct device *dev)
 	struct mem_ctl_info *mci;
 	struct dimm_info *dimm;
 	LIST_HEAD(empty);
+	int rc;
 
 	mci = ghes_mc_create(dev, 0, 1);
 	if (!mci)
@@ -642,13 +643,18 @@ static int ghes_edac_register_fake(struct device *dev)
 
 	snprintf(dimm->label, sizeof(dimm->label), "unknown memory");
 
-	return ghes_mc_add_or_free(mci, &empty);
+	rc = ghes_mc_add(mci, &empty);
+	if (rc < 0)
+		ghes_mc_free(mci);
+
+	return rc;
 }
 
 static int ghes_edac_register_one(struct device *dev, int mc_idx, int num_dimm)
 {
 	struct dimm_fill dimm_fill;
 	struct mem_ctl_info *mci;
+	int rc;
 
 	mci = ghes_mc_create(dev, mc_idx, num_dimm);
 	if (!mci)
@@ -660,7 +666,13 @@ static int ghes_edac_register_one(struct device *dev, int mc_idx, int num_dimm)
 
 	dmi_walk(ghes_edac_dmidecode, &dimm_fill);
 
-	return ghes_mc_add_or_free(mci, &dimm_fill.dimms);
+	rc = ghes_mc_add(mci, &dimm_fill.dimms);
+	if (rc < 0) {
+		dimm_release(&dimm_fill.dimms);
+		ghes_mc_release(mci);
+	}
+
+	return rc;
 }
 
 int ghes_edac_register(struct ghes *ghes, struct device *dev)
@@ -740,10 +752,13 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 
 void ghes_edac_unregister(struct ghes *ghes)
 {
+	struct mem_ctl_info *mci;
+
 	mutex_lock(&ghes_reg_mutex);
 
 	if (refcount_dec_and_test(&ghes_refcount)) {
-		ghes_mc_free();
+		mci = ghes_mc_del();
+		ghes_mc_release(mci);
 		dimm_pool_destroy();
 	}
 
-- 
2.20.1

