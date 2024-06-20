Return-Path: <linux-edac+bounces-1320-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A9E910DF5
	for <lists+linux-edac@lfdr.de>; Thu, 20 Jun 2024 19:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29EB1F23135
	for <lists+linux-edac@lfdr.de>; Thu, 20 Jun 2024 17:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84BF1B29C3;
	Thu, 20 Jun 2024 17:02:45 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00CA1AF6A1;
	Thu, 20 Jun 2024 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902965; cv=none; b=GbC7dhTUNRfRM9QCPoHOQWH24HLSknnerjobcn9mPEiI3l/yY6ebh4a7UniyiGFOYfogHC1e6tt/JjnXAnx+4d6fv+3vLgmcmO1HdCcHge+kQtkE8qVMenKf3KwS7/q6zIWAMDsVblsG1VwzPSSUR+LX91wqtC36XVQPN82CBRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902965; c=relaxed/simple;
	bh=dQyLtb+cJ05rxBQwATIO1FU+2n2lVj3m7CTnnFZdUcA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cW5glJE1IgTqFgxJvPKOtpkoyYRCEqTdZXVqS6LSVtKx5yIVCSjrCa/UCrqGXmIJqA8+5wJoO6CyEWWGkd4VdytQFR6a5HA3VX+uXM/7odAf7jrzKF/mfuDi76jPAeYT8Fwult49JjhyRaC5TfRnGY9vysU7clJahu0FmZ9eqtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4my54BCjz6JB7w;
	Fri, 21 Jun 2024 01:02:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 66567140D27;
	Fri, 21 Jun 2024 01:02:40 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 18:02:39 +0100
