Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6103160BD55
	for <lists+linux-edac@lfdr.de>; Tue, 25 Oct 2022 00:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiJXW0I (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Oct 2022 18:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiJXWZv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Oct 2022 18:25:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35F131B82E;
        Mon, 24 Oct 2022 13:47:35 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e790329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e790:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 52FF51EC06A9;
        Mon, 24 Oct 2022 22:30:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666643435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eEJBB2pOfMf6Hy19YXgdsDPwAyP0Qr2tsBoSRTkUpSo=;
        b=aZz5DmwqGGtpnxWDR3/HMWl0RE7XJ5Fv2OSZisZz+t73or0y7/xWNetABFf/COAFgtne3S
        fPmGb/FV/nVBO10IUN4oEF9PI4K4Gsf/QBSuX7w4Mfecqgm1vWdxRcdb5wH4KICxEkjcRH
        OweYocTHPhPMYE4+qAKe/cTS/HO8Mak=
Date:   Mon, 24 Oct 2022 22:30:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Message-ID: <Y1b15vnE/Pd1U4r8@zn.tnic>
References: <20220418174440.334336-1-yazen.ghannam@amd.com>
 <20220418174440.334336-2-yazen.ghannam@amd.com>
 <Yr2CpuL+JHWblJMD@zn.tnic>
 <YsxefXQDCiJ1zxLG@yaz-fattaah>
 <YtUgb2Y/H/Wq9yIn@zn.tnic>
 <YtVlNrW58cFmksln@zn.tnic>
 <YukW/IltcCRwvSM4@yaz-fattaah>
 <Y1a4prRIYNw8GIkm@zn.tnic>
 <Y1a/lCVnlTMk8p75@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1a/lCVnlTMk8p75@agluck-desk3.sc.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 24, 2022 at 09:38:44AM -0700, Tony Luck wrote:
> There are still a fair number of users of mcelog, so I think it needs
> to remain in its half-undead state a while longer.

That's not the question - the question is how should vendor-specific
info should be logged so that the struct mce record doesn't get blown
up or ends up containing unused fields on the other vendor.

I.e., how to keep it as small as possible and to share the space there
in the most compact way.

That vendor-specific "space" in there could be used by each vendor
differently. As in this case, Intel doesn't have MCA_SYND{1,2} u64
values. So they could be part of a vendor_info which gets interpreted
based on vendor.

When Intel wants to carry more info through struct mce to userspace,
it can reuse those 2 u64s which are vendor_info but interpret them
differently.

Which then begs the question, how should those get logged etc.

I guess a u8 vendor_info[VENDOR_INFO_SIZE] or so which we can extend
later if needed.

Perhaps prepend it with its length too:

	error_record {
		struct mce;
		unsigned int vendor_info_len;
		u8 vendor_info[vendor_info_len];
	};

For example.

Not saying this is how it should be done - this is just what is swirling
around in my head right now.

Hmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
