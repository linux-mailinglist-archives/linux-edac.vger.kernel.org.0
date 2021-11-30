Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B03F463E76
	for <lists+linux-edac@lfdr.de>; Tue, 30 Nov 2021 20:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbhK3TQf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 30 Nov 2021 14:16:35 -0500
Received: from mga07.intel.com ([134.134.136.100]:57604 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230100AbhK3TQf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 30 Nov 2021 14:16:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="299693466"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="299693466"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 11:13:15 -0800
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="459734500"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 11:13:15 -0800
Date:   Tue, 30 Nov 2021 11:13:14 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     mchehab@kernel.org, bp@alien8.de, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
Subject: Re: [PATCH] edac,ghes,cper: Add device to Memory Error Record
Message-ID: <YaZ3yiIBRj6qIg2h@agluck-desk2.amr.corp.intel.com>
References: <20211130131648.85860-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130131648.85860-1-xueshuai@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Nov 30, 2021 at 09:16:48PM +0800, Shuai Xue wrote:
> If Bit 7 of Validation Bits is valid, the device number of the memory
> associated with errors should be reported to Memory Error Record.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  drivers/edac/ghes_edac.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index a918ca93e4f7..cf98b270d6f7 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -378,6 +378,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  	if (mem_err->validation_bits & CPER_MEM_VALID_BANK_ADDRESS)
>  		p += sprintf(p, "bank_address:%d ",
>  			     mem_err->bank & CPER_MEM_BANK_ADDRESS_MASK);
> +	if (mem_err->validation_bits & CPER_MEM_VALID_DEVICE)
> +		p += sprintf(p, "device:%d ", mem_err->device);
>  	if (mem_err->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
>  		u32 row = mem_err->row;
>  

This looks OK (same as code in drivers/firmware/efi/cper.c in the
cper_mem_err_location() function. But that makes me wonder why there
is near duplication of code in ghes_edac.c?

The cper.c code seems to be written defensively using scnprintf()
instead of sprintf().  Could ghes_edac share the same code?

-Tony
