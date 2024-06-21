Return-Path: <linux-edac+bounces-1333-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481D591221D
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2024 12:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC76528875C
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2024 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F8117165E;
	Fri, 21 Jun 2024 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="cjiAtJFn"
X-Original-To: linux-edac@vger.kernel.org
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6FA171641;
	Fri, 21 Jun 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965012; cv=none; b=df0xnWOTYFi0piCnI0uoXZ2/hzOFWa8WvhBI+hCl6pA6jzq7UXdNbTULR82hXowV1iib8cZjZJHID8cJq0PNbauHY6Cq38fDlEdBJV8zj6x4RjrNNqlb5OVuz/Pg3V5GbqDXoovWR8pv6u2Uq14h1Fr6qVYYQWdJPHAoitW3nfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965012; c=relaxed/simple;
	bh=FL0ybe9oSjt/xHXdA51SYGX9XM4ph1qt9P2lcHNgOg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bXa4skj9I4Q+/1ujzgFM++xyjU/HMC+TcVcXbo1dql+ah3pVhWZK1+B38+N613Y9fedzRKZDLBpO1FrwKkCOQ+tuXTYpPT6yc5bBYbSQO1Csz9JK7s+TFXrjyDLpYS8dYdGL910NSB3MH0nRKAgz/MjcpGpoUrpixbRJMGaIu6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=cjiAtJFn; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718965009; x=1750501009;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FL0ybe9oSjt/xHXdA51SYGX9XM4ph1qt9P2lcHNgOg4=;
  b=cjiAtJFn8EmeF44LaUOpVNbAj0otjr0B1kS7NN9U/tk/TSVLv4RHtz3k
   6f7yzf7QyFjeZcPV+dp4d5RAWeOMyv8Fxvq+C4JPrJqn6tMhBx5EKYnIh
   f3nZcNIfQWTWFq8/J97y21t8KcpiJfVxNrlGCx54rJvkd/ESF9Rqvr7Nx
   HXKriY1J7hiTpNrJzJFkOZ3gsGUaIvzG6RZqrgPEAKBLK7xwnvpsGoiA+
   PG2E3aC+FQmI/UQjTJ02+osN4lS4iW7l/0pXHSavbpwUgWTU1E/qYWkjz
   rIvJp6FLMHCio98amxMfJmmAepQAopvCwmcmIfxCVCvwtmUHTBiSNsr24
   w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="166346656"
X-IronPort-AV: E=Sophos;i="6.08,254,1712588400"; 
   d="scan'208";a="166346656"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 19:16:39 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8A067C68E1;
	Fri, 21 Jun 2024 19:16:37 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id D4C7FD7B71;
	Fri, 21 Jun 2024 19:16:36 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5BAADE5E05;
	Fri, 21 Jun 2024 19:16:36 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B55371A0002;
	Fri, 21 Jun 2024 18:16:34 +0800 (CST)
Message-ID: <83c705ce-a013-4a88-adcd-18dbc16d88df@fujitsu.com>
Date: Fri, 21 Jun 2024 18:16:33 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, dave@stgolabs.net, ira.weiny@intel.com,
 alison.schofield@intel.com, dave.jiang@intel.com, vishal.l.verma@intel.com,
 Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
 linux-edac@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
 <20240620180239.00004d41@Huawei.com>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20240620180239.00004d41@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28468.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28468.004
