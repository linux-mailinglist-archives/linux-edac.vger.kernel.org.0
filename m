Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3455A2E01
	for <lists+linux-edac@lfdr.de>; Fri, 26 Aug 2022 20:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245347AbiHZSJS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Aug 2022 14:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiHZSJR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 26 Aug 2022 14:09:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96286B56E0;
        Fri, 26 Aug 2022 11:09:16 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98b8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2692D1EC03EA;
        Fri, 26 Aug 2022 20:09:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661537351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iCRg1BZZBWD+TbCyuzPQlX9XHqNXqh9pUPyGuQmJ7bs=;
        b=c7+3bNPB8AcQzOC/SKx4n85TYarfRYJFQTtt3J7mFildxVA2qxwIa/+b6pSaWO7/ZJZ3ta
        HO1onnhJ2xADFE7ouivOeIxVRLmTE5YPy+ZAHSEFvxQpBDp2bXtJfiNkX/FbUIebi/2IlV
        NaNV9TNHJf3qgmygBzGERgmO2EQZF+A=
Date:   Fri, 26 Aug 2022 20:09:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jane Chu <jane.chu@oracle.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v7] x86/mce: retrieve poison range from hardware
Message-ID: <YwkMQsUn7BLPi5mU@zn.tnic>
References: <20220802195053.3882368-1-jane.chu@oracle.com>
 <YwUFlo3+my6bJHWj@zn.tnic>
 <b3880db6-6731-1d1b-144f-1080a033ad01@oracle.com>
 <Ywf9ZL6zjzSf5pdF@zn.tnic>
 <630908d7e6937_259e5b29445@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <630908d7e6937_259e5b29445@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 26, 2022 at 10:54:31AM -0700, Dan Williams wrote:
> How about:
> 
> ---
> 
> When memory poison consumption machine checks fire,
> mce-notifier-handlers like nfit_handle_mce() record the impacted
> physical address range.

... which is reported by the hardware in the MCi_MISC MSR.

> The error information includes data about blast
> radius, i.e. how many cachelines did the hardware determine are
> impacted.

Yap, nice.

> A recent change, commit 7917f9cdb503 ("acpi/nfit: rely on
> mce->misc to determine poison granularity"), updated nfit_handle_mce()
> to stop hard coding the blast radius value of 1 cacheline, and instead
> rely on the blast radius reported in 'struct mce' which can be up to 4K
> (64 cachelines).
> 
> It turns out that apei_mce_report_mem_error() had a similar problem in
> that it hard coded a blast radius of 4K rather than checking the blast

s/checking/reading/

> radius in the error information. Fix apei_mce_report_mem_error() to

s/in/from/

> convey the proper poison granularity.
> 
> ---

Yap, that's a lot better.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
