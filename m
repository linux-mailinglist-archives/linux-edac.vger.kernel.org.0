Return-Path: <linux-edac+bounces-1862-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ED4975938
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2024 19:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1178287448
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2024 17:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57401B1414;
	Wed, 11 Sep 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hpshhi3R"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009E164A8F;
	Wed, 11 Sep 2024 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075242; cv=none; b=laaoDmjxJK+SYIvRmnUSmIztJw/L5fGHyELHfE+prEnd22HkhhUurw/4kTZVnj7x4IYzP67qTfMEZmhTaHw8xhqr/B0d7wDaiuCIjJJ5AvkbQ5bfEUXs5SdQCnGm7/gXGZJAY0ABPajVu+RTuRWMzpsPTHzXwjQFhxAiFek3Nq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075242; c=relaxed/simple;
	bh=lym+1MkeGnntTTIubcQX/mUUTLwkwlejHNFLsBENrqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbNcVd7bzZ1zxCk4lHUGt6vlokVPksy9wEbN4GsS/jf9PFXzDUw+t+/jA7+N/uH3obadkgyyAMMFy+e5YBLaEEnT5cPkr9MccT2e59R1USCmNDXgNPcj5da5cez6USymH9rsgxKVh8iQhgbYw63DpmFciBDHoWmczWYC+ACXBAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hpshhi3R; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726075240; x=1757611240;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lym+1MkeGnntTTIubcQX/mUUTLwkwlejHNFLsBENrqU=;
  b=Hpshhi3R7L5N0YSQzSvxhnPlCR+qXbgjkMNgyWkjqVtOCwj2zpo2a0HY
   Ooas54Z7i7ZIXqi3+eOLdUl8vMHE/QaiOA6dmkhfCEkKRJcNb94uS0p+r
   j2uydHu0zOOEXTR/te/+N3JrjL4RXmXoecmb9srE8awZVXrjNrtUdTqJD
   MV67syjNtUtNnF2PqU0brXq5DmQMHOr9U+VkcXl0Ao1fZteM8DhhA5Nrj
   4jaHSLYC5U0DpK0ShG6Xk/I9lrgg8kgvW0dKvAFtgzONMRir47au4Q/Ds
   TcuwTjFIfosEi4t9s3f7CRE3OHJnbDwPujmkR6b1A51N+PkCR5kbkAszk
   w==;
X-CSE-ConnectionGUID: GIik9O86SI6NJg3lQSI3Ew==
X-CSE-MsgGUID: Dnp585EJTRu0G9Q4TP3dfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="50307712"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="50307712"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 10:20:39 -0700
X-CSE-ConnectionGUID: LVvWoQ7PS1ysqaO5sJ6bjA==
X-CSE-MsgGUID: ShSgwn/0SA+9RO3BLX9zXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="72235459"
Received: from rchernet-mobl4.amr.corp.intel.com (HELO [10.125.108.13]) ([10.125.108.13])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 10:20:36 -0700
Message-ID: <dad6c35b-7df5-4d40-9b20-7a5924cc53bd@intel.com>
Date: Wed, 11 Sep 2024 10:20:35 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/17] cxl: Move mailbox related bits to the same
 context
To: shiju.jose@huawei.com, linux-edac@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: bp@alien8.de, tony.luck@intel.com, rafael@kernel.org, lenb@kernel.org,
 mchehab@kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, david@redhat.com,
 Vilas.Sridharan@amd.com, leo.duran@amd.com, Yazen.Ghannam@amd.com,
 rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
 dave.hansen@linux.intel.com, naoya.horiguchi@nec.com, james.morse@arm.com,
 jthoughton@google.com, somasundaram.a@hpe.com, erdemaktas@google.com,
 pgonda@google.com, duenwen@google.com, mike.malvestuto@intel.com,
 gthelen@google.com, wschwartz@amperecomputing.com,
 dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
 nifan.cxl@gmail.com, jgroves@micron.com, vsalve@micron.com,
 tanxiaofei@huawei.com, prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com, linuxarm@huawei.com
References: <20240911090447.751-1-shiju.jose@huawei.com>
 <20240911090447.751-5-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240911090447.751-5-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/11/24 2:04 AM, shiju.jose@huawei.com wrote:
> From: Dave Jiang <dave.jiang@intel.com>
> 
> Create a new 'struct cxl_mailbox' and move all mailbox related bits to
> it. This allows isolation of all CXL mailbox data in order to export
> some of the calls to external caller (fwctl) and avoid exporting of
> CXL driver specific bits such has device states.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Hi Shiju,
Just FYI there's this series [1] that may require some rebasing for the cxl mailbox bits. I do plan to pull those changes in for 6.12 merge window. 

