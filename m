Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B63587B27
	for <lists+linux-edac@lfdr.de>; Tue,  2 Aug 2022 12:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbiHBK7j (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 Aug 2022 06:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236219AbiHBK7i (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 2 Aug 2022 06:59:38 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C272102F;
        Tue,  2 Aug 2022 03:59:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s11so5697680edd.13;
        Tue, 02 Aug 2022 03:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OoOjj2ZKfm+aKI2XCz2uW/zV54aqeuaDJtU0JfcCK5E=;
        b=BQKJG+lMQFqqR5u9jSq85ByIMbXSY75N7rX+qutL9ytJ7mJJUrFj8xY2dqKMpv4Ueq
         HFWQAt1D74J8OAEpzcZ/lQ9hDrybyiihp9wpum6QUR84QziYBdHCVb9BXJi91B0wi3ro
         jFNhoG1Ndj/wB+urRa0WhG1z36rhCiVdQEfQa4+whvEWDNIhvk2bOqdcAVjjEGP1fcmK
         qMVzx1OmJ/aXRVrZSFs3LxLF3k6FJgfouWjS0r63LMuqPPz+WjSpiprlUYbvTEG8hl9t
         UQ5UHnLJFA+XF0iW0fHmFgulmM6uauQxCZk9N90DHVa0PlYNI79yIrSoQCdWctAmg4rc
         n2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OoOjj2ZKfm+aKI2XCz2uW/zV54aqeuaDJtU0JfcCK5E=;
        b=I2kZjobd0+MoFJH6PGxa0NKD8Zpn+9MJ6MO+VqRdeNcmvXHhOIsIaSgILJTE0DQX5l
         yr/MtdERXW0kCkmltdBZt5GYVEAQO0UDPUZXyEe2XkGxqbRUJIqI5qJBMkysC6598mDo
         0Pg53N78AOtp9S2pfs57MyNRnuYzCC6kKxRzgvcoQ+GWmKh2M5qQn24kDngPfDEBXOhK
         5Um/inzqtxHegPo93hmQD+VLmU2Wd7ws3j5rC0REjqft0XZAxE2++CN8sl8XYTtSEVzk
         CBEvOOhImd/CTs2lj5GlA8YuEmPiTQLeUna4yDM6Hu3/77QfSp/ynrwM9I31uMvxIuzI
         pRSw==
X-Gm-Message-State: AJIora/0n+aax9zK7URM767EYPf+lfVRoM6eh2vddOrRiW2D/bT0rCMn
        uuAeUZU1/kOpi9iL05C+R4o=
X-Google-Smtp-Source: AGRyM1slWsFtBGYQGRf9JsGLxptO6wteWd0849lQuQzFHhHumIbPQkQUQOOt+b/HreL9OuzslVtZvA==
X-Received: by 2002:a05:6402:d05:b0:425:b5c8:faeb with SMTP id eb5-20020a0564020d0500b00425b5c8faebmr19475384edb.273.1659437976136;
        Tue, 02 Aug 2022 03:59:36 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id a9-20020a50ff09000000b0043d1c639e15sm6718213edu.65.2022.08.02.03.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 03:59:35 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 2 Aug 2022 12:59:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, hch@lst.de, nvdimm@lists.linux.dev
Subject: Re: [PATCH v6] x86/mce: retrieve poison range from hardware
Message-ID: <YukDlb9SsZ2UlX8o@gmail.com>
References: <20220802000614.3769714-1-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802000614.3769714-1-jane.chu@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


* Jane Chu <jane.chu@oracle.com> wrote:

> With Commit 7917f9cdb503 ("acpi/nfit: rely on mce->misc to determine
> poison granularity") that changed nfit_handle_mce() callback to report
> badrange according to 1ULL << MCI_MISC_ADDR_LSB(mce->misc), it's been
> discovered that the mce->misc LSB field is 0x1000 bytes, hence injecting
> 2 back-to-back poisons and the driver ends up logging 8 badblocks,
> because 0x1000 bytes is 8 512-byte.
> 
> Dan Williams noticed that apei_mce_report_mem_error() hardcode
> the LSB field to PAGE_SHIFT instead of consulting the input
> struct cper_sec_mem_err record.  So change to rely on hardware whenever
> support is available.
> 
> Link: https://lore.kernel.org/r/7ed50fd8-521e-cade-77b1-738b8bfb8502@oracle.com
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  arch/x86/kernel/cpu/mce/apei.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
> index 717192915f28..e2439c7872ba 100644
> --- a/arch/x86/kernel/cpu/mce/apei.c
> +++ b/arch/x86/kernel/cpu/mce/apei.c
> @@ -29,15 +29,27 @@
>  void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
>  {
>  	struct mce m;
> +	int lsb;
>  
>  	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
>  		return;
>  
> +	/*
> +	 * Even if the ->validation_bits are set for address mask,
> +	 * to be extra safe, check and reject an error radius '0',
> +	 * and fallback to the default page size.
> +	 */

speling nit:

  s/fallback/fall back

> +	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
> +		lsb = find_first_bit((const unsigned long *)
> +			&mem_err->physical_addr_mask, PAGE_SHIFT);

I think we can write this in a shorter form and in a single line:

		lsb = find_first_bit((void *)&mem_err->physical_addr_mask, PAGE_SHIFT);

(Ignore checkpatch if it wants to break the line.)

Untested.

Assuming my suggestion is correct and with those addressed:

  Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
