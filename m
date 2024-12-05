Return-Path: <linux-edac+bounces-2648-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 762129E5F40
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2024 21:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17BC1884BDC
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2024 20:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E631E22F381;
	Thu,  5 Dec 2024 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="TTp7zXUL"
X-Original-To: linux-edac@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E93122D4F7;
	Thu,  5 Dec 2024 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733429162; cv=none; b=bbHqoZLYTHfxXMFKgP3ir96sL1nS+wvKypgb+cmAY4pAQqvsf6/Qchi8dpudfJ5PTaU9cylSzOQil9lIIhVVerCUwSUdVEsMe39J1FkcQ/aeyAckqy6VsTBBu4DyQpB3H5BbEKPP+5qVqN4LcKwros1oRXX8ryw9opuBveczUcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733429162; c=relaxed/simple;
	bh=6O79edKEb4GROwGT6JZk8xHtDN2CVYHr2a+2azD6wUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YniCS8WJLRu8WIfMWzkOu5Jp3szRu9wD1EfETj8wucaSML2mW2rtkwMWe84sHeLdkwJ1qNJStLPLxjVlsb+9+vEBtJf9ybljjJ+8WOlg2uKDt6FmlVK56IfXnRza35RaV+J2mzYYp/joLfM9WPt3z5NGd4MKia2ewMbb158BidQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=TTp7zXUL; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5K35HG006806;
	Thu, 5 Dec 2024 20:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=FB2pybYxR/ua/8GwkHyNXMBbIt
	OCCjVb1LKr1v+2g8A=; b=TTp7zXULVeDbxSdeDOtnprkM+R11sd/xLJH+A6JnTI
	dhaZJB6+4OYdr2Fi5iADt91ni3DMdHgSuGQylsDUg5oKxeAFJZb1V6cgmh7ywkeG
	8Tm76POeRmbjkxcVS++UREas7OPWh0QMlcRsI/SWyLXzZ6vvo/qGZ9Fu68t3OgWu
	bWciZRJEBdOFahhDjEvMUAOEazUMArZJff6cd8g0ivBYDw1s0yazV2ecPS/Q3zp9
	G26nKFTFbhMxEaY3DVlukNkiw9vRLDB040NjEiuEptTV/tAhdzbWLy1hw+D9Z0CO
	czHkTvEWnn6GHDjPGNqQ4smUtr8Xx1izmztcYBcrWA0g==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 43bjvar0k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 20:05:44 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 7BF4B2D84B;
	Thu,  5 Dec 2024 20:05:38 +0000 (UTC)
