Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F245D32288B
	for <lists+linux-edac@lfdr.de>; Tue, 23 Feb 2021 11:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhBWKGX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Feb 2021 05:06:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36772 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230482AbhBWKGX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 23 Feb 2021 05:06:23 -0500
Received: from zn.tnic (p200300ec2f08d800f4a123a8a64e4d27.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:d800:f4a1:23a8:a64e:4d27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A34811EC051F;
        Tue, 23 Feb 2021 11:05:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614074740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Lj5iIoesPz2ZRWUkdPvplvvFVZPwHPGzrGTJCq2uw3w=;
        b=gKVSOvOqx4T08vP3y0Evua0nuWO/o/R3IW8mceMGbjnuAgcJuNhLXZ+2qXdVvWRTI4Y4sW
        2MUTokBZZ5ngPt8Kye9NAPcrWRU5Btd6cFaR6cY+9ijsVO+z6MwwRdOzNSTNeuXdx9wenz
        6iqc8HU9qjMkvcGAS51IW2F/MCFVlcM=
Date:   Tue, 23 Feb 2021 11:05:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     tony.luck@intel.com, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangfeng1@kingsoft.com,
        yaoaili@kingsoft
Subject: Re: [PATCH v2] x86/mce: fix wrong no-return-ip logic in
 do_machine_check()
Message-ID: <20210223100538.GB26060@zn.tnic>
References: <20210222180819.3998fe33@alex-virtual-machine>
 <20210222102206.GC29063@zn.tnic>
 <20210222192146.76ffec84@alex-virtual-machine>
 <20210222201723.0fcec589@alex-virtual-machine>
 <20210222122241.GA10880@zn.tnic>
 <20210222203549.0e54c26f@alex-virtual-machine>
 <20210222124550.GB10880@zn.tnic>
 <20210223102755.13cbdffd@alex-virtual-machine>
 <20210223094300.GA26060@zn.tnic>
 <20210223175640.5708c7ed@alex-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210223175640.5708c7ed@alex-virtual-machine>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Feb 23, 2021 at 05:56:40PM +0800, Aili Yao wrote:
> What i inject is AR error, and I don't see MCG_STATUS_RIPV flag.

Then keep debugging qemu to figure out why that is.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
