Return-Path: <linux-edac+bounces-1632-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839A894C453
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2024 20:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F201C221D8
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2024 18:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C891146A83;
	Thu,  8 Aug 2024 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltQdlRHO"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE1178C98;
	Thu,  8 Aug 2024 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141709; cv=none; b=nkfMU6pfB/g2h7ZbpvFMcY5ILH9H43rqK0aM+fhZvmkdKynJ7C698pHFtPun/KU3n8hjqdjkGv9sAQEeqrmaMkah5f77TDCGjlxKq8XzZGVKQCf4FMcPclcPq3daV+aj3skb47VISrpaP+diphurMOSuIHs7DaZZIB+BCcA1WMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141709; c=relaxed/simple;
	bh=DBWdlq8SezUJpQ3Dp+nyDwcDPUROy6hy8Y7XPrskYrM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6WXYPouyzPWhTDRFKdMwf2OSWNHHjBsulTVzbMf2+eBAZ2KM4gJ5VNBCmW0GTUs25WvPf2e+pl5t7sKEI36c7TZBqcqLL5n+c2USK5sv/4r5WcwelzyhN4p0DfjfbWu3HpiQB+/RjTE/h93fbc6CHczP/ownpaO8loi+H/bVlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltQdlRHO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70eaf5874ddso1067973b3a.3;
        Thu, 08 Aug 2024 11:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723141707; x=1723746507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x/eKB9adD5vtAdH+AHSGnKrabRcrcGFa4QNQ7bMcvU8=;
        b=ltQdlRHO4p8khJijlWcmci50Y2UD2QBABeJ8mdUrwa1YEILUvq6TY7osH6bd5FBvqy
         VqAheJMXYZkiGZjnKxr2fHxOyzHE0Rl2BT1QK/vnOtzXylf6ZjUnknnIz+yKJrNcB9rf
         HgPm601a9OYHEUhm2ENeMqmvE7d8muJVCAjSTSm/Re8RgRZgGlUiKF+J+emcEF5qF3vH
         rEkYk9UQHdu1cJ0/n9p30PYg9CuuP0sZsAoKtrv17LFwRMRYgcYqXurO9o/ESuH9fsgn
         Zis4Q+gZsv2Ybp6ywSwfbBBspjbjVYzK4baEYIIDoPpzd/u4sn/4vACJb9BIbc0M+9Vp
         irww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723141707; x=1723746507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/eKB9adD5vtAdH+AHSGnKrabRcrcGFa4QNQ7bMcvU8=;
        b=U+w0962rvqrGpptYfxdnYVNkdmpyUHRK8adjHqRbTxsfLat8uvX9emlbs8rH5fAfzu
         PcALLZ1Ko40peluAuB09IFXTkGvYw4yD21Juuk0/IfF/hQkcd5nDofvmTEANxGgmdVE2
         8K4W+fRZJJk9+iGgkjJUwTb1RV2A/BpVO9pvU/kh/oAbYwgrl7rx78aFE7kJaeRKlNiH
         e0vKmLVc+WA/X4gops706KKgEoQkOL6ZEBDDZZeAXePSYspMLEXnm3i6AHEui1PA4EfG
         5jSs6L/URgCE2WrEBwVzLVgCTKFygmD8ldR255LVrc9I7/xmN9aPoZHVqcT7+qjlNpHl
         ES6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyPsM8Kc2UmtGI6YHWTwCNsNKyVJ0SPn5e+zVj+ZX4ZVjpz2suClvFTpVEYQgWxBsFkOIyzwP+zylJ1y5rhYys4H5rM5q5ZyAHAZKm6Nx/DexYTUSqacf9QY/it+OVjo8dsdtQ+w==
X-Gm-Message-State: AOJu0YxwOdZ5bC1E3O9AmvUx7bNnIdwO1H98CjH8t/nj/cF0JVH18hM/
	AwuL7AxW8rq9zdL8kx6hIs8DfJ/fSqozv+3FXJlGZVPBRjCqycxe
X-Google-Smtp-Source: AGHT+IHhCjRuTNDogtGzrIlZwTbvqVxHATIyO9zKjrlxrDbVkksTgDVka1CaxP0T7jfYts3GQuVkZQ==
X-Received: by 2002:a05:6a20:4313:b0:1c3:3436:a244 with SMTP id adf61e73a8af0-1c6fceb871emr3559685637.1.1723141706780;
        Thu, 08 Aug 2024 11:28:26 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:ba5b:a13:cdb6:fb15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2d0355sm1408586b3a.118.2024.08.08.11.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 11:28:26 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 8 Aug 2024 11:28:05 -0700
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-mm@kvack.org,
	dan.j.williams@intel.com, vishal.l.verma@intel.com,
	Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
	bp@alien8.de, dave.jiang@intel.com, dave@stgolabs.net,
	ira.weiny@intel.com, james.morse@arm.com, linmiaohe@huawei.com,
	mchehab@kernel.org, nao.horiguchi@gmail.com, rric@kernel.org,
	tony.luck@intel.com
