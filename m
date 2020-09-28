Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0459527B434
	for <lists+linux-edac@lfdr.de>; Mon, 28 Sep 2020 20:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgI1SOQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Sep 2020 14:14:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58958 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgI1SOQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 28 Sep 2020 14:14:16 -0400
Received: from zn.tnic (p200300ec2f072200163fab7f7d674efc.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:2200:163f:ab7f:7d67:4efc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A5A51EC026F;
        Mon, 28 Sep 2020 20:14:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601316854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=q06RMVvlARe/Lo00so5MlnNumjPTEFqY/eH41sF1eo8=;
        b=XlAbOSaJbwp+CnQpSPCCpNyOBDkmS9NwISzai9/PBxjvHuoVrQ26K1KZ95zIwQoE+Hi/1A
        Exrp64Govygk+6PEeNwIIOvfEAv85Yok6ilskQz97xQGLWqHuNV1FcmCrBVkLIOb8KiK/x
        l98kU1fOBVOjfMrQq5wnVJVn9EnhGsU=
Date:   Mon, 28 Sep 2020 20:14:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 8/8] x86/MCE/AMD Support new memory interleaving modes
 during address translation
Message-ID: <20200928181407.GH1685@zn.tnic>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
 <20200903200144.310991-9-Yazen.Ghannam@amd.com>
 <20200923082039.GB28545@zn.tnic>
 <20200923162510.GB1684790@yaz-nikka.amd.com>
 <20200925072231.GC16872@zn.tnic>
 <20200925195127.GA323455@yaz-nikka.amd.com>
 <20200928094759.GF1685@zn.tnic>
 <20200928155350.GA926956@yaz-nikka.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200928155350.GA926956@yaz-nikka.amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 28, 2020 at 10:53:50AM -0500, Yazen Ghannam wrote:
> I don't have any clear reasons. I just get vague use cases sometimes
> about not using EDAC and relying on other things. But it shouldn't hurt
> to have the module load anyway. The EDAC messages can be suppressed, and
> the sysfs interface can be ignored. So, after a bit more thought, this
> doesn't seem like a good reason.

Ok. We can always carve it out if someone comes up with a valid reason
later.

> I agree that the translation code is implementation-specific and applies
> only to DRAM ECC errors, so it make sense to have it in amd64_edac. The
> only issue is getting the address translation to earlier notifiers. I
> think we can add a new one in amd64_edac to run before others. Maybe this
> can be a new priority class like MCE_PRIO_PREPROCESS, or something like
> that for notifiers that fixup the MCE data.

Well, I'm not sure you need notifiers here - you wanna call
mce_usable_address() and in it, it should do the address conversion
calculation to give you a physical address which you can feed to
memory_failure etc.

Now, mce_usable_address() is core code and we can make core code call
into a module but that is yucky. So *that* is your reason for keeping it
where it is.

Looking at its size:

$ readelf -s vmlinux | grep umc_normaddr_to
  2864: ffffffff817d8ae5   168 FUNC    LOCAL  DEFAULT    1 umc_normaddr_to_[...]
 91866: ffffffff81030e00  1127 FUNC    GLOBAL DEFAULT    1 umc_normaddr_to_[...]

that's something like ~1.3K and if you split it and do some
experimenting, you might get it even slimmer. Not that ~1.3K is that
huge for current standards but we should always aim at not bloating the
fat guy our kernel already is.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
