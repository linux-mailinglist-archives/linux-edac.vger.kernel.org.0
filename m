Return-Path: <linux-edac+bounces-1861-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217119752D9
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2024 14:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC3B4B2A244
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2024 12:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E9D188A14;
	Wed, 11 Sep 2024 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Hu5Bjm17"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F214218C91D;
	Wed, 11 Sep 2024 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726058881; cv=none; b=aJhB47Q4dQ+tIP+19i/03+Y7hghATGYd/5hKd4TJIlcUP5CX8nVtJCw89AxUjWwHG2QrspxO1Ni10pH1GEnM79S0sxY6vx7ONckTmX4h84SebGALXHckzLDST4ITuQSvOOCpnZKrKG7zrVXZpL3SNxTe4KMYMts2F4S97KabESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726058881; c=relaxed/simple;
	bh=2tRDEZrsSBBpxDmjQoyksIOvGsHVRn4TJmdvfaCRBV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHoCAODUF1s80sHzJSU6kXEToMf/ISIY+j3t5isrKS3R7Qzl0S5LtmvqCxVd80w7+F/tncGbXbtcHdY+GGP/HjS5/VMEWj7eEJoILcywLSXRRxJCjUZhRwVZxNbQyM+FIm7qfYsHcKUyxLHm46g71BVbMhwM3YIASzyMz9ivBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Hu5Bjm17; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8C51F40E0263;
	Wed, 11 Sep 2024 12:47:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZN4TlhODfSlf; Wed, 11 Sep 2024 12:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1726058862; bh=5nFhUoMgQm7q9H8g20P4R6GPgMFJ7s+LHuGRCpdiLmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hu5Bjm17VxxYoVwBzQG0WjP143YWYhNrICZWE2ghw2FGjpOyHvxrhr/TXAgJ/XVLY
	 DTmsIZRnXyhP8DEexHWTmWdIve9lbdIzhid44BLVMeAPfO72F/FKTvtP0tAslNl89Y
	 kDpd2cfA9M7LAN7secubtyJkFfUKvZ2EeQ5m1Rop4XMP/jkkYv1Tgd+ymuq39lWReL
	 4+JJS5ATcSlOpVnGUKSO1wis+25GBOACi+qkAXR8fvKxagx099yO8DmCql+blR/DFn
	 bQ9QILJaQC/xEqjMqllv2vlmy/6XKfHR/EJw8XOvGS276kG03RF5+VydaXXV+52rAD
	 61ox8Qaly3I7akJkMGxOSSxCKdcNFBpXhAHOsTm6J3henOqwvvrlbanmpRA57nNAz8
	 K5fkjfLVqq7kTk8haNXkN44MyOepE61Bz1OpvvawvD4comiO6Bq0mZGtKtT/yxMs3t
	 wzaa2dTuEPVF7LHd9kztfIVihkcJLOvoAPaFkOTdNrD0ZybylPngOmZO3b1hWRYdFv
	 /BApbmg6qXfl608FxWcRZnRBJIiGN5zfAvw2J+rfnzoQ3pwQLmPQI2ybm34rcJil5/
	 AmQCUkWE0vatbwn8yHC8KLWr52vwy6M25OGQ0fhEN9q597ELpx4BjMmey85n359MkU
	 bEEVQ75/dEJBZKYcOtnbrHgg=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D010140E021C;
	Wed, 11 Sep 2024 12:47:22 +0000 (UTC)
Date: Wed, 11 Sep 2024 14:47:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jason Tian <jason@os.amperecomputing.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tony Luck <tony.luck@intel.com>,
	Tyler Baicar <tbaicar@codeaurora.org>,
	Xie XiuQi <xiexiuqi@huawei.com>, linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Signed-off-by: Shengwei Luo" <luoshengwei@huawei.com>,
	Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: Re: [PATCH v3 1/5] RAS: Report all ARM processor CPER information to
 userspace
Message-ID: <20240911124716.GDZuGRVHkCFd2JLQKc@fat_crate.local>
References: <cover.1725429659.git.mchehab+huawei@kernel.org>
 <52d3210c770699369654d81816f501b987ccb805.1725429659.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52d3210c770699369654d81816f501b987ccb805.1725429659.git.mchehab+huawei@kernel.org>

On Wed, Sep 04, 2024 at 08:07:14AM +0200, Mauro Carvalho Chehab wrote:
> From: Jason Tian <jason@os.amperecomputing.com>
> 
> The ARM processor CPER record was added at UEFI 2.6, and hasn't
> any changes up to UEFI 2.10 on its struct.

Did some fixups to the commit message, please use it in your next
submission.

There was also this typo:

Co-developed-by: Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>

