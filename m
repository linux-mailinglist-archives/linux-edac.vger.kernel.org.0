Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4CF281A61
	for <lists+linux-edac@lfdr.de>; Fri,  2 Oct 2020 20:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbgJBSC2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Oct 2020 14:02:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47390 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBSC2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Oct 2020 14:02:28 -0400
Received: from zn.tnic (p200300ec2f0d630076c6316353094260.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6300:76c6:3163:5309:4260])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A500E1EC046E;
        Fri,  2 Oct 2020 20:02:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601661746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pfeUMFmdB3fOIoL+4yEs3nJFfmZU0aNu3XTvE6X8GXU=;
        b=B/mvmiIii64QTSUarSBZJugjzMpddCWKGsxAcph0YxkkuhKpWaYYDY/DsL6UewQPOxa1wl
        aLSdcrDW28mmwHgArBmsgGP71pNh44vPvN/d6RID81lJF1Qa0xpVe6TG2mc9u/gFtU3lbB
        1XimJqU1CkH3cG26rooRW7vkRyLnVJQ=
Date:   Fri, 2 Oct 2020 20:02:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 0/7] RAS/CEC: Extend CEC for errors count check on
 short time period
Message-ID: <20201002180125.GD17436@zn.tnic>
References: <20201002122235.1280-1-shiju.jose@huawei.com>
 <20201002124352.GC17436@zn.tnic>
 <19a8cc62b11c49e9b584857a6a6664e5@huawei.com>
 <59950d44-906b-684f-c876-e09c76e5f827@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59950d44-906b-684f-c876-e09c76e5f827@arm.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 02, 2020 at 06:33:17PM +0100, James Morse wrote:
> > I think adding the CPU error collection to the kernel
> > has the following advantages,
> >     1. The CPU error collection and isolation would not be active if the
> >          rasdaemon stopped running or not running on a machine.

Wasn't there this thing called systemd which promised that it would
restart daemons when they fail? And even if it is not there, you can
always do your own cronjob which checks rasdaemon presence and restarts
it if it has died and sends a mail to the admin to check why it had
died.

Everything else I've trimmed but James has put it a lot more eloquently
than me and I cannot agree more with what he says. Doing this in
userspace is better in every aspect you can think of.

The current CEC thing runs in the kernel because it has a completely
different purpose - to limit corrected error reports which turn into
very expensive support calls for errors which were corrected but people
simply don't get that they were corrected. Instead, they throw hands in
the air and go "OMG, my hardware is failing".

Where those are, as James says:

> These are corrected errors. Nothing has gone wrong.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
