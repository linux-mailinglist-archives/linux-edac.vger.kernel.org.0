Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6FC0FBFC2
	for <lists+linux-edac@lfdr.de>; Thu, 14 Nov 2019 06:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfKNFiy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Nov 2019 00:38:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfKNFiy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 14 Nov 2019 00:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HTGF1IQjoTA/dUti9LvA0TqftIfXvhdUOAI7PuXm2nw=; b=GEiOR1Zv/LlvbXbsFy23Dm/tz
        IUAVRrcl9DqM/+Fui2TbflXlm887W7RDSy/TVM9xqG0+W/g/aMY3jbP8R1R1S09cPYLxC4pkWYDET
        Tb0XAbZYvyDqXLQ6j385vT+0fFcE6C5BX2TYE2BUSpSzXk9Zdu33Nnbtji04CXg6r7xjvKYKaMM4h
        oxR/XYDg8JupT7z5Y5m1km0OzNQwvWbfuEFqwdpB4pha3u3SwuPfgskQccaXrD4JPBnxmjSeo4NnD
        nKQ5y3r44818LgFELYm+jeqyfz69kGIWn6i0CmywssORKt4WunGa9aCcNrnpBbEkPwJQFptnXRCAf
        +Qv3BsqOg==;
Received: from [80.156.29.194] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iV7qF-0003ZL-1X; Thu, 14 Nov 2019 05:38:51 +0000
Date:   Thu, 14 Nov 2019 06:38:46 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        <james.morse@arm.com>, <rjw@rjwysocki.net>, <tony.luck@intel.com>,
        <linuxarm@huawei.com>, <ard.biesheuvel@linaro.org>,
        <nariman.poushin@linaro.org>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>
Subject: Re: [PATCH v4 2/6] efi / ras: CCIX Cache error reporting
Message-ID: <20191114063846.60dd8090@kernel.org>
In-Reply-To: <20191113151627.7950-3-Jonathan.Cameron@huawei.com>
References: <20191113151627.7950-1-Jonathan.Cameron@huawei.com>
        <20191113151627.7950-3-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Wed, 13 Nov 2019 23:16:23 +0800
Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:

> As CCIX Request Agents have fully cache coherent caches,
> the CCIX 1.0 Base Specification defines detailed error
> reporting for these caches.
> 
> A CCIX cache error is reported via a CPER record as defined in the
> UEFI 2.8 specification. The PER log section is defined in the
> CCIX 1.0 Base Specification.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/acpi/apei/ghes.c         |   4 +
>  drivers/firmware/efi/cper-ccix.c | 170 +++++++++++++++++++++++++++++++
>  include/linux/cper.h             |  57 +++++++++++
>  include/ras/ras_event.h          |  67 ++++++++++++
>  4 files changed, 298 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 75a177ae9de3..c99a4216b67d 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -517,6 +517,10 @@ static void ghes_handle_ccix_per(struct acpi_hest_generic_data *gdata, int sev)
>  		trace_ccix_memory_error_event(payload, err_seq, sev,
>  					      ccix_mem_err_ven_len_get(payload));
>  		break;
> +	case CCIX_CACHE_ERROR:
> +		trace_ccix_cache_error_event(payload, err_seq, sev,
> +					     ccix_cache_err_ven_len_get(payload));
> +		break;
>  	default:
>  		/* Unknown error type */
>  		pr_info("CCIX error of unknown or vendor defined type\n");
> diff --git a/drivers/firmware/efi/cper-ccix.c b/drivers/firmware/efi/cper-ccix.c
> index 53ab5d650479..14d3f5b8ceab 100644
> --- a/drivers/firmware/efi/cper-ccix.c
> +++ b/drivers/firmware/efi/cper-ccix.c
> @@ -290,6 +290,110 @@ static int cper_ccix_mem_err_details(const char *pfx,
>  	return 0;
>  }
>  
> +static const char * const ccix_cache_type_strs[] = {
> +	"Instruction Cache",
> +	"Data Cache",
> +	"Generic / Unified Cache",
> +	"Snoop Filter Directory",
> +};
> +
> +static const char *cper_ccix_cache_type_str(__u8 type)
> +{
> +	return type < ARRAY_SIZE(ccix_cache_type_strs) ?
> +		ccix_cache_type_strs[type] : "Reserved";
> +}
> +
> +static const char * const ccix_cache_err_type_strs[] = {
> +	"Data",
> +	"Tag",
> +	"Timeout",
> +	"Hang",
> +	"Data Lost",
> +	"Invalid Address",
> +};
> +
> +const char *cper_ccix_cache_err_type_str(__u8 error_type)
> +{
> +	return error_type < ARRAY_SIZE(ccix_cache_err_type_strs) ?
> +		ccix_cache_err_type_strs[error_type] : "Reserved";
> +}
> +
> +static const char * const ccix_cache_err_op_strs[] = {
> +	"Generic",
> +	"Generic Read",
> +	"Generic Write",
> +	"Data Read",
> +	"Data Write",
> +	"Instruction Fetch",
> +	"Prefetch",
> +	"Eviction",
> +	"Snooping",
> +	"Snooped",
> +	"Management / Command Error",
> +};
> +
> +static const char *cper_ccix_cache_err_op_str(__u8 op)
> +{
> +	return op < ARRAY_SIZE(ccix_cache_err_op_strs) ?
> +		ccix_cache_err_op_strs[op] : "Reserved";
> +}
> +
> +static int cper_ccix_cache_err_details(const char *pfx,
> +				     struct acpi_hest_generic_data *gdata)
> +{
> +	struct cper_ccix_cache_error *full_cache_err;
> +	struct cper_sec_ccix_cache_error *cache_err;
> +	u16 vendor_data_len;
> +	int i;
> +
> +	if (gdata->error_data_length < sizeof(*full_cache_err))
> +		return -ENOSPC;
> +
> +	full_cache_err = acpi_hest_get_payload(gdata);
> +
> +	cache_err = &full_cache_err->cache_record;
> +
> +	if (cache_err->validation_bits & CCIX_CACHE_ERR_TYPE_VALID)
> +		printk("%s""Cache Type: %s\n", pfx,
> +		       cper_ccix_cache_type_str(cache_err->cache_type));
> +
> +	if (cache_err->validation_bits & CCIX_CACHE_ERR_OP_VALID)
> +		printk("%s""Operation: %s\n", pfx,
> +		       cper_ccix_cache_err_op_str(cache_err->op_type));
> +
> +	if (cache_err->validation_bits & CCIX_CACHE_ERR_CACHE_ERR_TYPE_VALID)
> +		printk("%s""Cache Error Type: %s\n", pfx,
> +		       cper_ccix_cache_err_type_str(cache_err->cache_error_type));
> +
> +	if (cache_err->validation_bits & CCIX_CACHE_ERR_LEVEL_VALID)
> +		printk("%s""Level: %d\n", pfx, cache_err->cache_level);
> +
> +	if (cache_err->validation_bits & CCIX_CACHE_ERR_SET_VALID)
> +		printk("%s""Set: %d\n", pfx, cache_err->set);
> +
> +	if (cache_err->validation_bits & CCIX_CACHE_ERR_WAY_VALID)
> +		printk("%s""Way: %d\n", pfx, cache_err->way);
> +
> +	if (cache_err->validation_bits & CCIX_CACHE_ERR_INSTANCE_ID_VALID)
> +		printk("%s""Instance ID: %d\n", pfx, cache_err->instance);
> +
> +	if (cache_err->validation_bits & CCIX_CACHE_ERR_VENDOR_DATA_VALID) {
> +		if (gdata->error_data_length < sizeof(*full_cache_err) + 4)
> +			return -ENOSPC;
> +
> +		vendor_data_len = cache_err->vendor_data[0] & GENMASK(15, 0);
> +		if (gdata->error_data_length <
> +		    sizeof(*full_cache_err) + vendor_data_len)
> +			return -ENOSPC;
> +
> +		for (i = 0; i < vendor_data_len / 4 - 1; i++)
> +			printk("%s""Vendor%d: 0x%08x\n", pfx, i,
> +			       cache_err->vendor_data[i + 1]);

I forgot to comment this at patch 1/6, as this is more a reflection
than asking for a change...

Not sure what's the value of also printing events to the Kernel logs.

I mean, we do that for existent RAS drivers, mainly because the RAS report
mechanism came after the printks, and someone could be relying at the
kernel logs instead of using rasdaemon (or some other alternative software
someone might write).

For new report mechanisms, perhaps we could be smarter - at least offering
ways to disable the printks if a daemon is listening to the trace events.

Boris/Tony: what do you think?

> +	}
> +
> +	return 0;
> +}
> +
>  int cper_print_ccix_per(const char *pfx, struct acpi_hest_generic_data *gdata)
>  {
>  	struct cper_sec_ccix_header *header = acpi_hest_get_payload(gdata);
> @@ -351,9 +455,75 @@ int cper_print_ccix_per(const char *pfx, struct acpi_hest_generic_data *gdata)
>  	switch (per_type) {
>  	case CCIX_MEMORY_ERROR:
>  		return cper_ccix_mem_err_details(pfx, gdata);
> +	case CCIX_CACHE_ERROR:
> +		return cper_ccix_cache_err_details(pfx, gdata);
>  	default:
>  		/* Vendor defined so no formatting be done */
>  		break;
>  	}
>  	return 0;
>  }
> +
> +void cper_ccix_cache_err_pack(const struct cper_sec_ccix_cache_error *cache_record,
> +			      struct cper_ccix_cache_err_compact *ccache_err,
> +			      const u16 vendor_data_len,
> +			      u8 *vendor_data)
> +{
> +	ccache_err->validation_bits = cache_record->validation_bits;
> +	ccache_err->set = cache_record->set;
> +	ccache_err->way = cache_record->way;
> +	ccache_err->cache_type = cache_record->cache_type;
> +	ccache_err->op_type = cache_record->op_type;
> +	ccache_err->cache_error_type = cache_record->cache_error_type;
> +	ccache_err->cache_level = cache_record->cache_level;
> +	ccache_err->instance = cache_record->instance;
> +	memcpy(vendor_data, &cache_record->vendor_data[1], vendor_data_len);
> +}
> +
> +static int cper_ccix_err_cache_location(struct cper_ccix_cache_err_compact *ccache_err,
> +					char *msg)
> +{
> +	u32 len = CPER_REC_LEN - 1;
> +	u32 n = 0;
> +
> +	if (!msg)
> +		return 0;
> +
> +	if (ccache_err->validation_bits & CCIX_CACHE_ERR_CACHE_ERR_TYPE_VALID)
> +		n += snprintf(msg + n, len, "Error: %s ",
> +			     cper_ccix_cache_err_type_str(ccache_err->cache_error_type));
> +
> +	if (ccache_err->validation_bits & CCIX_CACHE_ERR_TYPE_VALID)
> +		n += snprintf(msg + n, len, "Type: %s ",
> +			     cper_ccix_cache_type_str(ccache_err->cache_type));

Same comments as before: we should ensure that gcc will be able to warn if
the passed buffer has a size different than CPER_REC_LEN, and the remaining
length should be decremented on each snprintf() call.

> +
> +	if (ccache_err->validation_bits & CCIX_CACHE_ERR_OP_VALID)
> +		n += snprintf(msg + n, len, "Op: %s ",
> +			      cper_ccix_cache_err_op_str(ccache_err->op_type));
> +
> +	if (ccache_err->validation_bits & CCIX_CACHE_ERR_LEVEL_VALID)
> +		n += snprintf(msg + n, len, "Level: %d ",
> +			      ccache_err->cache_level);
> +	if (ccache_err->validation_bits & CCIX_CACHE_ERR_SET_VALID)
> +		n += snprintf(msg + n, len, "Set: %d ", ccache_err->set);
> +	if (ccache_err->validation_bits & CCIX_CACHE_ERR_WAY_VALID)
> +		n += snprintf(msg + n, len, "Way: %d ", ccache_err->way);
> +	if (ccache_err->validation_bits & CCIX_CACHE_ERR_INSTANCE_ID_VALID)
> +		n += snprintf(msg + n, len, "Instance: %d ",
> +			      ccache_err->instance);
> +
> +	return n;
> +}
> +
> +const char *cper_ccix_cache_err_unpack(struct trace_seq *p,
> +				       struct cper_ccix_cache_err_compact *ccache_err)
> +{
> +	const char *ret = trace_seq_buffer_ptr(p);
> +
> +	if (cper_ccix_err_cache_location(ccache_err, rcd_decode_str))
> +		trace_seq_printf(p, "%s", rcd_decode_str);
> +
> +	trace_seq_putc(p, '\0');
> +
> +	return ret;
> +}
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index df7a34c3ba4f..eef254b8b8b7 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -627,6 +627,54 @@ struct cper_ccix_mem_err_compact {
>  	__u8	fru;
>  };
>  
> +struct cper_sec_ccix_cache_error {
> +	__u32	validation_bits;
> +#define CCIX_CACHE_ERR_TYPE_VALID		BIT(0)
> +#define CCIX_CACHE_ERR_OP_VALID			BIT(1)
> +#define CCIX_CACHE_ERR_CACHE_ERR_TYPE_VALID	BIT(2)
> +#define CCIX_CACHE_ERR_LEVEL_VALID		BIT(3)
> +#define CCIX_CACHE_ERR_SET_VALID		BIT(4)
> +#define CCIX_CACHE_ERR_WAY_VALID		BIT(5)
> +#define CCIX_CACHE_ERR_INSTANCE_ID_VALID	BIT(6)
> +#define CCIX_CACHE_ERR_VENDOR_DATA_VALID	BIT(7)
> +	__u16	length; /* Includes vendor specific log info */
> +	__u8	cache_type;
> +	__u8	op_type;
> +	__u8	cache_error_type;
> +	__u8	cache_level;
> +	__u32	set;
> +	__u32	way;
> +	__u8	instance;
> +	__u8	reserved;
> +	__u32	vendor_data[];
> +};
> +
> +struct cper_ccix_cache_error {
> +	struct cper_sec_ccix_header header;
> +	__u32 ccix_header[CCIX_PER_LOG_HEADER_DWS];
> +	struct cper_sec_ccix_cache_error cache_record;
> +};
> +
> +static inline u16 ccix_cache_err_ven_len_get(struct cper_ccix_cache_error *cache_err)
> +{
> +	if (cache_err->cache_record.validation_bits &
> +	    CCIX_CACHE_ERR_VENDOR_DATA_VALID)
> +		return cache_err->cache_record.vendor_data[0] & 0xFFFF;
> +	else
> +		return 0;
> +}
> +
> +struct cper_ccix_cache_err_compact {
> +	__u32	validation_bits;
> +	__u32	set;
> +	__u32	way;
> +	__u8	cache_type;
> +	__u8	op_type;
> +	__u8	cache_error_type;
> +	__u8	cache_level;
> +	__u8	instance;
> +};
> +
>  /* Reset to default packing */
>  #pragma pack()
>  
> @@ -649,6 +697,15 @@ const char *cper_ccix_mem_err_unpack(struct trace_seq *p,
>  				     struct cper_ccix_mem_err_compact *cmem_err);
>  const char *cper_ccix_mem_err_type_str(unsigned int error_type);
>  const char *cper_ccix_comp_type_str(u8 comp_type);
> +
> +void cper_ccix_cache_err_pack(const struct cper_sec_ccix_cache_error *cache_record,
> +			      struct cper_ccix_cache_err_compact *ccache_err,
> +			      const u16 vendor_data_len,
> +			      u8 *vendor_data);
> +const char *cper_ccix_cache_err_unpack(struct trace_seq *p,
> +				       struct cper_ccix_cache_err_compact *ccache_err);
> +const char *cper_ccix_cache_err_type_str(__u8 error_type);
> +
>  struct acpi_hest_generic_data;
>  int cper_print_ccix_per(const char *pfx,
>  			struct acpi_hest_generic_data *gdata);
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index 560e55958561..4a158820074c 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -415,6 +415,73 @@ TRACE_EVENT(ccix_memory_error_event,
>  			    __entry->vendor_data_length)
>  	)
>  );
> +
> +TRACE_EVENT(ccix_cache_error_event,
> +	TP_PROTO(struct cper_ccix_cache_error *err,
> +		 u32 err_seq,
> +		 u8 sev,
> +		 u16 ven_len),
> +
> +	TP_ARGS(err, err_seq, sev, ven_len),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, err_seq)
> +		__field(u8, sev)
> +		__field(u8, sevdetail)
> +		__field(u8, source)
> +		__field(u8, component)
> +		__field(u64, pa)
> +		__field(u8, pa_mask_lsb)
> +		__field_struct(struct cper_ccix_cache_err_compact, data)
> +		__field(u16, vendor_data_length)
> +		__dynamic_array(u8, vendor_data, ven_len)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->err_seq = err_seq;
> +
> +		__entry->sev = sev;
> +		__entry->sevdetail = FIELD_GET(CCIX_PER_LOG_DW1_SEV_UE_M |
> +			CCIX_PER_LOG_DW1_SEV_NO_COMM_M |
> +			CCIX_PER_LOG_DW1_SEV_DEGRADED_M |
> +			CCIX_PER_LOG_DW1_SEV_DEFFERABLE_M,
> +			err->ccix_header[1]);
> +		if (err->header.validation_bits & 0x1)
> +			__entry->source = err->header.source_id;
> +		else
> +			__entry->source = ~0;
> +		__entry->component = FIELD_GET(CCIX_PER_LOG_DW1_COMP_TYPE_M,
> +					       err->ccix_header[1]);
> +		if (err->ccix_header[1] & CCIX_PER_LOG_DW1_ADDR_VAL_M) {
> +			__entry->pa = (u64)err->ccix_header[2] << 32 |
> +				(err->ccix_header[3] & 0xfffffffc);
> +			__entry->pa_mask_lsb = err->ccix_header[4] & 0xff;
> +		} else {
> +			__entry->pa = ~0ull;
> +			__entry->pa_mask_lsb = ~0;
> +		}
> +
> +		__entry->vendor_data_length = ven_len ? ven_len - 4 : 0;
> +		cper_ccix_cache_err_pack(&err->cache_record, &__entry->data,
> +					 __entry->vendor_data_length,
> +					 __get_dynamic_array(vendor_data));
> +	),
> +
> +	TP_printk("{%d} %s CCIX PER Cache Error in %s SevUE:%d SevNoComm:%d SevDegraded:%d SevDeferred:%d physical addr: %016llx (mask: %x) %s vendor:%s",
> +		__entry->err_seq,
> +		cper_severity_str(__entry->sev),
> +		cper_ccix_comp_type_str(__entry->component),
> +		__entry->sevdetail & BIT(0) ? 1 : 0,
> +		__entry->sevdetail & BIT(1) ? 1 : 0,
> +		__entry->sevdetail & BIT(2) ? 1 : 0,
> +		__entry->sevdetail & BIT(3) ? 1 : 0,
> +		__entry->pa,
> +		__entry->pa_mask_lsb,
> +		cper_ccix_cache_err_unpack(p, &__entry->data),
> +		__print_hex(__get_dynamic_array(vendor_data),
> +			    __entry->vendor_data_length)
> +	)
> +);
>  #endif
>  
>  /*




Cheers,
Mauro