X-TMASE-Result: 10--30.233600-10.000000
X-TMASE-MatchedRID: OnXFgg5KIq2PvrMjLFD6eKn9fPsu8s0a2q80vLACqaeqvcIF1TcLYLBk
	jjdoOP1bp3Z/y3zTL9+zN6XcSN8uuHerlGbz8OXFolVO7uyOCDUXivwflisSrEJsNXD374+pO+W
	Rk1kOc5MCcJ+0x3yT8twnF1a+MpDfC5dVqsgzBjuOFfLQqF6P0tUEOicf335WUoV94zwLp3VJ9L
	43nm/22bqZhYf6F5ZElyW1ZrZx68b/awIuxLRW1EhwlOfYeSqxlDt5PQMgj00zAwv94MqCLh8aR
	hKglPt8mNVEdxRO2BKiQrGQ0QrIUcfdkIlEiI2knVTWWiNp+v/0swHSFcVJ6DxzAG47ocHfBk0s
	RysFrTA+flhazaw2+PtIw293QqFjj4s0JN6UudnfqVBdB7I8UeTuQvwGTH36sqiKlYBJQxguJaP
	bC+kbrOmOkdLRzR1Y63smvwVtnbpFFCG8sIFUT7nHu4BcYSmtwTlc9CcHMZerwqxtE531VBFup4
	CINH3JYGFrrc6fVM/HUvCTKXIuFlE/ARLVFdXaA3HGs3zFTqgGsbP1/fAnOf/PlfQrPF26UqOSl
	IOIhgkKJfF2LeZOj/OKfz3NcveUOn+bl8FgKwanOYknDZ/QocMKxxeacM3vqU5CNByvM6VNMJgQ
	uMz4JUFg+UhPNwox9J777fUg1RCR9GF2J2xqM4MbH85DUZXyudR/NJw2JHcNYpvo9xW+mI6HM5r
	qDwqtlExlQIQeRG0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/6/21 1:02, Jonathan Cameron 写道:
