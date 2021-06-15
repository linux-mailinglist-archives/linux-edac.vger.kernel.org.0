Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0EB3A861A
	for <lists+linux-edac@lfdr.de>; Tue, 15 Jun 2021 18:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhFOQNU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Jun 2021 12:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFOQNU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Jun 2021 12:13:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C0BC061574;
        Tue, 15 Jun 2021 09:11:15 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f270048ecafc2d258032c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:2700:48ec:afc2:d258:32c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E20811EC01A8;
        Tue, 15 Jun 2021 18:11:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623773473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CB+Ne3gzXhLcGr5cw3T1uZe9C7ABTcqDxUDiv2De+S8=;
        b=Kp3xTiw1pxFOtNydsEO0BZWgrWdEvABKB/6hAmzJqs3jL7Wh+GnHrAMR7hD4O+irIokWEq
        5mxQiHiyRpKh5QQtQxSlw6S66zlmT8aKcB4QBwWGRm6TTzMBtKTzz61nO641P6+w1g2cx9
        fuLPl0m3LdydOGSVD844LDERnvfdTzk=
Date:   Tue, 15 Jun 2021 18:11:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Subject: Re: [PATCH] EDAC/mce_amd: Reduce unnecessary spew in dmesg if SMCA
 feature bit is not exposed
Message-ID: <YMjRGFiqp2HNWUrZ@zn.tnic>
References: <20210614212129.227698-1-Smita.KoralahalliChannabasappa@amd.com>
 <YMfRxX/M4rJ5gM/R@zn.tnic>
 <16a34b6834f94f139444c2ff172645e9@intel.com>
 <YMhwAZaFr4d1QOGG@zn.tnic>
 <20210615150846.GA409@aus-x-yghannam.amd.com>
 <YMjE2iwRFWVrfzLL@zn.tnic>
 <20210615160009.GA29258@aus-x-yghannam.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210615160009.GA29258@aus-x-yghannam.amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 15, 2021 at 12:00:09PM -0400, Yazen Ghannam wrote:
> So I think we can downgrade this warning to a debug message, if the
> module stays builtin. And/or we change the default config option to
> module, and we make sure the module only autoloads in the proper cases.
> 
> What do you think?

I think, as I said before, that we should simply not load this in
guests. Then this will be taken care of once and for all and we can do
whatever we want on baremetal, as to what error message to issue and how
many times to issue it, whether the decoder is builtin or default y or
yadda yadda.

Because even if you say in a guest:

	pr_warn_once("Decoding supported only on Scalable MCA processors.\n");

you're kinda misleading because the guest might be an SMCA processor but
not all features are emulated, including SMCA. So it is not really an
SMCA processor but some not really existant hybrid or so.

So since this whole SMCA thing does not apply to virtualization, we
should simply not load on virt and be done with it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
