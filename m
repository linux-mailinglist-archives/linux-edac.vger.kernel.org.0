Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC167FF34
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2019 19:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404012AbfHBRE5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Aug 2019 13:04:57 -0400
Received: from foss.arm.com ([217.140.110.172]:55232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403954AbfHBRE5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Aug 2019 13:04:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74938344;
        Fri,  2 Aug 2019 10:04:56 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C281F3F575;
        Fri,  2 Aug 2019 10:04:55 -0700 (PDT)
Subject: Re: [PATCH v2 12/24] EDAC, ghes: Use standard kernel macros for page
 calculations
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-13-rrichter@marvell.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <ffd8ec87-74fd-3d8e-1c8e-eed7f425df48@arm.com>
Date:   Fri, 2 Aug 2019 18:04:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190624150758.6695-13-rrichter@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Robert,

On 24/06/2019 16:09, Robert Richter wrote:
> Use standard macros for page calculations.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---

> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 786f1b32eee1..746083876b5f 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -311,8 +311,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  
>  	/* Error address */
>  	if (mem_err->validation_bits & CPER_MEM_VALID_PA) {
> -		e->page_frame_number = mem_err->physical_addr >> PAGE_SHIFT;
> -		e->offset_in_page = mem_err->physical_addr & ~PAGE_MASK;
> +		e->page_frame_number = PHYS_PFN(mem_err->physical_addr);
> +		e->offset_in_page = offset_in_page(mem_err->physical_addr);
>  	}
>  
>  	/* Error grain */
> 


After a shorter game of spot-the-difference:
Reviewed-by: James Morse <james.morse@arm.com>

Previously here:
https://lore.kernel.org/linux-edac/e566fe1d-ed06-53bc-6827-f6dfa32ee485@arm.com/


Please pick up tags when posting a new version.
If you don't do this, its very difficult to convince people to spend time reviewing your
series.


Thanks,

James