> On Wed, 19 Jun 2024 00:53:10 +0800
> Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
> 
>> Background:
>> Since CXL device is a memory device, while CPU consumes a poison page of
>> CXL device, it always triggers a MCE by interrupt (INT18), no matter
>> which-First path is configured.  This is the first report.  Then
>> currently, in FW-First path, the poison event is transferred according
>> to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHES
>>   -> CPER -> trace report.  This is the second one.  These two reports
>> are indicating the same poisoning page, which is the so-called "duplicate
>> report"[1].  And the memory_failure() handling I'm trying to add in
>> OS-First path could also be another duplicate report.
>>
>> Hope the flow below could make it easier to understand:
>> CPU accesses bad memory on CXL device, then
>>   -> MCE (INT18), *always* report (1)
>>   -> * FW-First (implemented now)
>>        -> CXL device -> FW
>> 	      -> OS:ACPI->APEI->GHES->CPER -> trace report (2.a)
>>      * OS-First (not implemented yet, I'm working on it)
>>        -> CXL device -> MSI
>> 	      -> OS:CXL driver -> memory_failure() (2.b)
>> so, the (1) and (2.a/b) are duplicated.
>>
>> (I didn't get response in my reply for [1] while I have to make patch to
>> solve this problem, so please correct me if my understanding is wrong.)
>>
>> This patch adds a new notifier_block and MCE_PRIO_CXL, for CXL memdev
>> to check whether the current poison page has been reported (if yes,
>> stop the notifier chain, won't call the following memory_failure()
>> to report), into `x86_mce_decoder_chain`.  In this way, if the poison
>> page already handled(recorded and reported) in (1) or (2), the other one
>> won't duplicate the report.  The record could be clear when
>> cxl_clear_poison() is called.
>>
>> [1] https://lore.kernel.org/linux-cxl/664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch/
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> 
> So poison can be cleared in a number of ways and a CXL poison clear command
> is unfortunately only one of them.  Some architectures have instructions
> that guarantee to write a whole cacheline and can clear things as well.
> I believe x86 does for starters.

According to the CXL Spec, to clear an error record on device, an 
explicit clear operation is required (I think this means sending a mbox 
command).  I'm not sure if it is able to clear device error by just 
writing a whole cacheline.

> 
> +CC linux-edac and related maintainers / reviewers.
>      linux-mm and hwpoison maintainer.
> 
> So I think this needs a more general solution that encompasses
> more general cleanup of poison.
> 
> Trivial comments inline.

Thanks

> 
> Jonathan
> 
> 
>> ---
>>   arch/x86/include/asm/mce.h |   1 +
>>   drivers/cxl/core/mbox.c    | 130 +++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/core/memdev.c  |   6 +-
>>   drivers/cxl/cxlmem.h       |   3 +
>>   4 files changed, 139 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
>> index dfd2e9699bd7..d8109c48e7d9 100644
>> --- a/arch/x86/include/asm/mce.h
>> +++ b/arch/x86/include/asm/mce.h
>> @@ -182,6 +182,7 @@ enum mce_notifier_prios {
>>   	MCE_PRIO_NFIT,
>>   	MCE_PRIO_EXTLOG,
>>   	MCE_PRIO_UC,
>> +	MCE_PRIO_CXL,
>>   	MCE_PRIO_EARLY,
>>   	MCE_PRIO_CEC,
>>   	MCE_PRIO_HIGHEST = MCE_PRIO_CEC
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index 2626f3fff201..0eb3c5401e81 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -4,6 +4,8 @@
>>   #include <linux/debugfs.h>
>>   #include <linux/ktime.h>
>>   #include <linux/mutex.h>
>> +#include <linux/notifier.h>
>> +#include <asm/mce.h>
>>   #include <asm/unaligned.h>
>>   #include <cxlpci.h>
>>   #include <cxlmem.h>
>> @@ -880,6 +882,9 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>>   		if (cxlr)
>>   			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
>>   
>> +		if (hpa != ULLONG_MAX && cxl_mce_recorded(hpa))
>> +			return;
>> +
>>   		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>>   			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
>>   						&evt->gen_media);
>> @@ -1408,6 +1413,127 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
>>   
>> +struct cxl_mce_record {
>> +	struct list_head node;
>> +	u64 hpa;
>> +};
>> +LIST_HEAD(cxl_mce_records);
>> +DEFINE_MUTEX(cxl_mce_mutex);
>> +
>> +bool cxl_mce_recorded(u64 hpa)
>> +{
>> +	struct cxl_mce_record *cur, *next, *rec;
>> +	int rc;
>> +
>> +	rc = mutex_lock_interruptible(&cxl_mce_mutex);
> 
> guard(mutex)(&cxl_mce_muted);
> 
>> +	if (rc)
>> +		return false;
>> +
>> +	list_for_each_entry_safe(cur, next, &cxl_mce_records, node) {
>> +		if (cur->hpa == hpa) {
>> +			mutex_unlock(&cxl_mce_mutex);
>> +			return true;
>> +		}
>> +	}
>> +
>> +	rec = kmalloc(sizeof(struct cxl_mce_record), GFP_KERNEL);
>> +	rec->hpa = hpa;
>> +	list_add(&cxl_mce_records, &rec->node);
>> +
>> +	mutex_unlock(&cxl_mce_mutex);
>> +
>> +	return false;
>> +}
>> +
>> +void cxl_mce_clear(u64 hpa)
>> +{
>> +	struct cxl_mce_record *cur, *next;
>> +	int rc;
>> +
>> +	rc = mutex_lock_interruptible(&cxl_mce_mutex);
> 
> Maybe cond_guard().

Ok, this is better.  I'll use automatic clean locks instead.


--
Thanks,
Ruan.

> 
>> +	if (rc)
>> +		return;
>> +
>> +	list_for_each_entry_safe(cur, next, &cxl_mce_records, node) {
>> +		if (cur->hpa == hpa) {
>> +			list_del(&cur->node);
>> +			break;
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&cxl_mce_mutex);
>> +}
>> +
>> +struct cxl_contains_hpa_context {
>> +	bool contains;
>> +	u64 hpa;
>> +};
>> +
>> +static int __cxl_contains_hpa(struct device *dev, void *arg)
>> +{
>> +	struct cxl_contains_hpa_context *ctx = arg;
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct range *range;
>> +	u64 hpa = ctx->hpa;
>> +
>> +	if (!is_endpoint_decoder(dev))
>> +		return 0;
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	range = &cxled->cxld.hpa_range;
>> +
>> +	if (range->start <= hpa && hpa <= range->end) {
>> +		ctx->contains = true;
>> +		return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static bool cxl_contains_hpa(const struct cxl_memdev *cxlmd, u64 hpa)
>> +{
>> +	struct cxl_contains_hpa_context ctx = {
>> +		.contains = false,
>> +		.hpa = hpa,
>> +	};
>> +	struct cxl_port *port;
>> +
>> +	port = cxlmd->endpoint;
>> +	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
>> +		device_for_each_child(&port->dev, &ctx, __cxl_contains_hpa);
>> +
>> +	return ctx.contains;
>> +}
>> +
>> +static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
>> +			  void *data)
>> +{
>> +	struct mce *mce = (struct mce *)data;
>> +	struct cxl_memdev_state *mds = container_of(nb, struct cxl_memdev_state,
>> +						    mce_notifier);
>> +	u64 hpa;
>> +
>> +	if (!mce || !mce_usable_address(mce))
>> +		return NOTIFY_DONE;
>> +
>> +	hpa = mce->addr & MCI_ADDR_PHYSADDR;
>> +
>> +	/* Check if the PFN is located on this CXL device */
>> +	if (!pfn_valid(hpa >> PAGE_SHIFT) &&
>> +	    !cxl_contains_hpa(mds->cxlds.cxlmd, hpa))
>> +		return NOTIFY_DONE;
>> +
>> +	/*
>> +	 * Search PFN in the cxl_mce_records, if already exists, don't continue
>> +	 * to do memory_failure() to avoid a poison address being reported
>> +	 * more than once.
>> +	 */
>> +	if (cxl_mce_recorded(hpa))
>> +		return NOTIFY_STOP;
>> +	else
>> +		return NOTIFY_OK;
>> +}
>> +
>>   struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>>   {
>>   	struct cxl_memdev_state *mds;
>> @@ -1427,6 +1553,10 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>>   	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
>>   	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
>>   
>> +	mds->mce_notifier.notifier_call = cxl_handle_mce;
>> +	mds->mce_notifier.priority = MCE_PRIO_CXL;
>> +	mce_register_decode_chain(&mds->mce_notifier);
>> +
>>   	return mds;
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, CXL);
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 0277726afd04..aa3ac89d17be 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -376,10 +376,14 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>>   		goto out;
>>   
>>   	cxlr = cxl_dpa_to_region(cxlmd, dpa);
>> -	if (cxlr)
>> +	if (cxlr) {
>> +		u64 hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
>> +
>> +		cxl_mce_clear(hpa);
>>   		dev_warn_once(mds->cxlds.dev,
>>   			      "poison clear dpa:%#llx region: %s\n", dpa,
>>   			      dev_name(&cxlr->dev));
>> +	}
>>   
>>   	record = (struct cxl_poison_record) {
>>   		.address = cpu_to_le64(dpa),
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 19aba81cdf13..fbf8d9f46984 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -501,6 +501,7 @@ struct cxl_memdev_state {
>>   	struct cxl_fw_state fw;
>>   
>>   	struct rcuwait mbox_wait;
>> +	struct notifier_block mce_notifier;
>>   	int (*mbox_send)(struct cxl_memdev_state *mds,
>>   			 struct cxl_mbox_cmd *cmd);
>>   };
>> @@ -836,6 +837,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>>   int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>>   int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>>   int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>> +bool cxl_mce_recorded(u64 pfn);
>> +void cxl_mce_clear(u64 pfn);
>>   
>>   #ifdef CONFIG_CXL_SUSPEND
>>   void cxl_mem_active_inc(void);
> 