Date: Thu, 20 Jun 2024 18:02:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>, <ira.weiny@intel.com>,
	<alison.schofield@intel.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, "James Morse" <james.morse@arm.com>, Mauro Carvalho
 Chehab <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
	<linux-edac@vger.kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, Naoya
 Horiguchi <nao.horiguchi@gmail.com>, <linux-mm@kvack.org>
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
Message-ID: <20240620180239.00004d41@Huawei.com>
In-Reply-To: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 19 Jun 2024 00:53:10 +0800
Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> Background:
> Since CXL device is a memory device, while CPU consumes a poison page of 
> CXL device, it always triggers a MCE by interrupt (INT18), no matter 
> which-First path is configured.  This is the first report.  Then 
> currently, in FW-First path, the poison event is transferred according 
> to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHES 
>  -> CPER -> trace report.  This is the second one.  These two reports  
> are indicating the same poisoning page, which is the so-called "duplicate
> report"[1].  And the memory_failure() handling I'm trying to add in
> OS-First path could also be another duplicate report.
> 
> Hope the flow below could make it easier to understand:
> CPU accesses bad memory on CXL device, then
>  -> MCE (INT18), *always* report (1)
>  -> * FW-First (implemented now)
>       -> CXL device -> FW
> 	      -> OS:ACPI->APEI->GHES->CPER -> trace report (2.a)  
>     * OS-First (not implemented yet, I'm working on it)
>       -> CXL device -> MSI
> 	      -> OS:CXL driver -> memory_failure() (2.b)  
> so, the (1) and (2.a/b) are duplicated.
> 
> (I didn't get response in my reply for [1] while I have to make patch to
> solve this problem, so please correct me if my understanding is wrong.)
> 
> This patch adds a new notifier_block and MCE_PRIO_CXL, for CXL memdev
> to check whether the current poison page has been reported (if yes,
> stop the notifier chain, won't call the following memory_failure()
> to report), into `x86_mce_decoder_chain`.  In this way, if the poison
> page already handled(recorded and reported) in (1) or (2), the other one
> won't duplicate the report.  The record could be clear when
> cxl_clear_poison() is called.
> 
> [1] https://lore.kernel.org/linux-cxl/664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

So poison can be cleared in a number of ways and a CXL poison clear command
is unfortunately only one of them.  Some architectures have instructions
that guarantee to write a whole cacheline and can clear things as well.
I believe x86 does for starters.

+CC linux-edac and related maintainers / reviewers.
    linux-mm and hwpoison maintainer.

So I think this needs a more general solution that encompasses 
more general cleanup of poison.

Trivial comments inline.

Jonathan


> ---
>  arch/x86/include/asm/mce.h |   1 +
>  drivers/cxl/core/mbox.c    | 130 +++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/memdev.c  |   6 +-
>  drivers/cxl/cxlmem.h       |   3 +
>  4 files changed, 139 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index dfd2e9699bd7..d8109c48e7d9 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -182,6 +182,7 @@ enum mce_notifier_prios {
>  	MCE_PRIO_NFIT,
>  	MCE_PRIO_EXTLOG,
>  	MCE_PRIO_UC,
> +	MCE_PRIO_CXL,
>  	MCE_PRIO_EARLY,
>  	MCE_PRIO_CEC,
>  	MCE_PRIO_HIGHEST = MCE_PRIO_CEC
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2626f3fff201..0eb3c5401e81 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -4,6 +4,8 @@
>  #include <linux/debugfs.h>
>  #include <linux/ktime.h>
>  #include <linux/mutex.h>
> +#include <linux/notifier.h>
> +#include <asm/mce.h>
>  #include <asm/unaligned.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
> @@ -880,6 +882,9 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  		if (cxlr)
>  			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
>  
> +		if (hpa != ULLONG_MAX && cxl_mce_recorded(hpa))
> +			return;
> +
>  		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
>  						&evt->gen_media);
> @@ -1408,6 +1413,127 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
>  
> +struct cxl_mce_record {
> +	struct list_head node;
> +	u64 hpa;
> +};
> +LIST_HEAD(cxl_mce_records);
> +DEFINE_MUTEX(cxl_mce_mutex);
> +
> +bool cxl_mce_recorded(u64 hpa)
> +{
> +	struct cxl_mce_record *cur, *next, *rec;
> +	int rc;
> +
> +	rc = mutex_lock_interruptible(&cxl_mce_mutex);

guard(mutex)(&cxl_mce_muted);

> +	if (rc)
> +		return false;
> +
> +	list_for_each_entry_safe(cur, next, &cxl_mce_records, node) {
> +		if (cur->hpa == hpa) {
> +			mutex_unlock(&cxl_mce_mutex);
> +			return true;
> +		}
> +	}
> +
> +	rec = kmalloc(sizeof(struct cxl_mce_record), GFP_KERNEL);
> +	rec->hpa = hpa;
> +	list_add(&cxl_mce_records, &rec->node);
> +
> +	mutex_unlock(&cxl_mce_mutex);
> +
> +	return false;
> +}
> +
> +void cxl_mce_clear(u64 hpa)
> +{
> +	struct cxl_mce_record *cur, *next;
> +	int rc;
> +
> +	rc = mutex_lock_interruptible(&cxl_mce_mutex);

Maybe cond_guard().

> +	if (rc)
> +		return;
> +
> +	list_for_each_entry_safe(cur, next, &cxl_mce_records, node) {
> +		if (cur->hpa == hpa) {
> +			list_del(&cur->node);
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&cxl_mce_mutex);
> +}
> +
> +struct cxl_contains_hpa_context {
> +	bool contains;
> +	u64 hpa;
> +};
> +
> +static int __cxl_contains_hpa(struct device *dev, void *arg)
> +{
> +	struct cxl_contains_hpa_context *ctx = arg;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct range *range;
> +	u64 hpa = ctx->hpa;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	range = &cxled->cxld.hpa_range;
> +
> +	if (range->start <= hpa && hpa <= range->end) {
> +		ctx->contains = true;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool cxl_contains_hpa(const struct cxl_memdev *cxlmd, u64 hpa)
> +{
> +	struct cxl_contains_hpa_context ctx = {
> +		.contains = false,
> +		.hpa = hpa,
> +	};
> +	struct cxl_port *port;
> +
> +	port = cxlmd->endpoint;
> +	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
> +		device_for_each_child(&port->dev, &ctx, __cxl_contains_hpa);
> +
> +	return ctx.contains;
> +}
> +
> +static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
> +			  void *data)
> +{
> +	struct mce *mce = (struct mce *)data;
> +	struct cxl_memdev_state *mds = container_of(nb, struct cxl_memdev_state,
> +						    mce_notifier);
> +	u64 hpa;
> +
> +	if (!mce || !mce_usable_address(mce))
> +		return NOTIFY_DONE;
> +
> +	hpa = mce->addr & MCI_ADDR_PHYSADDR;
> +
> +	/* Check if the PFN is located on this CXL device */
> +	if (!pfn_valid(hpa >> PAGE_SHIFT) &&
> +	    !cxl_contains_hpa(mds->cxlds.cxlmd, hpa))
> +		return NOTIFY_DONE;
> +
> +	/*
> +	 * Search PFN in the cxl_mce_records, if already exists, don't continue
> +	 * to do memory_failure() to avoid a poison address being reported
> +	 * more than once.
> +	 */
> +	if (cxl_mce_recorded(hpa))
> +		return NOTIFY_STOP;
> +	else
> +		return NOTIFY_OK;
> +}
> +
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  {
>  	struct cxl_memdev_state *mds;
> @@ -1427,6 +1553,10 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
>  	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
>  
> +	mds->mce_notifier.notifier_call = cxl_handle_mce;
> +	mds->mce_notifier.priority = MCE_PRIO_CXL;
> +	mce_register_decode_chain(&mds->mce_notifier);
> +
>  	return mds;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, CXL);
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 0277726afd04..aa3ac89d17be 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -376,10 +376,14 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  		goto out;
>  
>  	cxlr = cxl_dpa_to_region(cxlmd, dpa);
> -	if (cxlr)
> +	if (cxlr) {
> +		u64 hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
> +
> +		cxl_mce_clear(hpa);
>  		dev_warn_once(mds->cxlds.dev,
>  			      "poison clear dpa:%#llx region: %s\n", dpa,
>  			      dev_name(&cxlr->dev));
> +	}
>  
>  	record = (struct cxl_poison_record) {
>  		.address = cpu_to_le64(dpa),
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 19aba81cdf13..fbf8d9f46984 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -501,6 +501,7 @@ struct cxl_memdev_state {
>  	struct cxl_fw_state fw;
>  
>  	struct rcuwait mbox_wait;
> +	struct notifier_block mce_notifier;
>  	int (*mbox_send)(struct cxl_memdev_state *mds,
>  			 struct cxl_mbox_cmd *cmd);
>  };
> @@ -836,6 +837,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
> +bool cxl_mce_recorded(u64 pfn);
> +void cxl_mce_clear(u64 pfn);
>  
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);


