Return-Path: <linux-edac+bounces-1712-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59835959F1D
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 15:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B6028423C
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 13:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF7D1AF4E6;
	Wed, 21 Aug 2024 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ik3CmFaW"
X-Original-To: linux-edac@vger.kernel.org
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD72F199946;
	Wed, 21 Aug 2024 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724248641; cv=none; b=nl1FAIEiEBXs40qAZXkXmbPm/bRMSh3boKBEwCHNwchKe6pc7nP/uvjM+2Sjp/IIN0hEd6eSquxjWvy3f1oMf0rXwiUrbUVGqE+YVIc2AE+8h7ii7HHvSyfEd6ypx+hjpxXBp4tYm6JCF1fmUpWNr59vPHTDz2g34TWksN3v0w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724248641; c=relaxed/simple;
	bh=Vmns/KCkTSIUEDDrY1N4NuJbDBwwQf3ZYG53AW+z+IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2peJIC/3dxCpJTxSA3DfImziGj9Ih8qlnwLWhCcUAUA2w+1DqzA/GcKY4zR3RfL7BapPJd9x615HbeSQ9vvYmNtn6J/KLtUss1TU0iPqSgGcaBZGFWVSJpQFZzxZB3uyLQ9WonV0WwviNFlIg9Ux7+pPzpVZK6ekISrpp8ArMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ik3CmFaW; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1724248636; x=1755784636;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Vmns/KCkTSIUEDDrY1N4NuJbDBwwQf3ZYG53AW+z+IU=;
  b=ik3CmFaWA6FHu+Q8Edj2e5idFXCnV9n0XKOBnSuAIdOxq8roRnsN3e25
   Mao4qwM/B7DqMnSVihV3ZmvA61wjk7oyZcG9j40Rh9ZkakedbL/N05E5u
   TpQOxsEpwA+tjAS4leyhmpMZJkdUWbgnOXgFXaJL8i12bnaZPLpVaSaJw
   X8tB9XI0VgztfZo+j7bN/q3ZII0S8lznPdzB5EH9WKW/rflsdS1TaZsgx
   PHizmsqE6+eZMEsjy+T9PHgdqBTBErBBjdb/3qPzKURPUnOKjf5Sk24hE
   fVOWFZuO8oBT1e316OYVPylHv/xu+EKG7/LnWmbnC6n9bLqoBlH28FKz0
   A==;
X-CSE-ConnectionGUID: 6pMzSiX4TKGJbtJRU6Ya9g==
X-CSE-MsgGUID: vrtwK+nNQ8GcyIUNfvDP0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="150659870"
X-IronPort-AV: E=Sophos;i="6.10,164,1719846000"; 
   d="scan'208";a="150659870"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 22:57:07 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 45BE7D6473;
	Wed, 21 Aug 2024 22:57:06 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 81F9BBF3C8;
	Wed, 21 Aug 2024 22:57:05 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 126C122460B;
	Wed, 21 Aug 2024 22:57:05 +0900 (JST)
Received: from [10.193.128.195] (unknown [10.193.128.195])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 215D91A000A;
	Wed, 21 Aug 2024 21:57:03 +0800 (CST)
Message-ID: <f136caa2-5e2f-4b58-9490-823cb85eaa21@fujitsu.com>
Date: Wed, 21 Aug 2024 21:57:02 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] cxl/core: introduce device reporting poison
 hanlding
To: Fan Ni <nifan.cxl@gmail.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-mm@kvack.org, dan.j.williams@intel.com,
 vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
 alison.schofield@intel.com, bp@alien8.de, dave.jiang@intel.com,
 dave@stgolabs.net, ira.weiny@intel.com, james.morse@arm.com,
 linmiaohe@huawei.com, mchehab@kernel.org, nao.horiguchi@gmail.com,
 rric@kernel.org, tony.luck@intel.com
