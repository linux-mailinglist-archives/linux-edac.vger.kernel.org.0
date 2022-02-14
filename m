Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF754B51FF
	for <lists+linux-edac@lfdr.de>; Mon, 14 Feb 2022 14:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354556AbiBNNmr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Feb 2022 08:42:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349004AbiBNNmr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Feb 2022 08:42:47 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC344CF3;
        Mon, 14 Feb 2022 05:42:39 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5C8661EC0523;
        Mon, 14 Feb 2022 14:42:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644846154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HfTLwgR7h0xjposLrkmkHEsu76CpvTu7TFpbntEX7Kk=;
        b=D2kwNUd6if1rjMYG+blSPKiu2C6GCG4Xrbcik5PhzGlAMZNxCrDRMVZvXZtvlynfkFTxLI
        7zXiLLzDbK22wJl1jtWOqtoca2boM2EwAakqBn4lW4LJ0pOdHV6THFvTJ3PuZhjb/Ualbx
        CFVrDDwC25d6kbQLk9M2cflbw5z2Jss=
Date:   Mon, 14 Feb 2022 14:42:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 21/24] EDAC/amd64: Update CS ID calculation to match
 reference code
Message-ID: <YgpcTDC1i6s4Wcy4@zn.tnic>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-22-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220127204115.384161-22-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 27, 2022 at 08:41:12PM +0000, Yazen Ghannam wrote:
> Redo the current CS ID calculations to match the reference code. Helper
> functions are introduced that will be expanded for future DF versions.

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

Also, do not talk about what your patch does - that should hopefully be
visible in the diff itself. Rather, talk about *why* you're doing what
you're doing.

Just a reminder.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
