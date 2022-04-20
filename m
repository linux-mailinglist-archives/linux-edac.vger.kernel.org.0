Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7D05084B9
	for <lists+linux-edac@lfdr.de>; Wed, 20 Apr 2022 11:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354767AbiDTJUn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Apr 2022 05:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239291AbiDTJUm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Apr 2022 05:20:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A643D1FF;
        Wed, 20 Apr 2022 02:17:56 -0700 (PDT)
Received: from zn.tnic (p200300ea971b5839329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:5839:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7CD321EC032C;
        Wed, 20 Apr 2022 11:17:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650446270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/tYmDPvB7cOff+NTWHwXAfy91qng1z+BQ/j1QNPFkgw=;
        b=NCSID5qnDZhGpu1KHyDDZIzFvUoMviIomwOZ//5jO+DxYlSNcGMg+kVdXqBNZs+LMKndze
        RBqaQLORPqvmQZPDEkCwHc3mdljkuua4BkI5vjhRpYHtJJJmAzBMOUytd4cDoA1KMPYzZR
        HIMtFKPhOVpWmIbZIRaUYhrqnW7sx54=
Date:   Wed, 20 Apr 2022 11:17:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4 1/2] x86/mce: Check for writes ignored in MCA_STATUS
 register
Message-ID: <Yl/PupT3bAfc4IBW@zn.tnic>
References: <20220214233640.70510-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220214233640.70510-2-Smita.KoralahalliChannabasappa@amd.com>
 <Yk267A1MKOo2AlXQ@zn.tnic>
 <6cda2827-af75-589d-3e43-a287d6683e7a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6cda2827-af75-589d-3e43-a287d6683e7a@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 18, 2022 at 08:24:35PM -0700, Smita Koralahalli wrote:
> Why are we checking this here? This flag (hw_injection_possible)
> is set to false inside prepare_msrs() called from
> smp_call_function_single().
> Should this check be done after the call to smp_call_function_single()?

Why would you do that then?

Is any of the code after

        if (inj_type == SW_INJ) {
                mce_log(m);
                return 0;
        }

worth running if hardware injection is not possible?

> Also, we already have inj_desc.err which returns error code to userspace
> when WRIG in status registers. Why is this flag needed?

To not do unnecessary work when you *know* hardware injection won't
work.

:-)

Btw, please trim your mails when you reply, just like I did.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
