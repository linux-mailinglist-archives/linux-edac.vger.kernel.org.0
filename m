Return-Path: <linux-edac+bounces-3953-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BE5ABD46E
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 12:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E4B189ACD2
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 10:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518AD2686AA;
	Tue, 20 May 2025 10:21:53 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245B267F59;
	Tue, 20 May 2025 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747736513; cv=none; b=hOrqJi2erPhJ5gGEsr+s/Rgd55FdyvhCZ1Xg/ypd6YAVJBBBWkZsDfQ388riznNv1KXpdpNWd50rS8/XZdmgjPEeBT8dyXMaZq/xkkB5bFlb3jiH4AZ7Osr9IRE1nqC/JLxLWrNArNEyHOeOfQptCqYzyivxAi2D+Lvcmz2rhi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747736513; c=relaxed/simple;
	bh=VREl+V2fOxBTK3UCySo6txqXRYFz0TN6kSgb4Badq0c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGIIgBQjVUvNLOtzkWEi9AQjfxiyCibbr9HARrnuiL0iPM0Q5W12SCuCzzHYRSHm75HarovnXSnyvBxXIeqbsQ8Rv/VbsNAX035eaROvY2HZZFsqwVOUf82ncAfeLFYUewMYpHRzYdGxnDQ/emdZCUNkAPWVDVQcYfV9RgWYV7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1r9q2hxZz6L5Lh;
	Tue, 20 May 2025 18:18:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3951E140447;
	Tue, 20 May 2025 18:21:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 May
 2025 12:21:46 +0200
Date: Tue, 20 May 2025 11:21:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>, <bp@alien8.de>,
	<tony.luck@intel.com>, <lenb@kernel.org>, <Yazen.Ghannam@amd.com>,
	<mchehab@kernel.org>, <nifan.cxl@gmail.com>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<roberto.sassu@huawei.com>, <kangkang.shen@futurewei.com>,
	<wanghuiqiang@huawei.com>
Subject: Re: [PATCH v5 3/8] cxl/edac: Add CXL memory device patrol scrub
 control feature
Message-ID: <20250520112144.000067b6@huawei.com>
In-Reply-To: <aCviqcNwQCUokZhl@aschofie-mobl2.lan>
References: <20250515115927.772-1-shiju.jose@huawei.com>
	<20250515115927.772-4-shiju.jose@huawei.com>
	<aCviqcNwQCUokZhl@aschofie-mobl2.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 19 May 2025 19:02:17 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Thu, May 15, 2025 at 12:59:19PM +0100, shiju.jose@huawei.com wrote:
> > From: Shiju Jose <shiju.jose@huawei.com>
> > 
> > CXL spec 3.2 section 8.2.10.9.11.1 describes the device patrol scrub
> > control feature. The device patrol scrub proactively locates and makes
> > corrections to errors in regular cycle.
> >   
> 
> snip
> 
> > +
> > +static int cxl_scrub_get_attrbs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
> > +				u8 *cap, u16 *cycle, u8 *flags, u8 *min_cycle)
> > +{
> > +	struct cxl_mailbox *cxl_mbox;
> > +	u8 min_scrub_cycle = U8_MAX;
> > +	struct cxl_memdev *cxlmd;
> > +	int i, ret;
> > +
> > +	if (cxl_ps_ctx->cxlr) {
> > +		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
> > +		struct cxl_region_params *p = &cxlr->params;  
> 
> This function and the next, have a big if { } wrapper around
> cxlr existence. Can this logic be reversed -
> 
> ie, declare cxl_region and cxl_region_params in the header and
> then do something like - 
> 
> 	if (!cxl_ps_ctx->cxlr) {
> 		cxl_mbox = &cxl_ps_ctx->cxlmd->cxlds->cxl_mbox;
> 		return cxl_mem_scrub_get_attrbs(cxl_mbox, cap, cycle, flags, min_cycle);
> 	}
> 
> 	cxlr =  cxl_ps_ctx->cxlr;
> 	p = &cxlr->params;
> 
> Then all this code below can shift left.

See below - I'd factor out the region and no region cases because
then it will looks same as messier case below.

> 
> > +
> > +		struct rw_semaphore *region_lock __free(rwsem_read_release) =
> > +			rwsem_read_intr_acquire(&cxl_region_rwsem);
> > +		if (!region_lock)
> > +			return -EINTR;
> > +
> > +		for (i = 0; i < p->nr_targets; i++) {
> > +			struct cxl_endpoint_decoder *cxled = p->targets[i];
> > +
> > +			cxlmd = cxled_to_memdev(cxled);
> > +			cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> > +			ret = cxl_mem_scrub_get_attrbs(cxl_mbox, cap, cycle,
> > +						       flags, min_cycle);
> > +			if (ret)
> > +				return ret;
> > +
> > +			if (min_cycle)
> > +				min_scrub_cycle =
> > +					min(*min_cycle, min_scrub_cycle);
> > +		}
> > +
> > +		if (min_cycle)
> > +			*min_cycle = min_scrub_cycle;
> > +
> > +		return 0;
> > +	}
> > +	cxl_mbox = &cxl_ps_ctx->cxlmd->cxlds->cxl_mbox;
> > +
> > +	return cxl_mem_scrub_get_attrbs(cxl_mbox, cap, cycle, flags, min_cycle);
> > +}
> > +
> > +static int cxl_scrub_set_attrbs(struct device *dev,
> > +				struct cxl_patrol_scrub_context *cxl_ps_ctx,
> > +				u8 cycle, u8 flags)
> > +{
> > +	struct cxl_scrub_wr_attrbs wr_attrbs;
> > +	struct cxl_mailbox *cxl_mbox;
> > +	struct cxl_memdev *cxlmd;
> > +	int ret, i;
> > +
> > +	wr_attrbs.scrub_cycle_hours = cycle;
> > +	wr_attrbs.scrub_flags = flags;
> > +
> > +	if (cxl_ps_ctx->cxlr) {
> > +		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
> > +		struct cxl_region_params *p = &cxlr->params;  
> 
> Similar to above function, but more work in the !cxlr case. Maybe a goto.
> 

A goto would be nasty. Given almost total lack of shared code
why not have
cxl_scrub_set_attrbs_region() and
cxl_scrub_set_attrbs_device() 

and this just becomes
	if (cxl_ps_cts->cxlr)
		return cxl_scrub_set_attrbs_region(dev, cxl_ps_ctx, cycle, flags);
	return cxl_scrub_set_attrbs_device(dev, cxl_ps_ctx, cycle, flags);

(or something along those lines anyway)

> 
> > +
> > +		struct rw_semaphore *region_lock __free(rwsem_read_release) =
> > +			rwsem_read_intr_acquire(&cxl_region_rwsem);
> > +		if (!region_lock)
> > +			return -EINTR;
> > +
> > +		for (i = 0; i < p->nr_targets; i++) {
> > +			struct cxl_endpoint_decoder *cxled = p->targets[i];
> > +
> > +			cxlmd = cxled_to_memdev(cxled);
> > +			cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> > +			ret = cxl_set_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
> > +					      cxl_ps_ctx->set_version, &wr_attrbs,
> > +					      sizeof(wr_attrbs),
> > +					      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET,
> > +					      0, NULL);
> > +			if (ret)
> > +				return ret;
> > +
> > +			if (cycle != cxlmd->cur_scrub_cycle) {
> > +				if (cxlmd->cur_region_id != -1)
> > +					dev_info(dev,
> > +						 "Device scrub rate(%d hours) set by region%d rate overwritten by region%d scrub rate(%d hours)\n",
> > +						 cxlmd->cur_scrub_cycle,
> > +						 cxlmd->cur_region_id, cxlr->id,
> > +						 cycle);
> > +
> > +				cxlmd->cur_scrub_cycle = cycle;
> > +				cxlmd->cur_region_id = cxlr->id;
> > +			}
> > +		}
> > +
> > +		return 0;
> > +	}
> > +
> > +	cxlmd = cxl_ps_ctx->cxlmd;
> > +	cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> > +	ret = cxl_set_feature(cxl_mbox, &CXL_FEAT_PATROL_SCRUB_UUID,
> > +			      cxl_ps_ctx->set_version, &wr_attrbs,
> > +			      sizeof(wr_attrbs),
> > +			      CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET, 0,
> > +			      NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (cycle != cxlmd->cur_scrub_cycle) {
> > +		if (cxlmd->cur_region_id != -1)
> > +			dev_info(dev,
> > +				 "Device scrub rate(%d hours) set by region%d rate overwritten with device local scrub rate(%d hours)\n",
> > +				 cxlmd->cur_scrub_cycle, cxlmd->cur_region_id,
> > +				 cycle);
> > +
> > +		cxlmd->cur_scrub_cycle = cycle;
> > +		cxlmd->cur_region_id = -1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +  