Received: from DESKTOP-V47QP3F. (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id AF941813DD6;
	Thu,  5 Dec 2024 20:05:37 +0000 (UTC)
Date: Thu, 5 Dec 2024 14:05:36 -0600
From: Kyle Meyer <kyle.meyer@hpe.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: bp@alien8.de, james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/{i10nm,skx,skx_common}: Support multiple clumps
Message-ID: <Z1IHkBlm_0p-0-c3@hpe.com>
References: <20241205165954.7957-1-kyle.meyer@hpe.com>
 <Z1H7U9-O2LdAoa5r@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1H7U9-O2LdAoa5r@agluck-desk3>
X-Proofpoint-GUID: jwm1n_Lo41bfoCt46MrY-9xkGDQkozJI
X-Proofpoint-ORIG-GUID: jwm1n_Lo41bfoCt46MrY-9xkGDQkozJI
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050149

On Thu, Dec 05, 2024 at 11:13:23AM -0800, Luck, Tony wrote:
> On Thu, Dec 05, 2024 at 10:59:54AM -0600, Kyle Meyer wrote:
> > The 3-bit source IDs in PCI configuration space registers are limited to
> > 8 unique IDs, and each ID is local to a clump (UPI/QPI domain).
> 
> Is there any better name than "clump"?

Yes, a UPI/QPI domain.

> > Source IDs can not be used to map devices to sockets on systems with
> > multiple clumps because each clump has identical repeating source IDs.
> > 
> > Get package IDs instead of source IDs on systems with multiple clumps
> > and use package/source IDs to name IMC information structures.
> 
> What would happen if you just assumed the system had clumps and you
> always used package/source? Would that change EDAC naming for
> existing systems? That would be less complexity for the driver.

That works if NUMA is enabled. skx_get_pkg_id() uses NUMA information to
determine the package ID.
 
> > Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> > ---
> >  drivers/edac/i10nm_base.c | 21 +++++++++-------
> >  drivers/edac/skx_base.c   | 19 ++++++++------
> >  drivers/edac/skx_common.c | 52 +++++++++++++++++++++++++++++++++------
> >  drivers/edac/skx_common.h |  5 ++--
> >  4 files changed, 71 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
> > index 51556c72a967..59384677d025 100644
> > --- a/drivers/edac/i10nm_base.c
> > +++ b/drivers/edac/i10nm_base.c
> > @@ -1010,7 +1010,7 @@ static struct notifier_block i10nm_mce_dec = {
> >  
> >  static int __init i10nm_init(void)
> >  {
> > -	u8 mc = 0, src_id = 0, node_id = 0;
> > +	u8 mc = 0, src_id = 0;
> >  	const struct x86_cpu_id *id;
> >  	struct res_config *cfg;
> >  	const char *owner;
> > @@ -1018,6 +1018,7 @@ static int __init i10nm_init(void)
> >  	int rc, i, off[3] = {0xd0, 0xc8, 0xcc};
> >  	u64 tolm, tohm;
> >  	int imc_num;
> > +	int dup_src_ids = 0;
> >  
> >  	edac_dbg(2, "\n");
> >  
> > @@ -1065,24 +1066,26 @@ static int __init i10nm_init(void)
> >  
> >  	imc_num = res_cfg->ddr_imc_num + res_cfg->hbm_imc_num;
> >  
> > -	list_for_each_entry(d, i10nm_edac_list, list) {
> > -		rc = skx_get_src_id(d, 0xf8, &src_id);
> > -		if (rc < 0)
> > -			goto fail;
> > +	rc = dup_src_ids = skx_check_dup_src_ids(0xf8);
> 
> Checkpatch complains about this: "multiple assignments should be
> avoided"
> 
> > +	if (rc < 0)
> > +		goto fail;
> >  
> > -		rc = skx_get_node_id(d, &node_id);
> > +	list_for_each_entry(d, i10nm_edac_list, list) {
> > +		if (dup_src_ids)
> > +			rc = skx_get_pkg_id(d, &src_id);
> > +		else
> > +			rc = skx_get_src_id(d, 0xf8, &src_id);
> >  		if (rc < 0)
> >  			goto fail;
> >  
> > -		edac_dbg(2, "src_id = %d node_id = %d\n", src_id, node_id);
> > +		edac_dbg(2, "src_id = %d\n", src_id);
> >  		for (i = 0; i < imc_num; i++) {
> >  			if (!d->imc[i].mdev)
> >  				continue;
> >  
> >  			d->imc[i].mc  = mc++;
> >  			d->imc[i].lmc = i;
> > -			d->imc[i].src_id  = src_id;
> > -			d->imc[i].node_id = node_id;
> > +			d->imc[i].src_id = src_id;
> >  			if (d->imc[i].hbm_mc) {
> >  				d->imc[i].chan_mmio_sz = cfg->hbm_chan_mmio_sz;
> >  				d->imc[i].num_channels = cfg->hbm_chan_num;
> > diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
> > index 14cfd394b469..189b8c5a1bda 100644
> > --- a/drivers/edac/skx_base.c
> > +++ b/drivers/edac/skx_base.c
> > @@ -600,8 +600,9 @@ static int __init skx_init(void)
> >  	const struct munit *m;
> >  	const char *owner;
> >  	int rc = 0, i, off[3] = {0xd0, 0xd4, 0xd8};
> > -	u8 mc = 0, src_id, node_id;
> > +	u8 mc = 0, src_id;
> >  	struct skx_dev *d;
> > +	int dup_src_ids = 0;
> >  
> >  	edac_dbg(2, "\n");
> >  
> > @@ -646,19 +647,23 @@ static int __init skx_init(void)
> >  		}
> >  	}
> >  
> > +	rc = dup_src_ids = skx_check_dup_src_ids(0xf0);
> 
> Checkpatch complains about this: "multiple assignments should be
> avoided"

That's strange, my scripts/checkpatch.pl didn't complain. I'll avoid that going
forward.

Thanks,
Kyle Meyer