References: <20240808151328.707869-1-ruansy.fnst@fujitsu.com>
 <20240808151328.707869-2-ruansy.fnst@fujitsu.com> <ZrUONRvQf4M6CNCh@fan>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <ZrUONRvQf4M6CNCh@fan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28608.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28608.007
X-TMASE-Result: 10--23.928600-10.000000
X-TMASE-MatchedRID: C0Xwo0Y+vY2PvrMjLFD6eKn9fPsu8s0a2q80vLACqaeqvcIF1TcLYLBk
	jjdoOP1bW9EH4+AJvKPMrGM6h+7YUICoSWHZmQrDKiJEqUFWRghZDdHiTk9OcJDHQ2MaZXz4jK1
	xN9jQWTmEkt/L8HtAJ6Y70l+keWg+/iG8k6NejseJJ72DuZB0nDnOm2OHJgpY/gMNehoKqTtSRG
	QAFjO+uHeO6Bj0fYm80+j23NMt8oZujdbubeNfI52wBULX+gacQ1Zooh0EhXhXGTbsQqHbks2fh
	/Vuh6xFrs8eT/x5DzdWHSUfKtrk8CZ0TtZEfDmeTuctSpiuWyUUi4Ehat0545Tx+2LIqNmtJstK
	1NXQZJeXYZQAF2E+zIMuR75hY8zA9H//YyhN9ge4u3nS+3EEDvi4nVERfgwdZ7MN8KplzpwY20f
	1wrB11o3fDvBOMJyVk0bQDJF2wJjev27akzvuZt+pUF0HsjxRmF/+S9oK0r2vloAnGr4qhkINRX
	nZvSBfgEx/MZlaMxXBlU8KFeeE9VABpNhnDlEI9k0tWBWiOf8th3LBMeXue3HBbiUCoeceWnMen
	dKlFy9E/RFnPTO/Q/Z5MzLbDyyOmmJTaSCgYAvG+nS24MzHeX0tCKdnhB581B0Hk1Q1KyIOsECO
	9s+GHnQdJ7XfU86ekGUtrowrXLg=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/8/9 2:28, Fan Ni 写道:
> On Thu, Aug 08, 2024 at 11:13:27PM +0800, Shiyang Ruan wrote:
>> CXL device can find&report memory problems, even before MCE is detected
>> by CPU.  AFAIK, the current kernel only traces POISON error event
>> from FW-First/OS-First path, but it doesn't handle them, neither
>> notify processes who are using the POISON page like MCE does.
>>
>> Thus, user have to read logs from trace and find out which device
>> reported the error and which applications are affected.  That is not
>> an easy work and cannot be handled in time.  Thus, it is needed to add
>> the feature to make the work done automatically and quickly.  Once CXL
>> device reports the POISON error (via FW-First/OS-First), kernel
>> handles it immediately, similar to the flow when a MCE is triggered.
>>
>> The current call trace of error reporting&handling looks like this:
>> ```
>> 1.  MCE (interrupt #18, while CPU consuming POISON)
>>       -> do_machine_check()
>>         -> mce_log()
>>           -> notify chain (x86_mce_decoder_chain)
>>             -> memory_failure()
>>
>> 2.a FW-First (optional, CXL device proactively find&report)
>>       -> CXL device -> Firmware
>>         -> OS: ACPI->APEI->GHES->CPER -> CXL driver -> trace
>>                                                    \-> memory_failure()
>>                                                        ^----- ADD
>> 2.b OS-First (optional, CXL device proactively find&report)
>>       -> CXL device -> MSI
>>         -> OS: CXL driver -> trace
>>                          \-> memory_failure()
>>                              ^------------------------------- ADD
>> ```
>> This patch adds calling memory_failure() while CXL device reporting
>> error is received, marked as "ADD" in figure above.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   drivers/cxl/core/mbox.c   | 75 ++++++++++++++++++++++++++++++++-------
>>   drivers/cxl/cxlmem.h      |  8 ++---
>>   drivers/cxl/pci.c         |  4 +--
>>   include/linux/cxl-event.h | 16 ++++++++-
>>   4 files changed, 83 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index e5cdeafdf76e..0cb6ef2e6600 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -849,10 +849,55 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>>   
>> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>> -			    enum cxl_event_log_type type,
>> -			    enum cxl_event_type event_type,
>> -			    const uuid_t *uuid, union cxl_event *evt)
>> +static void cxl_report_poison(struct cxl_memdev *cxlmd, u64 hpa)
>> +{
>> +	unsigned long pfn = PHYS_PFN(hpa);
>> +
>> +	memory_failure_queue(pfn, 0);
>> +}
>> +
>> +static void cxl_event_handle_general_media(struct cxl_memdev *cxlmd,
>> +					   enum cxl_event_log_type type,
>> +					   u64 hpa,
>> +					   struct cxl_event_gen_media *rec)
>> +{
>> +	if (type == CXL_EVENT_TYPE_FAIL) {
>> +		switch (rec->media_hdr.transaction_type) {
>> +		case CXL_EVENT_TRANSACTION_READ:
>> +		case CXL_EVENT_TRANSACTION_WRITE:
>> +		case CXL_EVENT_TRANSACTION_SCAN_MEDIA:
>> +		case CXL_EVENT_TRANSACTION_INJECT_POISON:
>> +			cxl_report_poison(cxlmd, hpa);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>> +static void cxl_event_handle_dram(struct cxl_memdev *cxlmd,
>> +				  enum cxl_event_log_type type,
>> +				  u64 hpa,
>> +				  struct cxl_event_dram *rec)
>> +{
>> +	if (type == CXL_EVENT_TYPE_FAIL) {
>> +		switch (rec->media_hdr.transaction_type) {
>> +		case CXL_EVENT_TRANSACTION_READ:
>> +		case CXL_EVENT_TRANSACTION_WRITE:
>> +		case CXL_EVENT_TRANSACTION_SCAN_MEDIA:
>> +		case CXL_EVENT_TRANSACTION_INJECT_POISON:
>> +			cxl_report_poison(cxlmd, hpa);
>> +			break;
>> +		default:
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>> +void cxl_event_handle_record(struct cxl_memdev *cxlmd,
>> +			     enum cxl_event_log_type type,
>> +			     enum cxl_event_type event_type,
>> +			     const uuid_t *uuid, union cxl_event *evt)
>>   {
>>   	if (event_type == CXL_CPER_EVENT_MEM_MODULE) {
>>   		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
>> @@ -880,18 +925,22 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>>   		if (cxlr)
>>   			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
>>   
>> -		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>> +		if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
>>   			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
>>   						&evt->gen_media);
>> -		else if (event_type == CXL_CPER_EVENT_DRAM)
>> +			cxl_event_handle_general_media(cxlmd, type, hpa,
>> +						&evt->gen_media);
>> +		} else if (event_type == CXL_CPER_EVENT_DRAM) {
>>   			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->dram);
>> +			cxl_event_handle_dram(cxlmd, type, hpa, &evt->dram);
> 
> Does it make sense to call the trace function in
> cxl_event_handle_dram/general_media and replace the trace function with
> the handle_* here?

Sorry for late reply.  I'm not really good at naming functions.  Since 
the trace functions already have the framework to deal with each kind of 
uuids and event types, I don't think we should make another one for the 
same logics.  Thus, I reused it and renamed the functions.  Maybe 
"handle" isn't a good word to describe "tracing records and doing 
memory_failure if necessary".  Could you help me to name it better?

> 
>> +		}
>>   	}
>>   }
>> -EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
>> +EXPORT_SYMBOL_NS_GPL(cxl_event_handle_record, CXL);
>>   
>> -static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>> -				     enum cxl_event_log_type type,
>> -				     struct cxl_event_record_raw *record)
>> +static void __cxl_event_handle_record(struct cxl_memdev *cxlmd,
>> +				      enum cxl_event_log_type type,
>> +				      struct cxl_event_record_raw *record)
>>   {
>>   	enum cxl_event_type ev_type = CXL_CPER_EVENT_GENERIC;
>>   	const uuid_t *uuid = &record->id;
>> @@ -903,7 +952,7 @@ static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>>   	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
>>   		ev_type = CXL_CPER_EVENT_MEM_MODULE;
>>   
>> -	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
>> +	cxl_event_handle_record(cxlmd, type, ev_type, uuid, &record->event);
>>   }
>>   
>>   static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>> @@ -1012,8 +1061,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>>   			break;
>>   
>>   		for (i = 0; i < nr_rec; i++)
>> -			__cxl_event_trace_record(cxlmd, type,
>> -						 &payload->records[i]);
>> +			__cxl_event_handle_record(cxlmd, type,
>> +						  &payload->records[i]);
>>   
>>   		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>>   			trace_cxl_overflow(cxlmd, type, payload);
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index afb53d058d62..5c4810dcbdeb 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -826,10 +826,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>>   void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>>   				  unsigned long *cmds);
>>   void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
>> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>> -			    enum cxl_event_log_type type,
>> -			    enum cxl_event_type event_type,
>> -			    const uuid_t *uuid, union cxl_event *evt);
>> +void cxl_event_handle_record(struct cxl_memdev *cxlmd,
>> +			     enum cxl_event_log_type type,
>> +			     enum cxl_event_type event_type,
>> +			     const uuid_t *uuid, union cxl_event *evt);
>>   int cxl_set_timestamp(struct cxl_memdev_state *mds);
>>   int cxl_poison_state_init(struct cxl_memdev_state *mds);
>>   int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 4be35dc22202..6e65ca89f666 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -1029,8 +1029,8 @@ static void cxl_handle_cper_event(enum cxl_event_type ev_type,
>>   	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
>>   	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
>>   
>> -	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type,
>> -			       &uuid_null, &rec->event);
>> +	cxl_event_handle_record(cxlds->cxlmd, log_type, ev_type,
>> +				&uuid_null, &rec->event);
>>   }
>>   
>>   static void cxl_cper_work_fn(struct work_struct *work)
>> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
>> index 0bea1afbd747..be4342a2b597 100644
>> --- a/include/linux/cxl-event.h
>> +++ b/include/linux/cxl-event.h
>> @@ -7,6 +7,20 @@
>>   #include <linux/uuid.h>
>>   #include <linux/workqueue_types.h>
>>   
>> +/*
>> + * Event transaction type
>> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
> 
> Here and below, update the specification reference to reflect cxl 3.1.

Ok. Will update it.


--
Thanks,
Ruan.

> 
> Fan
>> + */
>> +enum cxl_event_transaction_type {
>> +	CXL_EVENT_TRANSACTION_UNKNOWN = 0X00,
>> +	CXL_EVENT_TRANSACTION_READ,
>> +	CXL_EVENT_TRANSACTION_WRITE,
>> +	CXL_EVENT_TRANSACTION_SCAN_MEDIA,
>> +	CXL_EVENT_TRANSACTION_INJECT_POISON,
>> +	CXL_EVENT_TRANSACTION_MEDIA_SCRUB,
>> +	CXL_EVENT_TRANSACTION_MEDIA_MANAGEMENT,
>> +};
>> +
>>   /*
>>    * Common Event Record Format
>>    * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
>> @@ -26,7 +40,7 @@ struct cxl_event_media_hdr {
>>   	__le64 phys_addr;
>>   	u8 descriptor;
>>   	u8 type;
>> -	u8 transaction_type;
>> +	u8 transaction_type;	/* enum cxl_event_transaction_type */
>>   	/*
>>   	 * The meaning of Validity Flags from bit 2 is
>>   	 * different across DRAM and General Media records
>> -- 
>> 2.34.1
>>