And I should be able to rebase the fwctl code and post v2 after plumbers pending the discussions there. and it should reflect the same code WRT to features as what you are using here in the RAS series.  

[1]: https://lore.kernel.org/linux-cxl/20240905223711.1990186-1-dave.jiang@intel.com/

DJ

> ---
>  MAINTAINERS                  |  1 +
>  drivers/cxl/core/mbox.c      | 48 ++++++++++++++++++---------
>  drivers/cxl/core/memdev.c    | 18 +++++++----
>  drivers/cxl/cxlmem.h         | 49 ++--------------------------
>  drivers/cxl/pci.c            | 58 +++++++++++++++++++--------------
>  drivers/cxl/pmem.c           |  4 ++-
>  include/linux/cxl/mailbox.h  | 63 ++++++++++++++++++++++++++++++++++++
>  tools/testing/cxl/test/mem.c | 27 ++++++++++------
>  8 files changed, 163 insertions(+), 105 deletions(-)
>  create mode 100644 include/linux/cxl/mailbox.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 878dcd23b331..227c2b214f00 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5619,6 +5619,7 @@ F:	Documentation/driver-api/cxl
>  F:	drivers/cxl/
>  F:	include/linux/einj-cxl.h
>  F:	include/linux/cxl-event.h
> +F:	include/linux/cxl/
>  F:	include/uapi/linux/cxl_mem.h
>  F:	tools/testing/cxl/
>  
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index e5cdeafdf76e..216937ef9e07 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -244,16 +244,17 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>  int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
>  			  struct cxl_mbox_cmd *mbox_cmd)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	size_t out_size, min_out;
>  	int rc;
>  
> -	if (mbox_cmd->size_in > mds->payload_size ||
> -	    mbox_cmd->size_out > mds->payload_size)
> +	if (mbox_cmd->size_in > cxl_mbox->payload_size ||
> +	    mbox_cmd->size_out > cxl_mbox->payload_size)
>  		return -E2BIG;
>  
>  	out_size = mbox_cmd->size_out;
>  	min_out = mbox_cmd->min_out;
> -	rc = mds->mbox_send(mds, mbox_cmd);
> +	rc = cxl_mbox->mbox_send(cxl_mbox, mbox_cmd);
>  	/*
>  	 * EIO is reserved for a payload size mismatch and mbox_send()
>  	 * may not return this error.
> @@ -353,6 +354,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
>  			     struct cxl_memdev_state *mds, u16 opcode,
>  			     size_t in_size, size_t out_size, u64 in_payload)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	*mbox = (struct cxl_mbox_cmd) {
>  		.opcode = opcode,
>  		.size_in = in_size,
> @@ -374,7 +376,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
>  
>  	/* Prepare to handle a full payload for variable sized output */
>  	if (out_size == CXL_VARIABLE_PAYLOAD)
> -		mbox->size_out = mds->payload_size;
> +		mbox->size_out = cxl_mbox->payload_size;
>  	else
>  		mbox->size_out = out_size;
>  
> @@ -398,6 +400,8 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
>  			      const struct cxl_send_command *send_cmd,
>  			      struct cxl_memdev_state *mds)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +
>  	if (send_cmd->raw.rsvd)
>  		return -EINVAL;
>  
> @@ -406,7 +410,7 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
>  	 * gets passed along without further checking, so it must be
>  	 * validated here.
>  	 */
> -	if (send_cmd->out.size > mds->payload_size)
> +	if (send_cmd->out.size > cxl_mbox->payload_size)
>  		return -EINVAL;
>  
>  	if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
> @@ -494,6 +498,7 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
>  				      struct cxl_memdev_state *mds,
>  				      const struct cxl_send_command *send_cmd)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mem_command mem_cmd;
>  	int rc;
>  
> @@ -505,7 +510,7 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
>  	 * supports, but output can be arbitrarily large (simply write out as
>  	 * much data as the hardware provides).
>  	 */
> -	if (send_cmd->in.size > mds->payload_size)
> +	if (send_cmd->in.size > cxl_mbox->payload_size)
>  		return -EINVAL;
>  
>  	/* Sanitize and construct a cxl_mem_command */
> @@ -591,6 +596,7 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev_state *mds,
>  					u64 out_payload, s32 *size_out,
>  					u32 *retval)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct device *dev = mds->cxlds.dev;
>  	int rc;
>  
> @@ -601,7 +607,7 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev_state *mds,
>  		cxl_mem_opcode_to_name(mbox_cmd->opcode),
>  		mbox_cmd->opcode, mbox_cmd->size_in);
>  
> -	rc = mds->mbox_send(mds, mbox_cmd);
> +	rc = cxl_mbox->mbox_send(cxl_mbox, mbox_cmd);
>  	if (rc)
>  		goto out;
>  
> @@ -659,11 +665,12 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
>  static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
>  			u32 *size, u8 *out)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	u32 remaining = *size;
>  	u32 offset = 0;
>  
>  	while (remaining) {
> -		u32 xfer_size = min_t(u32, remaining, mds->payload_size);
> +		u32 xfer_size = min_t(u32, remaining, cxl_mbox->payload_size);
>  		struct cxl_mbox_cmd mbox_cmd;
>  		struct cxl_mbox_get_log log;
>  		int rc;
> @@ -752,17 +759,18 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  
>  static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_get_supported_logs *ret;
>  	struct cxl_mbox_cmd mbox_cmd;
>  	int rc;
>  
> -	ret = kvmalloc(mds->payload_size, GFP_KERNEL);
> +	ret = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
>  	if (!ret)
>  		return ERR_PTR(-ENOMEM);
>  
>  	mbox_cmd = (struct cxl_mbox_cmd) {
>  		.opcode = CXL_MBOX_OP_GET_SUPPORTED_LOGS,
> -		.size_out = mds->payload_size,
> +		.size_out = cxl_mbox->payload_size,
>  		.payload_out = ret,
>  		/* At least the record number field must be valid */
>  		.min_out = 2,
> @@ -910,6 +918,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  				  enum cxl_event_log_type log,
>  				  struct cxl_get_event_payload *get_pl)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_clear_event_payload *payload;
>  	u16 total = le16_to_cpu(get_pl->record_count);
>  	u8 max_handles = CXL_CLEAR_EVENT_MAX_HANDLES;
> @@ -920,8 +929,8 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  	int i;
>  
>  	/* Payload size may limit the max handles */
> -	if (pl_size > mds->payload_size) {
> -		max_handles = (mds->payload_size - sizeof(*payload)) /
> +	if (pl_size > cxl_mbox->payload_size) {
> +		max_handles = (cxl_mbox->payload_size - sizeof(*payload)) /
>  			      sizeof(__le16);
>  		pl_size = struct_size(payload, handles, max_handles);
>  	}
> @@ -979,6 +988,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  				    enum cxl_event_log_type type)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
>  	struct device *dev = mds->cxlds.dev;
>  	struct cxl_get_event_payload *payload;
> @@ -995,7 +1005,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  			.payload_in = &log_type,
>  			.size_in = sizeof(log_type),
>  			.payload_out = payload,
> -			.size_out = mds->payload_size,
> +			.size_out = cxl_mbox->payload_size,
>  			.min_out = struct_size(payload, records, 0),
>  		};
>  
> @@ -1328,6 +1338,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr)
>  {
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_poison_out *po;
>  	struct cxl_mbox_poison_in pi;
>  	int nr_records = 0;
> @@ -1346,7 +1357,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  			.opcode = CXL_MBOX_OP_GET_POISON,
>  			.size_in = sizeof(pi),
>  			.payload_in = &pi,
> -			.size_out = mds->payload_size,
> +			.size_out = cxl_mbox->payload_size,
>  			.payload_out = po,
>  			.min_out = struct_size(po, record, 0),
>  		};
> @@ -1382,7 +1393,9 @@ static void free_poison_buf(void *buf)
>  /* Get Poison List output buffer is protected by mds->poison.lock */
>  static int cxl_poison_alloc_buf(struct cxl_memdev_state *mds)
>  {
> -	mds->poison.list_out = kvmalloc(mds->payload_size, GFP_KERNEL);
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +
> +	mds->poison.list_out = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
>  	if (!mds->poison.list_out)
>  		return -ENOMEM;
>  
> @@ -1411,6 +1424,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  {
>  	struct cxl_memdev_state *mds;
> +	struct cxl_mailbox *cxl_mbox;
>  
>  	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
>  	if (!mds) {
> @@ -1418,7 +1432,9 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> -	mutex_init(&mds->mbox_mutex);
> +	cxl_mbox = &mds->cxlds.cxl_mbox;
> +	mutex_init(&cxl_mbox->mbox_mutex);
> +
>  	mutex_init(&mds->event.log_lock);
>  	mds->cxlds.dev = dev;
>  	mds->cxlds.reg_map.host = dev;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 0277726afd04..05bb84cb1274 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -58,7 +58,7 @@ static ssize_t payload_max_show(struct device *dev,
>  
>  	if (!mds)
>  		return sysfs_emit(buf, "\n");
> -	return sysfs_emit(buf, "%zu\n", mds->payload_size);
> +	return sysfs_emit(buf, "%zu\n", cxlds->cxl_mbox.payload_size);
>  }
>  static DEVICE_ATTR_RO(payload_max);
>  
> @@ -124,15 +124,16 @@ static ssize_t security_state_show(struct device *dev,
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>  	unsigned long state = mds->security.state;
>  	int rc = 0;
>  
>  	/* sync with latest submission state */
> -	mutex_lock(&mds->mbox_mutex);
> +	mutex_lock(&cxl_mbox->mbox_mutex);
>  	if (mds->security.sanitize_active)
>  		rc = sysfs_emit(buf, "sanitize\n");
> -	mutex_unlock(&mds->mbox_mutex);
> +	mutex_unlock(&cxl_mbox->mbox_mutex);
>  	if (rc)
>  		return rc;
>  
> @@ -829,12 +830,13 @@ static enum fw_upload_err cxl_fw_prepare(struct fw_upload *fwl, const u8 *data,
>  {
>  	struct cxl_memdev_state *mds = fwl->dd_handle;
>  	struct cxl_mbox_transfer_fw *transfer;
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  
>  	if (!size)
>  		return FW_UPLOAD_ERR_INVALID_SIZE;
>  
>  	mds->fw.oneshot = struct_size(transfer, data, size) <
> -			    mds->payload_size;
> +			    cxl_mbox->payload_size;
>  
>  	if (cxl_mem_get_fw_info(mds))
>  		return FW_UPLOAD_ERR_HW_ERROR;
> @@ -854,6 +856,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
>  {
>  	struct cxl_memdev_state *mds = fwl->dd_handle;
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>  	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>  	struct cxl_mbox_transfer_fw *transfer;
>  	struct cxl_mbox_cmd mbox_cmd;
> @@ -877,7 +880,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
>  	 * sizeof(*transfer) is 128.  These constraints imply that @cur_size
>  	 * will always be 128b aligned.
>  	 */
> -	cur_size = min_t(size_t, size, mds->payload_size - sizeof(*transfer));
> +	cur_size = min_t(size_t, size, cxl_mbox->payload_size - sizeof(*transfer));
>  
>  	remaining = size - cur_size;
>  	size_in = struct_size(transfer, data, cur_size);
> @@ -1059,16 +1062,17 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>  static void sanitize_teardown_notifier(void *data)
>  {
>  	struct cxl_memdev_state *mds = data;
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct kernfs_node *state;
>  
>  	/*
>  	 * Prevent new irq triggered invocations of the workqueue and
>  	 * flush inflight invocations.
>  	 */
> -	mutex_lock(&mds->mbox_mutex);
> +	mutex_lock(&cxl_mbox->mbox_mutex);
>  	state = mds->security.sanitize_node;
>  	mds->security.sanitize_node = NULL;
> -	mutex_unlock(&mds->mbox_mutex);
> +	mutex_unlock(&cxl_mbox->mbox_mutex);
>  
>  	cancel_delayed_work_sync(&mds->security.poll_dwork);
>  	sysfs_put(state);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index afb53d058d62..19609b708b09 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -8,6 +8,7 @@
>  #include <linux/rcuwait.h>
>  #include <linux/cxl-event.h>
>  #include <linux/node.h>
> +#include <linux/cxl/mailbox.h>
>  #include "cxl.h"
>  
>  /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> @@ -105,42 +106,6 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>  	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
>  }
>  
> -/**
> - * struct cxl_mbox_cmd - A command to be submitted to hardware.
> - * @opcode: (input) The command set and command submitted to hardware.
> - * @payload_in: (input) Pointer to the input payload.
> - * @payload_out: (output) Pointer to the output payload. Must be allocated by
> - *		 the caller.
> - * @size_in: (input) Number of bytes to load from @payload_in.
> - * @size_out: (input) Max number of bytes loaded into @payload_out.
> - *            (output) Number of bytes generated by the device. For fixed size
> - *            outputs commands this is always expected to be deterministic. For
> - *            variable sized output commands, it tells the exact number of bytes
> - *            written.
> - * @min_out: (input) internal command output payload size validation
> - * @poll_count: (input) Number of timeouts to attempt.
> - * @poll_interval_ms: (input) Time between mailbox background command polling
> - *                    interval timeouts.
> - * @return_code: (output) Error code returned from hardware.
> - *
> - * This is the primary mechanism used to send commands to the hardware.
> - * All the fields except @payload_* correspond exactly to the fields described in
> - * Command Register section of the CXL 2.0 8.2.8.4.5. @payload_in and
> - * @payload_out are written to, and read from the Command Payload Registers
> - * defined in CXL 2.0 8.2.8.4.8.
> - */
> -struct cxl_mbox_cmd {
> -	u16 opcode;
> -	void *payload_in;
> -	void *payload_out;
> -	size_t size_in;
> -	size_t size_out;
> -	size_t min_out;
> -	int poll_count;
> -	int poll_interval_ms;
> -	u16 return_code;
> -};
> -
>  /*
>   * Per CXL 3.0 Section 8.2.8.4.5.1
>   */
> @@ -438,6 +403,7 @@ struct cxl_dev_state {
>  	struct resource ram_res;
>  	u64 serial;
>  	enum cxl_devtype type;
> +	struct cxl_mailbox cxl_mbox;
>  };
>  
>  /**
> @@ -448,11 +414,8 @@ struct cxl_dev_state {
>   * the functionality related to that like Identify Memory Device and Get
>   * Partition Info
>   * @cxlds: Core driver state common across Type-2 and Type-3 devices
> - * @payload_size: Size of space for payload
> - *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
>   * @lsa_size: Size of Label Storage Area
>   *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
> - * @mbox_mutex: Mutex to synchronize mailbox access.
>   * @firmware_version: Firmware version for the memory device.
>   * @enabled_cmds: Hardware commands found enabled in CEL.
>   * @exclusive_cmds: Commands that are kernel-internal only
> @@ -470,17 +433,13 @@ struct cxl_dev_state {
>   * @poison: poison driver state info
>   * @security: security driver state info
>   * @fw: firmware upload / activation state
> - * @mbox_wait: RCU wait for mbox send completely
> - * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
>   * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
>   * details on capacity parameters.
>   */
>  struct cxl_memdev_state {
>  	struct cxl_dev_state cxlds;
> -	size_t payload_size;
>  	size_t lsa_size;
> -	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
>  	char firmware_version[0x10];
>  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> @@ -500,10 +459,6 @@ struct cxl_memdev_state {
>  	struct cxl_poison_state poison;
>  	struct cxl_security_state security;
>  	struct cxl_fw_state fw;
> -
> -	struct rcuwait mbox_wait;
> -	int (*mbox_send)(struct cxl_memdev_state *mds,
> -			 struct cxl_mbox_cmd *cmd);
>  };
>  
>  static inline struct cxl_memdev_state *
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4be35dc22202..faf6f5a49368 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -124,6 +124,7 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>  	u16 opcode;
>  	struct cxl_dev_id *dev_id = id;
>  	struct cxl_dev_state *cxlds = dev_id->cxlds;
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>  
>  	if (!cxl_mbox_background_complete(cxlds))
> @@ -132,13 +133,13 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>  	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
>  	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
>  	if (opcode == CXL_MBOX_OP_SANITIZE) {
> -		mutex_lock(&mds->mbox_mutex);
> +		mutex_lock(&cxl_mbox->mbox_mutex);
>  		if (mds->security.sanitize_node)
>  			mod_delayed_work(system_wq, &mds->security.poll_dwork, 0);
> -		mutex_unlock(&mds->mbox_mutex);
> +		mutex_unlock(&cxl_mbox->mbox_mutex);
>  	} else {
>  		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> -		rcuwait_wake_up(&mds->mbox_wait);
> +		rcuwait_wake_up(&cxl_mbox->mbox_wait);
>  	}
>  
>  	return IRQ_HANDLED;
> @@ -152,8 +153,9 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>  	struct cxl_memdev_state *mds =
>  		container_of(work, typeof(*mds), security.poll_dwork.work);
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>  
> -	mutex_lock(&mds->mbox_mutex);
> +	mutex_lock(&cxl_mbox->mbox_mutex);
>  	if (cxl_mbox_background_complete(cxlds)) {
>  		mds->security.poll_tmo_secs = 0;
>  		if (mds->security.sanitize_node)
> @@ -167,7 +169,7 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>  		mds->security.poll_tmo_secs = min(15 * 60, timeout);
>  		schedule_delayed_work(&mds->security.poll_dwork, timeout * HZ);
>  	}
> -	mutex_unlock(&mds->mbox_mutex);
> +	mutex_unlock(&cxl_mbox->mbox_mutex);
>  }
>  
>  /**
> @@ -192,17 +194,20 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>   * not need to coordinate with each other. The driver only uses the primary
>   * mailbox.
>   */
> -static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
> +static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
>  				   struct cxl_mbox_cmd *mbox_cmd)
>  {
> -	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct cxl_dev_state *cxlds = container_of(cxl_mbox,
> +						   struct cxl_dev_state,
> +						   cxl_mbox);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>  	void __iomem *payload = cxlds->regs.mbox + CXLDEV_MBOX_PAYLOAD_OFFSET;
>  	struct device *dev = cxlds->dev;
>  	u64 cmd_reg, status_reg;
>  	size_t out_len;
>  	int rc;
>  
> -	lockdep_assert_held(&mds->mbox_mutex);
> +	lockdep_assert_held(&cxl_mbox->mbox_mutex);
>  
>  	/*
>  	 * Here are the steps from 8.2.8.4 of the CXL 2.0 spec.
> @@ -315,10 +320,10 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>  
>  		timeout = mbox_cmd->poll_interval_ms;
>  		for (i = 0; i < mbox_cmd->poll_count; i++) {
> -			if (rcuwait_wait_event_timeout(&mds->mbox_wait,
> -				       cxl_mbox_background_complete(cxlds),
> -				       TASK_UNINTERRUPTIBLE,
> -				       msecs_to_jiffies(timeout)) > 0)
> +			if (rcuwait_wait_event_timeout(&cxl_mbox->mbox_wait,
> +						       cxl_mbox_background_complete(cxlds),
> +						       TASK_UNINTERRUPTIBLE,
> +						       msecs_to_jiffies(timeout)) > 0)
>  				break;
>  		}
>  
> @@ -360,7 +365,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>  		 */
>  		size_t n;
>  
> -		n = min3(mbox_cmd->size_out, mds->payload_size, out_len);
> +		n = min3(mbox_cmd->size_out, cxl_mbox->payload_size, out_len);
>  		memcpy_fromio(mbox_cmd->payload_out, payload, n);
>  		mbox_cmd->size_out = n;
>  	} else {
> @@ -370,14 +375,14 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>  	return 0;
>  }
>  
> -static int cxl_pci_mbox_send(struct cxl_memdev_state *mds,
> +static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
>  			     struct cxl_mbox_cmd *cmd)
>  {
>  	int rc;
>  
> -	mutex_lock_io(&mds->mbox_mutex);
> -	rc = __cxl_pci_mbox_send_cmd(mds, cmd);
> -	mutex_unlock(&mds->mbox_mutex);
> +	mutex_lock_io(&cxl_mbox->mbox_mutex);
> +	rc = __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
> +	mutex_unlock(&cxl_mbox->mbox_mutex);
>  
>  	return rc;
>  }
> @@ -385,6 +390,7 @@ static int cxl_pci_mbox_send(struct cxl_memdev_state *mds,
>  static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>  {
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
>  	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
>  	struct device *dev = cxlds->dev;
>  	unsigned long timeout;
> @@ -392,6 +398,7 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>  	u64 md_status;
>  	u32 ctrl;
>  
> +	cxl_mbox->host = dev;
>  	timeout = jiffies + mbox_ready_timeout * HZ;
>  	do {
>  		md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> @@ -417,8 +424,8 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>  		return -ETIMEDOUT;
>  	}
>  
> -	mds->mbox_send = cxl_pci_mbox_send;
> -	mds->payload_size =
> +	cxl_mbox->mbox_send = cxl_pci_mbox_send;
> +	cxl_mbox->payload_size =
>  		1 << FIELD_GET(CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK, cap);
>  
>  	/*
> @@ -428,16 +435,16 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>  	 * there's no point in going forward. If the size is too large, there's
>  	 * no harm is soft limiting it.
>  	 */
> -	mds->payload_size = min_t(size_t, mds->payload_size, SZ_1M);
> -	if (mds->payload_size < 256) {
> +	cxl_mbox->payload_size = min_t(size_t, cxl_mbox->payload_size, SZ_1M);
> +	if (cxl_mbox->payload_size < 256) {
>  		dev_err(dev, "Mailbox is too small (%zub)",
> -			mds->payload_size);
> +			cxl_mbox->payload_size);
>  		return -ENXIO;
>  	}
>  
> -	dev_dbg(dev, "Mailbox payload sized %zu", mds->payload_size);
> +	dev_dbg(dev, "Mailbox payload sized %zu", cxl_mbox->payload_size);
>  
> -	rcuwait_init(&mds->mbox_wait);
> +	rcuwait_init(&cxl_mbox->mbox_wait);
>  	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
>  
>  	/* background command interrupts are optional */
> @@ -578,9 +585,10 @@ static void free_event_buf(void *buf)
>   */
>  static int cxl_mem_alloc_event_buf(struct cxl_memdev_state *mds)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_get_event_payload *buf;
>  
> -	buf = kvmalloc(mds->payload_size, GFP_KERNEL);
> +	buf = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
>  	if (!buf)
>  		return -ENOMEM;
>  	mds->event.buf = buf;
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 4ef93da22335..3985ff9ce70e 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -102,13 +102,15 @@ static int cxl_pmem_get_config_size(struct cxl_memdev_state *mds,
>  				    struct nd_cmd_get_config_size *cmd,
>  				    unsigned int buf_len)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> +
>  	if (sizeof(*cmd) > buf_len)
>  		return -EINVAL;
>  
>  	*cmd = (struct nd_cmd_get_config_size){
>  		.config_size = mds->lsa_size,
>  		.max_xfer =
> -			mds->payload_size - sizeof(struct cxl_mbox_set_lsa),
> +			cxl_mbox->payload_size - sizeof(struct cxl_mbox_set_lsa),
>  	};
>  
>  	return 0;
> diff --git a/include/linux/cxl/mailbox.h b/include/linux/cxl/mailbox.h
> new file mode 100644
> index 000000000000..654df6175828
> --- /dev/null
> +++ b/include/linux/cxl/mailbox.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2024 Intel Corporation. */
> +#ifndef __CXL_MBOX_H__
> +#define __CXL_MBOX_H__
> +
> +#include <linux/auxiliary_bus.h>
> +
> +/**
> + * struct cxl_mbox_cmd - A command to be submitted to hardware.
> + * @opcode: (input) The command set and command submitted to hardware.
> + * @payload_in: (input) Pointer to the input payload.
> + * @payload_out: (output) Pointer to the output payload. Must be allocated by
> + *		 the caller.
> + * @size_in: (input) Number of bytes to load from @payload_in.
> + * @size_out: (input) Max number of bytes loaded into @payload_out.
> + *            (output) Number of bytes generated by the device. For fixed size
> + *            outputs commands this is always expected to be deterministic. For
> + *            variable sized output commands, it tells the exact number of bytes
> + *            written.
> + * @min_out: (input) internal command output payload size validation
> + * @poll_count: (input) Number of timeouts to attempt.
> + * @poll_interval_ms: (input) Time between mailbox background command polling
> + *                    interval timeouts.
> + * @return_code: (output) Error code returned from hardware.
> + *
> + * This is the primary mechanism used to send commands to the hardware.
> + * All the fields except @payload_* correspond exactly to the fields described in
> + * Command Register section of the CXL 2.0 8.2.8.4.5. @payload_in and
> + * @payload_out are written to, and read from the Command Payload Registers
> + * defined in CXL 2.0 8.2.8.4.8.
> + */
> +struct cxl_mbox_cmd {
> +	u16 opcode;
> +	void *payload_in;
> +	void *payload_out;
> +	size_t size_in;
> +	size_t size_out;
> +	size_t min_out;
> +	int poll_count;
> +	int poll_interval_ms;
> +	u16 return_code;
> +};
> +
> +/**
> + * struct cxl_mailbox - context for CXL mailbox operations
> + * @host: device that hosts the mailbox
> + * @adev: auxiliary device for fw-ctl
> + * @payload_size: Size of space for payload
> + *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
> + * @mbox_mutex: mutex protects device mailbox and firmware
> + * @mbox_wait: rcuwait for mailbox
> + * @mbox_send: @dev specific transport for transmitting mailbox commands
> + */
> +struct cxl_mailbox {
> +	struct device *host;
> +	struct auxiliary_device adev; /* For fw-ctl */
> +	size_t payload_size;
> +	struct mutex mbox_mutex; /* lock to protect mailbox context */
> +	struct rcuwait mbox_wait;
> +	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
> +};
> +
> +#endif
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 129f179b0ac5..1829b626bb40 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -8,6 +8,7 @@
>  #include <linux/delay.h>
>  #include <linux/sizes.h>
>  #include <linux/bits.h>
> +#include <linux/cxl/mailbox.h>
>  #include <asm/unaligned.h>
>  #include <crypto/sha2.h>
>  #include <cxlmem.h>
> @@ -534,6 +535,7 @@ static int mock_gsl(struct cxl_mbox_cmd *cmd)
>  
>  static int mock_get_log(struct cxl_memdev_state *mds, struct cxl_mbox_cmd *cmd)
>  {
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	struct cxl_mbox_get_log *gl = cmd->payload_in;
>  	u32 offset = le32_to_cpu(gl->offset);
>  	u32 length = le32_to_cpu(gl->length);
> @@ -542,7 +544,7 @@ static int mock_get_log(struct cxl_memdev_state *mds, struct cxl_mbox_cmd *cmd)
>  
>  	if (cmd->size_in < sizeof(*gl))
>  		return -EINVAL;
> -	if (length > mds->payload_size)
> +	if (length > cxl_mbox->payload_size)
>  		return -EINVAL;
>  	if (offset + length > sizeof(mock_cel))
>  		return -EINVAL;
> @@ -617,12 +619,13 @@ void cxl_mockmem_sanitize_work(struct work_struct *work)
>  {
>  	struct cxl_memdev_state *mds =
>  		container_of(work, typeof(*mds), security.poll_dwork.work);
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  
> -	mutex_lock(&mds->mbox_mutex);
> +	mutex_lock(&cxl_mbox->mbox_mutex);
>  	if (mds->security.sanitize_node)
>  		sysfs_notify_dirent(mds->security.sanitize_node);
>  	mds->security.sanitize_active = false;
> -	mutex_unlock(&mds->mbox_mutex);
> +	mutex_unlock(&cxl_mbox->mbox_mutex);
>  
>  	dev_dbg(mds->cxlds.dev, "sanitize complete\n");
>  }
> @@ -631,6 +634,7 @@ static int mock_sanitize(struct cxl_mockmem_data *mdata,
>  			 struct cxl_mbox_cmd *cmd)
>  {
>  	struct cxl_memdev_state *mds = mdata->mds;
> +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
>  	int rc = 0;
>  
>  	if (cmd->size_in != 0)
> @@ -648,14 +652,14 @@ static int mock_sanitize(struct cxl_mockmem_data *mdata,
>  		return -ENXIO;
>  	}
>  
> -	mutex_lock(&mds->mbox_mutex);
> +	mutex_lock(&cxl_mbox->mbox_mutex);
>  	if (schedule_delayed_work(&mds->security.poll_dwork,
>  				  msecs_to_jiffies(mdata->sanitize_timeout))) {
>  		mds->security.sanitize_active = true;
>  		dev_dbg(mds->cxlds.dev, "sanitize issued\n");
>  	} else
>  		rc = -EBUSY;
> -	mutex_unlock(&mds->mbox_mutex);
> +	mutex_unlock(&cxl_mbox->mbox_mutex);
>  
>  	return rc;
>  }
> @@ -1333,10 +1337,13 @@ static int mock_activate_fw(struct cxl_mockmem_data *mdata,
>  	return -EINVAL;
>  }
>  
> -static int cxl_mock_mbox_send(struct cxl_memdev_state *mds,
> +static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
>  			      struct cxl_mbox_cmd *cmd)
>  {
> -	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct cxl_dev_state *cxlds = container_of(cxl_mbox,
> +						   struct cxl_dev_state,
> +						   cxl_mbox);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>  	struct device *dev = cxlds->dev;
>  	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
>  	int rc = -EIO;
> @@ -1460,6 +1467,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	struct cxl_memdev_state *mds;
>  	struct cxl_dev_state *cxlds;
>  	struct cxl_mockmem_data *mdata;
> +	struct cxl_mailbox *cxl_mbox;
>  	int rc;
>  
>  	mdata = devm_kzalloc(dev, sizeof(*mdata), GFP_KERNEL);
> @@ -1487,9 +1495,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	if (IS_ERR(mds))
>  		return PTR_ERR(mds);
>  
> +	cxl_mbox = &mds->cxlds.cxl_mbox;
>  	mdata->mds = mds;
> -	mds->mbox_send = cxl_mock_mbox_send;
> -	mds->payload_size = SZ_4K;
> +	cxl_mbox->mbox_send = cxl_mock_mbox_send;
> +	cxl_mbox->payload_size = SZ_4K;
>  	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
>  	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mockmem_sanitize_work);
>  

