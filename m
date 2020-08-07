Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C09E23EFC1
	for <lists+linux-edac@lfdr.de>; Fri,  7 Aug 2020 17:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgHGPGF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Aug 2020 11:06:05 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:11582 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbgHGPGF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 7 Aug 2020 11:06:05 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077F2vuK011992;
        Fri, 7 Aug 2020 15:05:51 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 32qx4rspct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 15:05:51 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 0BFDC60;
        Fri,  7 Aug 2020 15:05:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [16.214.163.59])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 890A24B;
        Fri,  7 Aug 2020 15:05:50 +0000 (UTC)
Date:   Fri, 7 Aug 2020 10:05:50 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Kyle Meyer <kyle.meyer@hpe.com>
Cc:     russ.anderson@hpe.com, steve.wahl@hpe.com, tony.luck@intel.com,
        bp@alien8.de, linux-edac@vger.kernel.org
Subject: Re: [PATCH] x86/MCE: Set the MCE's status and misc members
Message-ID: <20200807150548.GK4686@localhost.localdomain>
References: <20200807142750.270548-1-kyle.meyer@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807142750.270548-1-kyle.meyer@hpe.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_12:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070107
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

There's one small code change I suggest below.

But now it's time to think about the description.  We need to zoom out
to the 10,000 ft. view.  IMHO, to understand what this patch does,
your current description requires the reader to be more familiar with
the involved functions than we should expect.

To introduce the reader to what's going on, it should read more like:

"When creating an MCE record from a CPER memory error, fill in the
m.misc field and mark it as valid in the m.status field on processors
where MCEs are expected to have this information.  This ensures that
mce_usable_address() will not interpret the address as invalid, which
(for example) would cause cec_notifier() to ignore the created MCE
records."

In addition to giving an improved background picture, that gives
direct "pointers" to the other functions you have to examine to
understand what's going on.

On Fri, Aug 07, 2020 at 09:27:50AM -0500, Kyle Meyer wrote:
> The MCE's status and misc members are initialized to zero
> within mce_setup. Set the MCE's status and misc members to the
> corresponding values passed in by the mem_err argument. This provides
> support for the RAS: Corrected Errors Collector (CEC) which uses the
> MCE.
> 
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> ---
>  arch/x86/include/asm/mce.h     | 6 ++++--
>  arch/x86/kernel/cpu/mce/apei.c | 8 ++++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index cf503824529c..2346d900a232 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -79,8 +79,10 @@
>  #define MCACOD_INSTR	0x0150	/* Instruction Fetch */
>  
>  /* MCi_MISC register defines */
> -#define MCI_MISC_ADDR_LSB(m)	((m) & 0x3f)
> -#define MCI_MISC_ADDR_MODE(m)	(((m) >> 6) & 7)
> +#define MCI_MISC_ADDR_LSB(m)		((m) & 0x3f)
> +#define MCI_MISC_ADDR_LSB_SET(x) 	((x) & 0x3f)
> +#define MCI_MISC_ADDR_MODE(m)		(((m) >> 6) & 7)
> +#define MCI_MISC_ADDR_MODE_SET(x) 	(((x) & 7) << 6)
>  #define  MCI_MISC_ADDR_SEGOFF	0	/* segment offset */
>  #define  MCI_MISC_ADDR_LINEAR	1	/* linear address */
>  #define  MCI_MISC_ADDR_PHYS	2	/* physical address */
> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
> index af8d37962586..efdfb55b934a 100644
> --- a/arch/x86/kernel/cpu/mce/apei.c
> +++ b/arch/x86/kernel/cpu/mce/apei.c
> @@ -38,6 +38,14 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
>  	/* Fake a memory read error with unknown channel */
>  	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | 0x9f;
>  
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL ||
> +	    boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN) {
> +		m.status |= MCI_STATUS_MISCV;

Concentrating on this statement:

> +		m.misc |= MCI_MISC_ADDR_LSB_SET(ffs(
> +					mem_err->physical_addr_mask) - 1) |
> +			  MCI_MISC_ADDR_MODE_SET(MCI_MISC_ADDR_PHYS);

I know you mentioned that the whole of structure m was cleared out by
mce_setup(), but that's in the change comment, not the code.  Since we
know m.misc is already 0, the code would be clearer if this line
started

		m.misc = MCI_MISC...

instead of

		m.misc |= MCI_MISC...

because the result is the same, and someone coming fresh into reading
this code has to go into the definition of mce_setup() to know that
m.misc started as zero for the |= version.

Another way of stating this is there's nothing already in m.misc
you're trying to preserve and add to, where seeing the |= operation
could mislead a new reader into thinking there was something there
you're trying to preserve.


> +	}
> +
>  	if (severity >= GHES_SEV_RECOVERABLE)
>  		m.status |= MCI_STATUS_UC;
>  
> -- 
> 2.26.2
> 
--> Steve