Subject: Re: [PATCH v4 1/2] cxl/core: introduce device reporting poison
 hanlding
Message-ID: <ZrUONRvQf4M6CNCh@fan>
References: <20240808151328.707869-1-ruansy.fnst@fujitsu.com>
 <20240808151328.707869-2-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808151328.707869-2-ruansy.fnst@fujitsu.com>

On Thu, Aug 08, 2024 at 11:13:27PM +0800, Shiyang Ruan wrote:
> CXL device can find&report memory problems, even before MCE is detected
> by CPU.  AFAIK, the current kernel only traces POISON error event
> from FW-First/OS-First path, but it doesn't handle them, neither
> notify processes who are using the POISON page like MCE does.
> 
> Thus, user have to read logs from trace and find out which device
> reported the error and which applications are affected.  That is not
> an easy work and cannot be handled in time.  Thus, it is needed to add
> the feature to make the work done automatically and quickly.  Once CXL
> device reports the POISON error (via FW-First/OS-First), kernel
> handles it immediately, similar to the flow when a MCE is triggered.
> 
> The current call trace of error reporting&handling looks like this:
> ```
> 1.  MCE (interrupt #18, while CPU consuming POISON)
>      -> do_machine_check()
>        -> mce_log()
>          -> notify chain (x86_mce_decoder_chain)
>            -> memory_failure()
> 
> 2.a FW-First (optional, CXL device proactively find&report)
>      -> CXL device -> Firmware
>        -> OS: ACPI->APEI->GHES->CPER -> CXL driver -> trace
>                                                   \-> memory_failure()
>                                                       ^----- ADD
> 2.b OS-First (optional, CXL device proactively find&report)
>      -> CXL device -> MSI
>        -> OS: CXL driver -> trace
>                         \-> memory_failure()
>                             ^------------------------------- ADD
> ```
> This patch adds calling memory_failure() while CXL device reporting
> error is received, marked as "ADD" in figure above.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/mbox.c   | 75 ++++++++++++++++++++++++++++++++-------
>  drivers/cxl/cxlmem.h      |  8 ++---
>  drivers/cxl/pci.c         |  4 +--
>  include/linux/cxl-event.h | 16 ++++++++-
>  4 files changed, 83 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index e5cdeafdf76e..0cb6ef2e6600 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -849,10 +849,55 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
>  
> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -			    enum cxl_event_log_type type,
> -			    enum cxl_event_type event_type,
> -			    const uuid_t *uuid, union cxl_event *evt)
> +static void cxl_report_poison(struct cxl_memdev *cxlmd, u64 hpa)
> +{
> +	unsigned long pfn = PHYS_PFN(hpa);
> +
> +	memory_failure_queue(pfn, 0);
> +}
> +
> +static void cxl_event_handle_general_media(struct cxl_memdev *cxlmd,
> +					   enum cxl_event_log_type type,
> +					   u64 hpa,
> +					   struct cxl_event_gen_media *rec)
> +{
> +	if (type == CXL_EVENT_TYPE_FAIL) {
> +		switch (rec->media_hdr.transaction_type) {
> +		case CXL_EVENT_TRANSACTION_READ:
> +		case CXL_EVENT_TRANSACTION_WRITE:
> +		case CXL_EVENT_TRANSACTION_SCAN_MEDIA:
> +		case CXL_EVENT_TRANSACTION_INJECT_POISON:
> +			cxl_report_poison(cxlmd, hpa);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +static void cxl_event_handle_dram(struct cxl_memdev *cxlmd,
> +				  enum cxl_event_log_type type,
> +				  u64 hpa,
> +				  struct cxl_event_dram *rec)
> +{
> +	if (type == CXL_EVENT_TYPE_FAIL) {
> +		switch (rec->media_hdr.transaction_type) {
> +		case CXL_EVENT_TRANSACTION_READ:
> +		case CXL_EVENT_TRANSACTION_WRITE:
> +		case CXL_EVENT_TRANSACTION_SCAN_MEDIA:
> +		case CXL_EVENT_TRANSACTION_INJECT_POISON:
> +			cxl_report_poison(cxlmd, hpa);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +void cxl_event_handle_record(struct cxl_memdev *cxlmd,
> +			     enum cxl_event_log_type type,
> +			     enum cxl_event_type event_type,
> +			     const uuid_t *uuid, union cxl_event *evt)
>  {
>  	if (event_type == CXL_CPER_EVENT_MEM_MODULE) {
>  		trace_cxl_memory_module(cxlmd, type, &evt->mem_module);
> @@ -880,18 +925,22 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  		if (cxlr)
>  			hpa = cxl_dpa_to_hpa(cxlr, cxlmd, dpa);
>  
> -		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
> +		if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
>  						&evt->gen_media);
> -		else if (event_type == CXL_CPER_EVENT_DRAM)
> +			cxl_event_handle_general_media(cxlmd, type, hpa,
> +						&evt->gen_media);
> +		} else if (event_type == CXL_CPER_EVENT_DRAM) {
>  			trace_cxl_dram(cxlmd, type, cxlr, hpa, &evt->dram);
> +			cxl_event_handle_dram(cxlmd, type, hpa, &evt->dram);

Does it make sense to call the trace function in
cxl_event_handle_dram/general_media and replace the trace function with
the handle_* here?

> +		}
>  	}
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
> +EXPORT_SYMBOL_NS_GPL(cxl_event_handle_record, CXL);
>  
> -static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -				     enum cxl_event_log_type type,
> -				     struct cxl_event_record_raw *record)
> +static void __cxl_event_handle_record(struct cxl_memdev *cxlmd,
> +				      enum cxl_event_log_type type,
> +				      struct cxl_event_record_raw *record)
>  {
>  	enum cxl_event_type ev_type = CXL_CPER_EVENT_GENERIC;
>  	const uuid_t *uuid = &record->id;
> @@ -903,7 +952,7 @@ static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  	else if (uuid_equal(uuid, &CXL_EVENT_MEM_MODULE_UUID))
>  		ev_type = CXL_CPER_EVENT_MEM_MODULE;
>  
> -	cxl_event_trace_record(cxlmd, type, ev_type, uuid, &record->event);
> +	cxl_event_handle_record(cxlmd, type, ev_type, uuid, &record->event);
>  }
>  
>  static int cxl_clear_event_record(struct cxl_memdev_state *mds,
> @@ -1012,8 +1061,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  			break;
>  
>  		for (i = 0; i < nr_rec; i++)
> -			__cxl_event_trace_record(cxlmd, type,
> -						 &payload->records[i]);
> +			__cxl_event_handle_record(cxlmd, type,
> +						  &payload->records[i]);
>  
>  		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>  			trace_cxl_overflow(cxlmd, type, payload);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index afb53d058d62..5c4810dcbdeb 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -826,10 +826,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
>  				  unsigned long *cmds);
>  void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
> -void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> -			    enum cxl_event_log_type type,
> -			    enum cxl_event_type event_type,
> -			    const uuid_t *uuid, union cxl_event *evt);
> +void cxl_event_handle_record(struct cxl_memdev *cxlmd,
> +			     enum cxl_event_log_type type,
> +			     enum cxl_event_type event_type,
> +			     const uuid_t *uuid, union cxl_event *evt);
>  int cxl_set_timestamp(struct cxl_memdev_state *mds);
>  int cxl_poison_state_init(struct cxl_memdev_state *mds);
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4be35dc22202..6e65ca89f666 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1029,8 +1029,8 @@ static void cxl_handle_cper_event(enum cxl_event_type ev_type,
>  	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
>  	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
>  
> -	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type,
> -			       &uuid_null, &rec->event);
> +	cxl_event_handle_record(cxlds->cxlmd, log_type, ev_type,
> +				&uuid_null, &rec->event);
>  }
>  
>  static void cxl_cper_work_fn(struct work_struct *work)
> diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
> index 0bea1afbd747..be4342a2b597 100644
> --- a/include/linux/cxl-event.h
> +++ b/include/linux/cxl-event.h
> @@ -7,6 +7,20 @@
>  #include <linux/uuid.h>
>  #include <linux/workqueue_types.h>
>  
> +/*
> + * Event transaction type
> + * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43

Here and below, update the specification reference to reflect cxl 3.1.

Fan
> + */
> +enum cxl_event_transaction_type {
> +	CXL_EVENT_TRANSACTION_UNKNOWN = 0X00,
> +	CXL_EVENT_TRANSACTION_READ,
> +	CXL_EVENT_TRANSACTION_WRITE,
> +	CXL_EVENT_TRANSACTION_SCAN_MEDIA,
> +	CXL_EVENT_TRANSACTION_INJECT_POISON,
> +	CXL_EVENT_TRANSACTION_MEDIA_SCRUB,
> +	CXL_EVENT_TRANSACTION_MEDIA_MANAGEMENT,
> +};
> +
>  /*
>   * Common Event Record Format
>   * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> @@ -26,7 +40,7 @@ struct cxl_event_media_hdr {
>  	__le64 phys_addr;
>  	u8 descriptor;
>  	u8 type;
> -	u8 transaction_type;
> +	u8 transaction_type;	/* enum cxl_event_transaction_type */
>  	/*
>  	 * The meaning of Validity Flags from bit 2 is
>  	 * different across DRAM and General Media records
> -- 
> 2.34.1
> 