From: Jason Tian <jason@os.amperecomputing.com>

    RAS: Report all ARM processor CPER information to userspace
    
    The ARM processor CPER record was added in UEFI v2.6 and remained
    unchanged up to v2.10.
    
    Yet, the original arm_event trace code added by
    
      e9279e83ad1f ("trace, ras: add ARM processor error trace event")
    
    is incomplete, as it only traces some fields of UAPI 2.6 table N.16, not
    exporting any information from tables N.17 to N.29 of the record.
    
    This is not enough for the user to be able to figure out what has
    exactly happened or to take appropriate action.
    
    According to the UEFI v2.9 specification chapter N2.4.4, the ARM
    processor error section includes:
    
    - several (ERR_INFO_NUM) ARM processor error information structures
      (Tables N.17 to N.20);
    - several (CONTEXT_INFO_NUM) ARM processor context information
      structures (Tables N.21 to N.29);
    - several vendor specific error information structures. The
      size is given by Section Length minus the size of the other
      fields.
    
    In addition, it also exports two fields that are parsed by the GHES
    driver when firmware reports it, e.g.:
    
    - error severity
    - CPU logical index
    
    Report all of these information to userspace via a the ARM tracepoint so
    that userspace can properly record the error and take decisions related
    to CPU core isolation according to error severity and other info.
    
    The updated ARM trace event now contains the following fields:
    
    ======================================  =============================
    UEFI field on table N.16                ARM Processor trace fields
    ======================================  =============================
    Validation                              handled when filling data for
                                            affinity MPIDR and running
                                            state.
    ERR_INFO_NUM                            pei_len
    CONTEXT_INFO_NUM                        ctx_len
    Section Length                          indirectly reported by
                                            pei_len, ctx_len and oem_len
    Error affinity level                    affinity
    MPIDR_EL1                               mpidr
    MIDR_EL1                                midr
    Running State                           running_state
    PSCI State                              psci_state
    Processor Error Information Structure   pei_err - count at pei_len
    Processor Context                       ctx_err- count at ctx_len
    Vendor Specific Error Info              oem - count at oem_len
    ======================================  =============================
    
    It should be noted that decoding of tables N.17 to N.29, if needed, will
    be handled in userspace. That gives more flexibility, as there won't be
    any need to flood the kernel with micro-architecture specific error
    decoding.
    
    Also, decoding the other fields require a complex logic, and should be
    done for each of the several values inside the record field.  So, let
    userspace daemons like rasdaemon decode them, parsing such tables and
    having vendor-specific micro-architecture-specific decoders.
    
      [mchehab: modified description, solved merge conflicts and fixed coding style]
    
    Fixes: e9279e83ad1f ("trace, ras: add ARM processor error trace event")
    Co-developed-by: Jason Tian <jason@os.amperecomputing.com>
    Signed-off-by: Jason Tian <jason@os.amperecomputing.com>
    Co-developed-by: Shengwei Luo <luoshengwei@huawei.com>
    Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
    Co-developed-by: Daniel Ferguson <danielf@os.amperecomputing.com>
    Signed-off-by: Daniel Ferguson <danielf@os.amperecomputing.com>
    Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
    Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    Tested-by: Shiju Jose <shiju.jose@huawei.com>
    Link: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-section

>  drivers/acpi/apei/ghes.c | 11 ++++-----
>  drivers/ras/ras.c        | 41 ++++++++++++++++++++++++++++++++--
>  include/linux/ras.h      | 16 +++++++++++---
>  include/ras/ras_event.h  | 48 +++++++++++++++++++++++++++++++++++-----
>  4 files changed, 99 insertions(+), 17 deletions(-)

Also, some cleanups ontop:

diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 6a0480c76e19..179b1744df71 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -70,14 +70,14 @@ void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
 	err_info = (struct cper_arm_err_info *)(err + 1);
 	ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
 	ctx_err = (u8 *)ctx_info;
+
 	for (n = 0; n < err->context_info_num; n++) {
 		sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
 		ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
 		ctx_len += sz;
 	}
 
-	vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) +
-					  pei_len + ctx_len);
+	vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) + pei_len + ctx_len);
 	if (vsei_len < 0) {
 		pr_warn(FW_BUG "section length: %d\n", err->section_length);
 		pr_warn(FW_BUG "section length is too small\n");
diff --git a/include/linux/ras.h b/include/linux/ras.h
index df444492b434..468941bfe855 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -55,8 +55,8 @@ amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
 #if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 #include <asm/smp_plat.h>
 /*
- * Include ARM specific SMP header which provides a function mapping mpidr to
- * cpu logical index.
+ * Include ARM-specific SMP header which provides a function mapping mpidr to
+ * CPU logical index.
  */
 #define GET_LOGICAL_INDEX(mpidr) get_logical_index(mpidr & MPIDR_HWID_BITMASK)
 #else


Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

